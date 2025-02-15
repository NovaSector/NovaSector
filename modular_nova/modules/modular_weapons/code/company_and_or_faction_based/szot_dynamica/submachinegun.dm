// Rapid firing submachinegun firing .27-54 Cesarzowa

/obj/item/gun/ballistic/automatic/miecz
	name = "\improper Miecz Submachine Gun"
	desc = "A short barrel, weapon riding the line between submachine gun, and a rifle. \
		Features an over-the-top carry handle, pre-threaded barrel, and magazine indicating sights. \
		Whatever the hell that means."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "miecz"

	inhand_icon_state = "c20r"
	worn_icon_state = "gun"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/miecz

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 0
	suppressor_y_offset = 0

	burst_size = 1
	fire_delay = 0.3 SECONDS
	actions_types = list()

	spread = 5

/obj/item/gun/ballistic/automatic/miecz/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/miecz/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/miecz/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/miecz/examine_more(mob/user)
	. = ..()

	. += "The Miecz is one of the staple weapons of the frontier, simple, effective, and based on \
		a figuratively 'tested' design, though you couldn't be sure which one that is. \
		Fires the .24-57 'pistol' caliber round, if only to dodge it's classification as a rifle. \
		Overall, it's decently accurate, lightweight, somehow still squeezes into your bag,  \
		and might feel a little more homely then the next gun over... or, atleast that's what the label says. \
		The Wood-Substitute material is known to have various side-effects, contact your local health department before use."

	return .

/obj/item/gun/ballistic/automatic/miecz/no_mag
	spawnwithmagazine = FALSE


/obj/item/gun/ballistic/automatic/napad
	name = "\improper 'Napad' Submachine Gun"
	desc = "A bulky submachine gun holding a close relation to the Zashchitnik pistol. Designated 'Napadayuschiy'. \
		It holds a notable fifty rounds of 10mm in the magazine."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "napad"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "napad"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "napad"

	special_mags = FALSE

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/napad

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/smg_heavy.ogg'
	fire_sound_volume = 80
	can_suppress = FALSE

	burst_size = 1
	fire_delay = 0.55 SECONDS
	actions_types = list()

	// This thing shoots faster then the Zashch, but the DPS and killing speed should not be that fast overall
	projectile_wound_bonus = -10
	projectile_damage_multiplier = 0.65
	spread = 6

/obj/item/gun/ballistic/automatic/napad/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/napad/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/napad/examine_more(mob/user)
	. = ..()

	. += "The Napadayuschiy was made for the inevitable situation of the Zashchitnik not being enough firepower \
		for the job. The Napadayuschiy sports a colossal magazine and a familiarly oversized stature to the Zashchitnik. \
		The massive magazine is a point of contention, being a stick magazine, it sticks far from the gun, \
		making it easy to catch on surfaces and door frames. Regardless, the weapon is reliable, \
		though if you do not place the charging handle into the loading notch before inserting a fresh magazine, \
		the spring pressure of the weapon's fully loaded magazine will make operating the charging handle require \
		a herculean feat of strength."

	return .

/obj/item/gun/ballistic/automatic/napad/no_mag
	spawnwithmagazine = FALSE
