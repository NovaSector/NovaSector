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
			use_delay = 3 SECONDS
			span_notice("You've upgraded [target] with armor kit")
			qdel(src)

	if(istype(target,/obj/item/clothing/head))
		if(!istype(target,/obj/item/clothing/head/helmet) && !istype(target,/obj/item/clothing/suit/mod))
			target.set_armor(/datum/armor/suit_armor)
			use_delay = 3 SECONDS
			span_notice("You've upgraded [target] with armor kit")
			qdel(src)

/obj/item/armorkit/traitor
	name = "syndicate armor kit"
	desc = "A syndicate armoring kit with flexible armored sheets and some nanoglue, for reinforcing clothing. Provide more protection, than security variant"
	icon_state = "syndicate"

/obj/item/armorkit/traitor/interact_with_atom(atom/target, mob/user, params)
	if(istype(target,/obj/item/clothing/suit))
		if(!istype(target,/obj/item/clothing/suit/armor) && !istype(target,/obj/item/clothing/suit/mod))
			var/obj/item/clothing/suit/typecast = target
			typecast.set_armor(/datum/armor/space_syndicate)
			typecast.allowed = GLOB.security_vest_allowed
			use_delay = 3 SECONDS
			span_notice("You've upgraded [target] with syndicate armor kit")
			qdel(src)

	if(istype(target,/obj/item/clothing/head))
		if(!istype(target,/obj/item/clothing/head/helmet) && !istype(target,/obj/item/clothing/suit/mod))
			target.set_armor(/datum/armor/space_syndicate)
			use_delay = 3 SECONDS
			span_notice("You've upgraded [target] with syndicate armor kit")
			qdel(src)
