/obj/structure/mannequin/operative_barracks
	material = "plastic"
	anchored = TRUE

/obj/structure/mannequin/operative_barracks/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/mannequin/operative_barracks/LateInitialize()
	//turn off those pesky soup sensors
	var/obj/item/clothing/under/uniform
	for(var/obj/item/clothing/clothing as anything in contents)
		if(istype(clothing, /obj/item/clothing/under))
			uniform = clothing
			break
	if(!uniform)
		return
	if(!uniform.has_sensor)
		return
	uniform.sensor_mode = NO_SENSORS

/obj/structure/mannequin/operative_barracks/wildcard

/obj/structure/mannequin/operative_barracks/wildcard/Initialize(mapload)
	/// If we are anything but the abstract type, it implies we already generated and are ready for a normal initialization
	if(type != /obj/structure/mannequin/operative_barracks/wildcard)
		return ..()
	/// Build a list of all wildcard subtypes and pick one to load
	var/wildcard_mannequins = list()
	var/picked_mannequin
	for(var/path in subtypesof(/obj/structure/mannequin/operative_barracks/wildcard))
		wildcard_mannequins += path
	picked_mannequin = pick(wildcard_mannequins)
	new picked_mannequin(loc)
	return INITIALIZE_HINT_QDEL

/obj/structure/mannequin/operative_barracks/loadout
	/// Variable which tells if this mannequin should still load its items
	var/loaded = FALSE

/obj/structure/mannequin/operative_barracks/loadout/proc/load_items(client/client_to_read)
	if(!client_to_read)
		return
	//compile the loadout data
	var/list/loadout_entries = client_to_read.prefs.read_preference(/datum/preference/loadout)
	var/list/selected_loadout = loadout_entries[client_to_read.prefs.read_preference(/datum/preference/loadout_index)]
	var/list/loadout_datums = client_to_read.get_loadout_datums()
	if(!length(loadout_datums))
		return
	//create our list of items
	for(var/datum/loadout_item/datum as anything in loadout_datums)
		if(datum.restricted_roles)
			continue
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
	var/mob/living/carbon/human/user = client_to_read.mob
	body_type = user.physique
	icon_state = "mannequin_[material]_[body_type == FEMALE ? "female" : "male"]"
	LAZYNULL(starting_items) //dump what we couldn't add

/*⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠈⠂⢀⠉⠢⢄⠀⠀⢠⣾⡶⡾⠁⢀⣠⣠⡀
⠀⠀⠀⠀⠸⡋⠍⣉⠁⠒⠣⠤⣀⢉⠐⠄⡑⢦⡹⣿⣿⣴⣿⣿⣿⣿⠏⠀⠀⠀⣠⣴⣺⣅⡀⣀
⠀⠀⠀⠀⠀⠑⢄⠀⠈⠑⢄⠒⠂⠬⢱⡒⠬⣣⠙⢆⠸⣿⣿⣿⣿⣿⣦⠀⢀⣾⠏
⠀⠀⠀⠀⠀⠀⠈⠳⡒⠂⠠⢬⠐⠂⠠⠥⢢⣈⠑⠤⡳⡙⢿⣿⣿⣿⡿⢀⣾⡟
⠀⠀⠀⠀⠀⠀⠀⠀⠈⠲⣈⠁⠈⠀⢒⠒⠦⠤⠩⠶⢌⣳⣸⣿⣿⣡⣴⣿⠟⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢶⣄⡉⠁⠚⠒⢒⣲⣦⣤⣶⣿⢿⣿⣿⣿⣿⡟⠁
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⠶⠶⢿⠿⣛⠿⣫⢟⠃⡜⣿⣿⣿⣿⠃
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⢒⠡⡮⡪⢋⢂⠎⣤⠁⣿⣿⣿⠃⠀⠀⠀⠀⠀\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠣⠥⡜⡠⠑⡙⢋⣠⣧⣾⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀\⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣔⡠⠔⠓⣹⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀( This is a dress-up game now, the following atoms are outfits
⠀⠀⠀⠀⠀⠀⢀⣠⣶⣤⣠⣤⣤⣤⣤⣄⣀⠀⣠⣿⣿⣿⢿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀supplied to the midround antag. There is only room for six
⠀⠀⠀⠀⠀⠴⠛⠋⠉⠉⠉⠉⠛⠛⣻⣿⣿⣿⣿⡿⠛⠁⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀mannequins, if you want to add an outfit instead of change,
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⣠⣴⣿⣿⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀please do so by moving an existing outfit onto the 'wildcard'
⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀mannequins, or consider if your new outfit would be suited
⠀⠀⠀⠀⠀⠀⠀⢰⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀to fit on those randomly picked 'wildcard' mannequins. )
*/

