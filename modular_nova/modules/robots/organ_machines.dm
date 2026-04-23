/// How long does it take to break out of the machine?
#define BREAKOUT_TIME 5 SECONDS
/// The interval that advertisements are said by the machine's speaker.
#define ADVERT_TIME 10 SECONDS

/datum/design/board/robotifier
	name = "Machine Design (CHOPSHOP)"
	desc = "The circuit board for the CHOPSHOP, for replacing an organic humanoid's internal organs with robotic ones with the press of a button."
	id = "robotifier"
	build_path = /obj/item/circuitboard/machine/robotifier
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/obj/item/circuitboard/machine/robotifier
	name = "CHOPSHOP (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/robotifier
	req_components = list(/datum/stock_part/micro_laser = 1)

/obj/machinery/robotifier
	name = "CHOPSHOP"
	desc = "The CHOPSHOP (that is the official, BRANDED name) is a tight, fully mechanized surgery theatre originally sold to Galactic (para)militaries as \
	a means to prevent fatal casualities, at a high cost. When inserted inside, the machine automatically replaces the presumably dead or dying \
	patient's entire body with cybernetic parts. This produces a conscious and able-bodied person very quickly, who is able to work and fight, \
	but also trapped in a body which is not their own."
	icon = 'modular_nova/modules/robots/sprites/organ.dmi'
	icon_state = "robotifier_open"
	circuit = /obj/item/circuitboard/machine/robotifier
	state_open = FALSE
	density = TRUE
	/// Is someone being processed inside of the machine?
	var/processing = FALSE
	/// How long does the machine take to work?
	var/processing_time = 30 SECONDS
	/// wzhzhzh
	var/datum/looping_sound/microwave/sound_loop
	/// A list containing advertisements that the machine says while working.
	var/static/list/advertisements = list(\
	"WARNING: The CHOPSHOP is a one-way process. Do not use the CHOPSHOP without signing the consent form.", \
	"The CHOPSHOP is not to be used by the elderly without direct adult supervision. Nanotrasen is not liable for any and all injuries sustained under unsupervised usage of the CHOPSHOP.", \
	"The CHOPSHOP is not to be used un-cleaned. Thanks to its non-stick coating, cleaning up after a failed organ replacement is easy as cleaning a microwave. Blood just doesn't stick!", \
	"Before using the CHOPSHOP, remove any and all metal devices, liquid containers over 12 ounces, and anything with sensitive electronics." , \
	"Remember, this is not cyborgification! Robotification is a legally distinct, Nanotrasen patent pending procedure. Still have questions? Call your nearest Nanotrasen Representative to requisition more information about the CHOPSHOP!")
	var/list/organ_slots = list(
		ORGAN_SLOT_BRAIN,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_APPENDIX
	)
	var/list/organ_paths = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/robot_nova,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs/cooling_fans,
		ORGAN_SLOT_HEART = /obj/item/organ/heart/oil_pump,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/fuel_generator,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/camera,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/microphone,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/speaker,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/cleaning_filter,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix/random_number_database,
	)
	var/bloodtype_to_use = BLOOD_TYPE_OIL
	COOLDOWN_DECLARE(advert_time)
	COOLDOWN_DECLARE(processing_time_cooldown)

/datum/area_spawn/chopshop
	target_areas = list(/area/station/science/robotics/lab, /area/station/science/robotics/mechbay)
	desired_atom = /obj/machinery/robotifier
	mode = AREA_SPAWN_MODE_HUG_WALL

/obj/machinery/robotifier/Initialize(mapload)
	. = ..()
	sound_loop = new(src, FALSE)
	register_context()
	update_appearance()

/obj/machinery/robotifier/Destroy()
	QDEL_NULL(sound_loop)
	return ..()

/obj/machinery/robotifier/update_appearance(updates)
	. = ..()
	if(isnull(occupant))
		icon_state = state_open ? "robotifier_open" : "robotifier_empty"
	else
		switch(processing)
			if(FALSE)
				icon_state = "robotifier_occupied"
			if(TRUE)
				icon_state = "robotifier_on"

/obj/machinery/robotifier/close_machine(atom/movable/target, density_to_set = TRUE)
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(!occupant)
		return FALSE
	if(!ishuman(occupant))
		occupant.forceMove(drop_location())
		set_occupant(null)
		return FALSE
	to_chat(occupant, span_notice("You enter [src]."))
	update_appearance()

