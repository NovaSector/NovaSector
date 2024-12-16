#define SLIME_ACTIONS_ICON_FILE 'modular_nova/master_files/icons/mob/actions/actions_slime.dmi'
/// This is the level of waterstacks that start doing noteworthy bloodloss to a slimeperson.
#define DAMAGE_WATER_STACKS 5
/// This is the level of waterstacks that prevent a slimeperson from regenerating, doing minimal bloodloss in the process.
#define REGEN_WATER_STACKS 1

/datum/species/jelly
	mutant_bodyparts = list()
	hair_alpha = 160 //a notch brighter so it blends better.
	facial_hair_alpha = 160
	mutantliver = /obj/item/organ/liver/slime
	mutantstomach = /obj/item/organ/stomach/slime
	mutantbrain = /obj/item/organ/brain/slime
	mutantears = /obj/item/organ/ears/jelly
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_TOXINLOVER,
		TRAIT_EASYDISMEMBER,
	)
	/// Ability to allow them to shapeshift their body around.
	var/datum/action/innate/alter_form/alter_form
	/// Ability to allow them to clean themselves and their stuff.
	var/datum/action/cooldown/spell/slime_washing/slime_washing
	/// Ability to allow them to resist the effects of water.
	var/datum/action/cooldown/spell/slime_hydrophobia/slime_hydrophobia
	/// Ability to allow them to turn their core's GPS on or off.
	var/datum/action/innate/core_signal/core_signal

/datum/species/jelly/on_species_gain(mob/living/carbon/new_jellyperson, datum/species/old_species, pref_load)
	. = ..()
	if(ishuman(new_jellyperson))
		alter_form = new
		alter_form.Grant(new_jellyperson)
		slime_washing = new
		slime_washing.Grant(new_jellyperson)
		slime_hydrophobia = new
		slime_hydrophobia.Grant(new_jellyperson)
		core_signal = new
		core_signal.Grant(new_jellyperson)

/datum/species/jelly/on_species_loss(mob/living/carbon/former_jellyperson, datum/species/new_species, pref_load)
	. = ..()
	if(alter_form)
		alter_form.Remove(former_jellyperson)
	if(slime_washing)
		slime_washing.Remove(former_jellyperson)
	if(slime_hydrophobia)
		slime_hydrophobia.Remove(former_jellyperson)
	if(core_signal)
		core_signal.Remove(former_jellyperson)

/datum/species/jelly/get_default_mutant_bodyparts()
	return list(
		"tail" = list("None", FALSE),
		"snout" = list("None", FALSE),
		"ears" = list("None", FALSE),
		"legs" = list("Normal Legs", FALSE),
		"taur" = list("None", FALSE),
		"wings" = list("None", FALSE),
		"horns" = list("None", FALSE),
		"spines" = list("None", FALSE),
		"frills" = list("None", FALSE),
	)

/datum/species/jelly/gain_oversized_organs(mob/living/carbon/human/human_holder, datum/quirk/oversized/oversized_quirk)
	if(isnull(human_holder.loc))
		return // preview characters don't need funny organs, prevents a runtime

	var/obj/item/organ/brain/slime/oversized/new_slime_brain = new
	var/obj/item/organ/stomach/slime/oversized/new_slime_stomach = new //YOU LOOK HUGE! THAT MUST MEAN YOU HAVE HUGE golgi apparatus! RIP AND TEAR YOUR HUGE golgi apparatus!

	var/obj/item/organ/brain/slime/old_brain = human_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/slime/old_stomach = human_holder.get_organ_slot(ORGAN_SLOT_STOMACH)
	oversized_quirk.old_organs = list(
		old_brain,
		old_stomach,
	)

	// To prevent ghosting. We have to do this manually here because TG has replace_into() hardcoded to qdel the old brain no matter what and there is no way around it.
	old_brain.Remove(human_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)

	new_slime_brain.Insert(human_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)
	to_chat(human_holder, span_warning("Your massive core pulses with bioelectricity!"))
	if(old_brain)
		old_brain.moveToNullspace()
		STOP_PROCESSING(SSobj, old_brain)
	if(old_stomach.is_oversized) // don't override augments that are already oversized
		oversized_quirk.old_organs -= old_stomach
		qdel(new_slime_stomach)
		return
	new_slime_stomach.Insert(human_holder, special = TRUE)
	to_chat(human_holder, span_warning("You feel your massive golgi apparatus squish!"))
	if(old_stomach)
		old_stomach.moveToNullspace()
		STOP_PROCESSING(SSobj, old_stomach)

/obj/item/organ/eyes/jelly
	name = "photosensitive eyespots"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_UNREMOVABLE

/obj/item/organ/eyes/roundstartslime
	name = "photosensitive eyespots"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_UNREMOVABLE

/obj/item/organ/ears/jelly
	name = "core audiosomes"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_UNREMOVABLE
	overrides_sprite_datum_organ_type = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/obj/item/organ/tongue/jelly
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_UNREMOVABLE

/obj/item/organ/lungs/slime
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_UNREMOVABLE

/obj/item/organ/liver/slime
	name = "endoplasmic reticulum"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_UNREMOVABLE

/obj/item/organ/stomach/slime
	name = "golgi apparatus"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_UNREMOVABLE

/obj/item/organ/brain/slime
	name = "core"
	desc = "The central core of a slimeperson, technically their 'extract.' Where the cytoplasm, membrane, and organelles come from; perhaps this is also a mitochondria?"
	zone = BODY_ZONE_CHEST
	/// This is the VFX for what happens when they melt and die.
	var/obj/effect/death_melt_type = /obj/effect/temp_visual/wizard/out
	/// Color of the slimeperson's 'core' brain, defaults to white.
	var/core_color = COLOR_WHITE
	icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	icon_state = "slime_core"
	/// This tracks whether their core has been ejected or not after they die.
	var/core_ejected = FALSE
	/// This tracks whether their GPS microchip is enabled or not, only becomes TRUE on activation of the below ability /datum/action/innate/core_signal.
	var/gps_active = FALSE
	throw_range = 9 //Oh! That's a baseball!
	throw_speed = 0.5
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | LAVA_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/item/organ/brain/slime/Initialize(mapload, mob/living/carbon/organ_owner, list/examine_list)
	. = ..()
	colorize()

