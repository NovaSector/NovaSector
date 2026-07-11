/obj/item/bodypart/chest
	/// The offset datum for our accessory overlay.
	var/datum/worn_feature_offset/worn_accessory_offset

/obj/item/bodypart/chest/Destroy(force)
	QDEL_NULL(worn_accessory_offset)
	return ..()

/obj/item/bodypart/head
	///Override of the eyes icon file, used for Vox and maybe more in the future - The future is now, with Teshari using it too
	var/eyes_icon

/obj/item/organ/eyes/on_bodypart_insert(obj/item/bodypart/head/limb, movement_flags)
	if(istype(limb) && limb.eyes_icon)
		eye_icon = limb.eyes_icon
	return ..()

/obj/item/organ/eyes/on_bodypart_remove(obj/item/bodypart/head/limb, movement_flags)
	if(istype(limb) && limb.eyes_icon)
		eye_icon = initial(eye_icon)
	return ..()

