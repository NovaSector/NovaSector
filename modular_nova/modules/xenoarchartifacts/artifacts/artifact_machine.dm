/obj/machinery/artifact
	name = "alien artifact"
	desc = "A large alien device."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/artifacts.dmi'
	icon_state = "artifact_1"
	anchored = 0
	/// The id of the of artifact type, determined in init_artifact_type()
	var/artifact_type_id
	density = TRUE
	///artifact first effect
	var/datum/artifact_effect/first_effect
	///artifact second effect
	var/datum/artifact_effect/secondary_effect
	///is artifact busy right now, used it harvester code
	var/being_used = 0
	///does our artifact needs an init, dont forget to init turfs in prebuilt artifacts if needed
	var/need_init = TRUE
	///how often do we scan
	var/scan_delay = 2 SECONDS
	///touch cooldown to prevent spam in /bumped
	var/touch_cooldown = 3 SECONDS
	///last time mob touched us
	var/last_time_touched = 0
	///our health
	max_integrity = 1000
	///no accident lava or acid destruction
	resistance_flags =  LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/machinery/artifact/Initialize(mapload)
	. = ..()
	if(!need_init)
		return
	//setup primary effect - these are the main ones (mixed)
	var/effect_type = pick(GLOB.valid_primary_effect_types)
	first_effect = new effect_type(src)

	//65% chance to have a secondary effect
	if(prob(65))
		effect_type = pick(GLOB.valid_secondary_effect_types)
		secondary_effect = new effect_type(src)

	if(!artifact_type_id)
		init_artifact_type()
	update_icon()

/**
 * Picks random artifact icon, changes its name, description
 */
/obj/machinery/artifact/proc/init_artifact_type()
	artifact_type_id = pick(
		ARTIFACT_WIZARD_LARGE,
		ARTIFACT_WIZARD_SMALL,
		ARTIFACT_MARTIAN_LARGE,
		ARTIFACT_MARTIAN_SMALL,
		ARTIFACT_MARTIAN_PINK,
		ARTIFACT_CUBE,
		ARTIFACT_PILLAR,
		ARTIFACT_COMPUTER,
		ARTIFACT_VENTS, ARTIFACT_FLOATING,
		ARTIFACT_CRYSTAL_GREEN,
	) // 12th and 13th are just types of crystals, please ignore them at THAT point
	switch(artifact_type_id)
		if(ARTIFACT_COMPUTER)
			name = "alien computer"
			desc = "It is covered in strange markings."
		if(ARTIFACT_PILLAR)
			name = "alien device"
			desc = "A large pillar, made of strange shiny metal."
		if(ARTIFACT_VENTS)
			name = "alien device"
			desc = "A large alien device, there appear to be some kind of vents in the side."
		if(ARTIFACT_FLOATING)
			name = "strange metal object"
			desc = "A large object made of tough green-shaded alien metal."
		if(ARTIFACT_CRYSTAL_GREEN)
			artifact_type_id = pick(ARTIFACT_CRYSTAL_GREEN, ARTIFACT_CRYSTAL_PURPLE, ARTIFACT_CRYSTAL_BLUE) // now we pick a color
			name = "large crystal"
			desc = pick(
				"It shines faintly as it catches the light.", "It appears to have a faint inner glow.",
				"It seems to draw you inward as you look it at.", "Something twinkles faintly as you look at it.",
				"It's mesmerizing to behold.",
			)

/obj/machinery/artifact/update_icon_state()
	. = ..()
	var/check_activity
	if(first_effect?.activated || secondary_effect?.activated)
		check_activity = "_active"
	icon_state = "artifact_[artifact_type_id][check_activity]"

/obj/machinery/artifact/emp_act(severity)
	if(!QDELING(src))
		return ..()

/obj/machinery/artifact/Destroy()
	do_destroy_effects()
	loc.visible_message(
		span_danger("[src] breaks in pieces, releasing a wave of energy!"),
		blind_message = span_hear("You hear something break into pieces!"),
	)
	if(!QDELETED(first_effect))
		QDEL_NULL(first_effect)
	if(!QDELETED(secondary_effect))
		QDEL_NULL(secondary_effect)
	return ..()

/**
 * Tries to turn the artifact effects on. Invokes async procs
 *
 * Arguments:
 * * trigger - trigger type(TRIGGER_WATER, TRIGGER_ENERGY, etc)
 */
/obj/machinery/artifact/proc/try_toggle_effects(trigger)
	if(first_effect?.trigger == trigger)
		first_effect.ToggleActivate()
	if(secondary_effect?.trigger == trigger)
		secondary_effect.ToggleActivate(FALSE)

/**
 * Tries to turn the artifact effects on.
 *
 * Arguments:
 * * trigger - trigger type(TRIGGER_WATER, TRIGGER_ENERGY, etc)
 */
/obj/machinery/artifact/proc/toggle_effects_on(trigger)
	if(first_effect)
		try_turn_on_effect(trigger, first_effect)
	if(secondary_effect)
		try_turn_on_effect(trigger, secondary_effect, FALSE)