/obj/machinery/robotifier/examine(mob/user)
	. = ..()
	. += span_info("Laser power <b>[display_power(active_power_usage)]</b> at average cycle time of <b>[DisplayTimeText(processing_time)]</b>.")

	if(processing)
		. += span_notice("The status display indicates <b>[DisplayTimeText(COOLDOWN_TIMELEFT(src, processing_time_cooldown), 2)]</b> remaining on the current cycle.")
	else
		. += span_notice("Left-click to <b>[state_open ? "close" : "open"]</b>.")
		if(!isnull(occupant) && !state_open)
			. += span_notice("<b>Alt-click</b> to turn on.")

/obj/machinery/robotifier/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!processing)
		context[SCREENTIP_CONTEXT_LMB] = "[state_open ? "Close" : "Open"] machine"
	if(!isnull(occupant) && !state_open && !processing)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "Start machine"

	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/robotifier/interact(mob/user)
	if(state_open)
		close_machine()
		return

	if(!processing)
		open_machine()
		return

/obj/machinery/robotifier/click_alt(mob/user)
	if(!powered() || !occupant || state_open || processing)
		return CLICK_ACTION_BLOCKING

	user.visible_message(span_notice("[user] presses the start button of the [src]."), span_notice("You press the start button of the [src]."))
	start_procedure()
	return CLICK_ACTION_SUCCESS

/obj/machinery/robotifier/process(seconds_per_tick)
	if(!processing)
		return

	if(!powered() && occupant && processing)
		eject_early(damaged_goods = TRUE)
		return

	if(!powered() || !occupant || !iscarbon(occupant))
		open_machine()
		return

	if(COOLDOWN_FINISHED(src, processing_time_cooldown))
		eject_new_you()
		return

	if(COOLDOWN_FINISHED(src, advert_time))
		COOLDOWN_START(src, advert_time, rand(ADVERT_TIME, ADVERT_TIME * 2))
		say(pick(advertisements))
		playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)

	use_energy(active_power_usage)

/obj/machinery/robotifier/proc/start_procedure()
	if(state_open || !occupant || !powered())
		return

	if(!ishuman(occupant))
		return

	playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)
	say("Starting procedure! Beginning organ replacement at a cycle time of [DisplayTimeText(processing_time)] at laser power [display_power(active_power_usage)].")
	to_chat(occupant, span_warning("This will take [DisplayTimeText(processing_time)] to complete. To cancel the procedure, hit the RESIST button or hotkey."))
	set_light(l_range = 1.5, l_power = 1.2, l_on = TRUE)
	sound_loop.start()
	COOLDOWN_START(src, processing_time_cooldown, processing_time)
	COOLDOWN_START(src, advert_time, rand(ADVERT_TIME * 0.75, ADVERT_TIME * 1.25))
	processing = TRUE
	update_appearance()

/obj/machinery/robotifier/proc/eject_new_you()
	set_light(l_on = FALSE)
	sound_loop.stop()
	processing = FALSE
	if(state_open || !occupant || !powered())
		return
	var/mob/living/carbon/human/patient = occupant
	for(var/organ_slot in organ_slots)
		var/obj/item/organ/existing_organ = patient.get_organ_slot(organ_slot)
		var/obj/item/organ/new_organ = SSwardrobe.provide_type(organ_paths[organ_slot])
		if(organ_slot == ORGAN_SLOT_BRAIN)
			var/obj/item/organ/brain/existing_brain = existing_organ
			existing_brain.before_organ_replacement(new_organ)
			existing_brain.Remove(patient, special = TRUE, movement_flags = NO_ID_TRANSFER)
		else
			existing_organ.before_organ_replacement(new_organ)
			existing_organ.Remove(patient, special = TRUE)
		existing_organ.forceMove(get_turf(src))
		new_organ.Insert(patient, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	patient.set_blood_type(get_blood_type(bloodtype_to_use))
	patient.update_cached_blood_dna_info()
	open_machine()

/obj/machinery/robotifier/proc/eject_early(damaged_goods = FALSE)
	set_light(l_on = FALSE)
	sound_loop.stop()
	processing = FALSE

	if(damaged_goods)
		var/mob/living/carbon/human/victim_living = occupant
		var/damage = (rand(75, 150))
		victim_living.emote("scream")
		victim_living.apply_damage(0.2 * damage, BURN, BODY_ZONE_HEAD, wound_bonus = 7)
		victim_living.apply_damage(0.4 * damage, BURN, BODY_ZONE_CHEST, wound_bonus = 21)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_L_LEG, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_R_LEG, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_L_ARM, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_R_ARM, wound_bonus = 14)
		victim_living.visible_message(span_warning("[src] shuts down, forcefully ejecting [victim_living]!"), span_danger("The [src] shuts down mid-procedure! That can't be good..."))

	open_machine()

