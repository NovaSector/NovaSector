/obj/item/xenoarch
	name = "measuring tape"
	desc = "A measuring tape specifically produced to measure the depth that has been dug into strange rocks."
	icon = 'modular_nova/modules/xenoarch/icons/xenoarch_items.dmi'
	icon_state = "tape"

// HAMMERS

/obj/item/xenoarch/hammer
	name = "hammer (1cm)"
	icon_state = "hammer1"
	desc = "A hammer that can be used to remove dirt from strange rocks."
	tool_behaviour = TOOL_HAMMER
	var/dig_amount = 1
	var/dig_speed = 0.5 SECONDS
	var/advanced = FALSE

/obj/item/xenoarch/hammer/examine(mob/user)
	. = ..()
	if(advanced)
		. += span_notice("This is an advanced hammer. It can change its digging depth from 1 to 30. Click to change depth.")

	. += span_notice("Current Digging Depth: [dig_amount]cm")

/obj/item/xenoarch/hammer/attack_self(mob/user, modifiers)
	. = ..()
	if(!advanced)
		to_chat(user, span_warning("This is not an advanced hammer, it cannot change its digging depth."))
		return

	var/user_choice = input(user, "Choose the digging depth. 1 to 30", "Digging Depth Selection") as null|num
	if(!user_choice)
		dig_amount = 1
		dig_speed = 1
		return

	if(dig_amount <= 0)
		dig_amount = 1
		dig_speed = 1
		return

	var/round_dig = round(user_choice)
	if(round_dig >= 30)
		dig_amount = 30
		dig_speed = 30
		return

	dig_amount = round_dig
	dig_speed = round_dig * 0.5
	to_chat(user, span_notice("You change the hammer's digging depth to [round_dig]cm."))

/obj/item/xenoarch/hammer/cm2
	name = "hammer (2cm)"
	icon_state = "hammer2"
	dig_amount = 2
	dig_speed = 1 SECONDS

/obj/item/xenoarch/hammer/cm3
	name = "hammer (3cm)"
	icon_state = "hammer3"
	dig_amount = 3
	dig_speed = 1.5 SECONDS

/obj/item/xenoarch/hammer/cm4
	name = "hammer (4cm)"
	icon_state = "hammer4"
	dig_amount = 4
	dig_speed = 2 SECONDS

/obj/item/xenoarch/hammer/cm5
	name = "hammer (5cm)"
	icon_state = "hammer5"
	dig_amount = 5
	dig_speed = 2.5 SECONDS

/obj/item/xenoarch/hammer/cm6
	name = "hammer (6cm)"
	icon_state = "hammer6"
	dig_amount = 6
	dig_speed = 3 SECONDS

/obj/item/xenoarch/hammer/cm10
	name = "hammer (10cm)"
	icon_state = "hammer10"
	dig_amount = 10
	dig_speed = 5 SECONDS

/obj/item/xenoarch/hammer/adv
	name = "advanced hammer"
	icon_state = "adv_hammer"
	dig_amount = 1
	dig_speed = 1
	advanced = TRUE

// BRUSHES

/obj/item/xenoarch/brush
	name = "brush"
	desc = "A brush that is used to uncover the secrets of the past from strange rocks. Also useful to clean up broken items."
	var/dig_speed = 3 SECONDS
	icon_state = "brush"

/obj/item/xenoarch/brush/adv
	name = "advanced brush"
	dig_speed = 0.5 SECONDS
	icon_state = "adv_brush"

// MISC.

/obj/item/xenoarch/handheld_scanner
	name = "handheld scanner"
	desc = "A handheld scanner for strange rocks. It tags the depths to the rock."
	icon_state = "scanner"
	var/scanning_speed = 2 SECONDS
	var/scan_advanced = FALSE

/obj/item/xenoarch/handheld_scanner/advanced
	name = "advanced handheld scanner"
	icon_state = "adv_scanner"
	scanning_speed = 1 SECONDS
	scan_advanced = TRUE

/obj/item/xenoarch/handheld_radar
	name = "handheld radar"
	desc = "A surface radar for unexpected objects in the sedimentary layer."
	icon_state = "recoverer"

/datum/scavenge_profile
	/// ckey of the player used as unique identifier for the archeology system scavenge sites.
	var/ckey
	/// turf that serves to mark the archeological site that will respond to that client.
	var/turf/site = null
	/// this is the leeway variable for digging a site. At 0 it means the digging it needs to be precise, at 1 it means it can be between one tile of the precise site, and so on.
	var/site_radius

