/datum/id_trim/job/explorer
	assignment = JOB_EXPLORER
	trim_icon = 'modular_iris/master_files/icons/obj/card.dmi'
	trim_state = "trim_explorer"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_PRISONER_BLACK // I KNOW this says "prisoner" but it's just a define for black
	sechud_icon_state = SECHUD_EXPLORER
	minimal_access = list(
		ACCESS_CARGO,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_EVA,
		ACCESS_GATEWAY,
		ACCESS_WEAPONS,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS // Many airlocks are in maints
		)
	extra_access = list(
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SHIPPING,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_QM,
	)
	job = /datum/job/explorer

/datum/job/explorer
	title = JOB_EXPLORER
	description = "Explore deep space. Partake in the Gateway program. \
		Meet the strangest people. Acquire rare loot."
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_QM
	exp_requirements = 180 // Probably a good idea since the role has access to lethal weaponry.
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "EXPLORER"

	outfit = /datum/outfit/job/explorer
	plasmaman_outfit = /datum/outfit/plasmaman

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_BASIC
	departments_list = list(
		/datum/job_department/cargo,
		)

	family_heirlooms = list(/obj/item/weldingtool/mini, /obj/item/flashlight/lantern, /obj/item/camera)
	rpg_title = "Wanderer"
	job_flags = STATION_JOB_FLAGS | JOB_ANTAG_PROTECTED
	mail_goodies = list(
		/obj/item/flashlight/flare = 15,
		/obj/item/tank/internals/emergency_oxygen/engi = 5,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 3
	)

/datum/outfit/job/explorer
	name = "Explorer"
	jobtype = /datum/job/explorer

	id_trim = /datum/id_trim/job/explorer
	uniform = /obj/item/clothing/under/rank/cargo/tech/nova/utility
	backpack_contents = list(
		/obj/item/choice_beacon/explorer = 1,
		/obj/item/knife/combat/survival = 1
	)
	ears = /obj/item/radio/headset/headset_cargo/explorer
	gloves = /obj/item/clothing/gloves/fingerless
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	head = /obj/item/clothing/head/soft/black
	suit = /obj/item/clothing/suit/frontier_colonist_flak
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/deforest/morpital
	r_pocket = /obj/item/gps/explorer
	belt = /obj/item/modular_computer/pda/explorer



	backpack = /obj/item/storage/backpack/industrial/frontier_colonist
	satchel = /obj/item/storage/backpack/industrial/frontier_colonist/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/industrial/frontier_colonist/messenger

	box = /obj/item/storage/box/survival/explorer

/* Job's unique equipment. */

/obj/item/modular_computer/pda/explorer
	name = "explorer PDA"
	icon_state = "/obj/item/modular_computer/pda/explorer"
	greyscale_config = /datum/greyscale_config/tablet/stripe_split
	greyscale_colors = "#8b4c31#8b4c31#333333"

/obj/item/storage/box/survival/explorer
	mask_type = /obj/item/clothing/mask/gas/atmos/frontier_colonist

/obj/item/storage/box/survival/explorer/PopulateContents()
	..()
	new /obj/effect/spawner/random/decoration/glowstick(src)
	new /obj/item/healthanalyzer/simple/explorer(src)

/obj/item/radio/headset/headset_cargo/explorer
	name = "explorer radio headset"
	desc = "Headset used by explorers. Has a built-in antenna allowing the headset to work independently of a communications network."
	icon_state = "mine_headset"
	worn_icon_state = "mine_headset"
	// "puts the antenna down" while the headset is off
	overlay_speaker_idle = "headset_up"
	overlay_mic_idle = "headset_up"
	subspace_transmission = FALSE // Comms without a relay

/obj/item/gps/explorer
	icon = 'modular_iris/master_files/icons/obj/devices/tracker.dmi'
	icon_state = "gps-x"
	gpstag = "EXP0"
	desc = "An essential tool for space exploration. Used to locate one's position in the void and find certain points of interests easier."

