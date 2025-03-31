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

/datum/blood_type
	/// Displayed name of the blood type.
	var/name = "?"
	/// Shown color of the blood type.
	var/color = "#FF291E"
	/// Blood types that are safe to use with people that have this blood type.
	var/compatible_types = list()
	/// What reagent is represented by this blood type?
	var/datum/reagent/reagent_type = /datum/reagent/blood
	/// What chem is used to restore this blood type (outside of itself, of course)?
	var/datum/reagent/restoration_chem = /datum/reagent/iron

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

/datum/blood_type/chlorocruorin
	name = "Chlorocruorin"
	color = "#9FF73B"
	compatible_types = list(
		/datum/blood_type/chlorocruorin,
	)

/datum/blood_type/hemerythrin
	name = "Hemerythrin"
	color = "#C978DD"
	compatible_types = list(
		/datum/blood_type/hemerythrin,
	)

/datum/blood_type/animal //for simplemob gib dna
	name = "Y-"
	compatible_types = list(
		/datum/blood_type/animal,
	)

/datum/blood_type/lizard
	name = "L"
	color = "#009696"
	compatible_types = list(
		/datum/blood_type/lizard,
	)

/datum/blood_type/vampire
	name = "V"
	color = "#009696"
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
	compatible_types = list(/datum/blood_type/xeno)

/// Clown blood, only used on April Fools
/datum/blood_type/clown
	name = "C"
	color = "#FF00FF"
	reagent_type = /datum/reagent/colorful_reagent

/// Slimeperson's jelly blood, is also known as "toxic" or "toxin" blood
/datum/blood_type/slime
	name = "TOX"
	color = /datum/reagent/toxin/slimejelly::color
	reagent_type = /datum/reagent/toxin/slimejelly

/// Water based blood for Podpeople primairly
/datum/blood_type/water
	name = "H2O"
	color = /datum/reagent/water::color
	reagent_type = /datum/reagent/water

/// Snails have Lube for blood, for some reason?
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
