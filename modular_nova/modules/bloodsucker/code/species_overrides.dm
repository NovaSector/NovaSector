// Base species procs for bloodsucker compatibility
// These add new procs to /datum/species that bloodsucker code calls

/// Called once the target is made into a bloodsucker. Used for removing conflicting species organs mostly
/datum/species/proc/on_bloodsucker_gain(mob/living/carbon/human/target)
	return null

/datum/species/proc/on_bloodsucker_loss(mob/living/carbon/human/target)
	return null

/// Replaces a couple organs to normal variants to not cause issues. Not super happy with this, alternative is disallowing incompatible species from being bloodsuckers
/datum/species/proc/humanize_organs(mob/living/carbon/human/target, organs = list())
	if(!organs || !length(organs))
		organs = list(
			ORGAN_SLOT_HEART = /obj/item/organ/heart,
			ORGAN_SLOT_LIVER = /obj/item/organ/liver,
			ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
			ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		)
	mutantheart = organs[ORGAN_SLOT_HEART]
	mutantliver = organs[ORGAN_SLOT_LIVER]
	mutantstomach = organs[ORGAN_SLOT_STOMACH]
	mutanttongue = organs[ORGAN_SLOT_TONGUE]
	for(var/organ_slot in organs)
		var/obj/item/organ/old_organ = target.get_organ_slot(organ_slot)
		var/organ_path = organs[organ_slot]
		if(old_organ?.type == organ_path)
			continue
		var/obj/item/organ/new_organ = SSwardrobe.provide_type(organ_path)
		new_organ.Insert(target, FALSE, DELETE_IF_REPLACED)

/datum/species/proc/normalize_organs(mob/living/carbon/human/target)
	mutantheart = initial(mutantheart)
	mutantliver = initial(mutantliver)
	mutantstomach = initial(mutantstomach)
	mutanttongue = initial(mutanttongue)
	regenerate_organs(target, replace_current = TRUE)

// Species-specific bloodsucker overrides

/datum/species/human/vampire/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	to_chat(target, span_warning("Your vampire features have been removed -- the deep strain symbiont has subsumed the lesser vampiric mutation."))
	humanize_organs(target, current_species)

/datum/species/human/vampire/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)

/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)

/datum/species/jelly/on_bloodsucker_gain(mob/living/carbon/human/target)
	humanize_organs(target)

/datum/species/jelly/on_bloodsucker_loss(mob/living/carbon/human/target)
	// regenerate_organs with replace doesn't seem to automatically remove invalid organs unfortunately
	normalize_organs()

/datum/species/hemophage/on_bloodsucker_gain(mob/living/carbon/human/target)
	to_chat(target, span_warning("Your standard hemophage features have been overwritten -- the deep strain symbiont has consumed and replaced the original hemophage mutation."))
	// Without this any new organs would get corrupted again.
	target.RemoveElement(/datum/element/tumor_corruption)
	for(var/obj/item/organ/organ in target.organs)
		organ.RemoveElement(/datum/element/tumor_corruption)
	humanize_organs(target)

/datum/species/hemophage/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)
