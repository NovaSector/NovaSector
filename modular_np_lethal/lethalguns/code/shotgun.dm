// Giant evil 6 gauge shotgun for blowing people to the nearest planet with

/obj/item/gun/ballistic/shotgun/ramu
	name = "\improper Ramu 6ga Shotgun"
	desc = "A six gauge monster-sized shotgun with a capacity of four total shells, including one in the chamber."

	icon = 'modular_np_lethal/lethalguns/icons/guns48x.dmi'
	icon_state = "ramu"

	worn_icon = 'modular_np_lethal/lethalguns/icons/mob_sprites/worn.dmi'
	worn_icon_state = "ramu"

	lefthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/lefthand.dmi'
	righthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/righthand.dmi'
	inhand_icon_state = "ramu"

	inhand_x_dimension = 32
	inhand_y_dimension = 32

	SET_BASE_PIXEL(-8, 0)

	load_sound = 'modular_np_lethal/lethalguns/sound/ramu/ramu_load.wav'
	fire_sound = 'modular_np_lethal/lethalguns/sound/ramu/ramu.wav'
	rack_sound = 'modular_np_lethal/lethalguns/sound/ramu/ramu_pump.wav'
	suppressed_sound = 'modular_np_lethal/lethalguns/sound/ramu/ramu_silenced.wav'
	can_suppress = TRUE
	can_unsuppress = TRUE

	pickup_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_heavygun.wav'
	drop_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_heavygun.wav'

	suppressor_x_offset = 12
	can_bayonet = FALSE
	can_be_sawn_off = FALSE

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	recoil = 2

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/s6gauge

/obj/item/gun/ballistic/shotgun/ramu/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/shotgun/ramu/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/shotgun/ramu/examine_more(mob/user)
	. = ..()

	. += "The Ramu was the marsian solution to a uniquely marsian problem. \
		As most of the planet's residents are either heavily biomodded, or \
		heavily robomodded, police forces on the planet were finding difficulty \
		dealing with many of the criminals using conventional weapons. Rather than \
		make something reasonable, some chief of peacekeeping came up with the idea \
		to simply make the shotguns they were using for riot suppression bigger."

	return .

/obj/item/gun/ballistic/shotgun/ramu/starts_empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/s6gauge/starts_empty

// Drum fed semi-automatic shotgun firing 12ga

/obj/item/gun/ballistic/automatic/nomi_shotgun
	name = "\improper Nomi repeating shotgun"
	desc = "A semi-automatic shotgun that fires 12ga out of a ten shell drum."

	icon = 'modular_np_lethal/lethalguns/icons/guns48x.dmi'
	icon_state = "nomi"

	worn_icon = 'modular_np_lethal/lethalguns/icons/mob_sprites/worn.dmi'
	worn_icon_state = "evilgun"

	lefthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/lefthand.dmi'
	righthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/righthand.dmi'
	inhand_icon_state = "evilgun"

	SET_BASE_PIXEL(-8, 0)

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/c12nomi

	load_sound = 'modular_np_lethal/lethalguns/sound/nomi/nomi_magin.ogg'
	rack_sound = 'modular_np_lethal/lethalguns/sound/nomi/nomi_rack.wav'
	fire_sound = 'modular_np_lethal/lethalguns/sound/nomi/nomi.wav'

	pickup_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_mediumgun.wav'
	drop_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_mediumgun.wav'

	can_bayonet = FALSE

	burst_size = 2
	fire_delay = 0.5 SECONDS

	projectile_wound_bonus = -10
	recoil = 0.5

/obj/item/gun/ballistic/automatic/nomi_shotgun/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/automatic/nomi_shotgun/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/nomi_shotgun/examine_more(mob/user)
	. = ..()

	. += "The Nomi was purpose made for Solfed police operations, who wanted not just a shotgun, \
		but a shotgun that could clear an entire room in as short a time as possible. \
		The solution was to simply make a rifle that fired shotgun shells, an elegant(?) solution \
		to a not-so-elegant problem."

	return .

/obj/item/gun/ballistic/automatic/nomi_shotgun/starts_empty
	spawnwithmagazine = FALSE
