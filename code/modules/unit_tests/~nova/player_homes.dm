/// Round-trips every starter home through the whole persistence path: file it, load it off disk,
/// save it back out with write_map(), and confirm what came out is still loadable. A starter map
/// losing its door, or write_map() quietly breaking the format, would otherwise only surface as
/// players losing homes they had spent a round decorating.
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

/// Clears every file the tests below leave behind, in every slot. Test ckeys are made up, so the
/// whole account directory can simply go.
/proc/wipe_test_home(ckey)
	for(var/slot in 1 to 10) // HOME_MAX_SLOTS, spelled out: module defines are not in scope this early
		SShomes.forget_preview(ckey, slot)
	fdel(SShomes.account_directory(ckey))

/datum/unit_test/player_home_round_trip/proc/round_trip(datum/map_template/home/starter)
	TEST_ASSERT(SShomes.write_starter(test_ckey, 1, starter, null), "[starter.name]: could not be filed to disk")

	var/datum/home_instance/home = SShomes.load_home(test_ckey, 1, null, null)
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
	var/datum/map_template/home/reparsed = SShomes.build_runtime_template(SShomes.home_file(test_ckey, 1), "round trip check")
	TEST_ASSERT_NOTNULL(reparsed, "[starter.name]: the file its own save wrote does not parse back")
	qdel(reparsed)

	SShomes.release_home(home)

/// Covers the parts of a home a player can rearrange: the front door coming down and going back up
/// somewhere else, and the room settings surviving a save. The door is a turf, so relocating it
/// means remembering what it was fitted into - and that only survives a save because the door
/// overrides get_save_vars().
/datum/unit_test/player_home_fixtures
	var/test_ckey = "unittesthomefixtures"

/datum/unit_test/player_home_fixtures/Destroy()
	wipe_test_home(test_ckey)
	return ..()

/datum/unit_test/player_home_fixtures/Run()
	var/datum/map_template/home/starter = SShomes.starter_templates[SShomes.starter_templates[1]]
	TEST_ASSERT_NOTNULL(starter, "no starter home template to test against")
	TEST_ASSERT(SShomes.write_starter(test_ckey, 1, starter, null), "could not file the test home")

	var/datum/home_instance/home = SShomes.load_home(test_ckey, 1, null, null)
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

	// You come in through the front door, so moving the door has to move where you arrive. Getting
	// this wrong is invisible until somebody relocates their door and keeps being dropped in the
	// room they moved it away from.
	TEST_ASSERT(get_dist(home.get_landing_turf(), home.find_door()) <= 1, "the landing spot did not follow the door to its new wall")

	TEST_ASSERT(SShomes.save_home(home, resident), "could not save after moving the fixtures")
	resident.forceMove(run_loc_floor_bottom_left) // releasing empties the turfs, occupants included
	SShomes.release_home(home)

	var/datum/home_instance/reloaded = SShomes.load_home(test_ckey, 1, null, null)
	TEST_ASSERT_NOTNULL(reloaded, "the home would not load after its fixtures moved")
	var/turf/closed/indestructible/hoteldoor/fakedoor/player_home/moved_door = reloaded.find_door()
	TEST_ASSERT_NOTNULL(moved_door, "the relocated door did not survive the save")
	TEST_ASSERT_EQUAL(moved_door.replaced_type, wall_type, "the relocated door forgot what wall it replaced")
	TEST_ASSERT(get_dist(reloaded.get_landing_turf(), moved_door) <= 1, "the landing spot did not survive the save at the relocated door")
	TEST_ASSERT_EQUAL(reloaded.brightness, 0, "brightness did not survive the save")
	TEST_ASSERT_EQUAL(reloaded.lamp_color, "#ff8800", "bulb colour did not survive the save")
	TEST_ASSERT(!reloaded.gravity, "the gravity setting did not survive the save")

	SShomes.release_home(reloaded)

/// Guards the requisition catalogue and the invariant that makes it safe to hand out: everything a
/// pod delivers is marked as the home's property, so ordered materials can never reach the round's
/// economy. Also catches a catalogue line naming a type that no longer exists.
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
	TEST_ASSERT(SShomes.write_starter(test_ckey, 1, starter, null), "could not file the test home")
	var/datum/home_instance/home = SShomes.load_home(test_ckey, 1, null, null)
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

/// Several homes on one account have to stay out of each other's way: separate files, separate
/// reservations and areas, and saving, naming or demolishing one never touching another. Also covers
/// the claim limit and adopting a record filed before accounts could hold more than one home.
/datum/unit_test/player_home_slots
	var/test_ckey = "unittesthomeslots"
	var/legacy_ckey = "unittesthomelegacy"

