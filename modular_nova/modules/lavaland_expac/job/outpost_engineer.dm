/// all things ghostineer
// Access and ID Trim
/obj/item/card/id/advanced/mining_station_engineer
	name = "Mining Station Support Engineer's access card"
	desc = "An access card designated for \"engineering staff\". You're going to be the one everyone points at to fix stuff, let's be honest."
	trim = /datum/id_trim/job/mining_station_engineer

/datum/id_trim/job/mining_station_engineer
	assignment = "Mining Station Support Engineer"
	trim_state = "trim_stationengineer"
	department_color = COLOR_AMETHYST
	sechud_icon_state = SECHUD_STATION_ENGINEER
	minimal_access = list(
		ACCESS_ATMOSPHERICS, // access for alarms
		ACCESS_AUX_BASE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP, // access to APC's and tool lockers
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING_STATION,
		ACCESS_MINING,
		ACCESS_SCIENCE, // access to the Xenoarch area
		ACCESS_WEAPONS, // shotgun
	)
	job = /datum/job/mining_station_engineer

//headset
/obj/item/radio/headset/headset_minegineer
	name = "engineering radio headset"
	desc = "When the engineers wish to chat like girls."
	icon_state = "eng_headset"
	worn_icon_state = "eng_headset"
	keyslot = /obj/item/encryptionkey/headset_minegineer

/obj/item/encryptionkey/headset_minegineer
	name = "mining engineer radio encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_mining"
	post_init_icon_state = "cypherkey_cargo"
	channels = list(
		RADIO_CHANNEL_SUPPLY = 1,
		RADIO_CHANNEL_SCIENCE = 1,
		RADIO_CHANNEL_ENGINEERING = 1,
	)
	greyscale_config = /datum/greyscale_config/encryptionkey_cargo
	greyscale_colors = "#49241a#bc4a9b"

// Outfit
/datum/outfit/mining_station
	name = "Mining Station Support Engineer"
	id = /obj/item/card/id/advanced/mining_station_engineer
	id_trim = /datum/id_trim/job/mining_station_engineer
	back = /obj/item/storage/backpack/messenger/eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	glasses = /obj/item/clothing/glasses/meson/engine/tray
	belt = /obj/item/storage/belt/utility/full/engi
	ears = /obj/item/radio/headset/headset_minegineer
	head = /obj/item/clothing/head/utility/hardhat/welding/up
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/modular_computer/pda/engineering
	r_pocket = /obj/item/t_scanner
	r_hand = /obj/item/gun/ballistic/shotgun/doublebarrel/slugs

	var/backpack = /obj/item/storage/backpack/industrial
	var/satchel = /obj/item/storage/backpack/satchel/eng
	var/duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	var/messenger = /obj/item/storage/backpack/messenger/eng
	box = /obj/item/storage/box/survival/engineer
	skillchips = list(/obj/item/skillchip/job/engineer)

/datum/outfit/mining_station/pre_equip(mob/living/carbon/human/minegineer, visuals_only = FALSE)
	if(ispath(back, /obj/item/storage/backpack)) //we just steal this from the job outfit datum.
		switch(minegineer.backpack)
			if(GBACKPACK)
				back = /obj/item/storage/backpack //Grey backpack
			if(GSATCHEL)
				back = /obj/item/storage/backpack/satchel //Grey satchel
			if(GDUFFELBAG)
				back = /obj/item/storage/backpack/duffelbag //Grey Duffel bag
			if(LSATCHEL)
				back = /obj/item/storage/backpack/satchel/leather //Leather Satchel
			if(GMESSENGER)
				back = /obj/item/storage/backpack/messenger //Grey messenger bag
			if(DBACKPACK)
				back = backpack
			if(DSATCHEL)
				back = satchel
			if(DMESSENGER)
				back = messenger
			if(DDUFFELBAG)
				back = duffelbag
			else
				back = backpack
	var/client/client = GLOB.directory[ckey(minegineer.mind?.key)]

	if(isplasmaman(minegineer))
		uniform = /obj/item/clothing/under/plasmaman
		gloves = /obj/item/clothing/gloves/color/plasmaman
		head = /obj/item/clothing/head/helmet/space/plasmaman
		l_hand = /obj/item/tank/internals/plasmaman/belt/full
		internals_slot = ITEM_SLOT_HANDS

	if(isvox(minegineer) || isvoxprimalis(minegineer))
		l_hand = /obj/item/tank/internals/nitrogen/belt/full
		mask = /obj/item/clothing/mask/breath/vox
		internals_slot = ITEM_SLOT_HANDS

	if(client?.is_veteran() && client?.prefs.read_preference(/datum/preference/toggle/playtime_reward_cloak))
		neck = /obj/item/clothing/neck/cloak/skill_reward/playing

/datum/outfit/mining_station/post_equip(mob/living/carbon/human/minegineer, visualsOnly)
	var/obj/item/card/id/id_card = minegineer.wear_id
	if(istype(id_card))
		id_card.registered_name = minegineer.real_name
		id_card.update_label()
		id_card.update_icon()
	handlebank(minegineer)

	. = ..()

// Spawner
/obj/effect/mob_spawn/ghost_role/human/mining_station_engineer
	name = "Mining Station Support Engineer"
	prompt_name = "a mining Station Support Engineer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-o"
	you_are_text = "NT is contracting this station to handle operations, your job is to ensure it stays functional for them."
	flavour_text = "You are your own boss and expected to self-manage, make sure the station is powered and sealed at all times. \
		Call for support when needed from the main station and support rescue efforts by accommodating visiting crew, you do not care about security \
		related issues unless it involves you or your duty station."
	important_text = "This job is contract based, your sole duty of care is the maintaining of the mining station and items within and around. Any character is allowed to play outside of DS-2 characters."
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE
	outfit = /datum/outfit/mining_station
	spawner_job_path = /datum/job/mining_station_engineer
