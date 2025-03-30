

/obj/item/gun/ballistic/automatic/napad
	name = "\improper 'Napad' Submachine Gun"
	desc = "A bulky, 10mm submachine gun with sizeable magazines holding a close relation to the Zashchitnik pistol. Designated 'Napadayuschiy'."

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

	lore_blurb = "<i>The 'Napadayuschiy' is a heavy sub-machine gun with a focus on reliability and a very large magazine size.<br><br>\
		Originally, it was designed for the inevitable situation of its sibling, the Zashchitnik handgun, \
		not bringing enough to bear for any given situation. \
		It sports a colossal magazine and a oversized stature familiar to the Zashchitnik. \
		However, the sheer size of the magazine is a point of contention; its simple, angular construction means \
		it sticks far from the gun, making it easy to catch on surfaces and door frames. \
		Regardless, the weapon is reliable, albeit with a small quirk regarding the manual of arms; \
		if the charging handle isn't placed into the loading notch before inserting a fresh magazine, \
		the spring pressure of fifty 10mm rounds will make operating the charging handle require \
		a herculean feat of strength.</i>"

/obj/item/gun/ballistic/automatic/napad/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/napad/no_mag
	spawnwithmagazine = FALSE
