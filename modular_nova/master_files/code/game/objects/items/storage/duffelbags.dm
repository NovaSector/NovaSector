/obj/item/storage/backpack/duffelbag/syndie
	name = "tactical duffel bag"
	desc = "A large duffel bag for holding extra tactical supplies."
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "This duffel bag has the Syndicate logo stiched on the inside. It appears to be made from lighter yet sturdier materials, and features an oiled plastitanium zipper for maximum speed tactical zipping."

/obj/item/storage/backpack/duffelbag/syndie/surgery
	name = "surgery duffel bag"
	desc = "A large duffel bag for holding extra supplies - this one has a material inlay with space for various sharp-looking tools."
	icon_state = "duffel-syndiemed"
	inhand_icon_state = "duffel-syndiemed"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "This duffel bag has the Syndicate logo stiched on the inside. It appears to be made from lighter yet sturdier materials."

/obj/item/storage/backpack/duffelbag/mining_conscript/PopulateContents()
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/clothing/suit/hooded/seva(src)
	new /obj/item/clothing/mask/gas/seva(src)
	new /obj/item/gun/energy/recharge/kinetic_accelerator(src)
	new /obj/item/knife/combat/survival(src)
	new /obj/item/flashlight/seclite(src)
