/**
 * Round-trips every starter home through the whole persistence path: file it, load it off disk,
 * save it back out with write_map(), and confirm what came out is still loadable.
 *
 * This is the regression guard that matters most for player homes. A starter map losing its door,
 * or a change to write_map() quietly breaking the format, would otherwise only surface as players
 * losing homes they had spent a round decorating.
 */
/datum/unit_test/player_home_round_trip
	/// A ckey nobody can hold, so the test never touches a real player's saved home.
	var/test_ckey = "unittestplayerhome"

/datum/unit_test/player_home_round_trip/Run()
	TEST_ASSERT(length(SShomes.starter_templates), "no starter home templates were registered")
	for(var/starter_name in SShomes.starter_templates)
		round_trip(SShomes.starter_templates[starter_name])

/datum/unit_test/player_home_round_trip/Destroy()
	wipe_test_home(test_ckey)
	return ..()

/// Clears every file the tests below leave behind.
/proc/wipe_test_home(ckey)
	fdel(SShomes.home_file(ckey))
	fdel(SShomes.home_file(ckey, "home_backup.dmm"))
	fdel(SShomes.home_file(ckey, "home.json"))
	SShomes.forget_preview(ckey)

/datum/unit_test/player_home_round_trip/proc/round_trip(datum/map_template/home/starter)
	TEST_ASSERT(SShomes.write_starter(test_ckey, starter, null), "[starter.name]: could not be filed to disk")

	var/datum/home_instance/home = SShomes.load_home(test_ckey, null, null)
	TEST_ASSERT_NOTNULL(home, "[starter.name]: filed interior would not load back off disk")

	// The two things a home is unusable without. Loading self-heals both, so a failure here means
	// even the self-heal could not cope.
	TEST_ASSERT_NOTNULL(home.find_door(), "[starter.name]: loaded without a home door")
	TEST_ASSERT_NOTNULL(home.find_console(), "[starter.name]: loaded without a save console")

	var/turf/landing = home.get_landing_turf()
	TEST_ASSERT_NOTNULL(landing, "[starter.name]: offers nowhere for an arriving player to stand")
	TEST_ASSERT(landing in home.reservation.reserved_turfs, "[starter.name]: landing spot is outside its own reservation")

	// Forcing the area is what stops a save file from claiming a station area, so prove it happened.
	var/area/landing_area = get_area(landing)
	TEST_ASSERT(istype(landing_area, /area/misc/player_home), "[starter.name]: loaded into [landing_area.type] instead of a home area")

	TEST_ASSERT(SShomes.save_home(home, null), "[starter.name]: write_map() round trip refused to save")
	var/datum/map_template/home/reparsed = SShomes.build_runtime_template(SShomes.home_file(test_ckey), "round trip check")
	TEST_ASSERT_NOTNULL(reparsed, "[starter.name]: the file its own save wrote does not parse back")
	qdel(reparsed)

	SShomes.release_home(home)

/**
 * Covers the parts of a home a player can rearrange: the front door coming down and going back up
 * somewhere else, and the room settings surviving a save.
 *
 * The door is the interesting one. It is a turf, so relocating it means remembering what it was
 * fitted into - and that memory only survives a save because the door overrides get_save_vars().
 */
/datum/unit_test/player_home_fixtures
	var/test_ckey = "unittesthomefixtures"

/datum/unit_test/player_home_fixtures/Destroy()
	wipe_test_home(test_ckey)
	return ..()

