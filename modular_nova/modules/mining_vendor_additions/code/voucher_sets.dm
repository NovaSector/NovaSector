/datum/voucher_set/mining/survival_capsule/New()
	description += " It also comes with a set of Kheiral Cuffs to extend the range of sensors."
	set_items += /obj/item/kheiral_cuffs

/datum/voucher_set/mining/crusher_kit
	icon = 'modular_nova/modules/mining_crushers/icons/crusher_conversion_kit.dmi'
	icon_state = "crusher_kit"
	description = "Contains a crusher conversion kit and a pocket fire extinguisher. The conversion kit will transform into a proto-kinetic crusher variant of one's choice, giving a versatile melee mining tool capable both of mining and fighting local fauna. \
		It is difficult to use effectively for anyone but most skilled and/or suicidal miners."
	set_items = list(
		/obj/item/crusher_conversion_kit,
		/obj/item/extinguisher/mini,
	)