/obj/item/healthanalyzer/simple/explorer
	name = "explorer wound analyzer"
	icon = 'modular_iris/master_files/icons/obj/devices/scanner.dmi'
	icon_state = "explorer_aid"
	desc = "A repainted mining wound analyzer made by MeLo-Tech and used to diagnose injuries and recommend treatment for serious wounds. While it might not sound very informative for it to be able to tell you if you have a gaping hole in your body or not, it applies a temporary holoimage near the wound with information that is guaranteed to double the efficacy and speed of treatment. Just like with the mining one, the antenna is just for aesthetic and doesn't actually do anything!"

/* Weapon variants with the /explorer firing pin; Can't use them on station's z-level; */

// Longarms
/obj/item/gun/ballistic/shotgun/doublebarrel/explorer
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual/buckshot
	pin = /obj/item/firing_pin/explorer

/obj/item/gun/ballistic/rifle/boltaction/harpoon/explorer
	pin = /obj/item/firing_pin/explorer

// Lasers
/obj/item/gun/energy/laser/carbine/explorer
	pin = /obj/item/firing_pin/explorer

/obj/item/gun/energy/laser/explorer
	pin = /obj/item/firing_pin/explorer

// Pistols
/obj/item/gun/ballistic/automatic/pistol/sol/explorer
	pin = /obj/item/firing_pin/explorer

/obj/item/gun/ballistic/automatic/pistol/zashch/explorer
	pin = /obj/item/firing_pin/explorer

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/explorer
	pin = /obj/item/firing_pin/explorer

// Revolvers
/obj/item/gun/ballistic/revolver/c38/explorer
	pin = /obj/item/firing_pin/explorer

/obj/item/gun/ballistic/revolver/sol/explorer
	pin = /obj/item/firing_pin/explorer

/obj/item/choice_beacon/explorer
	name = "weaponry beacon"
	desc = "A single use beacon to deliver a weapon of your choice. Please only call this in a secure area!"
	company_source = "Nanotrasen Expeditionary Corps"
	company_message = span_bold("Supply Pod incoming, please stand by.")

/obj/item/choice_beacon/explorer/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Double Barrel Shotgun" = /obj/item/gun/ballistic/shotgun/doublebarrel/explorer,
		"Harpoon Gun" = /obj/item/gun/ballistic/rifle/boltaction/harpoon/explorer,
		"Laser Carbine" = /obj/item/gun/energy/laser/explorer,
		"Laser Auto-Carbine" = /obj/item/gun/energy/laser/carbine/explorer,
		"Guêpe Pistol" = /obj/item/gun/ballistic/automatic/pistol/sol/explorer,
		"Zashch Heavy Pistol" = /obj/item/gun/ballistic/automatic/pistol/zashch/explorer,
		"Gwiazda Plasma Sharpshooter" = /obj/item/gun/ballistic/automatic/pistol/plasma_marksman/explorer,
		".38 Revolver" = /obj/item/gun/ballistic/revolver/c38/explorer,
		"Renard Revolver" = /obj/item/gun/ballistic/revolver/sol/explorer,
		"Surplus Machete" = /obj/item/storage/belt/machete/full,
	)

	return selectable_gun_types

/obj/effect/landmark/start/explorer
	name = "Explorer"
	icon = 'modular_iris/master_files/icons/mob/landmarks.dmi'
	icon_state = "Explorer"

/area/station/cargo/exploration_office
	name = "\improper Exploration Office"
	icon = 'modular_iris/master_files/icons/areas/exploration.dmi'
	icon_state = "exploration_office"

/obj/effect/landmark/navigate_destination/exploration_office
	location = "Exploration Office"

/obj/machinery/suit_storage_unit/explorer
	mask_type = /obj/item/clothing/mask/gas/atmos/frontier_colonist
	mod_type = /obj/item/mod/control/pre_equipped/frontier_colonist
	storage_type = /obj/item/tank/jetpack

