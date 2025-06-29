///Similar to name2reagent list but contains only neuroware reagents.
GLOBAL_LIST_INIT(name2neuroware, build_name2neurowarelist())
///name2neuroware list which omits lewd reagents
GLOBAL_LIST_INIT(name2neuroware_safe, build_name2neurowarelist_safe())

///Same as build_name2reagentlist() but contains only neuroware reagents.
/proc/build_name2neurowarelist()
	var/list/neuroware_list = list()
	for (var/datum/reagent/reagent as anything in GLOB.chemical_reagents_list)
		if(reagent.chemical_flags & REAGENT_NEUROWARE)
			neuroware_list[initial(reagent.name)] = reagent
	return neuroware_list

///Same as build_name2neurowarelist() but omits aphrodisiacs.
/proc/build_name2neurowarelist_safe()
	var/list/neuroware_list = GLOB.name2neuroware.Copy()
	for (var/reagent_name in GLOB.name2neuroware)
		var/datum/reagent/reagent = GLOB.name2neuroware[reagent_name]
		if(ispath(reagent, /datum/reagent/drug/aphrodisiac))
			neuroware_list.Remove(reagent_name)
	return neuroware_list
