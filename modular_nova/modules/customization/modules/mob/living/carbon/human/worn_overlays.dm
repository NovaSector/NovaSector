/**
 * Setup the final version of accessory's overlay given custom species options.
 */
/obj/item/clothing/accessory/generate_accessory_overlay(obj/item/clothing/under/attached_to)
	if(!ishuman(attached_to.loc))
		return ..()

	var/mob/living/carbon/human/human_wearer = attached_to.loc
	// list[key] is null when absent, so this covers species with no custom accessory icon too
	var/icon/custom_accessory_icon = human_wearer.dna.species.custom_worn_icons[LOADOUT_ITEM_ACCESSORY]
	var/icon_state_to_check_for = icon_state_is_worn ? icon_state : worn_icon_state
	var/use_custom_icon = custom_accessory_icon && (icon_state_to_check_for in icon_states(custom_accessory_icon))

	var/mutable_appearance/appearance
	if(use_custom_icon)
		var/prev_worn_icon = worn_icon
		// Make new appearance so we don't break the real accessory overlay for other species, and treat it as final.
		worn_icon = custom_accessory_icon
		appearance = ..()
		worn_icon = prev_worn_icon // put it back how it was, so we don't break anything for whoever wears this next
	else
		appearance = ..()
		// Only apply the offset to the fallback sprite. it's drawn for a default human torso.
		// Species-specific sprites are already fitted and need no correction.
		var/obj/item/bodypart/chest/my_chest = human_wearer.get_bodypart(BODY_ZONE_CHEST)
		my_chest?.worn_accessory_offset?.apply_offset(appearance)

	return appearance
