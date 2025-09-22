/datum/outfit/hc_officer
	name = "HC Inspector"

	head = /obj/item/clothing/head/hats/colonial/nri_police
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild/command
	mask = null
	neck = /obj/item/clothing/neck/cloak/colonial/nri_police

	uniform = /obj/item/clothing/under/colonial/nri_police
	suit = null

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/security/nri
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack/inspector = 1,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 2,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 1,
		/obj/item/clothing/mask/gas/nri_police = 1,
		/obj/item/modular_computer/pda/hc_police = 1,
	)
	l_pocket = /obj/item/folder/blue/hc_cop
	r_pocket = /obj/item/storage/pouch/ammo

	id = /obj/item/card/id/advanced/hc_police
	id_trim = /datum/id_trim/hc_police

/datum/outfit/hc_officer/post_equip(mob/living/carbon/human/equipped)
	. = ..()
	equipped.faction |= "coalition"

	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = equipped.wear_id
	if(istype(id_card))
		id_card.registered_name = equipped.real_name
		id_card.update_icon()
		id_card.update_label()

	handlebank(equipped)

/obj/item/modular_computer/pda/hc_police
	name = "\improper HC police PDA"
	device_theme = PDA_THEME_TERMINAL
	greyscale_colors = "#363655#7878f7"
	comp_light_luminosity = 6.3 //Matching a flashlight
	comp_light_color = "#5c20aa" //"UV" light yeah uh-huh
	starting_programs = list(
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/robocontrol,
	)
	inserted_item = /obj/item/pen/fourcolor

/obj/item/card/id/advanced/hc_police
	name = "\improper HC police identification card"
	desc = "A retro-looking card model modified to work with the modern identification systems."
	icon = 'modular_nova/master_files/icons/obj/card.dmi'
	icon_state = "card_hc_police"
	assigned_icon_state = "assigned_hc_police"

/datum/id_trim/hc_police
	assignment = "HC Field Officer"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	trim_state = "trim_hc_police"
	department_color = COLOR_HC_POLICE_BLUE
	subdepartment_color = COLOR_HC_POLICE_SILVER
	sechud_icon_state = "hud_hc_police"
	access = list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS)
	threat_modifier = 2 // Not as threatening as syndicate, but still potentially harmful to the station

/obj/item/storage/belt/security/nri/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/flashbang = 1,
	), src)

/obj/item/storage/box/nri_survival_pack/inspector
	w_class = WEIGHT_CLASS_SMALL
	desc = "A box filled with useful inspection items, supplied by the HC."

/obj/item/storage/box/nri_survival_pack/inspector/PopulateContents()
	new /obj/item/oxygen_candle(src)
	new /obj/item/tank/internals/emergency_oxygen(src)
	new /obj/item/stack/spacecash/c1000(src)
	new /obj/item/storage/pill_bottle/iron(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/crowbar/red(src)
	new /obj/item/clipboard(src)
	new /obj/item/pen(src)

/obj/item/folder/blue/hc_cop
	name = "HC police SOPs"

/obj/item/folder/blue/hc_cop/Initialize(mapload)
	. = ..()
	new /obj/item/paper/fluff/hc_document(src)
	new /obj/item/paper/fluff/hc_document/cheat_sheet(src)
	new /obj/item/paper/fluff/hc_document/lexicon(src)
	new /obj/item/paper/fluff/hc_document/property_seizure_receipt(src)
	new /obj/item/paper/fluff/hc_document/incident_report(src)
	new /obj/item/paper/fluff/hc_document/shore_leave_request(src)
	new /obj/item/paper/fluff/hc_document/acquired_asset_register(src)
	new /obj/item/paper/fluff/hc_document/biological_examination_report(src)
	new /obj/item/paper/fluff/hc_document/pre_action_assessment(src)
	update_appearance()
