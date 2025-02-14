#define OVERSIZED_SPEED_SLOWDOWN 0.9
#define OVERSIZED_HUNGER_MOD 1.5

// Before making any changes to oversized, please see the module's readme.md file

/datum/quirk/oversized
	name = "Oversized"
	desc = "You, for whatever reason, are FAR too tall, and will encounter some rough situations because of it."
	gain_text = span_notice("That airlock looks small...")
	lose_text = span_notice("Is it still the same size...?") //Lol
	medical_record_text = "Patient is abnormally tall."
	value = 0
	mob_trait = TRAIT_OVERSIZED
	icon = FA_ICON_EXPAND_ARROWS_ALT
	veteran_only = TRUE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	/// Saves refs to the original (normal size) organs, which are on ice in nullspace in case this quirk gets removed somehow.
	var/list/obj/item/organ/old_organs

/datum/quirk/oversized/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = 2
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"] //Adjust runechat height
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_LARGE

	RegisterSignal(human_holder, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(on_gain_limb)) // make sure we handle this when new ones are applied

	// just dummy call our current limbs to have less duplication (by having more duplication ahueheu)
	for(var/obj/item/bodypart/bodypart as anything in human_holder.bodyparts)
		on_gain_limb(src, bodypart, special = FALSE)

	human_holder.blood_volume_normal = BLOOD_VOLUME_OVERSIZED
	human_holder.physiology.hunger_mod *= OVERSIZED_HUNGER_MOD //50% hungrier
	human_holder.add_movespeed_modifier(/datum/movespeed_modifier/oversized)

	human_holder.dna.species.gain_oversized_organs(human_holder, src) // handles the addition of oversized organs (species default is a plain oversized stomach)

/datum/quirk/oversized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = human_holder?.client?.prefs ?human_holder?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) : 1
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"]
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_HUMAN

	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_damage_high = initial(left_arm.unarmed_damage_high)

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_damage_high = initial(right_arm.unarmed_damage_high)

	var/obj/item/bodypart/leg/left_leg = human_holder.get_bodypart(BODY_ZONE_L_LEG)
	if (left_leg)
		left_leg.unarmed_effectiveness = initial(left_leg.unarmed_effectiveness)

	var/obj/item/bodypart/leg/right_leg = human_holder.get_bodypart(BODY_ZONE_R_LEG)
	if (right_leg)
		right_leg.unarmed_effectiveness = initial(right_leg.unarmed_effectiveness)

	for(var/obj/item/bodypart/bodypart as anything in human_holder.bodyparts)
		bodypart.name = replacetext(bodypart.name, "oversized ", "")

	UnregisterSignal(human_holder, COMSIG_CARBON_POST_ATTACH_LIMB)

	human_holder.blood_volume_normal = BLOOD_VOLUME_NORMAL
	human_holder.physiology.hunger_mod /= OVERSIZED_HUNGER_MOD
	human_holder.remove_movespeed_modifier(/datum/movespeed_modifier/oversized)

	for(var/obj/item/organ/organ_to_restore in old_organs)
		old_organs -= organ_to_restore

		if(QDELETED(organ_to_restore)) // not sure why this would ever happen but just in case
			continue

		// if it's a brain, make sure the mob doesn't get stuck outside their body
		var/obj/item/organ/brain/possibly_a_brain = organ_to_restore
		if(istype(possibly_a_brain))
			var/obj/item/organ/brain/current_brain = human_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
			possibly_a_brain.brainmob = current_brain.brainmob

		organ_to_restore.replace_into(quirk_holder)

/datum/quirk/oversized/proc/on_gain_limb(datum/source, obj/item/bodypart/gained, special)
	SIGNAL_HANDLER

	if(findtext(gained.name, "oversized"))
		return

	// Oversized arms have a higher damage maximum. Pretty simple.
	if(istype(gained, /obj/item/bodypart/arm))
		var/obj/item/bodypart/arm/new_arm = gained
		new_arm.unarmed_damage_high = initial(new_arm.unarmed_damage_high) + OVERSIZED_HARM_DAMAGE_BONUS

	// Before this, we never actually did anything with Oversized legs.
	// This brings their unarmed_effectiveness up to 20 from 15, which is on par with mushroom legs.
	// Functionally, this makes their prone kicks more accurate and increases the chance of extending prone knockdown... but only while the victim is already prone.
	else if(istype(gained, /obj/item/bodypart/leg))
		var/obj/item/bodypart/leg/new_leg = gained
		new_leg.unarmed_effectiveness = initial(new_leg.unarmed_effectiveness) + OVERSIZED_KICK_EFFECTIVENESS_BONUS

	gained.name = "oversized " + gained.name

/datum/movespeed_modifier/oversized
	multiplicative_slowdown = OVERSIZED_SPEED_SLOWDOWN


#undef OVERSIZED_HUNGER_MOD
#undef OVERSIZED_SPEED_SLOWDOWN