///
/// Guaranteed mannequins
/obj/structure/mannequin/operative_barracks/operative
	name = "operative mannequin"
	desc = "You've seen it a hundred times, but that's because it <b>works.</b>"
	starting_items = list(
		/obj/item/clothing/mask/neck_gaiter,
		/obj/item/clothing/glasses/meson/night,
		/obj/item/clothing/gloves/tackler/combat,
		/obj/item/clothing/under/syndicate/combat,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/storage/belt/military/assault,
		/obj/item/clothing/shoes/combat,
		/obj/item/storage/toolbox/guncase/nova/syndicate,
	)

/obj/structure/mannequin/operative_barracks/spy
	name = "spy mannequin"
	desc = "For a classic covert mission, when that chameleon gear is too much."
	starting_items = list(
		/obj/item/clothing/mask/gas/syndicate/ds,
		/obj/item/clothing/glasses/sunglasses/robohand,
		/obj/item/clothing/neck/tie/red/hitman,
		/obj/item/clothing/under/suit/black/armoured,
		/obj/item/clothing/suit/jacket/det_suit/noir/armoured,
		/obj/item/storage/belt/holster/detective/dark,
		/obj/item/clothing/shoes/laceup,
		/obj/item/storage/backpack/satchel/leather,
	)

/obj/structure/mannequin/operative_barracks/hacker
	name = "hacker mannequin"
	desc = "Don't have hard feelings after they call you a nerd."
	starting_items = list(
		/obj/item/clothing/mask/gas/ninja,
		/obj/item/clothing/glasses/hud/health/night,
		/obj/item/clothing/under/syndicate/ninja,
		/obj/item/clothing/suit/armor/sf_sacrificial,
		/obj/item/clothing/gloves/combat,
		/obj/item/storage/belt/military,
		/obj/item/clothing/shoes/combat,
		/obj/item/storage/toolbox/guncase/nova,
	)

/obj/structure/mannequin/operative_barracks/chameleon
	name = "chameleon mannequin"
	desc = "Completely clandestine, just don't get EMP'd."
	starting_items = list(
		/obj/item/clothing/head/chameleon,
		/obj/item/clothing/mask/chameleon,
		/obj/item/clothing/glasses/chameleon,
		/obj/item/clothing/neck/chameleon,
		/obj/item/clothing/under/chameleon,
		/obj/item/clothing/suit/chameleon,
		/obj/item/storage/belt/chameleon,
		/obj/item/clothing/gloves/chameleon,
		/obj/item/clothing/shoes/chameleon,
		/obj/item/storage/backpack/chameleon,
	)

/obj/structure/mannequin/operative_barracks/anarchist
	name = "anarchist mannequin"
	desc = "My name is not important."
	starting_items = list(
		/obj/item/clothing/glasses/sunglasses/robohand,
		/obj/item/clothing/under/pants/track/robohand,
		/obj/item/clothing/suit/jacket/leather_trenchcoat/gunman,
		/obj/item/clothing/shoes/combat,
		/obj/item/storage/toolbox/guncase/nova/green,
	)

/obj/structure/mannequin/operative_barracks/sol_militant
	name = "\improper Sol militant mannequin"
	desc = "They'll never know what hit 'em."
	starting_items = list(
		/obj/item/clothing/head/helmet/sf_peacekeeper,
		/obj/item/clothing/mask/gas/hecu,
		/obj/item/clothing/under/sol_peacekeeper,
		/obj/item/clothing/suit/armor/sf_peacekeeper,
		/obj/item/storage/belt/military/cin_surplus,
		/obj/item/clothing/gloves/frontier_colonist,
		/obj/item/clothing/shoes/jackboots/frontier_colonist,
		/obj/item/storage/toolbox/guncase/nova/solfed,
	)

