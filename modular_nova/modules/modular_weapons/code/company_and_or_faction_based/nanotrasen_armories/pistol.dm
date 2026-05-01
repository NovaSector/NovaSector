/obj/item/gun/ballistic/rifle/c96
	name = "\improper NT M-96" //needed to be a rifle subtype to use bolt action code for internal magazine and all sorts of extra things
	desc = "An antiquated design revived due to its long-expired patent and interest from collectors of the original, although this model comes in at a fraction of the price as the real deal. Still pricey, however, due to its complicated construction."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/ballistic.dmi'
	icon_state = "mauser"
	inhand_icon_state = "gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	worn_icon_state = "gun"
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/bay_gunshot_magnum.ogg'
	fire_sound_volume = 80

	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/c96
	can_suppress = FALSE
	casing_ejector = TRUE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_LOCKING
	need_bolt_lock_to_interact = TRUE
	weapon_weight = WEAPON_MEDIUM
	semi_auto = TRUE
	fire_delay = 0.45 SECONDS
	projectile_damage_multiplier = 0.7 //crew gun using what's typically an antag round, this is more than warranted, maybe even will go lower after testing
	spread = 5 //maybe needs to go lower in the future, we shall see
/obj/item/gun/ballistic/rifle/c96/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)
