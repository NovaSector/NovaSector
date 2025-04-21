/obj/item/kinetic_crusher/runic_greatsword
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	name = "Runic Greatsword"
	desc = "A greatsword of Hearthkin make. The runes on the blades glows a soft blue"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/kinetic_crusher/runic_greatsword/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(src, TRAIT_WIELDED) && !acts_as_if_wielded) // NOVA EDIT CHANGE - Original: if(!HAS_TRAIT(src, TRAIT_WIELDED))
		balloon_alert(user, "wield it first!")
		return ITEM_INTERACT_BLOCKING
	if(interacting_with == user)
		balloon_alert(user, "can't aim at yourself!")
		return ITEM_INTERACT_BLOCKING
	runic_spin()
	user.changeNext_move(CLICK_CD_MELEE)
	return ITEM_INTERACT_SUCCESS

/obj/item/kinetic_crusher/runic_greatsword/proc/runic_spin()
	var/spin_radius = 1 //Hits everyone around the user
	var/spin_center = get_turf(src)
	if(!charged)
		return
	for(var/mob/living/living_target in range(spin_radius,spin_center))
		if(living_target != src)
			for(var/obj/item/crusher_trophy/crusher_trophy as anything in used_crusher?.trophies)
				crusher_trophy.on_projectile_hit_mob(licing_target, usr)
			if(QDELETED(target))
				return ..()
			living_target.apply_status_effect(/datum/status_effect/crusher_mark)
			living_target.update_appearance()
	playsound(user, 'sound\effects\magic\tail_swing.ogg', 100, TRUE)
	charged = FALSE

// tofix : sword becomes invisible after being wielded, Add a visual
