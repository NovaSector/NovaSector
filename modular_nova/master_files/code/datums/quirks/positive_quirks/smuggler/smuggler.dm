#define TIMER_MIN 45 MINUTES
#define TIMER_MAX 1 HOURS

/datum/quirk/smuggler
	name = "Contraband Smuggler"
	desc = "Thanks to your connections, an illegal yet lucrative item will be shipped to you via the cargo shuttle, somewhere later in the shift."
	icon = FA_ICON_ENVELOPE
	value = 8
	medical_record_text = "Patient makes friends in the wrong places."
	gain_text = span_notice("You're hoping to be receiving a parcel later on in the shift...")
	lose_text = span_danger("You doubt you'll still be receiving that parcel...")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	/// weakref of the quirk holder's mind, to open the mail
	var/datum/weakref/mind_ref
	/// wether or not we should try the long timer, or the short timer if the aforementioned has expired already
	var/timer_passed = FALSE

/datum/quirk_constant_data/smuggler
	associated_typepath = /datum/quirk/smuggler
	customization_options = list(/datum/preference/choiced/smuggler)

/datum/quirk/smuggler/post_add()
	mind_ref = WEAKREF(quirk_holder.mind)
	if(!can_run())
		qdel(src)
		return
	if(!timer_passed)
		set_mail_timer()

/datum/quirk/smuggler/remove()
	if(QDELING(quirk_holder) || istype(quirk_holder, /mob/living/carbon/human/consistent))
		return
	QDEL_NULL(mind_ref)


// if the quirk should run
/datum/quirk/smuggler/proc/can_run()
	if(!check_postoffice())
		to_chat(quirk_holder, span_warning("Your [name] quirk did not load due to the mail being blocked this round!"))
		return FALSE
	if(!check_job_blacklist(mind_ref.resolve()))
		to_chat(quirk_holder, span_warning("Your [name] quirk did not load due to your job ([quirk_holder.mind?.assigned_role.title]) being on its blacklist!"))
		return FALSE
	return TRUE

// is mail being delivered today?
/datum/quirk/smuggler/proc/check_postoffice()
	if(SSeconomy.mail_blocked)
		return FALSE
	return TRUE

// job blacklist for the jobs that shouldnt do illegal stuff and get fined
/datum/quirk/smuggler/proc/check_job_blacklist(datum/mind/recipient)
	var/static/list/blacklisted_jobs = list(
		JOB_CAPTAIN,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_CUSTOMS_AGENT,
		JOB_ORDERLY,
		JOB_SCIENCE_GUARD,
		JOB_PRISONER,
		JOB_CORRECTIONS_OFFICER,
	//	JOB_BOUNCER, don't uncomment this is here so you know its intentional
		JOB_QUARTERMASTER,
		JOB_HEAD_OF_PERSONNEL,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_RESEARCH_DIRECTOR,
		JOB_CHIEF_ENGINEER,
		JOB_BLUESHIELD,
		JOB_NT_REP,
	//	JOB_BRIDGE_ASSISTANT, same deal
	)
	if(!recipient)
		return FALSE
	if (recipient.assigned_role.title in blacklisted_jobs)
		return FALSE
	return TRUE

// adds either the original timer, or a short timer for when the shuttle doesn't allow mail to spawn
/datum/quirk/smuggler/proc/set_mail_timer()
	if(!timer_passed)
		addtimer(CALLBACK(src, PROC_REF(try_smuggle)), rand(TIMER_MIN, TIMER_MAX), TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_DELETE_ME)
	else //check if the shuttle is at CC every once in a while
		addtimer(CALLBACK(src, PROC_REF(try_smuggle)), 1 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_DELETE_ME)

// try to run the quirk, or loop back into a timer if not able to
/datum/quirk/smuggler/proc/try_smuggle()
	timer_passed = TRUE
	var/turf/open/spot = find_a_spot()
	if(!spot || is_station_level(spot?.z))
		set_mail_timer()
		return
	// build parcel
	create_parcel(new /obj/item/mail(spot))
	// roll for penalty
	try_penalty()

// find a tile on the cargo shuttle to be placed at
/datum/quirk/smuggler/proc/find_a_spot()
	var/list/empty_shuttle_turfs = list()
	var/list/area/shuttle/shuttle_areas = SSshuttle.supply.shuttle_areas
	for(var/area/shuttle/shuttle_area as anything in shuttle_areas)
		for(var/turf/open/floor/shuttle_turf in shuttle_area.get_turfs_from_all_zlevels())
			if(shuttle_turf.is_blocked_turf())
				continue
			empty_shuttle_turfs += shuttle_turf
	if(!length(empty_shuttle_turfs))
		return
	return pick(empty_shuttle_turfs)

