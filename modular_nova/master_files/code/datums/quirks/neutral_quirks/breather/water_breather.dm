/datum/quirk/item_quirk/breather/water_breather
	name = "Water Breather"
	desc = "You have a pair of gills and are only capable of breathing oxygen through water, stay wet to breathe!"
	alert_text = "Be sure to equip your vaporizer, or you may end up choking to death!"
	icon = FA_ICON_FISH
	medical_record_text = "Patient has a pair of gills on their body."
	gain_text = span_notice("You suddenly have a hard time breathing through thin air.")
	lose_text = span_danger("You suddenly feel like you aren't bound to breathing through liquid anymore.")
	value = 0
	breathing_tank = /obj/item/clothing/accessory/vaporizer
	breath_type = "water"
	// bonus trait
	mob_trait = TRAIT_WATER_BREATHING
	///overlay to be added/culled
	var/datum/bodypart_overlay/simple/gills/gills_overlay

/datum/quirk/item_quirk/breather/water_breather/add(client/client_source)
	// this proc is guaranteed to be called multiple times
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return
	// set lung vars
	target_lungs.safe_oxygen_min = 0
	// update lung procs
	target_lungs.breathe_always[/datum/gas/water_vapor] = TYPE_PROC_REF(/obj/item/organ/lungs, breathe_water)
	// reflect correct lung flags
	target_lungs.respiration_type = RESPIRATION_OXYGEN

/datum/quirk/item_quirk/breather/water_breather/add_unique(client/client_source)
	. = ..()
	if(!.)
		return
	// flavor
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	target_lungs.AddElement(/datum/element/noticable_organ, "%PRONOUN_Theyve got a set of gills on %PRONOUN_their neck.", BODY_ZONE_PRECISE_MOUTH)
	target_lungs.AddComponent(/datum/component/bubble_icon_override, "fish", BUBBLE_ICON_PRIORITY_ORGAN)
	// add the gills overlay
	var/obj/item/bodypart/chest/target_chest = quirk_holder.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest) // just to be sure
		gills_overlay = target_chest.add_bodypart_overlay(new gills_overlay)

/datum/quirk/item_quirk/breather/water_breather/remove()
	. = ..()
	var/obj/item/organ/lungs/target_lungs = quirk_holder.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!target_lungs)
		return

	target_lungs.RemoveElement(/datum/element/noticable_organ)
	qdel(target_lungs.GetComponent(/datum/component/bubble_icon_override))
	var/obj/item/bodypart/chest/target_chest = quirk_holder.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest) // just to be sure
		target_chest.remove_bodypart_overlay(gills_overlay)
