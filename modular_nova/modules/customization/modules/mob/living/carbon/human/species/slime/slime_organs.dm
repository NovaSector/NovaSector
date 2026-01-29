/obj/item/organ/eyes/jelly
	name = "photosensitive eyespots"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE

/obj/item/organ/eyes/roundstartslime
	name = "photosensitive eyespots"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE

/obj/item/organ/ears/jelly
	name = "core audiosomes"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE

/obj/item/organ/tongue/jelly
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE

/obj/item/organ/tongue/jelly/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	set_say_modifiers(receiver, exclaim = "squishes", whisper = "fizzles", yell = "splashes", say = "blorbles")

/obj/item/organ/tongue/jelly/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	organ_owner.verb_ask = initial(verb_ask)
	organ_owner.verb_exclaim = initial(verb_exclaim)
	organ_owner.verb_whisper = initial(verb_whisper)
	organ_owner.verb_yell = initial(verb_yell)

/obj/item/organ/lungs/slime
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE

/obj/item/organ/liver/slime
	name = "endoplasmic reticulum"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE

// CHEMICAL HANDLING
// Here's where slimes heal off plasma and where they hate drinking water.
/obj/item/organ/liver/slime/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick)
	. = ..()
	if(. & COMSIG_MOB_STOP_REAGENT_TICK)
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
		for(var/datum/wound/iter_wound as anything in organ_owner.all_wounds)
			iter_wound.on_xadone(4 * REM * seconds_per_tick)
			organ_owner.reagents.remove_reagent(chem.type, min(chem.volume * 0.22, 10))
		if(organ_owner.get_blood_volume() > BLOOD_VOLUME_SLIME_SPLIT)
			organ_owner.adjust_organ_loss(
				pick(organs_we_mend),
				- 2 * seconds_per_tick,
			)
		if(SPT_PROB(5, seconds_per_tick))
			to_chat(organ_owner, span_purple("Your body's thirst for plasma is quenched, your inner and outer membrane using it to regenerate."))

	if(chem.type == /datum/reagent/water)
		if(HAS_TRAIT(organ_owner, TRAIT_SLIME_HYDROPHOBIA) || HAS_TRAIT(organ_owner, TRAIT_WATER_BREATHING))
			return

		organ_owner.adjust_blood_volume(-3 * seconds_per_tick)
		organ_owner.reagents.remove_reagent(chem.type, min(chem.volume * 0.22, 10))
		if(SPT_PROB(1, seconds_per_tick))
			to_chat(organ_owner, span_warning("The water starts to weaken and adulterate your insides!"))
		return COMSIG_MOB_STOP_REAGENT_TICK

/obj/item/organ/stomach/slime
	name = "golgi apparatus"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE
