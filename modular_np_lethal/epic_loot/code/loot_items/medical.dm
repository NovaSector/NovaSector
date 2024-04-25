/datum/export/epic_loot_super_med_tools
	cost = PAYCHECK_COMMAND * 5
	unit_name = "ancient medical tools"
	export_types = list(
		/obj/item/epic_loot/vein_finder,
		/obj/item/epic_loot/eye_scope,
	)

// Vein finder, uses strong LED lights to reveal veins in someone's body. Perhaps the name "LEDX" rings a bell
/obj/item/epic_loot/vein_finder
	name = "medical vein locator"
	desc = "A small device with a number of high intensity lights on one side. Used by medical professionals to locate veins in someone's body."
	icon_state = "vein_finder"
	inhand_icon_state = "headset"
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

/obj/item/epic_loot/vein_finder/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(!proximity_flag)
		return
	if(!ishuman(target))
		return
	user.visible_message(
		"[user] determines that [target] does, in fact, have veins.",
		"You determine that [target] does, in fact, have veins."
	)
	new /obj/effect/temp_visual/medical_holosign(get_turf(target), user)

/obj/item/epic_loot/vein_finder/examine_more(mob/user)
	. = ..()

	. += span_notice("<b>Medical Trade Station:</b>")
	. += span_notice("- <b>1</b> of these can be traded for <b>1</b> satchel medical kit.")

	return .

// Eyescope, a now rare device that was used to check the eyes of patients before the universal health scanner became common
/obj/item/epic_loot/eye_scope
	name = "medical eye-scope"
	desc = "An outdated device used to examine a patient's eyes. Rare now due to the outbreak of the universal health scanner."
	icon_state = "eyescope"
	inhand_icon_state = "zippo"
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

/obj/item/epic_loot/eye_scope/examine_more(mob/user)
	. = ..()

	. += span_notice("<b>Medical Trade Station:</b>")
	. += span_notice("- <b>1</b> of these can be traded for <b>1</b> first responder surgical kit.")

	return .

/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked/super
	name = "advanced satchel medical kit"
	icon = 'modular_np_lethal/epic_loot/icons/epic_loot.dmi'
	icon_state = "satchel_super"
	worn_icon_state = "satchel"
	storage_type = /datum/storage/duffel/deforest_medkit/super

/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked/super/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 2,
		/obj/item/bonesetter = 1,
		/obj/item/hemostat/alien = 1,
		/obj/item/cautery/alien = 1,
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		/obj/item/stack/medical/suture/coagulant = 1,
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/stack/medical/gauze/sterilized = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/ointment/red_sun = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
		/obj/item/healthanalyzer/advanced = 1,
	)
	generate_items_inside(items_inside,src)

/datum/storage/duffel/deforest_medkit/super
	max_specific_storage = WEIGHT_CLASS_NORMAL
	max_total_storage = 21 * WEIGHT_CLASS_NORMAL