/obj/item/organ/brain/slime/examine()
	. = ..()
	if(gps_active)
		. += span_notice("A dim light lowly pulsates from the center of the core, indicating an outgoing signal from a tracking microchip.")
		. += span_red("You could probably snuff that out.")
	. += span_hypnophrase("You remember that pouring plasma on it, if it's non-embodied, would make it regrow one.")

/obj/item/organ/brain/slime/attack_self(mob/living/user) // Allows a player (presumably an antag) to deactivate the GPS signal on a slime core
	if(!(gps_active))
		return
	user.visible_message(span_warning("[user] begins jamming [user.p_their()] hand into a slime core! Slime goes everywhere!"),
	span_notice("You jam your hand into the core, feeling for the densest point! Your arm is covered in slime!"),
	span_notice("You hear an obscene squelching sound.")
	)
	playsound(user, 'sound/items/handling/surgery/organ1.ogg', 80, TRUE)

	if(!do_after(user, 30 SECONDS, src))
		user.visible_message(span_warning("[user]'s hand slips out of the core before [user.p_they()] can cause any harm!'"),
		span_warning("Your hand slips out of the goopy core before you can find its densest point."),
		span_notice("You hear a resounding plop.")
		)
		return

	user.visible_message(span_warning("[user] crunches something deep in the slime core! It gradually stops glowing..."),
	span_notice("You find the densest point, crushing it in your palm. The blinking light in the core slowly dissipates."),
	span_notice("You hear a wet crunching sound."))
	playsound(user, 'sound/effects/wounds/crackandbleed.ogg', 80, TRUE)
	gps_active = FALSE
	qdel(GetComponent(/datum/component/gps))

/obj/item/organ/brain/slime/mob_insert(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	. = ..()
	if(!.)
		return
	colorize()
	core_ejected = FALSE
	RegisterSignal(organ_owner, COMSIG_LIVING_DEATH, PROC_REF(on_slime_death))

/obj/item/organ/brain/slime/on_mob_remove(mob/living/carbon/organ_owner)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_LIVING_DEATH)

/**
* Colors the slime's core (their brain) the same as their first mutant color.
*/
/obj/item/organ/brain/slime/proc/colorize()
	if(owner && isjellyperson(owner))
		core_color = owner.dna.features["mcolor"]
		add_atom_colour(core_color, FIXED_COLOUR_PRIORITY)

/**
* Handling for tracking when the slime in question dies (except through gibbing), which then segues into the core ejection proc.
*/
/obj/item/organ/brain/slime/proc/on_slime_death(mob/living/victim, gibbed)
	SIGNAL_HANDLER
	UnregisterSignal(victim, COMSIG_LIVING_DEATH)

	if(gibbed)
		qdel(src)
		UnregisterSignal(victim, COMSIG_LIVING_DEATH)
		return

	addtimer(CALLBACK(src, PROC_REF(core_ejection), victim), 0) // explode them after the current proc chain ends, to avoid weirdness

/**
* CORE EJECTION PROC -
* Makes it so that when a slime dies, their core ejects and their body is qdel'd.
*/
/obj/item/organ/brain/slime/proc/core_ejection(mob/living/victim, new_stat, turf/loc_override)
	if(core_ejected)
		return
	core_ejected = TRUE
	victim.visible_message(span_warning("[victim]'s body completely dissolves, collapsing outwards!"), span_notice("Your body completely dissolves, collapsing outwards!"), span_notice("You hear liquid splattering."))
	var/atom/death_loc = victim.drop_location()
	victim.unequip_everything()
	if(victim.get_organ_slot(ORGAN_SLOT_BRAIN) == src)
		Remove(victim)
	if(death_loc)
		forceMove(death_loc)
	src.wash(CLEAN_WASH)
	new death_melt_type(death_loc, victim.dir)

	do_steam_effects(get_turf(victim))
	playsound(victim, 'sound/effects/blob/blobattack.ogg', 80, TRUE)

	if(gps_active) // adding the gps signal if they have activated the ability
		AddComponent(/datum/component/gps, "[victim]'s Core")

	qdel(victim)
	UnregisterSignal(victim, COMSIG_LIVING_DEATH)

/**
* Procs the ethereal jaunt liquid effect when the slime dissolves on death.
*/
/obj/item/organ/brain/slime/proc/do_steam_effects(turf/loc)
	var/datum/effect_system/steam_spread/steam = new()
	steam.set_up(10, FALSE, loc)
	steam.start()

/**
* CHECK FOR REPAIR SECTION
* Makes it so that when a slime's core has plasma poured on it, it builds a new body and moves the brain into it.
*/
/obj/item/organ/brain/slime/check_for_repair(obj/item/item, mob/user)
	if(!item.is_drainable() || item.reagents.get_reagent_amount(/datum/reagent/toxin/plasma) < 100)
		return FALSE
	user.visible_message(
		span_notice("[user] starts to slowly pour the contents of [item] onto [src]. It seems to bubble and roil, beginning to stretch its cytoskeleton outwards..."),
		span_notice("You start to slowly pour the contents of [item] onto [src]. It seems to bubble and roil, beginning to stretch its membrane outwards...")
	)
	brainmob?.notify_revival("You are being revived!", sound = null, source = src) // no sound since it's a whopping 60 second wait time after this
	if(!do_after(user, 60 SECONDS, src))
		to_chat(user, span_warning("You failed to pour the contents of [item] onto [src]!"))
		return TRUE

	user.visible_message(
		span_notice("[user] pours the contents of [item] onto [src], causing it to form a proper cytoplasm and outer membrane."),
		span_notice("You pour the contents of [item] onto [src], causing it to form a proper cytoplasm and outer membrane.")
	)
	item.reagents.clear_reagents() //removes the whole shit
	if(isnull(brainmob))
		user.balloon_alert("This brain is not a viable candidate for repair!")
		return TRUE

	brainmob.grab_ghost()
	if(isnull(brainmob.stored_dna))
		user.balloon_alert("This brain does not contain any dna!")
		return TRUE
	if(isnull(brainmob.client))
		user.balloon_alert("This brain does not contain a mind!")
		return TRUE
	regenerate()
	return TRUE

