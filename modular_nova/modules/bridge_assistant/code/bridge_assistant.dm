/datum/job/bridge_assistant
	title = JOB_BRIDGE_ASSISTANT
	description = "Watch over the Bridge, command its consoles, and spend your days brewing coffee for higher-ups."
	department_head = list(JOB_CAPTAIN)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Nanotrasen Consultant, the Captain and all the other heads of command."
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BRIDGE_ASSISTANT"
	nova_stars_only = TRUE

	outfit = /datum/outfit/job/bridge_assistant
	plasmaman_outfit = /datum/outfit/plasmaman/bridge_assistant

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV
	bounty_types = CIV_JOB_DRINK

	display_order = JOB_DISPLAY_ORDER_BRIDGE_ASSISTANT
	department_for_prefs = /datum/job_department/captain
	departments_list = list(
		/datum/job_department/command,
		/datum/job_department/service
	)
	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	family_heirlooms = list(/obj/item/soap/nanotrasen)

	mail_goodies = list(
		/obj/item/storage/bag/tray = 1,
		/obj/item/vending_refill/cigarette = 1,
		/obj/item/vending_refill/coffee = 1,
	)
	job_flags = STATION_JOB_FLAGS
	rpg_title = "Royal Page"

//outfit datum
/datum/outfit/job/bridge_assistant
	name = "Bridge Officer"
	jobtype = /datum/job/bridge_assistant

	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/bridge_assistant
	uniform = /obj/item/clothing/under/rank/civilian/lawyer/greensuit
	neck = /obj/item/clothing/neck/bowtie/green
	ears = /obj/item/radio/headset/bridge_officer
	shoes = /obj/item/clothing/shoes/laceup
	belt = /obj/item/modular_computer/pda/bridge_assistant
	l_pocket = /obj/item/melee/baton/telescopic/bronze
	r_pocket = /obj/item/gun/energy/e_gun/mini
	backpack_contents = list(
		/obj/item/choice_beacon/job_locker/bridge_officer = 1,
		/obj/item/choice_beacon/coffee = 1,
	)

/datum/outfit/job/bridge_assistant/post_equip(mob/living/carbon/human/user, visuals_only = FALSE)
	. = ..()
	//give em a waistcoat
	var/obj/item/clothing/under/undersuit = user.w_uniform
	undersuit.attach_accessory(new /obj/item/clothing/accessory/waistcoat(user))

//undersuit and skirt
/obj/item/clothing/under/rank/civilian/lawyer/greensuit
	name = "green buttondown suit"
	worn_icon = 'icons/mob/clothing/under/shorts_pants_shirts.dmi'
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/lawyer/greensuit"
	post_init_icon_state = "buttondown_slacks"
	greyscale_config = /datum/greyscale_config/buttondown_slacks
	greyscale_config_worn = /datum/greyscale_config/buttondown_slacks/worn
	greyscale_colors = "#EEEEEE#FCECC1#17171B#4BA848"
	greyscale_config_worn_digi = /datum/greyscale_config/buttondown_slacks/worn/digi
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer/greensuit/skirt
	name = "green buttondown suitskirt"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/civilian/lawyer/greensuit/skirt"
	post_init_icon_state = "buttondown_skirt"
	greyscale_config = /datum/greyscale_config/buttondown_skirt
	greyscale_config_worn = /datum/greyscale_config/buttondown_skirt/worn
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/neck/bowtie/green
	name = "green bow tie"
	greyscale_colors = "#70b46e"

//trim
/datum/id_trim/job/bridge_assistant
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_COMMAND_BLUE

//pda
/obj/item/modular_computer/pda/bridge_assistant
	name = "bridge officer PDA"
	greyscale_colors = "#69E062#E26F41"
	starting_programs = list(
		/datum/computer_file/program/status,
	)

//headset radio
/obj/item/radio/headset/bridge_officer
	name = "\proper the bridge officer's headset"
	icon_state = "com_headset"
	worn_icon_state = "com_headset"
	keyslot = /obj/item/encryptionkey/headset_com
	command = TRUE