/datum/unit_test/player_home_fixtures/Run()
	var/datum/map_template/home/starter = SShomes.starter_templates[SShomes.starter_templates[1]]
	TEST_ASSERT_NOTNULL(starter, "no starter home template to test against")
	TEST_ASSERT(SShomes.write_starter(test_ckey, starter, null), "could not file the test home")

	var/datum/home_instance/home = SShomes.load_home(test_ckey, null, null)
	TEST_ASSERT_NOTNULL(home, "test home would not load")

	// Settings have to survive a save, since they live in the sidecar rather than in the .dmm.
	home.brightness = 0 // HOME_BRIGHTNESS_MIN, spelled out: module defines are not in scope this early
	home.lamp_color = "#ff8800"
	home.gravity = FALSE
	home.apply_settings()
	var/area/home_area = get_area(home.reservation.bottom_left_turfs[1])
	TEST_ASSERT(home_area.area_flags & NO_GRAVITY, "gravity was switched off but the area kept its gravity flag")

	// Take the door down. It should hand back a flat pack and leave a wall behind.
	var/mob/living/carbon/human/resident = allocate(/mob/living/carbon/human/consistent)
	resident.forceMove(home.get_landing_turf())
	var/turf/closed/indestructible/hoteldoor/fakedoor/player_home/was_a_door = home.find_door()
	var/replacing = was_a_door.replaced_type
	var/door_x = was_a_door.x
	var/door_y = was_a_door.y
	var/door_z = was_a_door.z
	TEST_ASSERT(home.uninstall_door(resident), "the front door refused to come down")
	TEST_ASSERT_NULL(home.find_door(), "the front door came down but a door is still standing")
	var/obj/item/home_door_kit/flat_pack = locate() in resident
	TEST_ASSERT_NOTNULL(flat_pack, "taking the door down did not hand over a flat pack")
	TEST_ASSERT(home.owns(flat_pack), "the flat-packed door could be carried out of the home")
	var/turf/left_behind = locate(door_x, door_y, door_z)
	TEST_ASSERT_EQUAL(left_behind.type, replacing, "the door left behind the wrong turf")

	// Hang it somewhere else, then prove the relocation survives a save and reload.
	var/turf/closed/somewhere_else
	for(var/turf/closed/candidate in home.reservation.reserved_turfs)
		if(home.has_open_neighbour(candidate))
			somewhere_else = candidate
			break
	TEST_ASSERT_NOTNULL(somewhere_else, "found no wall to hang the door on")
	// Read the wall's type now: a turf reference follows its map cell, so after the door is hung
	// this same var describes the door instead of the wall it went into.
	var/wall_type = somewhere_else.type
	// The dummy has no ckey, so it is not the owner - the guard on the item should turn it away.
	TEST_ASSERT(flat_pack.interact_with_atom(somewhere_else, resident) & ITEM_INTERACT_BLOCKING, "a non-owner was allowed to hang the front door")
	TEST_ASSERT_NULL(home.find_door(), "a non-owner hung the front door anyway")
	TEST_ASSERT_NOTNULL(home.hang_door(somewhere_else), "the door would not hang on a wall")
	qdel(flat_pack)

	TEST_ASSERT(SShomes.save_home(home, resident), "could not save after moving the fixtures")
	resident.forceMove(run_loc_floor_bottom_left) // releasing empties the turfs, occupants included
	SShomes.release_home(home)

	var/datum/home_instance/reloaded = SShomes.load_home(test_ckey, null, null)
	TEST_ASSERT_NOTNULL(reloaded, "the home would not load after its fixtures moved")
	var/turf/closed/indestructible/hoteldoor/fakedoor/player_home/moved_door = reloaded.find_door()
	TEST_ASSERT_NOTNULL(moved_door, "the relocated door did not survive the save")
	TEST_ASSERT_EQUAL(moved_door.replaced_type, wall_type, "the relocated door forgot what wall it replaced")
	TEST_ASSERT_EQUAL(reloaded.brightness, 0, "brightness did not survive the save")
	TEST_ASSERT_EQUAL(reloaded.lamp_color, "#ff8800", "bulb colour did not survive the save")
	TEST_ASSERT(!reloaded.gravity, "the gravity setting did not survive the save")

	SShomes.release_home(reloaded)

/**
 * Guards the requisition catalogue and the one invariant that makes it safe to hand out.
 *
 * Everything a pod delivers is marked as the home's property, so a player can order iron forever
 * without a single sheet of it reaching the round's economy. A catalogue line that skips the
 * marking, or names a type that no longer exists, is a bug this test catches at build time rather
 * than the first time somebody orders it.
 */
/datum/unit_test/player_home_supply
	var/test_ckey = "unittesthomesupply"

/datum/unit_test/player_home_supply/Destroy()
	wipe_test_home(test_ckey)
	return ..()

/datum/unit_test/player_home_supply/Run()
	TEST_ASSERT(length(SShomes.supply_catalogue), "the requisition catalogue is empty")
	for(var/datum/home_supply/entry as anything in SShomes.supply_catalogue)
		TEST_ASSERT(length(entry.manifest), "catalogue line '[entry.name]' ships nothing at all")
		for(var/thing_path in entry.manifest)
			TEST_ASSERT(ispath(thing_path, /atom/movable), "catalogue line '[entry.name]' names [thing_path], which is not a spawnable type")
			TEST_ASSERT(isnum(entry.manifest[thing_path]) && entry.manifest[thing_path] > 0, "catalogue line '[entry.name]' asks for a nonsense amount of [thing_path]")

	var/datum/map_template/home/starter = SShomes.starter_templates[SShomes.starter_templates[1]]
	TEST_ASSERT(SShomes.write_starter(test_ckey, starter, null), "could not file the test home")
	var/datum/home_instance/home = SShomes.load_home(test_ckey, null, null)
	TEST_ASSERT_NOTNULL(home, "test home would not load")

	// A toolbox arrives full of tools. Unmarked tools inside a marked box would walk straight out in
	// somebody's pocket, so the marking has to reach all the way down.
	var/obj/structure/closet/supplypod/pod = SShomes.deliver_supplies(home, list(/obj/item/storage/toolbox/mechanical = 1, /obj/item/stack/sheet/iron = 50))
	TEST_ASSERT_NOTNULL(pod, "a delivery produced no pod")
	var/obj/item/stack/sheet/iron/delivered_iron = locate() in pod
	TEST_ASSERT_NOTNULL(delivered_iron, "the iron never made it into the pod")
	TEST_ASSERT_EQUAL(delivered_iron.amount, 50, "a stack was delivered at the wrong size")

	var/loose = 0
	for(var/atom/movable/shipped as anything in pod.get_all_contents())
		if(shipped == pod)
			continue
		if(!home.owns(shipped))
			loose++
	TEST_ASSERT_EQUAL(loose, 0, "[loose] delivered items were not marked as the home's, and could be carried out into the round")
	qdel(pod)

	SShomes.release_home(home)
