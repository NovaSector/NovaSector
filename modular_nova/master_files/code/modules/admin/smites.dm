/// Applies the dreaded cone of shame to a target.
/datum/smite/cone_of_shame
	name = "Cone of Shame"

/datum/smite/cone_of_shame/divine
	name = "Cone of Shame (Divine)"
	smite_flags = SMITE_DIVINE

/*
 * Smite-specific helper to take a clothing item and apply indestructible, lava_proof, fire_proof
 * unacidable, and acid_proof, then adds the nodrop trait to it to keep it from being unequipped.
*/
/datum/smite/proc/smite_item_protection(obj/item/clothing/protected_item)
	if(QDELETED(protected_item))
		return
	protected_item.resistance_flags |= INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	ADD_TRAIT(protected_item, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/head/cone_of_shame/bad_dog
	name = "THE CONE."
	desc = "You've been VERY BAD."

/datum/smite/cone_of_shame/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target) && !iscyborg(target))
		to_chat(user, span_warning("This must be used on a carbon or cyborg mob."), confidential = TRUE)
		return
	var/obj/item/clothing/head/cone_of_shame/bad_dog/thecone = new
	if(iscarbon(target))
		var/mob/living/carbon/shamed = target
		var/obj/item/worn_necky = target.get_item_by_slot(ITEM_SLOT_NECK)
		if(istype(worn_necky))
			shamed.dropItemToGround(worn_necky)
		if(shamed.equip_to_slot_if_possible(thecone, ITEM_SLOT_NECK, qdel_on_fail = TRUE, disable_warning = TRUE, redraw_mob = TRUE))
			smite_item_protection(thecone)
			shamed.visible_message(span_warning("A Cone of Shame appears around [shamed]'s neck!"))
		return
	if(iscyborg(target))
		var/mob/living/silicon/robot/borgy = target
		borgy.place_on_head(thecone)
		smite_item_protection(thecone)
		borgy.visible_message(span_warning("A Cone of Shame appears around [borgy]'s neck!"))
		return
	qdel(thecone)

// Applies a prim and proper maid uniform to your target.
/datum/smite/maidification
	name = "Maid-ification"

/datum/smite/maidification/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return
	var/list/outfit_options = list(
		"Maid Uniform - Frilly" = list(
			/obj/item/clothing/head/costume/maid_headband = ITEM_SLOT_HEAD,
			/obj/item/clothing/under/costume/maid = ITEM_SLOT_ICLOTHING,
		),
		"Maid Uniform (Light Blue)" = list(
			/obj/item/clothing/head/maid_headband = ITEM_SLOT_HEAD,
			/obj/item/clothing/neck/maid_neck_cover = ITEM_SLOT_NECK,
			/obj/item/clothing/gloves/maid_arm_covers = ITEM_SLOT_GLOVES,
			/obj/item/clothing/under/maid_costume = ITEM_SLOT_ICLOTHING,
		),
		"Maid Uniform" = list(
			/obj/item/clothing/head/costume/nova/maid = ITEM_SLOT_HEAD,
			/obj/item/clothing/under/costume/nova/maid_uniform = ITEM_SLOT_ICLOTHING,
		),
		"Maid Uniform (Alternative)" = list(
			/obj/item/clothing/head/costume/nova/maid = ITEM_SLOT_HEAD,
			/obj/item/clothing/under/costume/nova/maid_uniform_alt = ITEM_SLOT_ICLOTHING,
		),
		"Syndiemaid" = list(
			/obj/item/clothing/head/costume/maid_headband/syndicate/loadout_headband = ITEM_SLOT_HEAD,
			/obj/item/clothing/under/syndicate/nova/maid/loadout_maid = ITEM_SLOT_ICLOTHING,
			/obj/item/clothing/gloves/tactical_maid = ITEM_SLOT_GLOVES,
		),
	)
	var/chosen_outfit = tgui_input_list(user, "Which maid outfit should be applied?", "Maid-ification", outfit_options)
	if(!chosen_outfit)
		return
	var/list/items = outfit_options[chosen_outfit]
	var/mob/living/carbon/shamed = target
	for(var/path, slot in items)
		target.dropItemToGround(target.get_item_by_slot(slot))
		var/obj/item/clothing/new_item = new path
		if(target.equip_to_slot_or_del(new_item, slot))
			smite_item_protection(new_item)
	if(!QDELETED(shamed))
		shamed.visible_message(span_warning("A maid uniform appears on [shamed]!"))