/obj/item/organ/brain/slime/proc/regenerate()
	//we have the plasma. we can rebuild them.
	set_organ_damage(-maxHealth) //fully heals the brain
	if(gps_active) // making sure the gps signal is removed if it's active on revival
		gps_active = FALSE
		qdel(GetComponent(/datum/component/gps))

	var/mob/living/carbon/human/new_body = new /mob/living/carbon/human(src.loc)

	brainmob.client?.prefs?.safe_transfer_prefs_to(new_body)
	new_body.underwear = "Nude"
	new_body.bra = "Nude"
	new_body.undershirt = "Nude" //Which undershirt the player wants
	new_body.socks = "Nude" //Which socks the player wants
	brainmob.stored_dna.transfer_identity(new_body, transfer_SE=1)
	new_body.dna.features["mcolor"] = new_body.dna.features["mcolor"]
	new_body.dna.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
	new_body.real_name = new_body.dna.real_name
	new_body.name = new_body.dna.real_name
	new_body.updateappearance(mutcolor_update=1)
	new_body.domutcheck()
	new_body.forceMove(get_turf(src))
	new_body.blood_volume = BLOOD_VOLUME_SAFE+60
	SSquirks.AssignQuirks(new_body, brainmob.client)
	src.replace_into(new_body)
	for(var/obj/item/bodypart/bodypart as anything in new_body.bodyparts)
		if(!istype(bodypart, /obj/item/bodypart/chest))
			bodypart.drop_limb()
			continue
	new_body.visible_message(span_warning("[new_body]'s torso \"forms\" from [new_body.p_their()] core, yet to form the rest."))
	to_chat(owner, span_purple("Your torso fully forms out of your core, yet to form the rest."))
	return TRUE

// HEALING SECTION
// Handles passive healing and water damage.
/datum/species/jelly/spec_life(mob/living/carbon/human/slime, seconds_per_tick, times_fired)
	. = ..()
	if(slime.stat != CONSCIOUS)
		return

	var/healing = TRUE

	var/datum/status_effect/fire_handler/wet_stacks/wetness = locate() in slime.status_effects
	if(HAS_TRAIT(slime, TRAIT_SLIME_HYDROPHOBIA))
		return
	if(istype(wetness) && wetness.stacks > (DAMAGE_WATER_STACKS))
		slime.blood_volume -= 2 * seconds_per_tick
		if(SPT_PROB(25, seconds_per_tick))
			slime.visible_message(span_danger("[slime]'s form begins to lose cohesion, seemingly diluting with the water!"), span_warning("The water starts to dilute your body, dry it off!"))

	if(istype(wetness) && wetness.stacks > (REGEN_WATER_STACKS))
		healing = FALSE
		if(SPT_PROB(1, seconds_per_tick))
			to_chat(slime, span_warning("You can't pull your body together and regenerate with water inside it!"))
			slime.blood_volume -= 1 * seconds_per_tick

	if(slime.blood_volume >= BLOOD_VOLUME_NORMAL && healing)
		if(HAS_TRAIT(slime, TRAIT_SLIME_HYDROPHOBIA))
			return
		if(slime.stat != CONSCIOUS)
			return
		slime.heal_overall_damage(brute = 1.5 * seconds_per_tick, burn = 1.5 * seconds_per_tick, required_bodytype = BODYTYPE_ORGANIC)
		slime.adjustOxyLoss(-1 * seconds_per_tick)


/**
* SLIME CLEANING ABILITY -
* When toggled, slimes clean themselves and their equipment.
*/
/datum/action/cooldown/spell/slime_washing
	name = "Toggle Slime Cleaning"
	desc = "Filter grime through your outer membrane, cleaning yourself and your equipment for sustenance. Also cleans the floor, providing your feet are uncovered. For sustenance."
	button_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "activate_wash"

	cooldown_time = 1 SECONDS
	spell_requirements = NONE

/datum/action/cooldown/spell/slime_washing/cast(mob/living/carbon/human/user = usr)
	. = ..()

	if(user.has_status_effect(/datum/status_effect/slime_washing))
		slime_washing_deactivate(user)
		return

	user.apply_status_effect(/datum/status_effect/slime_washing)
	user.visible_message(span_purple("[user]'s outer membrane starts to develop a roiling film on the outside, absorbing grime into [user.p_their()] inner layer!"), span_purple("Your outer membrane develops a roiling film on the outside, absorbing grime off yourself and your clothes; as well as the floor beneath you."))

/**
* Called when you activate it again after casting the ability-- turning it off, so to say.
*/
/datum/action/cooldown/spell/slime_washing/proc/slime_washing_deactivate(mob/living/carbon/human/user)
	if(!user.has_status_effect(/datum/status_effect/slime_washing))
		return

	user.remove_status_effect(/datum/status_effect/slime_washing)
	user.visible_message(span_notice("[user]'s outer membrane returns to normal, no longer cleaning [user.p_their()] surroundings."), span_notice("Your outer membrane returns to normal, filth no longer being cleansed."))

/datum/status_effect/slime_washing
	id = "slime_washing"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/slime_washing/tick(seconds_between_ticks, seconds_per_tick)
	if(ishuman(owner))
		var/mob/living/carbon/human/slime = owner
		for(var/obj/item/slime_items in slime.get_equipped_items(INCLUDE_ACCESSORIES | INCLUDE_HELD))
			slime_items.wash(CLEAN_WASH)
			slime.wash(CLEAN_WASH)
		if((slime.wear_suit?.body_parts_covered | slime.w_uniform?.body_parts_covered | slime.shoes?.body_parts_covered) & FEET)
			return
		else
			var/turf/open/open_turf = get_turf(slime)
			if(istype(open_turf))
				open_turf.wash(CLEAN_WASH)
				return TRUE
			if(SPT_PROB(5, seconds_per_tick))
				slime.adjust_nutrition((rand(5,25)))

