/obj/item/clothing/head/costume/nursehat
	icon = 'modular_nova/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/costume.dmi'


/obj/item/clothing/head/helmet/glassdome
	name = "glass bowl helmet"
	desc = "Despite the temptation, this won't protect you in space."
	icon = 'modular_nova/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/akula.dmi'
	clothing_flags = THICKMATERIAL | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	strip_delay = 6 SECONDS
	armor_type = /datum/armor/wetsuit_helmet
	resistance_flags = FIRE_PROOF
	flags_inv = null
	flags_cover = HEADCOVERSMOUTH | PEPPERPROOF
	/obj/item/clothing/head/helmet/glassdome/Destroy()
	var/mob/user = loc
	if(attached_hat)
		attached_hat.forceMove(drop_location())
		attached_hat = null

	if(!istype(user))
		return ..()

	return ..()

// Wearing hats inside the wetworks helmet
/obj/item/clothing/head/helmet/glassdome/examine()
	. = ..()
	if(attached_hat)
		. += span_notice("There's [attached_hat] placed in the helmet.")
		. += span_bold("Right-click to remove it.")
	else
		. += span_notice("There's nothing placed in the helmet.")

/obj/item/clothing/head/helmet/glassdome/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!istype(attacking_item, /obj/item/clothing/head))
		return
	var/obj/item/clothing/hitting_hat = attacking_item
	if(hitting_hat.clothing_flags & STACKABLE_HELMET_EXEMPT)
		balloon_alert(user, "doesn't fit!")
		return
	if(attached_hat)
		balloon_alert(user, "already something inside!")
		return

	attached_hat = hitting_hat
	balloon_alert(user, "[hitting_hat] put inside")
	hitting_hat.forceMove(src)
	icon_state = "empty"
	update_appearance()

/obj/item/clothing/head/helmet/glassdome/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!attached_hat || isinhands)
		return

	var/mutable_appearance/attached_hat_appearance = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
	attached_hat_appearance.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
	. += attached_hat_appearance


/obj/item/clothing/head/helmet/glassdome/attack_hand_secondary(mob/user)
	..()
	if(!attached_hat)
		return

	user.put_in_active_hand(attached_hat)
	balloon_alert(user, "[attached_hat] removed")
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
