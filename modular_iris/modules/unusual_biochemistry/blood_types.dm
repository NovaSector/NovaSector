/datum/blood_type/haemoglobin
	name = "Haemoglobin"
	color = "#a70000"
	desc = "For cowards who want the original red blood. This can be found in humans and a majority of other species. You are only compatible with other haemoglobin users and O- blood users."
	restoration_chem = /datum/reagent/iron
	compatible_types = list(
		/datum/blood_type/haemoglobin,
		/datum/blood_type/human/o_minus,
	)

/datum/blood_type/haemotoxin
	name = "Haemotoxin"
	color = "#614d7d"
	desc = "Want some zest? Your blood can be restored with toxins. Typically found in venomous animals, such as snakes and spiders. It's also a cute purple colour."
	restoration_chem = /datum/reagent/toxin
	compatible_types = list(
		/datum/blood_type/haemotoxin,
	)

//Not making this one printable cause it wouldn't make sense
/datum/blood_type/nanoblood
	name = "Nanomachine Infused Blood"
	color = "#FF7F33"
	desc = "Your blood is infused with nanites that give off a very bright orange color. This type glows in the darkness, can be replenished with nanite slurry."
	restoration_chem = /datum/reagent/medicine/nanite_slurry
	compatible_types = list(
		/datum/blood_type/nanoblood,
	)

/datum/blood_type/nanoblood/get_emissive_alpha(atom/source, is_worn = FALSE)
	if (is_worn)
		return 102
	return 125

/datum/blood_type/nanoblood/set_up_blood(obj/effect/decal/cleanable/blood/blood, new_splat = FALSE)
	. = ..()
	blood.emissive_alpha = max(blood.emissive_alpha, new_splat ? 125 : 63)
	if (new_splat)
		return
	blood.can_dry = FALSE