/datum/status_effect/slime_washing/get_examine_text()
	return span_notice("[owner.p_Their()] outer layer is pulling in grime, filth sinking inside of [owner.p_their()] body and vanishing.")

/*
* HYDROPHOBIA SPELL
* Makes it so that slimes are waterproof, but slower, and they don't regenerate.
*/
/datum/action/cooldown/spell/slime_hydrophobia
	name = "Toggle Hydrophobia"
	desc = "Develop an oily layer on your outer membrane, repelling water at the cost of lower viscosity."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_shield"

	cooldown_time = 1 MINUTES
	spell_requirements = NONE

/datum/action/cooldown/spell/slime_hydrophobia/cast(mob/living/carbon/human/user = usr)
	. = ..()

	if(user.has_status_effect(/datum/status_effect/slime_hydrophobia))
		slime_hydrophobia_deactivate(user)
		return

	ADD_TRAIT(user, TRAIT_SLIME_HYDROPHOBIA, ACTION_TRAIT)
	user.apply_status_effect(/datum/status_effect/slime_hydrophobia)
	user.visible_message(span_purple("[user]'s outer membrane starts to ooze out an oily coating, [owner.p_their()] body becoming more viscous!"), span_purple("Your outer membrane starts to ooze out an oily coating, protecting you from water but making your body more viscous."))

/**
* Called when you activate it again after casting the ability-- turning it off, so to say.
*/
/datum/action/cooldown/spell/slime_hydrophobia/proc/slime_hydrophobia_deactivate(mob/living/carbon/human/user)
	if(!user.has_status_effect(/datum/status_effect/slime_hydrophobia))
		return

	REMOVE_TRAIT(user, TRAIT_SLIME_HYDROPHOBIA, ACTION_TRAIT)
	user.remove_status_effect(/datum/status_effect/slime_hydrophobia)
	user.visible_message(span_purple("[user]'s outer membrane returns to normal, [owner.p_their()] body drawing the oily coat back inside!"), span_purple("Your outer membrane returns to normal, water becoming dangerous to you once again."))

/datum/movespeed_modifier/status_effect/slime_hydrophobia
	multiplicative_slowdown = 1.5

/datum/status_effect/slime_hydrophobia
	id = "slime_hydrophobia"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/slime_hydrophobia/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/slime_hydrophobia, update=TRUE)

/datum/status_effect/slime_hydrophobia/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/slime_hydrophobia, update=TRUE)

/datum/status_effect/slime_hydrophobia/get_examine_text()
	return span_notice("[owner.p_They()] is oozing out an oily coating onto [owner.p_their()] outer membrane, water rolling right off.")

// CHEMICAL HANDLING
// Here's where slimes heal off plasma and where they hate drinking water.

/datum/species/jelly/handle_chemical(datum/reagent/chem, mob/living/carbon/human/slime, seconds_per_tick, times_fired)
	. = ..()
	if(. & COMSIG_MOB_STOP_REAGENT_CHECK)
		return
	// slimes use plasma to fix wounds, and if they have enough blood, organs
	var/static/list/organs_we_mend = list(
		ORGAN_SLOT_BRAIN,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
	)
	if(chem.type == /datum/reagent/toxin/plasma || chem.type == /datum/reagent/toxin/hot_ice)
		for(var/datum/wound/iter_wound as anything in slime.all_wounds)
			iter_wound.on_xadone(4 * REM * seconds_per_tick)
			slime.reagents.remove_reagent(chem.type, min(chem.volume * 0.22, 10))
		if(slime.blood_volume > BLOOD_VOLUME_SLIME_SPLIT)
			slime.adjustOrganLoss(
			pick(organs_we_mend),
			- 2 * seconds_per_tick,
		)
		if(SPT_PROB(5, seconds_per_tick))
			to_chat(slime, span_purple("Your body's thirst for plasma is quenched, your inner and outer membrane using it to regenerate."))

	if(chem.type == /datum/reagent/water)
		if(HAS_TRAIT(slime, TRAIT_SLIME_HYDROPHOBIA))
			return

		slime.blood_volume -= 3 * seconds_per_tick
		slime.reagents.remove_reagent(chem.type, min(chem.volume * 0.22, 10))
		if(SPT_PROB(1, seconds_per_tick))
			to_chat(slime, span_warning("The water starts to weaken and adulterate your insides!"))
		return COMSIG_MOB_STOP_REAGENT_CHECK

/datum/species/jelly/get_species_description()
	return placeholder_description

/datum/species/jelly/get_species_lore()
	return list(placeholder_lore)

/datum/species/jelly/roundstartslime
	name = "Xenobiological Slime Hybrid"
	id = SPECIES_SLIMESTART
	examine_limb_id = SPECIES_SLIMEPERSON
	coldmod = 3
	heatmod = 1
	specific_alpha = 155
	markings_alpha = 130 //This is set lower than the other so that the alpha values don't stack on top of each other so much
	mutanteyes = /obj/item/organ/eyes/roundstartslime
	mutanttongue = /obj/item/organ/tongue/jelly

	bodypart_overrides = list( //Overriding jelly bodyparts
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/jelly/slime/roundstart,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/jelly/slime/roundstart,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/jelly/slime/roundstart,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/jelly/slime/roundstart,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/jelly/slime/roundstart,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/jelly/slime/roundstart,
	)