/**
 * Tries to turn on single effect
 *
 * Arguments:
 * * trigger - trigger type(TRIGGER_WATER, TRIGGER_ENERGY, etc)
 * * current_effect - the effect we try to activate
 * * announce_triggered - to show or not to show the activation message
 */
/obj/machinery/artifact/proc/try_turn_on_effect(trigger, datum/artifact_effect/current_effect, announce_triggered = TRUE)
	if(current_effect.trigger == trigger && !current_effect.activated)
		current_effect.ToggleActivate(announce_triggered)

/**
 * Tries to turn the artifact effects off.
 *
 * Arguments:
 * * trigger - trigger type(TRIGGER_WATER, TRIGGER_ENERGY, etc)
 */
/obj/machinery/artifact/proc/toggle_effects_off(trigger)
	if(first_effect)
		try_turn_off_effect(trigger, first_effect)
	if(secondary_effect)
		try_turn_off_effect(trigger, secondary_effect, FALSE)

/obj/machinery/artifact/proc/try_turn_off_effect(trigger, datum/artifact_effect/first_effect, announce_triggered = TRUE)
	if(first_effect.trigger == trigger && first_effect.activated)
		first_effect.ToggleActivate(announce_triggered)

/**
 * Calls first and second effect's do_effect_destroy()
 */
/obj/machinery/artifact/proc/do_destroy_effects()
	first_effect?.do_effect_destroy()
	secondary_effect?.do_effect_destroy()

/obj/machinery/artifact/examine(mob/user)
	. = ..()
	switch(round(100 * (get_integrity() / max_integrity)))
		if(85 to 100)
			to_chat(user, "Appears to have no structural damage.")
		if(65 to 85)
			to_chat(user, "Appears to have light structural damage.")
		if(45 to 65)
			to_chat(user, "Appears to have moderate structural damage.")
		if(10 to 45)
			to_chat(user, "Appears to have heavy structural damage.")
		if(0 to 10)
			to_chat(user, "Appears to be barely intact.")

/obj/machinery/artifact/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))
		to_chat(user, span_warning("You can't reach [src] from here!"))
		return TRUE
	if(iscarbon(user))
		var/mob/living/carbon/human_to_test = user
		if(human_to_test.gloves)
			if(!istype(human_to_test.gloves, /obj/item/clothing/gloves/latex))
				try_toggle_effects(TRIGGER_TOUCH)
		else
			try_toggle_effects(TRIGGER_TOUCH)
	else
		try_toggle_effects(TRIGGER_TOUCH)
	to_chat(user, span_bold("You touch [src]."))

	if(first_effect.release_method == ARTIFACT_EFFECT_TOUCH)
		first_effect.do_effect_touch(user)

	if(secondary_effect?.release_method == ARTIFACT_EFFECT_TOUCH && secondary_effect.activated)
		secondary_effect.do_effect_touch(user)

/obj/machinery/artifact/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0)
	. = ..()

	if(ISDIAGONALDIR(Dir))
		return .

	if(pulledby)
		Bumped(pulledby)
	first_effect?.update_move()
	secondary_effect?.update_move()

/obj/machinery/artifact/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir)
	. = ..()
	if(QDELING(src))
		return
	switch(damage_flag)
		if(FIRE)
			try_toggle_effects(TRIGGER_HEAT)
		if(ENERGY, LASER)
			try_toggle_effects(TRIGGER_ENERGY)
		if(BOMB)
			try_toggle_effects(TRIGGER_FORCE)
			try_toggle_effects(TRIGGER_HEAT)
		else
			try_toggle_effects(TRIGGER_FORCE)

/obj/machinery/artifact/process(seconds_per_tick, times_fired)
	//if either of our effects rely on environmental factors, work that out
	if((first_effect?.trigger & TRIGGER_ATMOS) || (secondary_effect?.trigger & TRIGGER_ATMOS))
		var/turf/our_turf = get_turf(src)
		var/datum/gas_mixture/env = our_turf.return_air()
		var/loc_gases = env.gases
		if(env)
			//COLD ACTIVATION
			if(env.temperature < 225)
				toggle_effects_on(TRIGGER_COLD)
			else toggle_effects_off(TRIGGER_COLD)
			//HEAT ACTIVATION
			if(env.temperature > 375)
				toggle_effects_on(TRIGGER_HEAT)
			else toggle_effects_off(TRIGGER_HEAT)
			//PLASMA GAS ACTIVATION.
			//Update 07.05.2024. No one remembers phoron anymore :( People say "plasma"
			if(loc_gases[/datum/gas/plasma] && loc_gases[/datum/gas/plasma][MOLES] >= 10)
				toggle_effects_on(TRIGGER_PLASMA)
			else toggle_effects_off(TRIGGER_PLASMA)
			//OXYGEN GAS ACTIVATION
			if(loc_gases[/datum/gas/oxygen] && loc_gases[/datum/gas/oxygen][MOLES] >= 10)
				toggle_effects_on(TRIGGER_OXY)
			else toggle_effects_off(TRIGGER_OXY)
			//CO2 GAS ACTIVATION
			if(loc_gases[/datum/gas/carbon_dioxide] && loc_gases[/datum/gas/carbon_dioxide][MOLES] >= 10)
				toggle_effects_on(TRIGGER_CO2)
			else toggle_effects_off(TRIGGER_CO2)
			//NITROGEN GAS ACTIVATION
			if(loc_gases[/datum/gas/nitrogen] && loc_gases[/datum/gas/nitrogen][MOLES] >= 10)
				toggle_effects_on(TRIGGER_NITRO)
			else toggle_effects_off(TRIGGER_NITRO)
	//TRIGGER_PROXY ACTIVATION
	if((first_effect?.trigger == TRIGGER_PROXY || secondary_effect?.trigger == TRIGGER_PROXY))
		if(locate(/mob/living) in view(3, src))
			toggle_effects_on(TRIGGER_PROXY)
		else
			toggle_effects_off(TRIGGER_PROXY)

