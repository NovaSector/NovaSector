/datum/quirk/four_arms
	name = "Four Arms"
	desc = "Whether due to the intrinsic nature of your species or genetic modification, you have four arms instead of two."
	value = 0
	mob_trait = TRAIT_FOUR_ARMS
	gain_text = span_notice("You feel your extra arms respond to your thoughts.")
	lose_text = span_danger("Your extra arms fade away.")
	medical_record_text = "Subject exhibits a tetramorphic physiognomy with four prehensile, articulated arms."
	icon = FA_ICON_HANDS_CLAPPING

/*
	It is not an oversight that this trait is not co-dependent with the 'extra arms' organ in fourarms.dm.

	By keeping traits and sprite overlays separate, players aren't forced to engage with finnicky four-arm mechanics if they...
	...just want a different appearance.
*/
#define EXTRA_ARM_HELD_OFFSET_Y -20

/datum/quirk/four_arms/proc/make_extra_arm_offset(obj/item/bodypart/arm/limb)
	return new /datum/worn_feature_offset(
		attached_part = limb,
		feature_key = OFFSET_HELD,
		offset_x = list("north" = 0, "south" = 0, "east" = 0, "west" = 0, "northwest" = 0, "southwest" = 0, "northeast" = 0, "southeast" = 0),
		offset_y = list("north" = EXTRA_ARM_HELD_OFFSET_Y, "south" = EXTRA_ARM_HELD_OFFSET_Y, "east" = EXTRA_ARM_HELD_OFFSET_Y, "west" = EXTRA_ARM_HELD_OFFSET_Y),
	)

#undef EXTRA_ARM_HELD_OFFSET_Y

/datum/quirk/four_arms/add(client/client_source)
	var/mob/living/carbon/human/quad_arm = quirk_holder
	quad_arm.change_number_of_arms(4)
	quad_arm.update_body_parts()
	quad_arm.change_number_of_hands(4)
	for(var/obj/item/bodypart/arm/limb in quad_arm.hand_bodyparts)
		if(limb.held_index > 2)
			limb.held_hand_offset ||= make_extra_arm_offset(limb)
/datum/quirk/four_arms/remove()
	var/mob/living/carbon/human/quad_arm = quirk_holder
	quad_arm.change_number_of_hands(2)

