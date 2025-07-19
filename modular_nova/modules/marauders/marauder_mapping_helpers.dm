//mannequin mapping helper
/obj/effect/mapping_helpers/mannequin
	desc = "Abstract type, don't use!"
	var/obj/structure/mannequin/mannequin

/obj/effect/mapping_helpers/mannequin/Initialize(mapload)
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return INITIALIZE_HINT_QDEL
	var/obj/structure/mannequin/target = locate(/obj/structure/mannequin) in loc
	if(isnull(target))
		var/area/target_area = get_area(src)
		log_mapping("[src] failed to find a machine at [AREACOORD(src)] ([target_area.type]).")
		return INITIALIZE_HINT_QDEL
	mannequin = target
	return ..()

//loadout mannequin
/obj/effect/mapping_helpers/mannequin/loadout_spawner
	desc = "When given a client with the 'get_client()' proc, will give that client's loadout to a mannequin sharing the same turf."
	late = TRUE

/obj/effect/mapping_helpers/mannequin/loadout_spawner/LateInitialize()
	load_items(mannequin, get_client())
	mannequin.update_appearance()
	qdel(src)

///Use this proc to fetch the client to read from
/obj/effect/mapping_helpers/mannequin/loadout_spawner/proc/get_client()
	return

/obj/effect/mapping_helpers/mannequin/loadout_spawner/proc/load_items(obj/structure/mannequin/mannequin, client/client_to_read)
	if(!mannequin || !client_to_read)
		return
	//compile the loadout data
	var/list/loadout_entries = client_to_read.prefs.read_preference(/datum/preference/loadout)
	var/list/selected_loadout = loadout_entries[client_to_read.prefs.read_preference(/datum/preference/loadout_index)]
	var/list/loadout_datums = client_to_read.get_loadout_datums()
	if(!loadout_datums.len)
		return
	//create our list of items
	for(var/datum/loadout_item/datum as anything in loadout_datums)
		if(datum.restricted_roles)
			continue
		LAZYADD(mannequin.starting_items, datum.item_path)
	//spawn our items and put it on our mannequin's slots
	for(var/slot_flag in mannequin.slot_flags)
		mannequin.worn_items["[slot_flag]"] = null
	//check per loadout-item if they fit in the slot we're trying to fill
		for(var/obj/item/clothing/item as anything in mannequin.starting_items)
			var/list/item_details = selected_loadout[item]
			if(initial(item.slot_flags) & slot_flag)
				//found a match lets spawn it
				var/obj/item/clothing/item_to_give = new item(mannequin)
				mannequin.worn_items["[slot_flag]"] = item_to_give
				//apply the custom details
				if(item_details[INFO_GREYSCALE])
					item_to_give.set_greyscale(item_details[INFO_GREYSCALE])
				if(item_details[INFO_NAMED])
					item_to_give.name = trim(item_details[INFO_NAMED], PREVENT_CHARACTER_TRIM_LOSS(MAX_NAME_LEN))
					ADD_TRAIT(item_to_give, TRAIT_WAS_RENAMED, "Loadout")
					item_to_give.on_loadout_custom_named()
				if(item_details[INFO_DESCRIBED])
					item_to_give.desc = item_details[INFO_DESCRIBED]
					ADD_TRAIT(item_to_give, TRAIT_WAS_RENAMED, "Loadout")
					item_to_give.on_loadout_custom_described()
				mannequin.starting_items -= item
				break
	//display the physique our player has
	var/mob/living/carbon/human/user = client_to_read.mob
	mannequin.body_type = user.physique
	mannequin.icon_state = "mannequin_[mannequin.material]_[mannequin.body_type == FEMALE ? "female" : "male"]"
	LAZYNULL(mannequin.starting_items) //dump what we couldn't add

//the midround antag's mannequin mapping helper
/obj/effect/mapping_helpers/mannequin/loadout_spawner/midround_traitor/get_client()
	var/instance = 0
	for(var/antag in GLOB.antagonists)
		if(istype(antag, /datum/antagonist/traitor/marauder))
			instance++
	for(var/datum/antagonist/traitor/marauder/antag as anything in GLOB.antagonists)
		if(!istype(antag, /datum/antagonist/traitor/marauder))
			continue
		if(antag.owner.current.client && (antag.marauder_no == instance))
			return antag.owner.current.client
