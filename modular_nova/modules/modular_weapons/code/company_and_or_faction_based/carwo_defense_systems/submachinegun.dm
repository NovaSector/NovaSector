// Base Sol SMG

/obj/item/gun/ballistic/automatic/sol_smg
	name = "\improper Sindano Submachine Gun"
	desc = "A small submachine gun firing .35 Sol Short. Commonly seen in the hands of PMCs and other unsavory corpos. Accepts any standard Sol pistol magazine."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	icon_state = "sindano"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "sindano"

	special_mags = TRUE

	bolt_type = BOLT_TYPE_OPEN

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 11

	burst_size = 1
	fire_delay = 0.25 SECONDS

	spread = 7.5

	lore_blurb = "The Sindano submachinegun was originally produced for a military contract.<br><br>\
		Thanks to that, they could be found in the hands of any SolFed second-line force, \
		such as, but not limited to, medics, ship techs, and logistics officers. \
		Funnily enough, shuttle pilots often had several just to show off.<br><br>\
		Due to SolFed's quest to extend the lifespans of their logistics officers and quartermasters, \
		the Sindano uses the same standard pistol cartridge and magazines that most other SolFed military weapons of \
		small caliber do. This results in interchangeable magazines between pistols and submachine guns. Neat!"

/obj/item/gun/ballistic/automatic/sol_smg/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/sol_smg/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/sol_smg/no_mag
	spawnwithmagazine = FALSE

// Sindano (evil)

/obj/item/gun/ballistic/automatic/sol_smg/evil
	desc = parent_type::desc + " This one is painted in a tacticool black."

	icon_state = "sindano_evil"
	inhand_icon_state = "sindano_evil"

/obj/item/gun/ballistic/automatic/sol_smg/evil/no_mag
	spawnwithmagazine = FALSE

// .27-54 PDW — Alacrán

/obj/item/gun/ballistic/automatic/sol_pdw
	name = "\improper Alacrán Personal Defense Weapon"
	desc = "A compact bullpup PDW chambered in .27-54 Cesarzowa, fed from a forty-eight-round magazine seated atop the receiver. \
		Popular with Sol Federation vehicle crews and tunnel-rats who need full-auto firepower without the bulk of a rifle."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	icon_state = "alacran"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "alacran"

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/alacran_pdw
	spawn_magazine_type = /obj/item/ammo_box/magazine/alacran_pdw

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/alacran_fire.ogg'
	can_suppress = TRUE

	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE

	// Custom per-state mag overlays are handled in update_overlays below.
	mag_display = FALSE

	suppressor_x_offset = 8

	burst_size = 1
	fire_delay = 0.17 SECONDS
	projectile_damage_multiplier = 0.66

	spread = 8
	recoil = 0

	/// Whether this Alacrán variant gets the automatic_fire component on init.
	/// The civilian carbine sets this to FALSE so it stays semi-only.
	var/has_autofire = TRUE

	lore_blurb = "The Alacrán, marketed under Carwo Defense Systems' defensive-arms line as a complement to the Sindano submachine gun, \
		began life as an answer to a Sol Federation Navy tender for a 'tunnel weapon'; something compact enough for \
		shuttle decks, vehicle crew and maintenance corridors, yet capable of sustained automatic fire against boarders in vacuum suits. \
		The result was a bullpup PDW chambered in .27-54 Cesarzowa, munition valued by its availability, and resilience.\
		Standard .35 was discarded due to its limited armor piercing capabilities, the finer tip and stronger charge of the HC alternative more suitable for the job. The shorter barrel causes some of the energy potential of the bullet to be lost along the way"

/obj/item/gun/ballistic/automatic/sol_pdw/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/sol_pdw/Initialize(mapload)
	. = ..()
	if(has_autofire)
		AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/sol_pdw/proc/get_ammo_suffix()
	if(!magazine || internal_magazine)
		return
	var/ratio = get_ammo() / magazine.max_ammo
	if(ratio >= 0.75)
		return "full"
	if(ratio >= 0.25)
		return "mid"
	if(ratio > 0)
		return "low"
	return "empty"

/obj/item/gun/ballistic/automatic/sol_pdw/update_overlays()
	. = ..()
	var/suffix = get_ammo_suffix()
	if(!suffix)
		return
	. += "[icon_state]_mag_[suffix]"

/obj/item/gun/ballistic/automatic/sol_pdw/update_icon_state()
	. = ..()
	// Pick the in-hand sprite variant based on whether a mag is inserted and
	// how full it is, so the held gun matches the world sprite's mag state.
	var/base_state = initial(icon_state)
	var/new_inhand
	if(!magazine || internal_magazine)
		new_inhand = base_state
	else
		var/suffix = get_ammo_suffix()
		new_inhand = "[base_state]_[suffix]"
	if(inhand_icon_state != new_inhand)
		inhand_icon_state = new_inhand
		// Force whichever mob is holding the gun to refresh its held-items
		// display, otherwise the inhand stays stale until the gun is dropped.
		if(ismob(loc))
			var/mob/holder = loc
			holder.update_held_items()

/obj/item/gun/ballistic/automatic/sol_pdw/no_mag
	spawnwithmagazine = FALSE

// Alacrán (evil)

/obj/item/gun/ballistic/automatic/sol_pdw/evil
	desc = parent_type::desc + " This one is painted in a tacticool black and appears to have been extensively modified to increase its performance to peak values. This is a weapon of war."

	projectile_damage_multiplier = 1
	icon_state = "alacran_evil"
	inhand_icon_state = "alacran_evil"

/obj/item/gun/ballistic/automatic/sol_pdw/evil/no_mag
	spawnwithmagazine = FALSE

// Civilian carbine — longer barrel, semi-automatic only.
/obj/item/gun/ballistic/automatic/sol_pdw/civil
	name = "\improper Alacrán Carbine"
	desc = "The civilian-market carbine variant of the Alacrán PDW, with a longer barrel, added weight to prevent one handed use and semi-automatic-only \
		operation to comply with Sol Federation civil arms regulations. Popular with shooting clubs and homesteaders \
		on the outer colonies. Still accepts the same forty-eight-round magazine as the military model."

	icon_state = "alacran_civil"
	inhand_icon_state = "alacran_civil"

	weapon_weight = WEAPON_HEAVY
	projectile_damage_multiplier = 0.9
	has_autofire = FALSE
	spread = 5
	fire_delay = 0.2 SECONDS

/obj/item/gun/ballistic/automatic/sol_pdw/civil/no_mag
	spawnwithmagazine = FALSE
