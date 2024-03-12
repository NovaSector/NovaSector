// allows style meter chads to do flips
/datum/component/style/RegisterWithParent()
	. = ..()
	ADD_TRAIT(parent, TRAIT_STYLISH, REF(src))

/datum/component/style/UnregisterFromParent()
	REMOVE_TRAIT(parent, TRAIT_STYLISH, REF(src)) // NOVA EDIT ADDITION - allows style meter chads to do flips
	return ..()