/datum/unit_test/player_home_slots/Destroy()
	wipe_test_home(test_ckey)
	wipe_test_home(legacy_ckey)
	return ..()

/datum/unit_test/player_home_slots/Run()
	// Slots arrive from the client, so anything that isn't a whole number in range is turned away.
	TEST_ASSERT_EQUAL(sanitize_home_slot("3"), 3, "a slot sent as text was not read")
	TEST_ASSERT_NULL(sanitize_home_slot(0), "slot 0 was accepted")
	TEST_ASSERT_NULL(sanitize_home_slot(11), "a slot past HOME_MAX_SLOTS was accepted")
	TEST_ASSERT_NULL(sanitize_home_slot(1.5), "a fractional slot was accepted")
	TEST_ASSERT_NULL(sanitize_home_slot("kitchen"), "a nonsense slot was accepted")

	var/datum/map_template/home/starter = SShomes.starter_templates[SShomes.starter_templates[1]]
	TEST_ASSERT_NOTNULL(starter, "no starter home template to test against")
	TEST_ASSERT(SShomes.write_starter(test_ckey, 1, starter, null), "could not file a home in slot 1")
	TEST_ASSERT(SShomes.write_starter(test_ckey, 3, starter, null), "could not file a home in slot 3")
	TEST_ASSERT_EQUAL(jointext(SShomes.filed_slots(test_ckey), ","), "1,3", "the registry miscounted which slots hold a home")
	TEST_ASSERT_EQUAL(SShomes.next_free_slot(test_ckey), 2, "a new claim was not offered the lowest free slot")

	var/datum/home_instance/first = SShomes.load_home(test_ckey, 1, null, null)
	var/datum/home_instance/third = SShomes.load_home(test_ckey, 3, null, null)
	TEST_ASSERT_NOTNULL(first, "the home in slot 1 would not load")
	TEST_ASSERT_NOTNULL(third, "the home in slot 3 would not load while slot 1 was standing")
	TEST_ASSERT(first != third, "two slots loaded as the same home")
	TEST_ASSERT_EQUAL(SShomes.get_active_home(test_ckey, 3), third, "the registry lost track of which loaded home is which")
	TEST_ASSERT(first.reservation != third.reservation, "two homes were unfolded into the same reservation")
	// Sharing an area would mean the last person leaving one home released the other as well.
	TEST_ASSERT(get_area(first.get_landing_turf()) != get_area(third.get_landing_turf()), "two loaded homes share an area")

	// Saving one home must leave the other's record alone, byte for byte.
	var/first_record_before = file2text(file(SShomes.home_file(test_ckey, 1)))
	var/first_sidecar_before = file2text(file(SShomes.home_file(test_ckey, 1, "home.json")))
	TEST_ASSERT(SShomes.save_home(third, null), "could not save the home in slot 3")
	TEST_ASSERT(fexists(SShomes.home_file(test_ckey, 3, "home_backup.dmm")), "slot 3's save did not roll its own backup")
	TEST_ASSERT(!fexists(SShomes.home_file(test_ckey, 1, "home_backup.dmm")), "saving slot 3 rolled a backup in slot 1")
	TEST_ASSERT_EQUAL(file2text(file(SShomes.home_file(test_ckey, 1))), first_record_before, "saving slot 3 wrote over slot 1's record")
	TEST_ASSERT_EQUAL(file2text(file(SShomes.home_file(test_ckey, 1, "home.json"))), first_sidecar_before, "saving slot 3 wrote over slot 1's sidecar")

	// Naming a loaded home has to reach the loaded copy too, or its next save puts the old name back.
	TEST_ASSERT(SShomes.set_home_label(test_ckey, 1, "Summer Place"), "could not name a home")
	TEST_ASSERT_EQUAL(first.label, "Summer Place", "naming a loaded home did not reach the loaded copy")
	TEST_ASSERT(SShomes.save_home(first, null), "could not save the home in slot 1")
	TEST_ASSERT_EQUAL(SShomes.home_display_name(test_ckey, 1), "Summer Place", "saving a home forgot its name")
	TEST_ASSERT_EQUAL(SShomes.home_display_name(test_ckey, 3), starter.name, "naming one home renamed another")

	SShomes.release_home(first)
	SShomes.release_home(third)
	TEST_ASSERT_NULL(SShomes.get_active_home(test_ckey, 1), "a released home was still registered as loaded")

	// Demolishing one frees its slot and nothing else.
	SShomes.reset_home(test_ckey, 1, null)
	TEST_ASSERT_EQUAL(jointext(SShomes.filed_slots(test_ckey), ","), "3", "demolishing one home disturbed the others")
	// Slot 1 still holds its backup for the admins, so a fresh claim should pass over it for an empty slot.
	TEST_ASSERT_EQUAL(SShomes.next_free_slot(test_ckey), 2, "a new claim was put on top of a demolished home's backup")

	// Fill the account up to its limit. Past it, there is no slot to offer.
	for(var/slot in 1 to CONFIG_GET(number/player_home_slots))
		if(!SShomes.has_home(test_ckey, slot))
			TEST_ASSERT(SShomes.write_starter(test_ckey, slot, starter, null), "could not file a home in slot [slot]")
	TEST_ASSERT_NULL(SShomes.next_free_slot(test_ckey), "an account at its limit was offered another slot")

	// A home filed before accounts had slots sits loose in the account directory. Discovering an
	// account's homes moves it into slot 1, files and all.
	var/legacy_directory = SShomes.account_directory(legacy_ckey)
	rustg_file_write(file2text(file(starter.mappath)), "[legacy_directory]home.dmm")
	rustg_file_write(json_encode(list("starter" = starter.name)), "[legacy_directory]home.json")
	TEST_ASSERT_EQUAL(jointext(SShomes.filed_slots(legacy_ckey), ","), "1", "a single-home record was not adopted into slot 1")
	TEST_ASSERT(!fexists("[legacy_directory]home.dmm"), "adopting a single-home record left the old copy behind")
	var/list/legacy_metadata = SShomes.read_metadata(legacy_ckey, 1)
	TEST_ASSERT_EQUAL(legacy_metadata["starter"], starter.name, "an adopted home lost its sidecar")
	var/datum/home_instance/adopted = SShomes.load_home(legacy_ckey, 1, null, null)
	TEST_ASSERT_NOTNULL(adopted, "an adopted home would not load")
	SShomes.release_home(adopted)