/obj/machinery/robotifier/container_resist_act(mob/living/user)
	if(state_open)
		return

	if(COOLDOWN_TIMELEFT(src, processing_time_cooldown) < BREAKOUT_TIME)
		to_chat(user, span_warning("The emergency release is not responding! You start pushing against the door, but you realize it's too late!"))
		return

	to_chat(user, span_notice("The emergency release is not responding! You start pushing against the door!"))
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(BREAKOUT_TIME)].)"), \
		span_hear("You hear a metallic creaking from [src]."))
	user.emote("scream")

	if(do_after(user, BREAKOUT_TIME, target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || state_open)
			return
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		eject_early(damaged_goods = TRUE)

/obj/machinery/robotifier/screwdriver_act(mob/living/user, obj/item/used_item)
	. = TRUE
	if(..())
		return

	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return

	if(default_deconstruction_screwdriver(user, icon_state, icon_state, used_item))
		update_appearance()
		return

	return FALSE

/obj/machinery/robotifier/crowbar_act(mob/living/user, obj/item/used_item)
	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return

	if(default_deconstruction_crowbar(used_item))
		return TRUE

/obj/machinery/robotifier/RefreshParts()
	. = ..()
	processing_time = 35 SECONDS
	for(var/datum/stock_part/micro_laser/laser in component_parts) // Laser tier increases speed, at the expense of power.
		processing_time -= laser.tier * 5 SECONDS
		active_power_usage = 7200000 / processing_time WATTS
		idle_power_usage = active_power_usage / 4

/datum/design/board/organ_fixer
	name = "Machine Design (Organ Fixer)"
	desc = "The circuit board for the Robotifier, for repairing damaged organic organs with synthflesh."
	id = "organ_fixer"
	build_path = /obj/item/circuitboard/machine/organ_fixer
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/circuitboard/machine/organ_fixer
	name = "Organ Fixer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/organ_fixer
	req_components = list(/datum/stock_part/micro_laser = 1)

/obj/machinery/organ_fixer
	name = "organ fixer"
	desc = "Insert a damaged organ to repair the organ!"
	icon = 'modular_nova/modules/robots/sprites/organ.dmi'
	icon_state = "organ_fixer"
	circuit = /obj/item/circuitboard/machine/organ_fixer
	state_open = FALSE
	density = TRUE
	var/obj/item/organ/contained_organ

/obj/machinery/organ_fixer/update_appearance(updates)
	. = ..()
	if(isnull(contained_organ))
		icon_state = "organ_fixer"
	else
		if(contained_organ.damage > 0)
			icon_state = "organ_fixer_on"
		else
			icon_state = "organ_fixer_done"

/obj/machinery/organ_fixer/process(seconds_per_tick)
	if(!powered())
		if(contained_organ)
			contained_organ.forceMove(get_turf(src))
			contained_organ = null
		update_appearance()
		return
	if(contained_organ)
		var/current_organ_health = contained_organ.maxHealth - contained_organ.damage
		if(current_organ_health != contained_organ.maxHealth)
			contained_organ.apply_organ_damage(-1)
			if(contained_organ.damage == 0)
				playsound(get_turf(src), 'sound/machines/chime.ogg', 30, FALSE)
	update_appearance()
	use_energy(active_power_usage)

/obj/machinery/organ_fixer/attackby(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!powered())
		return
	if(istype(weapon, /obj/item/organ))
		if(contained_organ)
			balloon_alert(user, "already has organ!")
		else
			balloon_alert_to_viewers("inserted [lowertext(weapon)]")
			contained_organ = weapon
			contained_organ.forceMove(src)
			update_appearance()

/obj/machinery/organ_fixer/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(contained_organ)
		user.put_in_hands(contained_organ)
		contained_organ = null
	update_appearance()

/datum/area_spawn/organ_fixer
	target_areas = list(/area/station/science/robotics/lab, /area/station/science/robotics/mechbay)
	desired_atom = /obj/machinery/organ_fixer
	mode = AREA_SPAWN_MODE_OPEN

#undef BREAKOUT_TIME
#undef ADVERT_TIME
