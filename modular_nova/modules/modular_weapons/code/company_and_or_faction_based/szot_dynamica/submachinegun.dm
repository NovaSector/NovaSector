

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

	lore_blurb = "The Napadayuschiy is what happens when you take the Zashchitnik pistol's design principles and feed them a steady diet of \
		growth hormones and poor life choices. It is the Zashch's bigger, uglier, and even less refined older sibling, chambered for the same \
		ubiquitous 10mm Auto and built from the same philosophy of using sheet steel as a primary architectural component. <br><br> \
		The colossal 50-round magazine was a solution in search of a problem, offering staggering firepower at the cost of making the \
		weapon a logistical nightmare. The magazine's simple, angular construction ensures it snags on every doorframe, equipment webbing, \
		and stray thought its user might have. A notorious quirk in the manual of arms requires the charging handle to be locked in a specific \
		loading notch before inserting a fresh magazine; failure to do so means the spring pressure of fifty rounds makes racking the slide a \
		feat of strength typically associated with loading capital ship railguns. <br><br> \
		It is the weapon of choice for budget-conscious militias, underworld enforcers who prioritize intimidation over finesse, and \
		security details who are more concerned with the upfront cost on a spreadsheet than the long-term chiropractic bills of their personnel. \
		It is a blunt instrument that fires smaller blunt instruments, a testament to the fact that sometimes, the cheapest solution is also the \
		heaviest, most cumbersome, and profoundly un-ergonomic one. It gets the job done, provided the job is \"making a lot of noise and being \
		very difficult to lose.\""

/obj/item/gun/ballistic/automatic/napad/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/napad/no_mag
	spawnwithmagazine = FALSE
