/// Applies the dreaded cone of shame to a target.
/datum/smite/cone_of_shame
	name = "Cone of Shame"

/datum/smite/cone_of_shame/divine
	name = "Cone of Shame (Divine)"
	smite_flags = SMITE_DIVINE

/obj/item/clothing/head/cone_of_shame/bad_dog
	name = "THE CONE."
	desc = "You've been VERY BAD."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/head/cone_of_shame/bad_dog/equipped(mob/user, slot)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/datum/smite/cone_of_shame/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target) && !iscyborg(target))
		to_chat(user, span_warning("This must be used on a carbon or cyborg mob."), confidential = TRUE)
		return
	var/obj/item/clothing/head/cone_of_shame/bad_dog/thecone = new
	if(iscarbon(target))
		var/mob/living/carbon/shamed = target
		var/obj/item/worn_necky = shamed.wear_neck
		if(istype(worn_necky))
			shamed.dropItemToGround(worn_necky)
		shamed.visible_message(span_warning("A Cone of Shame appears around [shamed]'s neck!"))
		shamed.equip_to_slot_if_possible(thecone, ITEM_SLOT_NECK ,qdel_on_fail = TRUE, disable_warning = TRUE, redraw_mob = TRUE)
		return
	if(iscyborg(target))
		var/mob/living/silicon/robot/borgy = target
		borgy.place_on_head(thecone)
		borgy.visible_message(span_warning("A Cone of Shame appears around [borgy]'s neck!"))
		return
	qdel(thecone)

// Applies the
/// Applies the dreaded cone of shame to a target.
/datum/smite/maidification
	name = "Maid-ification"

/obj/item/clothing/head/costume/maid_headband/maidsmite
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/head/costume/maid_headband/maidsmite/equipped(mob/user, slot)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/neck/maid_neck_cover/maidsmite
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/neck/maid_neck_cover/maidsmite/equipped(mob/user, slot)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/gloves/maid_arm_covers/maidsmite
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/gloves/maid_arm_covers/maidsmite/equipped(mob/user, slot)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/under/costume/maid/maidsmite
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/clothing/under/costume/maid/maidsmite/equipped(mob/user, slot)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/datum/smite/maidification/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return
	var/obj/item/clothing/head/cone_of_shame/bad_dog/thecone = new
	var/obj/item/clothing/head/costume/maid_headband/maidsmite/headband = new
	var/obj/item/clothing/neck/maid_neck_cover/maidsmite/neck_cover = new
	var/obj/item/clothing/gloves/maid_arm_covers/maidsmite/arm_cover = new
	var/obj/item/clothing/under/costume/maid/maidsmite/uniform = new

	if(iscarbon(target))
		var/mob/living/carbon/shamed = target
		var/obj/item/worn_neck = shamed.wear_neck
		var/obj/item/worn_head = shamed.head
		var/obj/item/worn_hand = shamed.gloves
		var/obj/item/worn_body = shamed.w_uniform
		if(istype(worn_neck))
			shamed.dropItemToGround(worn_neck)
		if(istype(worn_head))
			shamed.dropItemToGround(wear_head)
		if(istype(worn_hand))
			shamed.dropItemToGround(wear_hand)
		if(istype(worn_body))
			shamed.dropItemToGround(wear_body)
		shamed.visible_message(span_warning("A Cone of Shame appears around [shamed]'s neck!"))
		shamed.equip_to_slot_if_possible(neck_cover, ITEM_SLOT_NECK ,qdel_on_fail = TRUE, disable_warning = TRUE, redraw_mob = TRUE)
		shamed.equip_to_slot_if_possible(headband, ITEM_SLOT_HEAD ,qdel_on_fail = TRUE, disable_warning = TRUE, redraw_mob = TRUE)
		shamed.equip_to_slot_if_possible(arm_cover, ITEM_SLOT_GLOVES ,qdel_on_fail = TRUE, disable_warning = TRUE, redraw_mob = TRUE)
		shamed.equip_to_slot_if_possible(uniform, ITEM_SLOT_ICLOTHING ,qdel_on_fail = TRUE, disable_warning = TRUE, redraw_mob = TRUE)
		return
	//qdel(thecone)
