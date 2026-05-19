// .35 PDW — Trappiste Alacrán

/obj/item/gun/ballistic/automatic/sol_pdw
	name = "\improper Alacrán Personal Defense Weapon"
	desc = "A compact bullpup PDW chambered in .35 Sol Short, fed from a forty-eight-round magazine seated atop the receiver. \
		Popular with Sol Federation vehicle crews and tunnel-rats who need full-auto firepower without the bulk of a rifle."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "alacran"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "alacran"

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_alacran
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_alacran

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/alacran_fire.ogg'
	can_suppress = TRUE

	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE

	// Custom per-state mag overlays are handled in update_overlays below.
	// Disable the parent's auto-added `[icon_state]_mag` so it doesn't try to
	// fetch a non-existent `alacran_mag` icon state.
	mag_display = FALSE

	suppressor_x_offset = 8

	burst_size = 1
	fire_delay = 0.20 SECONDS

	spread = 8
	recoil = 0

	lore_blurb = "The Alacrán, marketed under Trappiste Fabriek's defensive-arms line as a complement to the Guêpe service pistol, \
		began life as an answer to a Sol Federation Navy tender for a 'tunnel weapon'; something compact enough for \
		shuttle decks and maintenance corridors, yet capable of sustained automatic fire against boarders in vacuum suits. \
		The result was a bullpup PDW chambered in the same .35 Sol Short cartridge used across the Federation's pistol line, \
		fed from a high capacity oversized polymer magazine seated horizontally atop the receiver."

/obj/item/gun/ballistic/automatic/sol_pdw/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/automatic/sol_pdw/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/sol_pdw/update_overlays()
	. = ..()
	if(!magazine || internal_magazine)
		return
	var/ratio = get_ammo() / magazine.max_ammo
	var/suffix
	if(ratio >= 0.75)
		suffix = "full"
	else if(ratio >= 0.25)
		suffix = "mid"
	else if(ratio > 0)
		suffix = "low"
	else
		suffix = "empty"
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
		var/ratio = get_ammo() / magazine.max_ammo
		var/suffix
		if(ratio >= 0.75)
			suffix = "full"
		else if(ratio >= 0.25)
			suffix = "mid"
		else if(ratio > 0)
			suffix = "low"
		else
			suffix = "empty"
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
	desc = parent_type::desc + " This one is painted in a tacticool black."

	icon_state = "alacran_evil"
	inhand_icon_state = "alacran_evil"

/obj/item/gun/ballistic/automatic/sol_pdw/evil/no_mag
	spawnwithmagazine = FALSE

// Uplink gun case — evil Alacrán + three full 48-round magazines.
/obj/item/storage/toolbox/guncase/nova/pistol/opfor/alacran/PopulateContents()
	new /obj/item/gun/ballistic/automatic/sol_pdw/evil(src)
	new /obj/item/ammo_box/magazine/c35sol_alacran(src)
	new /obj/item/ammo_box/magazine/c35sol_alacran(src)
	new /obj/item/ammo_box/magazine/c35sol_alacran(src)
