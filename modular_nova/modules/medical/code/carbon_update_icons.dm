/mob/living/carbon/proc/update_bandage_overlays()
	remove_overlay(BANDAGE_LAYER)

	var/mutable_appearance/overlays = mutable_appearance('modular_nova/modules/medical/icons/on_limb_overlays.dmi', "", -BANDAGE_LAYER)
	overlays_standing[BANDAGE_LAYER] = overlays

	for(var/obj/item/bodypart/limb in bodyparts)
		var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
		if(QDELETED(current_gauze))
			continue
		overlays.add_overlay(current_gauze.get_overlay_prefix(limb))

	apply_overlay(BANDAGE_LAYER)
