/obj/item/armorkit
	name = "lopland armor kit"
	desc = "A security armoring kit with flexible armored sheets and some nanoglue, for reinforcing outerwear."
	icon = 'modular_nova/modules/armor_kits/armor_kits.dmi'
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "security"

/obj/item/armorkit/interact_with_atom(atom/target, mob/user, params)
	if(istype(target,/obj/item/clothing/suit))
		if(!istype(target,/obj/item/clothing/suit/armor) && !istype(target,/obj/item/clothing/suit/mod))
			var/obj/item/clothing/suit/typecast = target
			typecast.set_armor(/datum/armor/suit_armor)
			typecast.allowed = GLOB.security_vest_allowed
			span_notice("You've upgraded [target] with armor kit")
			qdel(src)

	if(istype(target,/obj/item/clothing/head))
		if(!istype(target,/obj/item/clothing/head/helmet) && !istype(target,/obj/item/clothing/suit/mod))
			target.set_armor(/datum/armor/suit_armor)
			span_notice("You've upgraded [target] with armor kit")
			qdel(src)
