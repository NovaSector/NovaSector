/obj/item/gun/ballistic/automatic/type213
	name = "\improper Type 213 Kinetic Submachine Gun"
	desc = "A completely nonlethal longarm used by Sol Fed Peacekeeping forces. It uses kinetic rounds to temporarily disable adversaries. Made as a companion to the Type 207 Kinetic Pistol."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/bolt_fabrications/type213.dmi'
	icon_state = "type213"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/bolt_fabrications/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/bolt_fabrications/guns_righthand.dmi'
	inhand_icon_state = "type213"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/kineticballsbig
	can_suppress = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.3 SECONDS
	burst_size = 3
	spread = 12
	fire_sound = 'sound/effects/pop_expl.ogg'
	rack_sound = 'sound/items/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/pistol/slide_drop.ogg'
	fire_sound_volume = 80
	custom_premium_price = PAYCHECK_COMMAND * 6

/obj/item/gun/ballistic/automatic/pistol/type207/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BOLT)
