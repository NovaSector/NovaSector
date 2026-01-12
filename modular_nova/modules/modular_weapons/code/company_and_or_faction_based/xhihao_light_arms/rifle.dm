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

	lore_blurb = "The Xhihao 'Rengo' rifle began as a box of parts and a set of instructions — a \"Sporterization Kit\" sold to frontier gunsmiths and \
		hobbyists looking to improve their aging Sakhno rifles. The philosophy was simple: don't try to reinvent the wheel, just give \
		it better bearings. <br><br> \
		The kit replaces the original furniture with a modern composite chassis featuring an integrated accessory rail, a more ergonomic pistol \
		grip, and a shortened barrel profile for better balance. The crown jewel of the conversion is the precision - machined magazine well adapter, \
		which allows the rifle to feed from common Lanca-pattern magazines. This not only increases capacity but also simplifies logistics, as \
		.310 Strilka ammunition is the most common high-powered cartridge available on the civilian market. <br><br> \
		The included scope, a modest magnification optic also compatible with the Lanca battle rifle, finally gives the Sakhno's accurate barrel \
		the sighting system it always deserved. The conversion is irreversible by design; the chassis components are too integrated to allow for sawing \
		off or reversion to the original stock, a small price to pay for turning a collection of \"sometimes useful\" antiques into a single, highly \
		capable modern precision platform."

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