/obj/item/xenoarch/handheld_radar
	/// Minimum amount of distance from the user that the dig site will spawn in.
	var/min_distance = 24
	/// Maximum amount of distance from the user that the dig site will spawn in.
	var/max_distance = 52
	/// Speed it takes for the Scanner to do any scan operation that needs attention, ie, scan the digsite for the missing bit (the full scan is done in intervals). Do not reduce this under 3 seconds.
	var/scanner_speed = 5 SECONDS
	/// Speed it takes for the Scanner to dig out rocks
	var/digging_speed = 5 SECONDS
	/// How precise the scanner needs to be to dig out the treasures. Archeology has a change to give 1 more, the more leeway, the better.
	var/scanner_leeway = 1
	/// Static list of players profiles so their searchs are saved.
	var/static/list/profiles
	/// Mining areas we allow.
	var/static/list/allowed_areas = typecacheof(list(
			/area/forestplanet,
			/area/icemoon,
			/area/lavaland,
			/area/ocean,
			/area/ruin,
	))
	/// Mining areas we don't allow.
	var/static/list/disallowed_areas = typecacheof(list(
			/area/ruin/interdyne_planetary_base,
			/area/ruin/unpowered/ash_walkers,
			/area/ruin/unpowered/primitive_catgirl_den,
	))
	/// Turfs we don't allow.
	var/static/list/disallowed_turfs = typecacheof(list(
			/turf/open/lava,
			/turf/open/chasm,
			/turf/open/openspace,
			/turf/open/water,
	))
	COOLDOWN_DECLARE(tool_scan)

/obj/item/xenoarch/handheld_radar/click_alt(mob/user)
	scan(user)
	return CLICK_ACTION_SUCCESS

/obj/item/xenoarch/handheld_radar/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the [src] to start the scan.")
	. += span_notice("Use the [src] on the ground to dig the rocks.")
	. += span_notice("Use the [src] on your hand or right click to pinpoint the digsite.")

/obj/item/xenoarch/handheld_radar/pre_attack(atom/target, mob/user)
	if(isturf(target))
		check_dig(user, target)

/obj/item/xenoarch/handheld_radar/attack_self(mob/user, list/modifiers)
	. = ..()

	scan_digsite(user)

/obj/item/xenoarch/handheld_radar/attack_self_secondary(mob/user, modifiers)
	. = ..()

	scan_digsite(user)

// Checks wherever a particular turf is 
/obj/item/xenoarch/handheld_radar/proc/is_valid_scavenge_turf(turf/candidate_turf)
	if (is_type_in_typecache(candidate_turf, disallowed_turfs))
		return FALSE
	var/candidate_area = get_area(candidate_turf)
	if (!is_type_in_typecache(candidate_area, allowed_areas) || is_type_in_typecache(candidate_area, disallowed_areas))
		return FALSE
	return TRUE

// Gets the profile of the user ckey, or creates a new one should it be needed.
/obj/item/xenoarch/handheld_radar/proc/get_profile(mob/user)
	var/datum/scavenge_profile/profile = LAZYACCESS(profiles, user.ckey)
	if(!profile)
		profile = new
		profile.ckey = user.ckey
		LAZYSET(profiles, user.ckey, profile)
	return profile

// Makes 50 tries to get a turf in a radius between min and max distance of the caller, ensuring not to count places outside the map, and then validating the turf is one of the allowed types.
/obj/item/xenoarch/handheld_radar/proc/pick_valid_turf_in_range(mob/user)
	var/turf/candidate_turf = null
	if (!user)
		return null
	for(var/i = 0; i < 50; i++)
		var/angle = rand(0, 360)
		var/radius = rand(min_distance, max_distance)
		var/offset_x = round(radius * cos(angle))
		var/offset_y = round(radius * sin(angle))

		var/x = user.x + offset_x
		var/y = user.y + offset_y
		var/z = user.z

		if(x < 1) x = 1 + (1 - x)
		if(y < 1) y = 1 + (1 - y)
		if(x > world.maxx) x = world.maxx - (x - world.maxx)
		if(y > world.maxy) y = world.maxy - (y - world.maxy)

		candidate_turf = locate(x, y, z)
		if(candidate_turf && is_valid_scavenge_turf(candidate_turf))
			break
		candidate_turf = null
	return candidate_turf

