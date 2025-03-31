/obj/item/storage/box/nri_survival_pack
	name = "NRI survival pack"
	desc = "A box filled with useful emergency items, supplied by the NRI."
	icon_state = "survival_pack"
	icon = 'modular_nova/modules/novaya_ert/icons/survival_pack.dmi'
	illustration = null

/obj/item/storage/box/nri_survival_pack/PopulateContents()
	return list(
		/obj/item/oxygen_candle,
		/obj/item/tank/internals/emergency_oxygen/double,
		/obj/item/stack/spacecash/c1000,
		/obj/item/storage/pill_bottle/iron,
		/obj/item/storage/box/colonial_rations,
		/obj/item/storage/box/nri_pens,
		/obj/item/storage/box/nri_flares,
		/obj/item/crowbar/red,
	)

/obj/item/storage/box/nri_pens
	name = "box of injectors"
	desc = "A box full of first aid and combat MediPens."
	illustration = "epipen"

/obj/item/storage/box/nri_pens/PopulateContents()
	return list(
		/obj/item/reagent_containers/hypospray/medipen/ekit,
		/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone,
		/obj/item/reagent_containers/hypospray/medipen/salacid,
		/obj/item/reagent_containers/hypospray/medipen/salacid,
		/obj/item/reagent_containers/hypospray/medipen/penacid,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol,
		/obj/item/reagent_containers/hypospray/medipen/atropine,
		/obj/item/reagent_containers/hypospray/medipen/blood_loss,
	)

/obj/item/storage/box/nri_flares
	name = "box of flares"
	desc = "A box full of red emergency flares."
	illustration = "firecracker"

/obj/item/storage/box/nri_flares/PopulateContents()
	. = list()
	for(var/i in 1 to 7)
		. += /obj/item/flashlight/flare
