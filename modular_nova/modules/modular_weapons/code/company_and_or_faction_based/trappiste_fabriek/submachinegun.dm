// .35 Sol P90-style PDW — Trappiste Frelon

/obj/item/gun/ballistic/automatic/sol_pdw
	name = "\improper Frelon Personal Defense Weapon"
	desc = "A compact bullpup PDW chambered in .35 Sol Short, fed from a translucent fifty-round magazine seated atop the receiver. \
		Popular with Sol Federation vehicle crews and tunnel-rats who need full-auto firepower without the bulk of a rifle."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "frelon"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "frelon"

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pdw
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_pdw

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = FALSE

	// Open-bolt SMG: Z cocks the bolt (matching the sindano), bolt isn't shown
	// as a visible overlay since the P90's bolt is internal in this view.
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE

	mag_display = FALSE

	burst_size = 1
	fire_delay = 0.15 SECONDS

	spread = 8
	recoil = 0

	lore_blurb = "The Frelon, marketed under Trappiste Fabriek's defensive-arms line as a complement to the Guêpe service pistol, \
		began life as an answer to a Sol Federation Navy tender for a 'tunnel weapon'; something compact enough for \
		shuttle decks and maintenance corridors, yet capable of sustained automatic fire against boarders in vacuum suits. \
		The result was a bullpup PDW chambered in the same .35 Sol Short cartridge used across the Federation's pistol line, \
		fed from an oversized polymer magazine seated horizontally atop the receiver. The translucent shell of that magazine \
		— a deliberate carryover from the Guêpe's marketing identity — lets the operator gauge remaining rounds at a glance, \
		a feature endlessly mocked by the more puritanical rifle-school instructors and endlessly cherished by everyone \
		who has ever fumbled a reload in the dark."

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
	. += "[icon_state]_mag_p90_50_[suffix]"

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

// Frelon (evil)

/obj/item/gun/ballistic/automatic/sol_pdw/evil
	desc = parent_type::desc + " This one is painted in a tacticool black."

	icon_state = "frelon_evil"
	inhand_icon_state = "frelon_evil"

/obj/item/gun/ballistic/automatic/sol_pdw/evil/no_mag
	spawnwithmagazine = FALSE
