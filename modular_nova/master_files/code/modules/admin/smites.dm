/// Applies the dreaded cone of shame to a target.
/datum/smite/cone_of_shame
	name = "Cone of Shame"
	var/slot

/datum/smite/cone_of_shame/divine
	name = "Cone of Shame (Divine)"
	smite_flags = SMITE_DIVINE

/obj/item/clothing/head/cone_of_shame/bad_dog

/obj/item/clothing/head/cone_of_shame/bad_dog/equipped(mob/user, slot)
	. = ..()
	name = "THE CONE."
	desc = "You've been VERY BAD."
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/datum/smite/cone_of_shame/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target)&&!iscyborg(target))
		to_chat(user, span_warning("This must be used on a carbon or cyborg mob."), confidential = TRUE)
		return
	var/thecone = new /obj/item/clothing/head/cone_of_shame/bad_dog
	if(iscarbon(target))
		var/mob/living/carbon/shamed = target
		if(istype(shamed.wear_neck, /obj/item))
			var/obj/item/worn_necky = shamed.wear_neck
			shamed.dropItemToGround(worn_necky)
		shamed.visible_message(span_warning("A Cone of Shame appears around [shamed]'s neck!"))
		shamed.equip_to_slot_if_possible(thecone,ITEM_SLOT_NECK,1,1,1)
		return
	if(iscyborg(target))
		var/mob/living/silicon/robot/borgy = target
		borgy.place_on_head(thecone)
		borgy.visible_message(span_warning("A Cone of Shame appears around [borgy]'s neck!"))
		return

