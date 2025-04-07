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

/datum/blood_type
	/// Displayed name of the blood type.
	var/name = "?"
	/// A description of the blood type.
	var/desc
	/// Shown color of the blood type.
	var/color = "#FF291E"
	/// Blood types that are safe to use with people that have this blood type.
	var/compatible_types = list()
	/// What reagent is represented by this blood type?
	var/datum/reagent/reagent_type = /datum/reagent/blood
	/// What chem is used to restore this blood type (outside of itself, of course)?
	var/datum/reagent/restoration_chem = /datum/reagent/iron
	/// Whether or not this blood type should create blood trails, blood sprays, etc
	var/no_bleed_overlays

/datum/blood_type/New()
	. = ..()
	compatible_types |= type_key()

/datum/blood_type/Destroy(force)
	if(!force)
		stack_trace("qdel called on blood type singleton! (use FORCE if necessary)")
		return QDEL_HINT_LETMELIVE

	return ..()

/**
 * Key used to identify this blood type in the global blood_types list
 *
 * Allows for more complex or dynamically generated blood types
 */
/datum/blood_type/proc/type_key()
	return type

/datum/blood_type/a_minus
	name = "A-"
	compatible_types = list(/datum/blood_type/a_minus, /datum/blood_type/o_minus)

/datum/blood_type/a_plus
	name = "A+"
	compatible_types = list(/datum/blood_type/a_minus, /datum/blood_type/a_plus, /datum/blood_type/o_minus, /datum/blood_type/o_plus)

/datum/blood_type/b_minus
	name = "B-"
	compatible_types = list(
		/datum/blood_type/b_minus,
		/datum/blood_type/o_minus,
	)

/datum/blood_type/b_plus
	name = "B+"
	compatible_types = list(
		/datum/blood_type/b_minus,
		/datum/blood_type/b_plus,
		/datum/blood_type/o_minus,
		/datum/blood_type/o_plus,
	)

/datum/blood_type/ab_minus
	name = "AB-"
	compatible_types = list(
		/datum/blood_type/a_minus,
		/datum/blood_type/b_minus,
		/datum/blood_type/ab_minus,
		/datum/blood_type/o_minus,
	)

/datum/blood_type/ab_plus
	name = "AB+"
	compatible_types = list(
		/datum/blood_type/a_minus,
		/datum/blood_type/a_plus,
		/datum/blood_type/b_minus,
		/datum/blood_type/b_plus,
		/datum/blood_type/o_minus,
		/datum/blood_type/o_plus,
		/datum/blood_type/ab_minus,
		/datum/blood_type/ab_plus,
	)

/datum/blood_type/o_minus
	name = "O-"
	compatible_types = list(
		/datum/blood_type/o_minus,
	)

/datum/blood_type/o_plus
	name = "O+"
	compatible_types = list(
		/datum/blood_type/o_minus,
		/datum/blood_type/o_plus,
	)

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

/datum/blood_type/animal
	name = "Y-"
	compatible_types = list(
		/datum/blood_type/animal,
	)

/datum/blood_type/lizard
	name = "L"
	compatible_types = list(
		/datum/blood_type/lizard,
	)

/datum/blood_type/ethereal
	name = "LE"
	color = /datum/reagent/consumable/liquidelectricity::color
	no_bleed_overlays = TRUE
	compatible_types = list(
		/datum/blood_type/ethereal,
	)

/datum/blood_type/oil
	name = "Oil"
	color = "#1f1a00"
	reagent_type = /datum/reagent/fuel/oil

/datum/blood_type/vampire
	name = "V"
	compatible_types = list(
		/datum/blood_type/vampire,
	)

/datum/blood_type/meat // why does this exist
	name = "MT-"

/datum/blood_type/universal
	name = "U"

/datum/blood_type/universal/New()
	. = ..()
	compatible_types = subtypesof(/datum/blood_type)

/datum/blood_type/xeno
	name = "X*"
	color = "#C8F000"
	compatible_types = list(/datum/blood_type/xeno)

/// April fool's blood for clowns
/datum/blood_type/clown
	name = "C"
	reagent_type = /datum/reagent/colorful_reagent

/// Slimeperson blood, aka 'toxin' blood type
/datum/blood_type/slime
	name = "TOX"
	color = /datum/reagent/toxin/slimejelly::color
	reagent_type = /datum/reagent/toxin/slimejelly
	no_bleed_overlays = TRUE

/// Podpeople blood
/datum/blood_type/water
	name = "H2O"
	color = /datum/reagent/water::color
	reagent_type = /datum/reagent/water
	no_bleed_overlays = TRUE

/// Snaiil blood
/datum/blood_type/snail
	name = "Lube"
	reagent_type = /datum/reagent/lube

/// An abstract-ish blood type used particularly for species with blood set to random reagents, such as podpeople
/datum/blood_type/random_chemical

/datum/blood_type/random_chemical/New(datum/reagent/reagent_type)
	. = ..()
	src.name = initial(reagent_type.name)
	src.color = initial(reagent_type.color)
	src.reagent_type = reagent_type
	src.restoration_chem = reagent_type

/datum/blood_type/random_chemical/type_key()
	return reagent_type