/datum/species/jelly/roundstartslime/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "scissors",
			SPECIES_PERK_NAME = "Headcase",
			SPECIES_PERK_DESC = "Given slimepeople have all their organs in their chest, and no neck to boot, they can be decapitated easily.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "circle",
			SPECIES_PERK_NAME = "Single-Celled Organism",
			SPECIES_PERK_DESC = "Slimes only have one discrete organ, their core. It comes pre-installed with a togglable microchip for ease in location; their other organelles are unremovable.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "notes-medical",
			SPECIES_PERK_NAME = "Regenerator",
			SPECIES_PERK_DESC = "Slimes, if they have a proper amount of jelly inside, are capable of regenerating damage and limbs. If they're exposed to plasma at a high jelly volume, they can regenerate wounds.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "droplet-slash",
			SPECIES_PERK_NAME = "Dissolution",
			SPECIES_PERK_DESC = "If slimes have their limbs chopped off, they disintegrate and cannot be recovered. If their body dies as a whole, it dissolves away from their core and requires 100u of liquid plasma to fix.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "hand-holding-droplet",
			SPECIES_PERK_NAME = "Washes Right Out",
			SPECIES_PERK_DESC = "Slimes are capable of cleaning themselves and their clothing, siphoning the dirt off it and into themselves; even off the floor, if they're barefoot. This gives them a mild amount of nutrition.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "person-swimming",
			SPECIES_PERK_NAME = "Major Hydrophobia",
			SPECIES_PERK_DESC = "Slimes dissolve when exposed to water under normal circumstances, water nuking their blood volume and stopping their ability to regenerate.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "person-booth",
			SPECIES_PERK_NAME = "Shapeshifter",
			SPECIES_PERK_DESC = "Slimes can alter their size and general shape.",
		),
	)

	return to_add

/datum/species/jelly/roundstartslime/apply_supplementary_body_changes(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	if(preferences.read_preference(/datum/preference/toggle/allow_mismatched_hair_color))
		target.dna.species.hair_color_mode = null

/**
 * Alter Form is the ability of slimes to edit many of their character attributes at will
 * This covers most thing about their character, from body size or colour, to adding new wings, tails, ears, etc, to changing the presence of their genitalia
 * There are some balance concerns with some of these (looking at you, body size), but nobody has abused it Yet:tm:, and it would be exceedingly obvious if they did
 */
/datum/action/innate/alter_form
	name = "Alter Form"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "alter_form"
	button_icon = SLIME_ACTIONS_ICON_FILE
	background_icon_state = "bg_alien"
	/// Do you need to be a slime-person to use this ability?
	var/slime_restricted = TRUE
	///Is the person using this ability oversized?
	var/oversized_user = FALSE
	///What text is shown to others when the person uses the ability?
	var/shapeshift_text = "gains a look of concentration while standing perfectly still. Their body seems to shift and starts getting more goo-like."
	///List containing all of the avalible parts
	var/static/list/available_choices
	/// Icon for "Body Colors" alteration button.
	var/bodycolours_icon
	/// Icon for "DNA" alteration button.
	var/dna_icon
	/// Icon for "Hair" alteration button.
	var/hair_icon
	/// Icon for "Markings" alteration button.
	var/markings_icon
	/// Icon for "Primary Colour" alteration button.
	var/primarycolour_icon
	/// Icon for "Secondary Colour" alteration button.
	var/secondarycolour_icon
	/// Icon for "Tertiary Colour" alteration button.
	var/tertiarycolour_icon
	/// Icon for "All Colours" alteration button.
	var/allcolours_icon
	/// Icon for "Facial Hair" alteration button.
	var/facialhair_icon
	/// Icon for "Hair Colour" alteration button.
	var/haircolour_icon

/datum/action/innate/alter_form/proc/generate_radial_icons()
	bodycolours_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "slime_rainbow")
	dna_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "dna")
	hair_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "scissors")
	markings_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "rainbow_spraycan")
	primarycolour_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "slime_red")
	secondarycolour_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "slime_green")
	tertiarycolour_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "slime_blue")
	allcolours_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "slime_rainbow")
	facialhair_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "straight_razor")
	haircolour_icon = image(icon = SLIME_ACTIONS_ICON_FILE, icon_state = "rainbow_spraycan")

/datum/action/innate/alter_form/New(Target)
	. = ..()

	generate_radial_icons()

	if(length(available_choices))
		return

	available_choices = deep_copy_list(SSaccessories.sprite_accessories)
	for(var/parts_list in available_choices)
		for(var/parts in available_choices[parts_list])
			var/datum/sprite_accessory/part = available_choices[parts_list][parts]
			if(part.locked)
				available_choices[parts_list] -= parts

/datum/action/innate/alter_form/unrestricted
	slime_restricted = FALSE

/datum/action/innate/alter_form/Activate()
	var/mob/living/carbon/human/alterer = owner
	if(slime_restricted && !isjellyperson(alterer))
		return
	alterer.visible_message(
		span_notice("[owner] [shapeshift_text]"),
		span_notice("You focus intently on altering your body while standing perfectly still...")
	)
	change_form(alterer)

/**
 * Change form is the initial proc when using the alter form action
 * It brings up a radial menu to allow you to pick what about your character it is that you want to edit
 * Each of these radial menus should be kept from being too long where possible, really
 */
/datum/action/innate/alter_form/proc/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"Body Colours" = bodycolours_icon,
			"DNA" = dna_icon,
			"Hair" = hair_icon,
			"Markings" = markings_icon,
		),
		tooltips = TRUE,
	)
	if(!selected_alteration)
		return
	switch(selected_alteration)
		if("Body Colours")
			if(HAS_TRAIT(alterer, TRAIT_USES_SKINTONES))
				alter_skin_colours(alterer)
			else
				alter_colours(alterer)
		if("DNA")
			alter_dna(alterer)
		if("Hair")
			alter_hair(alterer)
		if("Markings")
			alter_markings(alterer)

/**
 * Alter skin colours handles the changing of skintone colours
 * This affects skin tone only.
 */
