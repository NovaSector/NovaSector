//outfits
/datum/outfit/lone_infiltrator
	name = "Syndicate Operative - Infiltrator"

	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/lone_infiltrator/post_equip(mob/living/carbon/human/equipped)
	equipped.faction |= ROLE_SYNDICATE
	SSquirks.AssignQuirks(equipped, equipped.client, TRUE, TRUE, null, FALSE, equipped)

/datum/outfit/lone_infiltrator_preview
	name = "Lone Infiltrator (Preview only)"
