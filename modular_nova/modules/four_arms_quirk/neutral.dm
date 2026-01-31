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


/datum/quirk/four_arms/add(client/client_source)
	var/mob/living/carbon/human/quad_arm = quirk_holder
	quad_arm.change_number_of_arms(4)
	quad_arm.update_body_parts()

/datum/quirk/four_arms/remove()
	var/mob/living/carbon/human/quad_arm = quirk_holder
	quad_arm.change_number_of_arms(2)
	quad_arm.update_body_parts()

// Based off the change_number_of_hands(amt) proc in inventory.dm
// This is a separate proc for two reasons:
// 1) Modularity,
// 2) Removing the ugly white overlay that is superimposed atop the old arms when the 'base' proc is used.
// ...
// I'm aware that the way this is just dropped in here is a horrid code smell and anti-pattern but I couldn't ...
// ... think of a better/quicker/easier way to do this in .dm; Will gladly alter this if someone more knowledgeable ...
// ... has a better solution in mind that doesn't involve tremenduous effort for a niche feature. - bwsb/SunriseOYH
/mob/living/carbon/human/proc/change_number_of_arms(amt)
	var/old_limbs = held_items.len
	if(amt < old_limbs)
		for(var/i in hand_bodyparts.len to amt step -1)
			var/obj/item/bodypart/BP = hand_bodyparts[i]
			BP.dismember()
			hand_bodyparts[i] = null
		hand_bodyparts.len = amt
	else if(amt > old_limbs)
		hand_bodyparts.len = amt
		for(var/i in old_limbs + 1 to amt)
			var/obj/item/bodypart/arm/new_bodypart
			if(IS_RIGHT_INDEX(i))
				new_bodypart = newBodyPart(BODY_ZONE_R_ARM)
			else
				new_bodypart = newBodyPart(BODY_ZONE_L_ARM)
			new_bodypart.held_index = i
			new_bodypart.try_attach_limb(src, TRUE)
			new_bodypart.update_limb(is_creating = TRUE)
			// values empirically tested to look the best.
			if(i > 2)
				if(IS_RIGHT_INDEX(i))
					new_bodypart.held_hand_offset = new(
						attached_part = new_bodypart,
						feature_key = OFFSET_HELD,
						offset_x = list("north" = 0, "south" = 0, "east" = 0, "west" = 0, "northwest" = 0, "southwest" = 0, "northeast" = 0, "southeast" = 0),
						offset_y = list("north" = -20, "south" = -20, "east" = -20, "west" = -20),
					)
				else
					new_bodypart.held_hand_offset = new(
						attached_part = new_bodypart,
						feature_key = OFFSET_HELD,
						offset_x = list("north" = 0, "south" = 0, "east" = 0, "west" = 0, "northwest" = 0, "southwest" = 0, "northeast" = 0, "southeast" = 0),
						offset_y = list("north" = -20, "south" = -20, "east" = -20, "west" = -20),
					)
			hand_bodyparts[i] = new_bodypart
	if(amt < held_items.len)
		for(var/i in held_items.len to amt step -1)
			dropItemToGround(held_items[i])
	held_items.len = amt
	if(hud_used)
		hud_used.build_hand_slots()
