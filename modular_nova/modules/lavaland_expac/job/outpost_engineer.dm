/// all things ghostineer
// Job - Cargo will be paying them their contracted rate.
/datum/job/mining_station_engineer
	title = ROLE_MINING_STATION_SUPPORT_ENGINEER
	description = "mining station support engineer"
	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR
	bounty_types = CIV_JOB_ENG

// Access and ID Trim
/obj/item/card/id/advanced/mining_station_engineer
	name = "Mining Station Support Engineer's access card"
	desc = "An access card designated for \"engineering staff\". You're going to be the one everyone points at to fix stuff, let's be honest."
	trim = /datum/id_trim/away/tarkon/eng

/datum/id_trim/job/mining_station_engineer
	assignment = "Mining Station Support Engineer"
	trim_state = "trim_stationengineer"
	department_color = COLOR_AMETHYST
	sechud_icon_state = SECHUD_STATION_ENGINEER
	minimal_access = list(
		ACCESS_AUX_BASE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_ENGINE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_TCOMMS,
		ACCESS_ATMOSPHERICS,
		ACCESS_WEAPONS,
		ACCESS_MINING_STATION,
		ACCESS_MINING,
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
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_ENGINEERING = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_cargo
	greyscale_colors = "#49241a#bc4a9b"

// Outfit
/datum/outfit/job/mining_station
	name = "Mining Station Support Engineer"
	jobtype = /datum/job/station_engineer
	id = /obj/item/card/id/advanced/mining_station_engineer
	id_trim = /datum/id_trim/job/mining_station_engineer
	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	glasses = /obj/item/clothing/glasses/meson/engine/tray
	belt = /obj/item/storage/belt/utility/full/engi
	ears = /obj/item/radio/headset/headset_minegineer
	head = /obj/item/clothing/head/utility/hardhat/welding/up
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/modular_computer/pda/engineering
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	messenger = /obj/item/storage/backpack/messenger/eng

	backpack_contents = list(
		/obj/item/construction/rcd/loaded,
		/obj/item/inducer = 1,
	)
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	skillchips = list(/obj/item/skillchip/job/engineer)

// Spawner
/obj/effect/mob_spawn/ghost_role/human/mining_station_engineer
	name = "Mining Station Support Engineer"
	prompt_name = "a mining Station Support Engineer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-o"
	you_are_text = "NT is contracting this station to handle operations, your job is to ensure it stays functional for them."
	flavour_text = "You are your own boss and expected to self-manage, make sure the station is powered and sealed at all times. Call for support when needed from the main station and support rescue efforts by accomodating visiting crew, you do not care about security related issues unless it involves you or your duty station."
	important_text = "This job is contract based, your sole duty of care is the maintaining of the mining station and items within and around. Any character is allowed to play outside of DS-2 characters."
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE
	outfit = /datum/outfit/job/mining_station
	spawner_job_path = /datum/job/mining_station_engineer