/datum/action/innate/alter_form/proc/alter_skin_colours(mob/living/carbon/human/alterer)
	var/skintone_string = tgui_input_list(
		alterer,
		"Choose your character's new skin color:",
		"Form Alteration",
		GLOB.skin_tone_names
	)

	if(!skintone_string)
		return

	var/skintone_index = GLOB.skin_tone_names.Find(skintone_string)

	if(!skintone_index)
		return

	var/selected_skintone = GLOB.skin_tones[skintone_index]

	alterer.skin_tone = selected_skintone
	alterer.dna.features["skin_color"] = skintone2hex(selected_skintone)
	alterer.dna.update_uf_block(DNA_SKIN_TONE_BLOCK)
	alterer.update_body(is_creating = TRUE)

/**
 * Alter colours handles the changing of mutant colours
 * This affects skin tone primarily, though has the option to change hair, markings, and mutant body parts to match
 */
/datum/action/innate/alter_form/proc/alter_colours(mob/living/carbon/human/alterer)
	var/color_choice = show_radial_menu(
		alterer,
		alterer,
		list(
			"Primary" = primarycolour_icon,
			"Secondary" = secondarycolour_icon,
			"Tertiary" = tertiarycolour_icon,
			"All" = allcolours_icon,
		),
		tooltips = TRUE,
	)
	if(!color_choice)
		return
	var/color_target
	switch(color_choice)
		if("Primary", "All")
			color_target = "mcolor"
		if("Secondary")
			color_target = "mcolor2"
		if("Tertiary")
			color_target = "mcolor3"

	var/new_mutant_colour = input(
		alterer,
		"Choose your character's new [color_choice = "All" ? "" : LOWER_TEXT(color_choice)] color:",
		"Form Alteration",
		alterer.dna.features[color_target]
	) as color|null
	if(!new_mutant_colour)
		return

	var/marking_reset = tgui_alert(
		alterer,
		"Would you like to reset your markings to match your new colors?",
		"Reset markings",
		list("Yes", "No"),
	)
	var/mutant_part_reset = tgui_alert(
		alterer,
		"Would you like to reset your mutant body parts(not limbs) to match your new colors?",
		"Reset mutant parts",
		list("Yes", "No"),
	)
	var/hair_reset = tgui_alert(
		alterer,
		"Would you like to reset your hair to match your new colors?",
		"Reset hair",
		list("Hair", "Facial Hair", "Both", "None"),
	)

	if(color_choice == "All")
		alterer.dna.features["mcolor"] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.features["mcolor2"] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.features["mcolor3"] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
		alterer.dna.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
		alterer.dna.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)
	else
		alterer.dna.features[color_target] = sanitize_hexcolor(new_mutant_colour)
		switch(color_target)
			if("mcolor")
				alterer.dna.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
			if("mcolor2")
				alterer.dna.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
			if("mcolor3")
				alterer.dna.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)

	if(marking_reset == "Yes")
		for(var/zone in alterer.dna.species.body_markings)
			for(var/key in alterer.dna.species.body_markings[zone])
				var/datum/body_marking/iterated_marking = GLOB.body_markings[key]
				if(iterated_marking.always_color_customizable)
					continue
				alterer.dna.species.body_markings[zone][key] = iterated_marking.get_default_color(alterer.dna.features, alterer.dna.species)

	if(mutant_part_reset == "Yes")
		alterer.mutant_renderkey = "" //Just in case
		for(var/mutant_key in alterer.dna.species.mutant_bodyparts)
			var/mutant_list = alterer.dna.species.mutant_bodyparts[mutant_key]
			var/datum/sprite_accessory/changed_accessory = SSaccessories.sprite_accessories[mutant_key][mutant_list[MUTANT_INDEX_NAME]]
			mutant_list[MUTANT_INDEX_COLOR_LIST] = changed_accessory.get_default_color(alterer.dna.features, alterer.dna.species)

	if(hair_reset)
		switch(hair_reset)
			if("Hair")
				alterer.hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()
			if("Facial Hair")
				alterer.facial_hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()
			if("Both")
				alterer.hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.facial_hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()

	alterer.update_body(is_creating = TRUE)

/**
 * Alter hair lets you adjust both the hair on your head as well as your facial hair
 * You can adjust the style of either
 */
/datum/action/innate/alter_form/proc/alter_hair(mob/living/carbon/human/alterer)
	var/target_hair = show_radial_menu(
		alterer,
		alterer,
		list(
			"Hair" = hair_icon,
			"Facial Hair" = facialhair_icon,
			"Hair Color" = haircolour_icon,
		),
		tooltips = TRUE,
	)
	if(!target_hair)
		return
	switch(target_hair)
		if("Hair")
			var/new_style = tgui_input_list(owner, "Select a hair style", "Hair Alterations", SSaccessories.hairstyles_list)
			if(new_style)
				alterer.set_hairstyle(new_style, update = TRUE)
		if("Facial Hair")
			var/new_style = tgui_input_list(alterer, "Select a facial hair style", "Hair Alterations", SSaccessories.facial_hairstyles_list)
			if(new_style)
				alterer.set_facial_hairstyle(new_style, update = TRUE)
		if("Hair Color")
			var/hair_area = tgui_alert(alterer, "Select which color you would like to change", "Hair Color Alterations", list("Hairstyle", "Facial Hair", "Both"))
			if(!hair_area)
				return
			var/new_hair_color = input(alterer, "Select your new hair color", "Hair Color Alterations", alterer.dna.features["mcolor"]) as color|null
			if(!new_hair_color)
				return

			switch(hair_area)

				if("Hairstyle")
					alterer.set_haircolor(sanitize_hexcolor(new_hair_color), update = TRUE)
				if("Facial Hair")
					alterer.set_facial_haircolor(sanitize_hexcolor(new_hair_color), update = TRUE)
				if("Both")
					alterer.set_haircolor(sanitize_hexcolor(new_hair_color), update = FALSE)
					alterer.set_facial_haircolor(sanitize_hexcolor(new_hair_color), update = TRUE)

/**
 * Alter DNA is an intermediary proc for the most part
 * It lets you pick between a few options for DNA specifics
 */
