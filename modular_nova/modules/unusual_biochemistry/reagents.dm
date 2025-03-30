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
	unique_blood = /datum/reagent/copper

/obj/item/reagent_containers/blood/chlorocruorin
	blood_type = "Chlorocruorin"

/obj/item/reagent_containers/blood/hemerythrin
	blood_type = "Hemerythrin"

/obj/item/reagent_containers/blood/pinnaglobin
	blood_type = "Pinnaglobin"
	unique_blood = /datum/reagent/manganese

/obj/item/reagent_containers/blood/exotic
	blood_type = "Exotic"
	unique_blood = /datum/reagent/sulfur
