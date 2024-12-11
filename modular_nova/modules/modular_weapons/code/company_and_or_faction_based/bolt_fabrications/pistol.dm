/obj/item/gun/ballistic/automatic/pistol/type207
	name = "\improper Type 207 Kinetic Pistol"
	desc = "A completly non lethal sidearm used by Sol Fed Peacekeeping forces. It uses kinetic rounds to temporarily disable adversaries, it's also a popular weapon for trick shot competitions."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/bolt_fabrications/type207.dmi'
	icon_state = "type207"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/bolt_fabrications/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/bolt_fabrications/guns_righthand.dmi'
	inhand_icon_state = "type207"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/kineticballs
	can_suppress = FALSE
	fire_delay = 0.3 SECONDS
	fire_sound = 'sound/effects/pop_expl.ogg'
	rack_sound = 'sound/items/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/pistol/slide_drop.ogg'
	fire_sound_volume = 70
	custom_premium_price = PAYCHECK_COMMAND * 5

/obj/item/gun/ballistic/automatic/pistol/type207/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BOLT)

/obj/item/gun/ballistic/automatic/pistol/type207/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)