/datum/action/innate/alter_form/proc/alter_dna(mob/living/carbon/human/alterer)
	var/list/key_list = list("Body Size", "Genitals", "Mutant Parts")
	if(CONFIG_GET(flag/disable_erp_preferences))
		key_list.Remove("Genitals")
	var/dna_alteration = tgui_input_list(
		alterer,
		"Select what part of your DNA you'd like to alter",
		"DNA Alteration",
		key_list,
	)
	if(!dna_alteration)
		return
	switch(dna_alteration)
		if("Body Size")
			if(oversized_user && !HAS_TRAIT(alterer, TRAIT_OVERSIZED))
				var/reset_size = tgui_alert(alterer, "Do you wish to return to being oversized?", "Size Change", list("Yes", "No"))
				if(reset_size == "Yes")
					alterer.add_quirk(/datum/quirk/oversized)
					return

			var/new_body_size = tgui_input_number(
				alterer,
				"Choose your desired sprite size: ([BODY_SIZE_MIN * 100]% to [BODY_SIZE_MAX * 100]%). Warning: May make your character look distorted",
				"Size Change",
				default = min(alterer.dna.features["body_size"] * 100, BODY_SIZE_MAX * 100),
				max_value = BODY_SIZE_MAX * 100,
				min_value = BODY_SIZE_MIN * 100,
			)
			if(!new_body_size)
				return

			if(HAS_TRAIT(alterer, TRAIT_OVERSIZED))
				oversized_user = TRUE
				alterer.remove_quirk(/datum/quirk/oversized)

			new_body_size = new_body_size * 0.01
			alterer.dna.features["body_size"] = new_body_size
			alterer.dna.update_body_size()

		if("Genitals")
			alter_genitals(alterer)
		if("Mutant Parts")
			alter_parts(alterer)

	alterer.mutant_renderkey = "" //Just in case
	alterer.update_body_parts()

/**
 * Alter parts lets you adjust mutant bodyparts
 * This can be adding (or removing) things like ears, tails, wings, et cetera.
 */
