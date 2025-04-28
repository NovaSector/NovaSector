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

/datum/blood_type/haemocyanin
	name = "Haemocyanin"
	color = "#3399FF"
	desc = "This oxygen-carrying macromolecule is formed using copper instead of iron (giving it its blue color), and has similar efficiency to haemoglobin in colder temperatures."
	restoration_chem = /datum/reagent/copper
	compatible_types = list(
		/datum/blood_type/haemocyanin,
	)

/datum/blood_type/chlorocruorin
	name = "Chlorocruorin"
	color = "#9FF73B"
	desc = "Chlorocruorin molecules are massive relative to other oxygen carriers and get their green color from the presence of an abnormal heme group."
	compatible_types = list(
		/datum/blood_type/chlorocruorin,
	)

/datum/blood_type/hemerythrin
	name = "Hemerythrin"
	color = "#C978DD"
	desc  = "The pink hemerythrin macromolecules actually bind to oxygen by creating a hydroperoxide, a unique mechanism for blood oxygen."
	compatible_types = list(
		/datum/blood_type/hemerythrin,
	)

/datum/blood_type/pinnaglobin
	name = "Pinnaglobin"
	color = "#CDC020"
	restoration_chem = /datum/reagent/manganese
	desc = "Most similar to haemocyanin, pinnaglobin possesses manganese atoms in place of copper, giving it a unique color."
	compatible_types = list(
		/datum/blood_type/pinnaglobin,
	)

/datum/blood_type/exotic
	name = "Exotic"
	color = "#333333"
	restoration_chem = /datum/reagent/sulfur
	compatible_types = list(
		/datum/blood_type/exotic,
	)
	desc = "This blood color does not appear to exist naturally in nature, but with exposure to sulfur or some other genetic engineering or corruption it might be possible."
