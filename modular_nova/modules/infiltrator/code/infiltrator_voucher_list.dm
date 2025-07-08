//item vouchers
/obj/item/paper/paperslip/corporate/syndicate
	name = "item voucher"
	desc = "A plastic card used to redeem equipment, this one is blank."
	icon_state = "voucher_blank"
	icon = 'modular_nova/modules/infiltrator/icons/voucher.dmi'
	show_written_words = FALSE

/datum/voucher_set/traitor //abstract type


/datum/voucher_set/traitor/crusher_kit
	name = "Crusher Kit"
	description = "Contains a kinetic crusher and a pocket fire extinguisher. Kinetic crusher is a versatile melee mining tool capable both of mining and fighting local fauna, however it is difficult to use effectively for anyone but most skilled and/or suicidal miners."
	icon = 'icons/obj/mining.dmi'
	icon_state = "crusher"
	set_items = list(
		/obj/item/kinetic_crusher,
		/obj/item/extinguisher/mini,
	)
