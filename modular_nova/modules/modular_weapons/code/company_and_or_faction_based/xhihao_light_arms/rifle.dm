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

/obj/item/gun/ballistic/rifle/sporterized/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/rifle/sporterized/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 35, offset_y = 12)

/obj/item/gun/ballistic/rifle/sporterized/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/rifle/sporterized/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/rifle/sporterized/examine_more(mob/user)
	. = ..()

	. += "The Xhihao 'Rengo' conversion rifle. Initially a set of chassis parts sold in a single kit by Xhihao Light Arms, \
		which can be swapped out with many of the outdated or simply old parts on a typical Sakhno rifle. \
		While not necessarily increasing performance in any way, the magazine is slightly longer. The weapon \
		is also overall a bit shorter, making it easier to handle for some people. Cannot be sawn off, cutting \
		really any part of this weapon off would make it non-functional."

	return .

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