/obj/machinery/artifact/Bumped(atom/what_bumped)
	. = ..()
	if(isobj(what_bumped))
		var/obj/object_bumped = what_bumped
		if(object_bumped.throwforce >= 10)
			try_toggle_effects(TRIGGER_FORCE)
	if(world.time >= last_time_touched + touch_cooldown)
		last_time_touched = world.time
		if(iscarbon(what_bumped))
			var/mob/living/carbon/human_to_test = what_bumped
			if(human_to_test.gloves)
				if(!istype(human_to_test.gloves, /obj/item/clothing/gloves/latex))
					try_toggle_effects(TRIGGER_TOUCH)
			else
				try_toggle_effects(TRIGGER_TOUCH)
		else
			try_toggle_effects(TRIGGER_TOUCH)
		if(first_effect.release_method == ARTIFACT_EFFECT_TOUCH && first_effect.activated && prob(50))
			first_effect.do_effect_touch(what_bumped)
		if(secondary_effect && secondary_effect.release_method == ARTIFACT_EFFECT_TOUCH && secondary_effect.activated && prob(50))
			secondary_effect.do_effect_touch(what_bumped)
		if(ismob(what_bumped))
			to_chat(what_bumped, span_bold("You accidentally touch [src]."))

/**
 * Checks if container has reagent, which is in volatile_reagents global list
 *
 * Arguments:
 * * container - container to check
 */
/obj/machinery/artifact/proc/check_for_volatile(obj/item/reagent_containers/container)
	for (var/volatile in GLOB.volatile_reagents)
		if (container.reagents.has_reagent(volatile, 1, check_subtypes = TRUE))
			return TRUE
	return FALSE

/obj/machinery/artifact/attackby(obj/item/attack_item, mob/living/user)
	if(istype(attack_item, /obj/item/reagent_containers))
		if(attack_item.reagents.has_reagent(/datum/reagent/hydrogen, 1) || attack_item.reagents.has_reagent(/datum/reagent/water, 1))
			try_toggle_effects(TRIGGER_WATER)
		else if(attack_item.reagents.has_reagent(/datum/reagent/toxin/acid, 1, check_subtypes = TRUE))
			try_toggle_effects(TRIGGER_ACID)
		else if(check_for_volatile(attack_item))
			try_toggle_effects(TRIGGER_VOLATILE)
		else if(attack_item.reagents.has_reagent(/datum/reagent/toxin, 1, check_subtypes = TRUE) || attack_item.reagents.has_reagent(/datum/reagent/consumable/ethanol/neurotoxin, 1))
			try_toggle_effects(TRIGGER_TOXIN)
	else
		if(istype(attack_item, /obj/item/melee/baton))
			var/obj/item/melee/baton/Batong = attack_item
			if(Batong.active)
				try_toggle_effects(TRIGGER_ENERGY)
		else if(istype(attack_item, /obj/item/melee/energy))
			try_toggle_effects(TRIGGER_ENERGY)
		else if (istype(attack_item, /obj/item/xenoarch/handheld_scanner))
			var/obj/item/xenoarch/handheld_scanner/scanner = attack_item
			get_scan(user, scanner)
	if(first_effect?.trigger == TRIGGER_HEAT || secondary_effect?.trigger == TRIGGER_HEAT)
		if(attack_item.get_temperature() > 700)
			try_toggle_effects(TRIGGER_HEAT)
			return
	return ..()

/**
 * If you try to scan using handheld scanner - you get nothing but fluff text
 *
 * Arguments:
 * * user - misguided soul, wishing for knowledge, but shall he receive nothing, but fluff text
 * * scanner - wretched tool, used to carve path to the artifact's lore
 */
/obj/machinery/artifact/proc/get_scan(mob/living/user, obj/item/xenoarch/handheld_scanner/scanner)
	user.visible_message(
		span_notice("[user] begins to scan [src] using [scanner]."),
		span_notice("You begin to scan [src] using [scanner]..."),
		blind_message = span_hear("You hear some kind of machine silently winding up."),
	)
	if(!do_after(user, scanner.scanning_speed * 5, target = src))
		to_chat(user, span_warning("You interrupt your scanning."))
		return
	to_chat(user, span_notice("[src] is too big to scan with [scanner]. Use static artifact analyzer."))