/datum/action/innate/alter_form/proc/alter_parts(mob/living/carbon/human/alterer)
	var/list/key_list = alterer.dna.mutant_bodyparts
	if(CONFIG_GET(flag/disable_erp_preferences))
		for(var/erp_part in ORGAN_ERP_LIST)
			key_list -= erp_part
	var/chosen_key = tgui_input_list(
		alterer,
		"Select the part you want to alter",
		"Body Part Alterations",
		key_list,
	)
	if(!chosen_key)
		return

	var/choice_list = available_choices[chosen_key]
	var/chosen_name_key = tgui_input_list(
		alterer,
		"What do you want the part to become?",
		"Body Part Alterations",
		choice_list,
	)
	if(!chosen_name_key)
		return

	var/datum/sprite_accessory/selected_sprite_accessory = SSaccessories.sprite_accessories[chosen_key][chosen_name_key]
	alterer.mutant_renderkey = "" //Just in case
	if(!selected_sprite_accessory.factual)
		if(selected_sprite_accessory.organ_type)
			var/obj/item/organ/organ_path = selected_sprite_accessory.organ_type
			var/slot = initial(organ_path.slot)
			var/obj/item/organ/got_organ = alterer.get_organ_slot(slot)
			if(got_organ)
				got_organ.Remove(alterer)
				qdel(got_organ)
		else
			alterer.dna.species.mutant_bodyparts -= chosen_key
	else
		if(selected_sprite_accessory.organ_type)
			var/robot_organs = HAS_TRAIT(alterer, TRAIT_ROBOTIC_DNA_ORGANS)

			var/obj/item/organ/organ_path = selected_sprite_accessory.organ_type
			var/slot = initial(organ_path.slot)
			var/obj/item/organ/got_organ = alterer.get_organ_slot(slot)
			if(got_organ)
				got_organ.Remove(alterer)
				qdel(got_organ)

			var/obj/item/organ/replacement_organ = SSwardrobe.provide_type(selected_sprite_accessory.organ_type)
			replacement_organ.sprite_accessory_flags = selected_sprite_accessory.flags_for_organ
			replacement_organ.relevant_layers = selected_sprite_accessory.relevent_layers

			var/list/new_acc_list = list()
			new_acc_list[MUTANT_INDEX_NAME] = selected_sprite_accessory.name
			new_acc_list[MUTANT_INDEX_COLOR_LIST] = selected_sprite_accessory.get_default_color(alterer.dna.features, alterer.dna.species)
			alterer.dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()

			if(robot_organs)
				replacement_organ.organ_flags |= ORGAN_ROBOTIC
			replacement_organ.build_from_dna(alterer.dna, chosen_key)
			replacement_organ.Insert(alterer, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		else
			var/list/new_acc_list = list()
			new_acc_list[MUTANT_INDEX_NAME] = selected_sprite_accessory.name
			new_acc_list[MUTANT_INDEX_COLOR_LIST] = selected_sprite_accessory.get_default_color(alterer.dna.features, alterer.dna.species)
			alterer.dna.species.mutant_bodyparts[chosen_key] = new_acc_list
			alterer.dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
		alterer.dna.update_uf_block(SSaccessories.dna_mutant_bodypart_blocks[chosen_key])
	alterer.update_body_parts()
	alterer.update_clothing(ALL) // for any clothing that has alternate versions (e.g. muzzled masks)

/**
 * Alter markings lets you add a particular body marking
 */
/datum/action/innate/alter_form/proc/alter_markings(mob/living/carbon/human/alterer)
	var/list/candidates = GLOB.body_marking_sets
	var/chosen_name = tgui_input_list(
		alterer,
		"Select which set of markings would you like to change into",
		"Marking Alterations",
		candidates,
	)
	if(!chosen_name)
		return
	var/datum/body_marking_set/marking_set = GLOB.body_marking_sets[chosen_name]
	alterer.dna.species.body_markings = assemble_body_markings_from_set(marking_set, alterer.dna.features, alterer.dna.species)
	alterer.update_body(is_creating = TRUE)

/**
 * Alter genitals lets you adjust the size or functionality of genitalia
 * If you don't own the genital you try to adjust, it'll ask you if you want to add it first
 */
/datum/action/innate/alter_form/proc/alter_genitals(mob/living/carbon/human/alterer)
	var/list/genital_list
	if(alterer.get_organ_slot(ORGAN_SLOT_BREASTS))
		genital_list += list("Breasts Lactation", "Breasts Size")
	if(alterer.get_organ_slot(ORGAN_SLOT_PENIS))
		genital_list += list("Penis Girth", "Penis Length", "Penis Sheath", "Penis Taur Mode")
	if(alterer.get_organ_slot(ORGAN_SLOT_TESTICLES))
		genital_list += list("Testicles Size")
	if(!length(genital_list))
		alterer.balloon_alert(alterer, "no genitals!")

	var/dna_alteration = tgui_input_list(
		alterer,
		"Select what bodypart you'd like to alter",
		"Genital Alteration",
		genital_list
	)
	if(!dna_alteration)
		return
	switch(dna_alteration)
		if("Breasts Lactation")
			var/obj/item/organ/genital/breasts/melons = alterer.get_organ_slot(ORGAN_SLOT_BREASTS)
			alterer.dna.features["breasts_lactation"] = !alterer.dna.features["breasts_lactation"]
			melons.lactates = alterer.dna.features["breasts_lactation"]
			alterer.balloon_alert(alterer, "[alterer.dna.features["breasts_lactation"] ? "lactating" : "not lactating"]")

		if("Breasts Size")
			var/obj/item/organ/genital/breasts/melons = alterer.get_organ_slot(ORGAN_SLOT_BREASTS)
			var/new_size = tgui_input_list(
				alterer,
				"Choose your character's breasts size:",
				"DNA Alteration",
				GLOB.breast_size_to_number,
			)
			if(!new_size)
				return
			alterer.dna.features["breasts_size"] = melons.breasts_cup_to_size(new_size)
			melons.set_size(alterer.dna.features["breasts_size"])

		if("Penis Girth")
			var/obj/item/organ/genital/penis/sausage = alterer.get_organ_slot(ORGAN_SLOT_PENIS)
			var/max_girth = PENIS_MAX_GIRTH
			if(alterer.dna.features["penis_size"] >= max_girth)
				max_girth = alterer.dna.features["penis_size"]
			var/new_girth = tgui_input_number(
				alterer,
				"Choose your penis girth:\n(1-[max_girth] (based on length) in inches)",
				"Character Preference",
				max_value = max_girth,
				min_value = 1
			)
			if(new_girth)
				alterer.dna.features["penis_girth"] = new_girth
				sausage.girth = alterer.dna.features["penis_girth"]

		if("Penis Length")
			var/obj/item/organ/genital/penis/wang = alterer.get_organ_slot(ORGAN_SLOT_PENIS)
			var/new_length = tgui_input_number(
				alterer,
				"Choose your penis length:\n([PENIS_MIN_LENGTH]-[PENIS_MAX_LENGTH] inches)",
				"DNA Alteration",
				max_value = PENIS_MAX_LENGTH,
				min_value = PENIS_MIN_LENGTH,
			)
			if(!new_length)
				return
			alterer.dna.features["penis_size"] = new_length
			if(alterer.dna.features["penis_girth"] >= new_length)
				alterer.dna.features["penis_girth"] = new_length - 1
				wang.girth = alterer.dna.features["penis_girth"]
			wang.set_size(alterer.dna.features["penis_size"])

		if("Penis Sheath")
			var/obj/item/organ/genital/penis/schlong = alterer.get_organ_slot(ORGAN_SLOT_PENIS)
			var/new_sheath = tgui_input_list(
				alterer,
				"Choose your penis sheath",
				"DNA Alteration",
				SHEATH_MODES,
			)
			if(new_sheath)
				alterer.dna.features["penis_sheath"] = new_sheath
				schlong.sheath = new_sheath

		if("Penis Taur Mode")
			alterer.dna.features["penis_taur_mode"] = !alterer.dna.features["penis_taur_mode"]
			alterer.balloon_alert(alterer, "[alterer.dna.features["penis_taur_mode"] ? "using taur penis" : "not using taur penis"]")

		if("Testicles Size")
			var/obj/item/organ/genital/testicles/avocados = alterer.get_organ_slot(ORGAN_SLOT_TESTICLES)
			var/new_size = tgui_input_list(
				alterer,
				"Choose your character's testicles size:",
				"Character Preference",
				GLOB.preference_balls_sizes,
			)
			if(new_size)
				alterer.dna.features["balls_size"] = avocados.balls_description_to_size(new_size)
				avocados.set_size(alterer.dna.features["balls_size"])

/**
 * Toggle Death Signal simply adds and removes the trait required for slimepeople to transmit a GPS signal upon core ejection.
 */
/datum/action/innate/core_signal
	name = "Toggle Core Signal"
	desc = "Interface with the microchip placed in your core, modifying if it emits a GPS signal or not; due to how thick your liquid body is, the signal won't reach out until your core is outside of it."
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	button_icon_state = "slime_core"
	background_icon_state = "bg_alien"
	/// Do you need to be a slime-person to use this ability?
	var/slime_restricted = TRUE

/datum/action/innate/core_signal/Activate()
	var/mob/living/carbon/human/slime = owner
	var/obj/item/organ/brain/slime/core = slime.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(slime_restricted && !isjellyperson(slime))
		return
	if(core.gps_active)
		to_chat(owner,span_notice("You tune out the electromagnetic signals from your core so they are ignored by GPS receivers upon its rejection."))
		core.gps_active = FALSE
	else
		to_chat(owner, span_notice("You fine-tune the electromagnetic signals from your core to be picked up by GPS receivers upon its rejection."))
		core.gps_active = TRUE

#undef SLIME_ACTIONS_ICON_FILE
#undef DAMAGE_WATER_STACKS
#undef REGEN_WATER_STACKS