// Initiates the scan action for the radar, checking the user is able to and on the right conditions to get a new digging site, then stores that along with the ckey of the user and special modifiers like the leeway they rolled to dig at the area.
/obj/item/xenoarch/handheld_radar/proc/scan(mob/user)
	if(!COOLDOWN_FINISHED(src, tool_scan))
		return

	COOLDOWN_START(src, tool_scan, 2 SECONDS)

	if(!(is_mining_level(user.z)))
		user.balloon_alert(user, "error!")
		to_chat(user, span_warning("You aren't in a sector where the radar can be used! try moving to a mining sector."))
		return FALSE

	var/user_area = get_area(user)
	if (!is_type_in_typecache(user_area, allowed_areas) || is_type_in_typecache(user_area, disallowed_areas))
		user.balloon_alert(user, "error!")
		to_chat(user, span_warning("You aren't standing in a natural area, try moving to one before trying again."))
		return FALSE

	var/datum/scavenge_profile/profile = get_profile(user)
	
	user.visible_message(span_notice("[user] triggers a pulse from their handheld radar, scanning the surrounding area."), \
	span_notice("You trigger a pulse from the handheld radar, scanning for potential dig sites."))
	user.balloon_alert(user, "scanning signal..!")
	if(!do_after(user, scanner_speed))
		user.balloon_alert(user, "interrupted!")
		return FALSE
	user.balloon_alert(user, "triangulating signal..!")
	if(!do_after(user, scanner_speed))
		user.balloon_alert(user, "interrupted!")
		return FALSE
	user.balloon_alert(user, "locking signal..!")
	if(!do_after(user, scanner_speed))
		user.balloon_alert(user, "interrupted!")
		return FALSE
	var/candidate_turf = pick_valid_turf_in_range(user)

	if(!candidate_turf)
		user.balloon_alert(user, "not found!")
		to_chat(user, span_warning("The radar couldn't find a suitable digging site."))
		return FALSE

	profile.site = candidate_turf
	profile.site_radius = scanner_leeway
	var/chance = user.mind?.get_skill_modifier(/datum/skill/archeology, SKILL_PROBS_MODIFIER) || 0
	if(prob(clamp(chance - 40, 0, 100)))
		profile.site_radius++
		to_chat(user, span_notice("Your knowledge of archeology helps you interpret the radar signals more accurately, giving you a bit of extra leeway."))
	user.balloon_alert(user, "site located!")
	playsound(src, 'sound/machines/compiler/compiler-stage1.ogg', 75)
	return TRUE

// This is the digging action, operates when you try to dig in the leeway area of the archeological site, its the one that spawns the rocks and calculates how many, as well as awrding xp
/obj/item/xenoarch/handheld_radar/proc/check_dig(mob/user, turf/dig_turf)
	if(!COOLDOWN_FINISHED(src, tool_scan))
		return

	COOLDOWN_START(src, tool_scan, 2 SECONDS)
	var/datum/scavenge_profile/profile = get_profile(user)
	if(!profile.site)
		return FALSE

	user.visible_message(span_notice("[user] methodically scans the ground and digs through the sediment of [dig_turf]."), \
	span_notice("You carefully scan and dig through the sediment of [dig_turf], searching for anything unusual."))
	var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/archeology, SKILL_SPEED_MODIFIER)
	if(!do_after(user, digging_speed * skill_modifier, target = dig_turf))
		user.balloon_alert(user, "interrupted!")
		return FALSE

	var/turf/site_turf = profile.site
	var/radius = profile.site_radius

	var/dif_x = abs(dig_turf.x - site_turf.x)
	var/dif_y = abs(dig_turf.y - site_turf.y)
	var/dif_z = dig_turf.z - site_turf.z

	if(dif_x > radius || dif_y > radius || dif_z != 0)
		user.visible_message(span_notice("[user] scans and digs through [dig_turf], but doesn't seem to find anything of interest."), \
		span_notice("You carefully dig through [dig_turf], but the scanner doesn't indicate anything useful here."))
		return FALSE

	profile.site = null
	
	var/rocks_amount = 1
	to_chat(user, span_notice("You sift through the sediment and recover some rock fragments."))
	if(prob(user.mind?.get_skill_modifier(/datum/skill/archeology, SKILL_PROBS_MODIFIER)))
		rocks_amount++
		to_chat(user, span_notice("With practiced skill, you spot and extract an extra rock!"))
	if(prob(50))
		rocks_amount++
		to_chat(user, span_notice("You get lucky and uncover an extra rock while digging!"))
	if (SSmapping.level_trait(dig_turf.z, ZTRAIT_LAVA_RUINS)) // review when Lavaland 2.0 comes out. - logic here is that lavaland is more dangerous than snow, thus, extra rock.
		rocks_amount++
		to_chat(user, span_notice("The necropolis is rich with buried remnants. You uncover an extra rock while digging."))
	for(var/i in 1 to rocks_amount)
		new /obj/item/xenoarch/strange_rock(dig_turf)
	user.mind?.adjust_experience(/datum/skill/archeology, rocks_amount*25)
	return TRUE

