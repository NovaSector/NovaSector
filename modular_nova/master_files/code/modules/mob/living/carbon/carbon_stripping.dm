/datum/strippable_item/hand/left_lower
	key = STRIPPABLE_ITEM_LHAND_LOWER
	hand_index = LEFT_HANDS_LOWER

/datum/strippable_item/hand/left_lower/should_show(atom/source, mob/user)
	return HAS_TRAIT(source, TRAIT_FOUR_ARMS)

/datum/strippable_item/hand/right_lower
	key = STRIPPABLE_ITEM_RHAND_LOWER
	hand_index = RIGHT_HANDS_LOWER

/datum/strippable_item/hand/right_lower/should_show(atom/source, mob/user)
	return HAS_TRAIT(source, TRAIT_FOUR_ARMS)
