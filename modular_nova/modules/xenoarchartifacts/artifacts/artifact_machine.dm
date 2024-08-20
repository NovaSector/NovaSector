/obj/machinery/artifact
	name = "alien artifact"
	desc = "A large alien device."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/artifacts.dmi'
	icon_state = "artifact_1"
	anchored = 0
	var/icon_num = 0
	density = TRUE
	///artifact first effect
	var/datum/artifact_effect/first_effect
	///artifact second effect
	var/datum/artifact_effect/secondary_effect
	///is artifact busy right now, used it harvester code
	var/being_used = 0
	///does our artifact needs an init, dont forget to init turfs in prebuild artifacts if needed
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
	var/effecttype = pick(GLOB.valid_primary_effect_types)
	first_effect = new effecttype(src)

	//65% chance to have a secondary effect
	if(prob(65))
		effecttype = pick(GLOB.valid_secondary_effect_types)
		secondary_effect = new effecttype(src)

	init_artifact_type()

/**
 * Picks random artifact icon, changes its name, description
 */
/obj/machinery/artifact/proc/init_artifact_type()
	icon_num = pick(ARTIFACT_WIZARD_LARGE,
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
	switch(icon_num)
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
			icon_num = pick(ARTIFACT_CRYSTAL_GREEN, ARTIFACT_CRYSTAL_PURPLE, ARTIFACT_CRYSTAL_BLUE) // now we pick a color
			name = "large crystal"
			desc = pick("It shines faintly as it catches the light.", "It appears to have a faint inner glow.",
                        "It seems to draw you inward as you look it at.", "Something twinkles faintly as you look at it.",
                        "It's mesmerizing to behold.")
	update_icon()

/obj/machinery/artifact/update_icon()
	. = ..()
	var/check_activity = null
	if(first_effect?.activated || secondary_effect?.activated)
		check_activity = "_active"
	icon_state = "artifact_[icon_num][check_activity]"
	return

/obj/machinery/artifact/Destroy()
	do_destroy_effects()
	visible_message("<span class='danger'>[src] breaks in pieces, releasing a wave of energy</span>")
	if(first_effect)
		QDEL_NULL(first_effect)
	if(secondary_effect)
		QDEL_NULL(secondary_effect)
	return ..()

/obj/machinery/artifact/proc/try_toggle_effects(trigger)
	if(first_effect?.trigger == trigger)
		first_effect.ToggleActivate()
	if(secondary_effect?.trigger == trigger)
		secondary_effect.ToggleActivate(FALSE)

/obj/machinery/artifact/proc/toggle_effects_on(trigger)
	if(first_effect)
		try_turn_on_effect(trigger, first_effect)
	if(secondary_effect)
		try_turn_on_effect(trigger, secondary_effect, FALSE)

/obj/machinery/artifact/proc/try_turn_on_effect(trigger, datum/artifact_effect/first_effect, announce_triggered = TRUE)
	if(first_effect.trigger == trigger && !first_effect.activated)
		first_effect.ToggleActivate(announce_triggered)

/obj/machinery/artifact/proc/toggle_effects_off(trigger)
	if(first_effect)
		try_turn_off_effect(trigger, first_effect)
	if(secondary_effect)
		try_turn_off_effect(trigger, secondary_effect, FALSE)

/obj/machinery/artifact/proc/try_turn_off_effect(trigger, datum/artifact_effect/first_effect, announce_triggered = TRUE)
	if(first_effect.trigger == trigger && first_effect.activated)
		first_effect.ToggleActivate(announce_triggered)

/obj/machinery/artifact/proc/do_destroy_effects()
	first_effect?.DoEffectDestroy()
	secondary_effect?.DoEffectDestroy()

/obj/machinery/artifact/examine(mob/user)
	. = ..()
	switch(round(100 * (get_integrity() / max_integrity)))
		if(85 to 100)
			to_chat(user, "Appears to have no structural damage.")
		if(65 to 85)
			to_chat(user, "Appears to have light structural damage.")
		if(45 to 65)
			to_chat(user, "Appears to have heavy structural damage.")
		if(10 to 45)
			to_chat(user, "Appears to have immirsed structural damage.")
		if(0 to 10)
			to_chat(user, "Appears to have to be barely intanct.")

/obj/machinery/artifact/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))
		to_chat(user, "<span class='warning'> You can't reach [src] from here.</span>")
		return TRUE
	try_toggle_effects(TRIGGER_TOUCH)
	to_chat(user, "<b>You touch [src].</b>")

	if(first_effect.release_method == ARTIFACT_EFFECT_TOUCH)
		first_effect.DoEffectTouch(user)

	if(secondary_effect?.release_method == ARTIFACT_EFFECT_TOUCH && secondary_effect.activated)
		secondary_effect.DoEffectTouch(user)

/obj/machinery/artifact/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0)
	. = ..()

	if(ISDIAGONALDIR(Dir))
		return .

	if(pulledby)
		Bumped(pulledby)
	first_effect?.UpdateMove()
	secondary_effect?.UpdateMove()

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

/obj/machinery/artifact/process()
	//if either of our effects rely on environmental factors, work that out
	if((first_effect?.trigger & TRIGGER_ATMOS) || (secondary_effect?.trigger & TRIGGER_ATMOS))
		var/turf/T = get_turf(src)
		var/datum/gas_mixture/env = T.return_air()
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
			//PHORON GAS ACTIVATION.
			//Update 07.05.2024. No one remembers phoron anymore :( People say "plasma"
			if(loc_gases[/datum/gas/plasma] && loc_gases[/datum/gas/plasma][MOLES] >= 10)
				toggle_effects_on(TRIGGER_PHORON)
			else toggle_effects_off(TRIGGER_PHORON)
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
	..()
	if(isobj(what_bumped))
		var/obj/O = what_bumped
		if(O.throwforce >= 10)
			try_toggle_effects(TRIGGER_FORCE)
	if(world.time >= last_time_touched + touch_cooldown)
		last_time_touched = world.time
		try_toggle_effects(TRIGGER_TOUCH)
		if(first_effect.release_method == ARTIFACT_EFFECT_TOUCH && first_effect.activated && prob(50))
			first_effect.DoEffectTouch(what_bumped)
		if(secondary_effect && secondary_effect.release_method == ARTIFACT_EFFECT_TOUCH && secondary_effect.activated && prob(50))
			secondary_effect.DoEffectTouch(what_bumped)
		if(ismob(what_bumped))
			to_chat(what_bumped, "<b>You accidentally touch [src].</b>")
	..()

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
		if(istype(attack_item, /obj/item/melee/baton/security))
			var/obj/item/melee/baton/security/Batong = attack_item
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
	..()

/obj/machinery/artifact/proc/get_scan(mob/living/user, obj/item/xenoarch/handheld_scanner/scanner)
	to_chat(user, span_notice("You begin to scan [src] using [scanner]."))
	if(!do_after(user, scanner.scanning_speed * 5, target = src))
		to_chat(user, span_warning("You interrupt your scanning."))
		return
	to_chat(user, span_notice("[src] is too big to scan with [scanner]. Use static artifact analyzer."))
	// var/out = "Anomalous alien device - composed of an unknown alloy.<br><br>"

	// if(first_effect)
	// 	out += first_effect.getDescription()

	// if(secondary_effect)
	// 	out += "<br><br>Internal scans indicate ongoing secondary activity<br><br>"
	// 	out += secondary_effect.getDescription()