// This generates an arrow of color based on the distance of the archeological site, and pointing in the direction of it, when you are in the site, it will no longer show an arrow, but you will have to make an educated guess as the exact site (counting of course on the leeway you rolled previously.)
/obj/item/xenoarch/handheld_radar/proc/scan_digsite(mob/user)
	if(!COOLDOWN_FINISHED(src, tool_scan))
		return

	COOLDOWN_START(src, tool_scan, 2 SECONDS)
	var/datum/scavenge_profile/profile = get_profile(user)
	if(!profile.site)
		user.balloon_alert(user, "error!")
		to_chat(user, span_warning("You don't have a site locked in! You need to do a long range scan first."))
		return
	
	var/turf/candidate_turf = profile.site
	if(profile.site.z != user.z)
		user.balloon_alert(user, "error!")
		to_chat(user, span_warning("You are not in the same sector as the scanned site."))
		return
	
	// We get the distance and direction from the user/tool to the turf we are heading towards.
	var/dist = get_dist(src, candidate_turf)
	var/dir = get_dir(user, candidate_turf)
	var/arrow_color

	// We pick the color (or break early) based on the distance we got.
	switch(dist)
		if (0 to 4)
			user.balloon_alert(user, "site close!")
			return
		if(5 to 10)
			user.balloon_alert(user, "! ! ! !")
			arrow_color = COLOR_GREEN
		if(10 to 15)
			user.balloon_alert(user, "! ! !")
			arrow_color = COLOR_YELLOW
		if(15 to 24)
			user.balloon_alert(user, "! !")
			arrow_color = COLOR_ORANGE
		else
			user.balloon_alert(user, "!")
			arrow_color = COLOR_RED

	// We create and validate the user hud
	var/datum/hud/user_hud = user.hud_used
	if(!user_hud || !istype(user_hud, /datum/hud) || !islist(user_hud.infodisplay))
		return

	// We use our data to color and move the arrow on the player's hud as needed
	var/atom/movable/screen/radar_arrow/arrow = new(null, user_hud)
	arrow.color = arrow_color
	arrow.screen_loc = around_player
	arrow.transform = matrix(dir2angle(dir), MATRIX_ROTATE)

	user_hud.infodisplay += arrow
	user_hud.show_hud(user_hud.hud_version)

	// We kill the arrow hud after a bit to avoid clutter.
	QDEL_IN(arrow, 1.5 SECONDS)

/atom/movable/screen/radar_arrow
	icon = 'icons/effects/96x96.dmi'
	icon_state = "multitool_arrow"
	pixel_x = -32
	pixel_y = -32

/atom/movable/screen/radar_arrow/Destroy()
	if(hud)
		hud.infodisplay -= src
		INVOKE_ASYNC(hud, TYPE_PROC_REF(/datum/hud, show_hud), hud.hud_version)
	return ..()

/obj/item/xenoarch/brush/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(istype(interacting_with, /obj/item/xenoarch/broken_item))
		var/obj/item/xenoarch/broken_item/brushed_item = interacting_with
		if (!brushed_item.loot)
			to_chat(user, span_notice("The item has no loot, if this item wasn't produced by an admin, speak to a coder."))
			return NONE
		var/turf/src_turf = get_turf(brushed_item)
		var/recovered_loot = brushed_item.loot
		new recovered_loot(src_turf)
		user.mind?.adjust_experience(/datum/skill/archeology, brushed_item.dig_xp)
		qdel(interacting_with)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/storage/belt/utility/xenoarch
	name = "xenoarch toolbelt"
	desc = "Holds archeological tools, gps, small pickaxe and a surprisingly amount of paper notes and clips."
	icon = 'modular_nova/modules/xenoarch/icons/xenoarch_items.dmi'
	icon_state = "xenoarch_belt"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_CREW * 2
	storage_type = /datum/storage/xenoarch_belt

