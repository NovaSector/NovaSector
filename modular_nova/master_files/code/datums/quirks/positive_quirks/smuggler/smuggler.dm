/datum/quirk/smuggler
	name = "Smuggler"
	desc = "Smuggle an item onboard after an amount of time."
	icon = FA_ICON_USER_SECRET
	value = 8
	medical_record_text = ""
	gain_text = span_notice("")
	lose_text = span_danger("")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	/// weakref of the quirk holder's mind, to open the mail
	var/datum/weakref/mind_ref
	/// type-path of chosen contraband item
	var/contraband
	/// binary wether or not we should try the long timer, or the short timer if the aforementioned has expired already
	var/timer_passed = FALSE

/datum/quirk_constant_data/smuggler
	associated_typepath = /datum/quirk/smuggler
	customization_options = list(/datum/preference/choiced/smuggler)

/datum/quirk/smuggler/add(client/client_source)
	var/item_choice = client_source?.prefs.read_preference(/datum/preference/choiced/smuggler)
	if(!item_choice)
		return
	contraband = GLOB.smuggler_items[item_choice]

/datum/quirk/smuggler/post_add()
	mind_ref = WEAKREF(quirk_holder.mind)
	add_timer()

/datum/quirk/smuggler/remove()
	if(QDELING(quirk_holder) || istype(quirk_holder, /mob/living/carbon/human/consistent))
		return
	QDEL_NULL(mind_ref)
	contraband = null

// adds either the original timer, or a short timer for when the shuttle doesn't allow mail to spawn
/datum/quirk/smuggler/proc/add_timer()
	if(!timer_passed)
		addtimer(CALLBACK(src, PROC_REF(try_to_add_to_shuttle)), rand(25 MINUTES, 45 MINUTES, TIMER_OVERRIDE|TIMER_DELETE_ME))
	else
		addtimer(CALLBACK(src, PROC_REF(try_to_add_to_shuttle)), 2.5 MINUTES, TIMER_OVERRIDE|TIMER_DELETE_ME) //check if the shuttle is at CC every once in a while

// actually place the item, or loop back into a timer if not able to
/datum/quirk/smuggler/proc/try_to_add_to_shuttle()
	timer_passed = TRUE
	var/turf/open/spot = find_a_spot()
	if(!spot || is_station_level(spot?.z) || !mind_ref)
		add_timer()
		return
	// build parcel
	var/obj/item/mail/illegal_parcel = new /obj/item/mail(spot)
	illegal_parcel.recipient_ref = mind_ref
	new contraband(illegal_parcel)

// find a tile on the cargo shuttle to be placed at
/datum/quirk/smuggler/proc/find_a_spot()
	var/list/empty_shuttle_turfs = list()
	var/list/blocked_shutte_turfs = list()
	var/list/area/shuttle/shuttle_areas = SSshuttle.supply.shuttle_areas
	for(var/area/shuttle/shuttle_area as anything in shuttle_areas)
		for(var/turf/open/floor/shuttle_turf in shuttle_area.get_turfs_from_all_zlevels())
			if(shuttle_turf.is_blocked_turf())
				blocked_shutte_turfs += shuttle_turf
				continue
			empty_shuttle_turfs += shuttle_turf
	if(!empty_shuttle_turfs.len)
		return FALSE
	return pick(empty_shuttle_turfs)

//list of contraband choices
GLOBAL_LIST_INIT(smuggler_items, list(
	"Screwdriver" = /obj/item/screwdriver,
))

//pref for the choices
/datum/preference/choiced/smuggler
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "smuggler"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/smuggler/init_possible_values()
	return GLOB.smuggler_items

/datum/preference/choiced/smuggler/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Smuggler" in preferences.all_quirks

/datum/preference/choiced/smuggler/apply_to_human(mob/living/carbon/human/target, value)
	return