// build and add some flavor to the mail item
/datum/quirk/smuggler/proc/create_parcel(obj/item/mail/illegal_parcel)
	illegal_parcel.recipient_ref = mind_ref
	illegal_parcel.name = "unmarked parcel for [mind_ref.resolve()]"
	illegal_parcel.desc = "A shady package that seems to have slipped between the cracks, it isn't postmarked."
	illegal_parcel.postmarked = FALSE
	illegal_parcel.color = pick(list(COLOR_FLOORTILE_GRAY, COLOR_ASSISTANT_OLIVE, COLOR_RUSTED_GLASS))
	illegal_parcel.cut_overlays()
	illegal_parcel.update_icon()
	illegal_parcel.pixel_y = rand(-12, 12)
	illegal_parcel.pixel_x = rand(-12, 12)
	if(add_contraband(illegal_parcel, GLOB.smuggler_items[quirk_holder.client?.prefs?.read_preference(/datum/preference/choiced/smuggler)]))
		return
	qdel(illegal_parcel)
	set_mail_timer() //spawning error, try again later

// add the actual contraband
/datum/quirk/smuggler/proc/add_contraband(obj/item/mail/illegal_parcel, contraband_path)
	if(ispath(contraband_path, /datum/computer_file/program))
		var/obj/item/disk/computer/shady_floppy = new(illegal_parcel)
		shady_floppy.name = "shady floppy disk"
		shady_floppy.icon_state = "datadisk3"
		shady_floppy.sticker_icon_state = "o_damaged"
		shady_floppy.add_file(new contraband_path)
		shady_floppy.cut_overlays()
		shady_floppy.update_icon()
		return TRUE
	else if(ispath(contraband_path, /obj/item))
		new contraband_path(illegal_parcel)
		return TRUE
	return FALSE

// if a penalty should run
/datum/quirk/smuggler/proc/try_penalty()
	if(rand(1, 30 == 1))
		var/datum/record/crew/record = find_record(mind_ref.resolve()) || find_record("[trim(first_name(mind_ref.resolve()), 2)]. [last_name(mind_ref.resolve())]") //visitor id shit
		fine(record)

// uh oh, looks like customs knows what you're upto...
/datum/quirk/smuggler/proc/fine(datum/record/crew/record)
	if(!record)
		return
	var/datum/crime/citation/citation = new(
		name = "Fraud",
		details = "CC customs have inspected a parcel belonging to [record.name] and declared it as unlawful.",
		author = "CentCom customs",
		fine = 250,
	)
	record.citations += citation
	aas_config_announce(/datum/aas_config_entry/cc_customs_inspection, list("PERSON" = record.name), src, list(RADIO_CHANNEL_SECURITY), RADIO_CHANNEL_SECURITY)

/datum/aas_config_entry/cc_customs_inspection
	name = "CentCom Customs"
	announcement_lines_map = list(
		RADIO_CHANNEL_SECURITY = "SECURITY ALERT: %PERSON has been found guilty for transfer of illegal goods. A fine of 250 Cr have been applied automatically, please see it through as paid.",
	)
	vars_and_tooltips_map = list(
		"PERSON" = "will be replaced with the name of the user",
	)


//list of contraband choices
GLOBAL_LIST_INIT(smuggler_items, list(
	"NV health meson goggles" = /obj/item/clothing/glasses/hud/health/night/meson,
	"Badass sunglasses" = /obj/item/clothing/glasses/sunglasses/robohand,
	"Fission360 PDA program" = /datum/computer_file/program/radar/fission360,
	"SyndEye PDA program" = /datum/computer_file/program/secureye/syndicate,
	"Aranesp pill bottle" = /obj/item/storage/pill_bottle/aranesp,
	"4U70-P3R4710N skillchip" = /obj/item/skillchip/self_surgery,
))

//pref for the contraband item choices
/datum/preference/choiced/smuggler
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "smuggler"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/smuggler/init_possible_values()
	return GLOB.smuggler_items

/datum/preference/choiced/smuggler/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Contraband Smuggler" in preferences.all_quirks

/datum/preference/choiced/smuggler/apply_to_human(mob/living/carbon/human/target, value)
	return

#undef TIMER_MIN
#undef TIMER_MAX