/datum/storage/xenoarch_belt
	max_total_storage = 100
	max_slots = 15

/datum/storage/xenoarch_belt/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	set_holdable(list(
		/obj/item/xenoarch/hammer,
		/obj/item/xenoarch/brush,
		/obj/item/xenoarch,
		/obj/item/xenoarch/core_sampler,
		/obj/item/xenoarch/handheld_scanner,
		/obj/item/xenoarch/handheld_radar,
		/obj/item/xenoarch/anomaly_stabilizer,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/mining_scanner,
		/obj/item/gps,
		/obj/item/pickaxe/mini,
		/obj/item/paper,
		/obj/item/pen,
	))

/obj/item/storage/belt/utility/xenoarch/full
	custom_premium_price = PAYCHECK_CREW * 15

/obj/item/storage/belt/utility/xenoarch/full/PopulateContents()
	. = ..()
	new /obj/item/xenoarch/hammer(src)
	new /obj/item/xenoarch/hammer/cm2(src)
	new /obj/item/xenoarch/hammer/cm3(src)
	new /obj/item/xenoarch/hammer/cm4(src)
	new /obj/item/xenoarch/hammer/cm5(src)
	new /obj/item/xenoarch/hammer/cm6(src)
	new /obj/item/xenoarch/hammer/cm10(src)
	new /obj/item/xenoarch/brush(src)
	new /obj/item/xenoarch(src)
	new /obj/item/xenoarch/handheld_scanner(src)
	new /obj/item/xenoarch/handheld_radar(src)
	new /obj/item/mining_scanner(src)
	new /obj/item/paper/fluff/xenoarch_guide(src)

/obj/item/storage/bag/xenoarch
	name = "xenoarch mining satchel"
	desc = "This little bugger can be used to store and transport strange rocks."
	icon = 'modular_nova/modules/xenoarch/icons/xenoarch_items.dmi'
	icon_state = "satchel"
	worn_icon_state = "satchel"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	storage_type = /datum/storage/bag/xenoarch
	var/insert_speed = 1 SECONDS
	var/mob/listeningTo
	var/range = null

	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it

/datum/storage/bag/xenoarch
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = 1000
	max_slots = 25
	numerical_stacking = FALSE

/datum/storage/bag/xenoarch/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	set_holdable(list(/obj/item/xenoarch/strange_rock))

/obj/item/storage/bag/xenoarch/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(pickup_rocks))
	listeningTo = user

/obj/item/storage/bag/xenoarch/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/xenoarch/proc/pickup_rocks(mob/living/user)
	SIGNAL_HANDLER
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return

	if(atom_storage)
		for(var/A in tile)
			if (!is_type_in_typecache(A, atom_storage.can_hold))
				continue
			else if(atom_storage.attempt_insert(A, user))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, span_warning("Your [name] is full and can't hold any more!"))
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, storage_type.rustle_sound, 50, TRUE)
		user.visible_message(span_notice("[user] scoops up the rocks beneath [user.p_them()]."), \
			span_notice("You scoop up the rocks beneath you with your [name]."))
	spam_protection = FALSE

/obj/item/storage/bag/xenoarch/adv
	name = "advanced xenoarch mining satchel"
	icon_state = "adv_satchel"
	insert_speed = 0.1 SECONDS
	storage_type = /datum/storage/bag/xenoarch/adv

/datum/storage/bag/xenoarch/adv
	max_slots = 50

/obj/structure/closet/xenoarch
	name = "xenoarchaeology equipment locker"
	icon_state = "science"

/obj/structure/closet/xenoarch/PopulateContents()
	. = ..()
	new /obj/item/storage/bag/xenoarch(src)
	new /obj/item/storage/belt/utility/xenoarch/full(src)
	new /obj/item/t_scanner/adv_mining_scanner(src)
	new /obj/item/pickaxe/mini(src)

/obj/structure/closet/xenoarch/ashwalker_version
	name = "dusty xenoarchaeology equipment locker"

/obj/structure/closet/xenoarch/ashwalker_version/PopulateContents()
	. = ..()
	new /obj/item/storage/bag/xenoarch(src)
	new /obj/item/storage/belt/utility/xenoarch/full(src)
	new /obj/item/t_scanner/adv_mining_scanner(src)
	new /obj/item/pickaxe/mini(src)	// we add a second set because we recognice tribals wanting to play with the system by more than one person.
