// Backpacks

/obj/item/storage/backpack/industrial/frontier_colonist
	name = "frontier backpack"
	desc = "A rugged backpack often used by settlers and explorers. It's fireproof."
	icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "backpack"
	worn_icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "backpack"
	inhand_icon_state = "backpack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/industrial/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/item/storage/backpack/industrial/frontier_colonist/satchel
	name = "frontier satchel"
	desc = "A rugged satchel often used by settlers and explorers. It's fireproof."
	icon_state = "satchel"
	worn_icon_state = "satchel"

/obj/item/storage/backpack/industrial/frontier_colonist/messenger
	name = "frontier messenger bag"
	desc = "A rugged messenger bag often used by settlers and explorers. It's fireproof."
	icon_state = "messenger"
	worn_icon_state = "messenger"

// Belts

/obj/item/storage/belt/utility/frontier_colonist
	name = "frontier chest rig"
	desc = "A versatile chest rig with pockets to store really whatever you could think of within. \
		That is, if whatever you could think of is within the realms of a utility belt. Fashion like this \
		comes at a price you know!"
	icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "harness"
	worn_icon = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_nova/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "harness"
	inhand_icon_state = null
	resistance_flags = FIRE_PROOF
	storage_type = /datum/storage/loadout_belt

/obj/item/storage/belt/utility/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)
