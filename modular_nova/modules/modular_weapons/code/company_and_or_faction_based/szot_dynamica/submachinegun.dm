

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
