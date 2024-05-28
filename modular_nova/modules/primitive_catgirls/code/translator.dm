/obj/item/clothing/neck/necklace/translator/hearthkin
	name = "antique necklace"
	desc = "A necklace with a old, strange device as its pendant. Symbols \
		constantly seem to appear on its screen, as noises happen around it, \
		but its purpose is not immediately apparent."
	icon = 'modular_nova/modules/primitive_catgirls/icons/translator.dmi'
	worn_icon = 'modular_nova/modules/primitive_catgirls/icons/translator_worn.dmi'
	icon_state = "translator"
	language_granted = /datum/language/siiktajr


/obj/item/clothing/neck/necklace/translator/hearthkin/equip_feedback(mob/living/carbon/human/equipper)
	to_chat(equipper, span_notice( \
		"<i>Slipping the necklace on, you notice a slight buzzing in your ears, \
		and that any word in [initial(language_granted.name)] said in your \
		general vicinity is immediately translated to your native language, \
		directly in your ears. Not only that, but you find yourself able to \
		speak your mind in such a way that the pendant translates your words \
		back in [initial(language_granted.name)].</i>" \
	))


/obj/item/clothing/neck/necklace/translator/hearthkin/unequip_feedback(mob/living/carbon/human/unequipper)
	to_chat(unequipper, span_boldnotice( \
		"<i>\The [src]'s constant buzzing suddenly stops. Peace, at last. \
		You also lose your artificial grasp on [initial(language_granted.name)], \
		unfortunately. Such is the price for peace and quiet.</i>" \
	))
