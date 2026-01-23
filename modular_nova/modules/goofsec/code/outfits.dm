/datum/outfit/solfed
	name = "SolFed Official"
	uniform = /obj/item/clothing/under/solfed/officer
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/jackboots
	accessory = /obj/item/clothing/accessory/nova/solfedribbon
	neck = /obj/item/clothing/neck/mantle/solfed
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/headset_solfed/officials
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/flashlight/seclite
	id = /obj/item/card/id/advanced/solfed
	r_hand = /obj/item/clipboard
	backpack_contents = list(
		/obj/item/stamp/solfed,
		/obj/item/stamp/denied,
		/obj/item/stamp/granted,
	)
	id_trim = /datum/id_trim/solfed/official

/datum/outfit/solfed/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/Radio = person.ears
	Radio.set_frequency(FREQ_SOLFED)
	Radio.freqlock = TRUE
	var/obj/item/card/id/ID = person.wear_id
	ID.registered_name = person.real_name
	ID.update_label()
	..()

/datum/outfit/solfed/lowrank
	name = "SolFed Official (Low Rank)"
	uniform = /obj/item/clothing/under/solfed/officer_lowrnk
	accessory = /obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official

/datum/outfit/solfed/civil
	name = "SolFed Official (Civil Services)"
	uniform = /obj/item/clothing/under/solfed/official_civil
	accessory = /obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official

/datum/outfit/solfed/social
	name = "SolFed Official (Social Services)"
	uniform = /obj/item/clothing/under/solfed/official_social
	accessory = /obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official
