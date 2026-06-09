/datum/species/human/ashwalker
	name = "Ash-Kin"
	id = SPECIES_ASHKIN
	mutanteyes = /obj/item/organ/eyes/night_vision/ashwalker
	coldmod = 1.5
	heatmod = 0.67
	mutantlungs = /obj/item/organ/lungs/lavaland
	mutantbrain = /obj/item/organ/brain/primitive
	species_language_holder = /datum/language_holder/lizard/ash
	inherent_traits = list(
		TRAIT_VIRUSIMMUNE,
		TRAIT_RESISTHEAT,
	)
		bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ashwalker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ashwalker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/ashwalker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/ashwalker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ashwalker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ashwalker,
	)




	always_customizable = TRUE


/datum/species/human/ashwalker/on_species_gain(mob/living/carbon/carbon_target, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	ADD_TRAIT(carbon_target, TRAIT_ASHSTORM_IMMUNE, SPECIES_TRAIT)
	RegisterSignal(carbon_target, COMSIG_MOB_ITEM_ATTACK, PROC_REF(mob_attack))
	carbon_target.AddComponent(/datum/component/ash_age)
	carbon_target.apply_status_effect(/datum/status_effect/ash_age)
	carbon_target.add_faction(FACTION_ASHWALKER)

/datum/species/human/ashwalker/on_species_loss(mob/living/carbon/carbon_target)
	. = ..()
	REMOVE_TRAIT(carbon_target, TRAIT_ASHSTORM_IMMUNE, SPECIES_TRAIT)
	UnregisterSignal(carbon_target, COMSIG_MOB_ITEM_ATTACK)
	carbon_target.remove_faction(FACTION_ASHWALKER)

/datum/species/human/ashwalker/proc/mob_attack(datum/source, mob/mob_target, mob/user)
	SIGNAL_HANDLER

	if(!isliving(mob_target))
		return

	var/mob/living/living_target = mob_target
	var/datum/status_effect/ashwalker_damage/ashie_damage = living_target.has_status_effect(/datum/status_effect/ashwalker_damage)
	if(!ashie_damage)
		ashie_damage = living_target.apply_status_effect(/datum/status_effect/ashwalker_damage)

	ashie_damage.register_mob_damage(living_target)

/datum/species/human/ashwalker/get_species_lore()
	return list(placeholder_lore)