///
/// Wildcard mannequins
/obj/structure/mannequin/operative_barracks/wildcard/maid
	name = "maid mannequin"
	body_type = FEMALE
	starting_items = list(
		/obj/item/clothing/head/costume/maidheadband/syndicate,
		/obj/item/clothing/under/syndicate/nova/maid,
		/obj/item/clothing/gloves/combat/maid,
		/obj/item/clothing/shoes/laceup,
	)

/obj/structure/mannequin/operative_barracks/wildcard/clown
	name = "clown mannequin"
	starting_items = list(
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/item/clothing/under/rank/civilian/clown,
		/obj/item/clothing/shoes/clown_shoes,
		/obj/item/storage/backpack/clown,
	)

/obj/structure/mannequin/operative_barracks/wildcard/mime
	name = "mime mannequin"
	starting_items = list(
		/obj/item/clothing/head/beret/frenchberet/armoured,
		/obj/item/clothing/mask/gas/mime,
		/obj/item/clothing/under/rank/civilian/mime,
		/obj/item/clothing/gloves/color/white,
		/obj/item/clothing/shoes/laceup,
		/obj/item/storage/backpack/mime,
	)

/obj/structure/mannequin/operative_barracks/wildcard/miner
	name = "miner mannequin"
	starting_items = list(
		/obj/item/clothing/mask/gas/explorer,
		/obj/item/clothing/glasses/meson,
		/obj/item/clothing/under/rank/cargo/miner/lavaland,
		/obj/item/clothing/suit/hooded/explorer,
		/obj/item/clothing/gloves/bracer,
		/obj/item/clothing/shoes/workboots/mining,
		/obj/item/storage/backpack/explorer,
	)

/obj/structure/mannequin/operative_barracks/wildcard/intern
	name = "centcom intern mannequin"
	starting_items = list(
		/obj/item/clothing/glasses/sunglasses/robohand,
		/obj/item/clothing/under/rank/centcom/officer,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/clothing/shoes/sneakers/green,
	)

/obj/structure/mannequin/operative_barracks/wildcard/wizard
	name = "wizard mannequin"
	starting_items = list(
		/obj/item/clothing/head/wizard,
		/obj/item/clothing/under/color/lightpurple,
		/obj/item/clothing/suit/wizrobe,
		/obj/item/clothing/shoes/sandal,
	)

/obj/structure/mannequin/operative_barracks/wildcard/cultie
	name = "cultist mannequin"
	starting_items = list(
		/obj/item/clothing/under/rank/civilian/chaplain,
		/obj/item/clothing/suit/hooded/cultrobes,
		/obj/item/clothing/shoes/cult,
	)

/obj/structure/mannequin/operative_barracks/wildcard/pirate
	name = "pirate mannequin"
	starting_items = list(
		/obj/item/clothing/head/helmet/space/pirate/bandana,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/clothing/under/costume/pirate,
		/obj/item/clothing/suit/space/pirate,
		/obj/item/clothing/shoes/pirate/armored,
	)

/obj/structure/mannequin/operative_barracks/wildcard/knight
	name = "knight mannequin"
	starting_items = list(
		/obj/item/clothing/head/helmet/knight/red,
		/obj/item/clothing/under/color/brown,
		/obj/item/clothing/suit/armor/vest/cuirass,
		/obj/item/clothing/gloves/plate/red,
		/obj/item/clothing/shoes/plate/red,
	)

/obj/structure/mannequin/operative_barracks/wildcard/pizza_guy
	name = "pizza delivery mannequin"
	starting_items = list(
		/obj/item/clothing/head/soft/red,
		/obj/item/clothing/mask/fakemoustache/italian,
		/obj/item/clothing/under/pizza,
		/obj/item/clothing/suit/toggle/jacket/nova/hoodie/pizza,
		/obj/item/clothing/shoes/sneakers/red,
	)