/**
 * The waste compactor destroys ordinary junk and refuses everything a home must never swallow. The
 * nested cases are the ones that matter: round-critical gear inside a bag, or somebody shut in the
 * bin, must not be a way to delete either of them.
 *
 * compactable() reads nothing but its own contents, so this runs on a bare compactor in the test
 * room rather than one standing in a loaded home. Moving a live mob into a container inside a turf
 * reservation and back out leaves it registered in two spatial grid cells, and none of that
 * machinery is what this test is about.
 */
/datum/unit_test/player_home_compactor

/datum/unit_test/player_home_compactor/Run()
	var/obj/structure/closet/crate/bin/home_compactor/compactor = allocate(/obj/structure/closet/crate/bin/home_compactor)

	// Ordinary junk: the compactor should be willing to take it.
	var/obj/item/trash/junk = allocate(/obj/item/trash/candle, compactor)
	TEST_ASSERT(junk in compactor.compactable(), "the compactor refused ordinary rubbish")

	// Round-critical, bare and buried. Neither may ever be destroyed. Documents rather than the nuke
	// disk: the disk is stationloving and would teleport itself out of the bin mid-test.
	var/obj/item/documents/secrets = allocate(/obj/item/documents/nanotrasen, compactor)
	TEST_ASSERT(SShomes.is_round_critical(secrets), "the test's stand-in for round-critical gear is not on the blacklist")
	TEST_ASSERT(!(secrets in compactor.compactable()), "the compactor was willing to destroy round-critical gear")
	var/obj/item/storage/backpack/smuggling = allocate(/obj/item/storage/backpack, compactor)
	secrets.forceMove(smuggling)
	TEST_ASSERT(!(smuggling in compactor.compactable()), "round-critical gear inside a backpack could be fed to the compactor")

	// Anything alive, at any depth, or the bin is a murder box. The compactor is allocated on the same
	// turf, so this moves the mob into a container without ever changing the grid cell it sits in.
	var/mob/living/carbon/human/stuffed = allocate(/mob/living/carbon/human/consistent)
	stuffed.forceMove(compactor)
	TEST_ASSERT(!(stuffed in compactor.compactable()), "the compactor was willing to destroy a living mob")

	// The junk is still fair game with all of that sitting beside it.
	TEST_ASSERT(junk in compactor.compactable(), "protected contents made the compactor refuse ordinary rubbish too")

	// Out of the bin before teardown starts qdeleting things around it.
	stuffed.forceMove(run_loc_floor_bottom_left)
