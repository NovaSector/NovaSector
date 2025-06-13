//item vouchers
/obj/item/paper/paperslip/corporate/syndicate
	name = "item voucher"
	desc = "A plastic card used to redeem equipment, this one is blank."
	icon_state = "voucher_blank"
	icon = 'modular_nova/modules/lone_infiltrator/icons/voucher.dmi'
	show_written_words = FALSE

//mannequin presets
/obj/structure/mannequin/plastic/lone_infil_memory //abstract type

/obj/structure/mannequin/plastic/lone_infil_memory/maid
	starting_items = list(
		/obj/item/clothing/head/costume/maidheadband/syndicate,
		/obj/item/clothing/under/syndicate/nova/maid,
		/obj/item/clothing/gloves/combat/maid,
		/obj/item/clothing/shoes/laceup,
		)

//outfits
/datum/outfit/lone_infiltrator
	name = "Syndicate Operative - Infiltrator"

	r_hand = /obj/item/paper/paperslip/corporate/syndicate

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
