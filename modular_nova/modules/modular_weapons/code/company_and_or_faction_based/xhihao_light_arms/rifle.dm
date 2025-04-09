/*
*	QM Sporter Rifle
*/

/obj/item/gun/ballistic/rifle/sporterized
	name = "\improper Rengo Precision Rifle"
	desc = "A heavily modified Sakhno rifle, with parts made by Xhihao light arms based around Jupiter herself. \
		Has a chassis that takes Lanca magazines in lieu of an internal magazine, leading to a higher capacity."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/guns40x.dmi'
	icon_state = "rengo"
	worn_icon_state = "enchanted_rifle" // Not actually magical looking, just looks closest to this one
	inhand_icon_state = "sakhno"
	slot_flags = ITEM_SLOT_BACK
	SET_BASE_PIXEL(-8, 0)
	accepted_magazine_type = /obj/item/ammo_box/magazine/lanca
	mag_display = TRUE
	tac_reloads = TRUE
	internal_magazine = FALSE
	can_be_sawn_off = FALSE
	weapon_weight = WEAPON_HEAVY

	lore_blurb = "<i>The Xhihao 'Rengo' rifle is a conversion of the venerable Sakhno Precision Rifle, \
		with \"modern\" features such as an accessory rail and detachable magazines.<br><br>\
		Initially a set of chassis parts sold in a single kit by Xhihao Light Arms, \
		the 'Rengo' kit is designed to replace much of the furniture on a typical Sakhno \
		in order to improve the ergonomics, reduce the weight, and overall improve the end-user experience. \
		While not necessarily increasing performance in any way, the magazine's cross-compatibility with Lanca magazines \
		allows for greater capacity than the five-round internal magazines that come standard with Sakhnos, and the \
		scope included with the kit, originally for use with the Lanca, is quite usable thanks to the shared chambering. \
		The weapon is also overall a bit shorter, making it easier to handle for smaller shooters and/or \
		in uncomfortably close quarters for a precision weapon. \
		Due to the reduced space between components, the Rengo cannot be sawn off; \
		cutting... any part of this weapon off, really, would make it either hazardous to fire or non-functional.</i>"

/obj/item/gun/ballistic/rifle/sporterized/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/rifle/sporterized/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 35, offset_y = 12)

/obj/item/gun/ballistic/rifle/sporterized/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/rifle/sporterized/empty
	bolt_locked = TRUE // so the bolt starts visibly open
	spawn_magazine_type = /obj/item/ammo_box/magazine/lanca/spawns_empty

/*
*	Box that contains Sakhno rifles, but less soviet union since we don't have one of those
*/

/obj/item/storage/toolbox/guncase/soviet/sakhno
	desc = "A weapon's case. This one is green and looks pretty old, but is otherwise in decent condition."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/cases.dmi'
	material_flags = NONE // ????? Why do these have materials enabled??
