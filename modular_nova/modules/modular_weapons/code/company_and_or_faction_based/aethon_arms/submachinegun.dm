/obj/item/gun/ballistic/automatic/mp5
	name = "\improper M-94 'Rapier' Submachinegun"
	desc = "An elegant automatic submachinegun with a reputation for the roguish and unsavory sort, this weapon is able to spit lead at an impressive cyclic rate, although it often leaves want for raw stopping power."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/scarborough_arms/submachinegun.dmi'
	icon_state = "placeholder"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "sindano"

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	burst_size = 1
	fire_delay = 0.25 SECONDS
	projectile_damage_multiplier = 0.8

/obj/item/gun/ballistic/automatic/mp5/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_AETHEON)
	lore_blurb = "Manufactured by the upstart Aethon Arms Company, a subdivison of Hephaestus Heavy Industries, this is a ressurection of an old Terran design \
		used by an absurd number of both state and non-state armed forces and paramilitary groups. In a bid to secure \
		a highly lucrative arms contract with Nanotrasen, Aethon Arms re-engineered the design around the 4.6x30mm caliber, \
		which was already in circulation and supply networds due to the outdated WT-550's formerly widespread use. While never adopted in any official capacity by Nanotrasen, \
		the design proved popular enough with individual sales to warrant its continued serial production on the restricted arms market.


/obj/item/gun/ballistic/automatic/mp5/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)
