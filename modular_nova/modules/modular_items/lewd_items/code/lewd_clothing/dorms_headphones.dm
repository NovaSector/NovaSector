/obj/item/clothing/ears/dorms_headphones
	name = "padded headphones"
	desc = "Protects your ears from loud noises - it has a little switch on the right-hand side."
	icon_state = "kinkphones_off"
	base_icon_state = "kinkphones"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_ears.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_ears.dmi'
	greyscale_colors = "#383840#dc7ef4#dc7ef4"
	greyscale_config = /datum/greyscale_config/dorms_headphones
	greyscale_config_worn = /datum/greyscale_config/dorms_headphones/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	strip_delay = 15
	custom_price = PAYCHECK_CREW * 2
	actions_types = list(/datum/action/item_action/toggle_dorms_headphones)
	/// Are we playing music? Controls icon state and flavor text.
	var/playing_music = FALSE

/obj/item/clothing/ears/dorms_headphones/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddElement(/datum/element/earhealing) // idk either; man, earmuffs do it too
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/clothing/ears/dorms_headphones/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[playing_music? "on" : "off"]"
	inhand_icon_state = "[base_icon_state]_[playing_music? "on" : "off"]"

/obj/item/clothing/ears/dorms_headphones/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(istype(user) && (slot & ITEM_SLOT_EARS)))
		return
	to_chat(user, span_purple("[!playing_music ? "You can barely hear anything! Your other senses have become more apparent..." : "Strange but relaxing music fills your mind. You feel so... Calm."]"))
	ADD_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)

/obj/item/clothing/ears/dorms_headphones/dropped(mob/living/carbon/human/user)
	. = ..()
	if(!(src == user.ears))
		return
	REMOVE_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
	to_chat(user, span_purple("You can finally hear the world around you once more."))

/obj/item/clothing/ears/dorms_headphones/proc/toggle(owner)
	playing_music = !playing_music
	update_icon()
	to_chat(owner, span_notice("You turn the music [playing_music ? "on. It plays relaxing music." : "off."]"))

/datum/action/item_action/toggle_dorms_headphones
	name = "Toggle Headphones' Music"
	desc = "Plays a selection of some rather meditative music."

/datum/action/item_action/toggle_dorms_headphones/Trigger(trigger_flags)
	var/obj/item/clothing/ears/dorms_headphones/headphones = target
	if(istype(headphones))
		headphones.toggle(owner)
