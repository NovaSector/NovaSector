/datum/outfit/sapper
	name = "Space Sapper"

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/sapper

	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/syndicate/nova/overalls
	suit = /obj/item/clothing/suit/armor/bulletproof
	belt = /obj/item/storage/belt/utility/sapper
	gloves = /obj/item/clothing/gloves/color/yellow
	shoes = /obj/item/clothing/shoes/workboots

	box = /obj/item/storage/box/smart_metal_foam
	back = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/empty
	backpack_contents = list(
		/obj/item/storage/backpack/satchel/flat/empty = 1,
		/obj/item/fireaxe = 1,
		/obj/item/stack/cable_coil/thirty = 2,
		)

	l_pocket = /obj/item/paper/fluff/sapper_intro
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	skillchips = list(/obj/item/skillchip/job/engineer)

/datum/outfit/sapper/post_equip(mob/living/carbon/human/equipped)
	equipped.faction |= FACTION_SAPPER

	var/obj/item/radio/outfit_radio = equipped.ears
	if(outfit_radio)
		outfit_radio.keyslot = new /obj/item/encryptionkey/syndicate()
		outfit_radio.set_frequency(FREQ_SYNDICATE)

	var/obj/item/card/id/outfit_id = equipped.wear_id
	if(outfit_id)
		outfit_id.registered_name = equipped.real_name
		outfit_id.update_label()
		outfit_id.update_icon()

	var/obj/item/clothing/under/outfit_uniform = equipped.w_uniform
	if(outfit_uniform)
		outfit_uniform.has_sensor = NO_SENSORS
		outfit_uniform.sensor_mode = SENSOR_OFF
		equipped.update_suit_sensors()

	SSquirks.AssignQuirks(equipped, equipped.client, TRUE, TRUE, null, FALSE, equipped)

/obj/item/storage/belt/utility/sapper
	preload = FALSE

/obj/item/storage/belt/utility/sapper/PopulateContents() //its just a complete mishmash
	new /obj/item/multitool(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/construction/rcd/improved(src)
	new /obj/item/screwdriver/caravan(src)
	new /obj/item/inducer/syndicate(src)
	new /obj/item/weldingtool/abductor(src)

/datum/id_trim/sapper
	assignment = "Sapper"
	trim_state = "trim_sapper"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	department_color = COLOR_ORANGE
	subdepartment_color = COLOR_ORANGE
	sechud_icon_state = SECHUD_SAPPER
	access = list(ACCESS_SAPPER_SHIP)
	threat_modifier = 10 //gangs are illegal

/datum/job/space_sapper
	title = ROLE_SPACE_SAPPER
	policy_index = ROLE_SPACE_SAPPER
