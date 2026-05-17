
/obj/item/security_voucher
	name = "security voucher"
	desc = "A token to redeem a piece of equipment. Use it on a SecTech vendor."
	icon = 'modular_nova/modules/security_vouchers/icons/security_voucher.dmi'
	icon_state = "security_voucher_primary"
	w_class = WEIGHT_CLASS_TINY

/obj/item/security_voucher/primary
	name = "security primary voucher"
	icon_state = "security_voucher_primary"

/obj/item/security_voucher/utility
	name = "security utility voucher"
	icon_state = "security_voucher_utility"

/obj/machinery/vending/security/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)


/datum/voucher_set/security
	blackbox_key = "security_voucher_redeemed"

/datum/voucher_set/security/primary

/datum/voucher_set/security/utility


/datum/voucher_set/security/primary/disabler
	name = "Disabler"
	description = "The standard issue energy gun of Nanotrasen security forces. Comes with it's own holster for enhanced recharging."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "disabler"
	set_items = list(
		/obj/item/storage/belt/holster/energy/disabler,
		)

/datum/voucher_set/security/primary/e_carbine
	name = "Energy Carbine"
	description = "A standard model Energy Carbine manufacture by Nano-Trasen. Nothing fancy, just old reliable."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "energy"
	set_items = list(
		/obj/item/gun/energy/e_gun,
		)

/datum/voucher_set/security/primary/disabler_smg
	name = "Pepperball AGH"
	description = "A slower firing handgun that fires 'pepperballs', which easily drop targets to the floor."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/pepperball/pepperball.dmi'
	icon_state = "peppergun"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/pepperball,
		/obj/item/ammo_box/magazine/pepperball
		)

/datum/voucher_set/security/primary/strobe_shield
	name = "Strobe Shield"
	description = "A shield with a built in, high intensity light capable of blinding and disorienting suspects. Takes regular handheld flashes as bulbs."
	icon = 'icons/obj/weapons/shields.dmi'
	icon_state = "flashshield"
	set_items = list(
		/obj/item/shield/riot/flash,
		)


/datum/voucher_set/security/utility/donut_box
	name = "Box of Donuts"
	description = "Tantalizing..."
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donutbox"
	set_items = list(
		/obj/item/storage/fancy/donut_box,
		/obj/item/reagent_containers/cup/glass/coffee,
		)

/datum/voucher_set/security/utility/barrier
	name = "Barrier Grenades"
	description = "Two barrier grenades."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "wallbang"
	set_items = list(
		/obj/item/grenade/barrier,
		/obj/item/grenade/barrier,
		)

/datum/voucher_set/security/utility/stingbang
	name = "Stingbang Grenades"
	description = "Two stingbang grenades."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "timeg_locked"
	set_items = list(
		/obj/item/grenade/stingbang,
		/obj/item/grenade/stingbang,
		)

/datum/voucher_set/security/utility/justice_helmet
	name = "Helmet of Justice"
	description = "Crime fears the helmet of justice."
	icon = 'icons/obj/clothing/head/helmet.dmi'
	icon_state = "justice"
	set_items = list(
		/obj/item/clothing/mask/gas/sechailer/swat,
		/obj/item/clothing/head/helmet/toggleable/justice,
		)

/datum/voucher_set/security/utility/pinpointer_pairs
	name = "Pinpointer Pair"
	description = "A pair of handheld tracking devices that lock onto the other half of the matching pair."
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "pinpointer"
	set_items = list(
		/obj/item/storage/box/pinpointer_pairs,
		)

/datum/voucher_set/security/utility/laptop
	name = "Security Laptop"
	description = "A laptop pre-loaded with security software."
	icon = 'icons/obj/devices/modular_laptop.dmi'
	icon_state = "laptop-closed"
	set_items = list(
		/obj/item/modular_computer/laptop/preset/security,
	)

/obj/item/modular_computer/laptop/preset/security
	starting_programs = list(
		/datum/computer_file/program/chatclient,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/secureye,
	)
