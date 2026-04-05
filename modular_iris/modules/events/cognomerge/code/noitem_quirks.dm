//Used by the cognomerge event to prevent the mass materialisation of wheelchairs, etc., across the station

//deafness
/datum/quirk/item_quirk/deafness/noitem
	name = "Deaf (No Item Version)"
	hidden_quirk = TRUE
	icon = FA_ICON_PHONE_SLASH

/datum/quirk/item_quirk/deafness/noitem/add_unique(client/client_source)
	return

//blindness
/datum/quirk/item_quirk/blindness/noitem
	name = "Blind (No Item Version)"
	hidden_quirk = TRUE
	icon = FA_ICON_PERSON_CANE

/datum/quirk/item_quirk/blindness/noitem/add_unique(client/client_source)
	return

//paraplegia
/datum/quirk/paraplegic/noitem
	name = "Paraplegic (No Item Version)"
	hidden_quirk = TRUE
	icon = FA_ICON_WHEELCHAIR_MOVE

/datum/quirk/paraplegic/noitem/add_unique(client/client_source)
	return

//medicine allergy
/datum/quirk/item_quirk/allergic/noitem
	name = "Extreme Medicine Allergy (No Item Version)"
	hidden_quirk = TRUE
	icon = FA_ICON_TABLETS

/datum/quirk/item_quirk/allergic/noitem/add_unique(client/client_source)
	//we have to copypasta here
	var/list/chem_list = subtypesof(/datum/reagent/medicine) - blacklist
	var/list/allergy_chem_names = list()
	for(var/i in 0 to 5)
		var/datum/reagent/medicine/chem_type = pick_n_take(chem_list)
		allergies += chem_type
		allergy_chem_names += initial(chem_type.name)

	allergy_string = allergy_chem_names.Join(", ")
	name = "Extreme [allergy_string] Allergies"
	medical_record_text = "Patient's immune system responds violently to [allergy_string]"
