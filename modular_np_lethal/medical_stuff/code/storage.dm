// Combat surgeon kit, except specifically for stealing organs from people

/obj/item/storage/medkit/combat_surgeon/organ
	name = "organ extraction toolkit"
	desc = "A folding kit that is ideally filled with surgical tools for obtaining those sweet, sweet organs. Comes with hooks to attach to your pockets."
	icon = 'modular_np_lethal/medical_stuff/icons/storage.dmi'
	icon_state = "organ_romania"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	slot_flags = ITEM_SLOT_POCKETS

/obj/item/storage/medkit/combat_surgeon/organ/stocked

/obj/item/storage/medkit/combat_surgeon/organ/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/scalpel/cruel = 1,
		/obj/item/retractor/cruel = 1,
		/obj/item/hemostat/cruel = 1,
		/obj/item/cautery/cruel = 1,
		/obj/item/circular_saw = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside,src)

// Super satchel medkit, comes with a lot of improved toys

/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked/super
	name = "advanced satchel medical kit"
	icon = 'modular_np_lethal/medical_stuff/icons/storage.dmi'
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
