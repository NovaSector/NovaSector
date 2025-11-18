/datum/reagent/manganese
	name = "Manganese"
	description = "A silvery-gray metal that resembles iron. It is hard and very brittle, difficult to fuse, but easy to oxidize."
	color = "#3D3C47"
	taste_description = "metal"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

// New blood packs
/obj/item/reagent_containers/blood/haemocyanin
	blood_type = "Haemocyanin"

/obj/item/reagent_containers/blood/chlorocruorin
	blood_type = "Chlorocruorin"

/obj/item/reagent_containers/blood/hemerythrin
	blood_type = "Hemerythrin"

/obj/item/reagent_containers/blood/pinnaglobin
	blood_type = "Pinnaglobin"

/obj/item/reagent_containers/blood/exotic
	blood_type = "Exotic"

/datum/supply_pack/medical/bloodpacks/uncommon
	name = "Uncommon Blood Pack Variety Crate"
	desc = "Contains ten different uncommmon blood packs for reintroducing blood to patients."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(
		/obj/item/reagent_containers/blood/haemocyanin = 2,
		/obj/item/reagent_containers/blood/chlorocruorin = 2,
		/obj/item/reagent_containers/blood/hemerythrin = 2,
		/obj/item/reagent_containers/blood/pinnaglobin = 2,
		/obj/item/reagent_containers/blood/exotic = 2,
	)
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer
