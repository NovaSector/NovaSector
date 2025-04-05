// SolFed shotgun (this was gonna be in a proprietary shotgun shell type outside of 12ga at some point, wild right?)

/obj/item/gun/ballistic/shotgun/riot/sol
	name = "\improper M64 Shotgun"
	desc = "A robust twelve-gauge shotgun with an eight-shell, top-mounted magazine tube. Made for and used by SolFed's various military and police forces."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "renoster"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "renoster"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "renoster"

	inhand_x_dimension = 32
	inhand_y_dimension = 32

	SET_BASE_PIXEL(-8, 0)

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/shotgun_heavy.ogg'
	rack_sound = 'modular_nova/modules/modular_weapons/sounds/shotgun_rack.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE
	rack_delay = 0.5 SECONDS
	fire_delay = 0.5 SECONDS // Turns out, this is actually pretty fairly balanced
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol
	suppressor_x_offset = 7
	suppressor_y_offset = -3

	lore_blurb = "The M64 was designed, at its core, as a police shotgun.<br><br>\
		As a consequence, it holds all the qualities a police force would want \
		in a shotgun; a large capacity, robust frame, and enough modularity \
		to satiate even the most overfunded of peacekeeper forces. \
		Inevitably, it made its way into civilian markets, \
		alongside its sale to several military branches that also \
		saw value in having a heavy shotgun."

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/gun/ballistic/shotgun/riot/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/shotgun/riot/sol/update_appearance(updates)
	if(sawn_off)
		suppressor_x_offset = 0
		SET_BASE_PIXEL(0, 0)

	. = ..()

/obj/item/ammo_box/magazine/internal/shot/sol
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	max_ammo = 8

/obj/item/gun/ballistic/shotgun/riot/sol/thunderdome
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol/thunderdome

/obj/item/ammo_box/magazine/internal/shot/sol/thunderdome
	ammo_type = /obj/item/ammo_casing/shotgun/beehive

// Shotgun but EVIL!

/obj/item/gun/ballistic/shotgun/riot/sol/evil
	desc = parent_type::desc + "This one is painted in a tacticool black."

	icon_state = "renoster_evil"
	worn_icon_state = "renoster_evil"
	inhand_icon_state = "renoster_evil"

/obj/item/gun/ballistic/shotgun/riot/sol/evil/thunderdome
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol/thunderdome/evil

/obj/item/ammo_box/magazine/internal/shot/sol/thunderdome/evil
	ammo_type = /obj/item/ammo_casing/shotgun/flechette_nova
