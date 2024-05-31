// Suppressed rifles firing 12mm sub-sonics, funny

/obj/item/gun/ballistic/automatic/suppressed_rifle
	name = "\improper Yari suppressed rifle"
	desc = "A special rifle firing 12mm Chinmoku out of an integrally suppressed barrel. Uses Chinmoku magazines."

	icon = 'modular_np_lethal/lethalguns/icons/guns48x.dmi'
	icon_state = "yari"

	worn_icon = 'modular_np_lethal/lethalguns/icons/mob_sprites/worn.dmi'
	worn_icon_state = "evilgun"

	lefthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/lefthand.dmi'
	righthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/righthand.dmi'
	inhand_icon_state = "evilgun"

	SET_BASE_PIXEL(-8, 0)

	special_mags = TRUE

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/c12chinmoku
	spawn_magazine_type = /obj/item/ammo_box/magazine/c12chinmoku/standard

	load_sound = 'modular_np_lethal/lethalguns/sound/yari/yari_magin.wav'
	rack_sound = 'modular_np_lethal/lethalguns/sound/yari/yari_rack.wav'
	fire_sound = 'modular_np_lethal/lethalguns/sound/yari/yari.wav'
	suppressed_sound = 'modular_np_lethal/lethalguns/sound/yari/yari.wav'
	can_suppress = TRUE
	can_unsuppress = FALSE

	pickup_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_mediumgun.wav'
	drop_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_mediumgun.wav'

	can_bayonet = FALSE

	burst_size = 1
	fire_delay = 0.3 SECONDS
	actions_types = list()
	spread = 7.5

/obj/item/gun/ballistic/automatic/suppressed_rifle/Initialize(mapload)
	. = ..()

	var/obj/item/suppressor/new_suppressor = new(src)
	install_suppressor(new_suppressor)

	give_autofire()

/// Separate proc for handling auto fire just because one of these subtypes isn't otomatica
/obj/item/gun/ballistic/automatic/suppressed_rifle/proc/give_autofire()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/suppressed_rifle/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/automatic/suppressed_rifle/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/suppressed_rifle/examine_more(mob/user)
	. = ..()

	. += "The Yari rifles were made for special forces units that needed the power of the standard Solfed \
		rifle selection, but needed a little more nuance to their operations. These weapons sport a barrel \
		with a suppressor built in, as well as a tacticool black paint scheme to be terrible in every environment. \
		Rather than firing the baseline .40 sol long cartridges, a modified variant was created to be both \
		sub-sonic and more powerful at extremely short ranges where these operations would be taking place."

	return .

/obj/item/gun/ballistic/automatic/suppressed_rifle/starts_empty
	spawnwithmagazine = FALSE

// The above rifle but with an underbarrel .980 grenade launcher

/obj/item/gun/ballistic/automatic/suppressed_rifle/grenade_launcher
	name = "\improper Gureibu-GL suppressed rifle"
	desc = "A special rifle firing 12mm Chinmoku out of an integrally suppressed barrel. Uses Chinmoku magazines. \
		This is a version of the Yari rifle that comes with an attached grenade launcher fit for .980 Tydhouer grenades."

	icon_state = "gureibu"

	spawn_magazine_type = /obj/item/ammo_box/magazine/c12chinmoku
	spread = 10

	/// The stored under-barrel grenade launcher for this weapon
	var/obj/item/gun/ballistic/revolver/grenadelauncher/tydhouer/underbarrel

/obj/item/gun/ballistic/automatic/suppressed_rifle/grenade_launcher/Initialize(mapload)
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/tydhouer(src)

/obj/item/gun/ballistic/automatic/suppressed_rifle/grenade_launcher/Destroy()
	QDEL_NULL(underbarrel)
	return ..()

/obj/item/gun/ballistic/automatic/suppressed_rifle/grenade_launcher/afterattack_secondary(atom/target, mob/living/user, proximity_flag, click_parameters)
	underbarrel.afterattack(target, user, proximity_flag, click_parameters)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/gun/ballistic/automatic/suppressed_rifle/grenade_launcher/attackby(obj/item/attacking, mob/user, params)
	if(isammocasing(attacking))
		var/obj/item/ammo_casing/attacking_casing = attacking
		if(attacking_casing.caliber == underbarrel.magazine.caliber)
			underbarrel.attack_self(user)
			underbarrel.attackby(attacking, user, params)
	else if(isammobox(attacking))
		var/obj/item/ammo_box/attacking_box = attacking
		if(attacking_box.caliber == underbarrel.magazine.caliber)
			underbarrel.attack_self(user)
			underbarrel.attackby(attacking, user, params)
		else
			..()
	else
		..()

/obj/item/gun/ballistic/automatic/suppressed_rifle/grenade_launcher/starts_empty
	spawnwithmagazine = FALSE

// Grenade launcher for holding .980 grenades in for the rifle

/obj/item/gun/ballistic/revolver/grenadelauncher/tydhouer
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/grenadelauncher/c980grenade
	pin = /obj/item/firing_pin

/obj/item/ammo_box/magazine/internal/grenadelauncher/c980grenade
	name = "grenade launcher internal magazine"
	ammo_type = /obj/item/ammo_casing/c980grenade
	caliber = CALIBER_980TYDHOUER
	start_empty = TRUE

// Variant of the suppressed rifle with a scope and perfect accuracy, also no automatic

/obj/item/gun/ballistic/automatic/suppressed_rifle/marksman
	name = "\improper Ransu suppressed marksman rifle"
	desc = "A special rifle firing 12mm Chinmoku out of an integrally suppressed barrel. Uses Chinmoku magazines. \
		This one is mounted with a scope and other furniture to support more long range action. Automatic fire \
		capability was removed and instead replaced with an optional three-round burst mode."

	icon_state = "ransu"

	spawn_magazine_type = /obj/item/ammo_box/magazine/c12chinmoku

	load_sound = 'modular_np_lethal/lethalguns/sound/yari/yari_magin.wav'
	rack_sound = 'modular_np_lethal/lethalguns/sound/ransu/ransu_rack.wav'
	fire_sound = 'modular_np_lethal/lethalguns/sound/ransu/ransu.wav'
	suppressed_sound = 'modular_np_lethal/lethalguns/sound/ransu/ransu.wav'
	can_suppress = TRUE
	can_unsuppress = FALSE

	can_bayonet = FALSE

	fire_delay = 0.5 SECONDS
	spread = 0

	projectile_damage_multiplier = 1.5
	recoil = 0.5

/obj/item/gun/ballistic/automatic/suppressed_rifle/marksman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/suppressed_rifle/marksman/give_autofire()
	return

/obj/item/gun/ballistic/automatic/suppressed_rifle/marksman/starts_empty
	spawnwithmagazine = FALSE
