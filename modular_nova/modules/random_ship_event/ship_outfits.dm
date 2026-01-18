/datum/outfit/ship_crew
	name = "Ship Crew"

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/ship
	uniform = /obj/item/clothing/under/color/random
	suit = /obj/item/clothing/suit/armor/vest
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/sunglasses
	head = /obj/item/clothing/head/helmet
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack

/datum/outfit/ship_crew/post_equip(mob/living/carbon/human/equipped)
	var/obj/item/radio/outfit_radio = equipped.ears
	if(outfit_radio)
		outfit_radio.set_frequency(FREQ_COMMON)
		outfit_radio.freqlock = RADIO_FREQENCY_UNLOCKED

	var/obj/item/card/id/outfit_id = equipped.wear_id
	if(outfit_id)
		outfit_id.registered_name = equipped.real_name
		outfit_id.update_label()
		outfit_id.update_icon()

	var/obj/item/clothing/under/crew_uniform = equipped.w_uniform
	crew_uniform?.set_sensor_mode(SENSOR_OFF)

/datum/outfit/ship_crew/captain
	name = "Ship Captain"

	id_trim = /datum/id_trim/ship/captain
	head = /obj/item/clothing/head/hats/caphat/parade
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/melee/energy/sword/saber/purple

/datum/outfit/ship_crew/rogue_trader
	name = "Rogue Trader"

	id_trim = /datum/id_trim/ship/rogue
	uniform = /obj/item/clothing/under/costume/pirate
	suit = /obj/item/clothing/suit/costume/pirate/armored
	ears = /obj/item/radio/headset/syndicate
	glasses = /obj/item/clothing/glasses/eyepatch
	head = /obj/item/clothing/head/costume/pirate/bandana/armored
	shoes = /obj/item/clothing/shoes/pirate/armored
	back = /obj/item/storage/backpack/satchel

/datum/outfit/ship_crew/rogue_trader/post_equip(mob/living/carbon/human/equipped)
	. = ..()
	equipped.faction |= FACTION_PIRATE

	var/obj/item/radio/outfit_radio = equipped.ears
	if(outfit_radio)
		outfit_radio.set_frequency(FREQ_SYNDICATE)
		outfit_radio.freqlock = RADIO_FREQENCY_LOCKED

/datum/id_trim/ship

/datum/id_trim/ship/captain

/datum/id_trim/ship/rogue
