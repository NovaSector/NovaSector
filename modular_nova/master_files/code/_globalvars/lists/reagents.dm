///name2reagent list which omits neuroware reagents
GLOBAL_LIST_INIT(name2reagent_normalized, build_name2reagentlist_normalized())
///Similar to name2reagent list but omits neuroware reagents
GLOBAL_LIST_INIT(name2neuroware, build_name2neurowarelist())
///name2neuroware list which omits lewd reagents
GLOBAL_LIST_INIT(name2neuroware_safe, build_name2neurowarelist_safe())

/proc/build_name2reagentlist_normalized()
	var/list/reagent_list = GLOB.name2reagent.Copy()
	for (var/datum/reagent/reagent as anything in GLOB.chemical_reagents_list)
		if(reagent.chemical_flags == REAGENT_NEUROWARE)
			reagent_list.Remove(initial(reagent.name))
	return reagent_list

///Same as build_name2reagentlist() but contains only neuroware reagents.
/proc/build_name2neurowarelist()
	var/list/neuroware_list = GLOB.name2reagent.Copy()
	for (var/datum/reagent/reagent as anything in GLOB.chemical_reagents_list)
		if(reagent.chemical_flags == REAGENT_NEUROWARE)
			continue
		neuroware_list.Remove(initial(reagent.name))
	return neuroware_list

///Same as build_name2neurowarelist() but omits aphrodisiacs.
/proc/build_name2neurowarelist_safe()
	var/list/neuroware_list = GLOB.name2neuroware.Copy()
	for (var/reagent_name in GLOB.name2neuroware)
		var/datum/reagent/reagent = GLOB.name2neuroware[reagent_name]
		if(ispath(reagent, /datum/reagent/drug/aphrodisiac))
			neuroware_list.Remove(reagent_name)
	return neuroware_list
