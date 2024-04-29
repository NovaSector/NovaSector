/datum/outfit/sapper
	name = "Space Sapper"

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/chameleon/sapper
	uniform = /obj/item/clothing/under/costume/pirate
	suit = /obj/item/clothing/suit/costume/pirate/armored
	ears = /obj/item/radio/headset/syndicate
	glasses = /obj/item/clothing/glasses/eyepatch
	head = /obj/item/clothing/head/costume/pirate/bandana/armored
	shoes = /obj/item/clothing/shoes/pirate/armored

/datum/outfit/sapper/post_equip(mob/living/carbon/human/equipped)
	equipped.faction |= FACTION_SAPPER

	var/obj/item/radio/outfit_radio = equipped.ears
	if(outfit_radio)
		outfit_radio.set_frequency(FREQ_SYNDICATE)
		outfit_radio.freqlock = RADIO_FREQENCY_LOCKED

	var/obj/item/card/id/outfit_id = equipped.wear_id
	if(outfit_id)
		outfit_id.registered_name = equipped.real_name
		outfit_id.update_label()
		outfit_id.update_icon()

	var/obj/item/clothing/under/pirate_uniform = equipped.w_uniform
	if(pirate_uniform)
		pirate_uniform.has_sensor = NO_SENSORS
		pirate_uniform.sensor_mode = SENSOR_OFF
		equipped.update_suit_sensors()

/datum/id_trim/chameleon/sapper
	assignment = "Sapper Gang"
	trim_state = "trim_contractor"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	department_color = COLOR_ORANGE
	subdepartment_color = COLOR_ORANGE
