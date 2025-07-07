//item vouchers
/obj/item/paper/paperslip/corporate/syndicate
	name = "item voucher"
	desc = "A plastic card used to redeem equipment, this one is blank."
	icon_state = "voucher_blank"
	icon = 'modular_nova/modules/infiltrator/icons/voucher.dmi'
	show_written_words = FALSE

//mannequin presets
/obj/structure/mannequin/plastic/infiltrator_memory //abstract type

/obj/structure/mannequin/plastic/infiltrator_memory/maid
	starting_items = list(
		/obj/item/clothing/head/costume/maidheadband/syndicate,
		/obj/item/clothing/under/syndicate/nova/maid,
		/obj/item/clothing/gloves/combat/maid,
		/obj/item/clothing/shoes/laceup,
		)

/obj/structure/mannequin/plastic/infiltrator_memory/loadout
	var/client/antag_client

/obj/structure/mannequin/plastic/infiltrator_memory/loadout/Initialize(mapload)
	. = ..()
	if(!mapload)
		return
	//find our player's client
	for(var/client/client in SSjob.dynamic_forced_occupations)
		if(LAZYACCESS(SSjob.dynamic_forced_occupations, client) == ROLE_INFILTRATOR)
			antag_client = client
			break
	//compile the loadout data
	var/list/loadout_entries = antag_client.prefs.read_preference(/datum/preference/loadout)
	var/list/selected_loadout = loadout_entries[antag_client.prefs.read_preference(/datum/preference/loadout_index)]
	var/list/loadout_datums = antag_client.get_loadout_datums()
	//create our list of items
	for(var/datum/loadout_item/datum as anything in loadout_datums)
		LAZYADD(starting_items, datum.item_path)
	//spawn our items and put it on our mannequin's slots
	for(var/slot_flag in slot_flags)
		worn_items["[slot_flag]"] = null
	//check per loadout-item if they fit in the slot we're trying to fill
		for(var/obj/item/clothing/item as anything in starting_items)
			var/list/item_details = selected_loadout[item]
			if(initial(item.slot_flags) & slot_flag)
	//found a match lets spawn it
				var/obj/item/clothing/item_to_give = new item(src)
				worn_items["[slot_flag]"] = item_to_give
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

				starting_items -= item
				break

	//display the physique our player has
	var/mob/living/carbon/human/user = antag_client.mob
	body_type = user.physique
	icon_state = "mannequin_[material]_[body_type == FEMALE ? "female" : "male"]"
	update_appearance()
	LAZYNULL(starting_items) //dump what we couldn't add


//outfits
/datum/outfit/infiltrator
	name = "Syndicate Operative - Infiltrator"

	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/infiltrator/post_equip(mob/living/carbon/human/equipped)
	equipped.faction |= ROLE_SYNDICATE
	SSquirks.AssignQuirks(equipped, equipped.client, TRUE, TRUE, null, FALSE, equipped)

/datum/outfit/infiltrator_preview
	name = "Infiltrator (Preview only)"
