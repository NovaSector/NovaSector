/obj/item/gun/ballistic/shotgun/katyusha
	name = "\improper Катюша Shotgun"
	desc = "A 2-round burst fire, mag-fed shotgun for combat in narrow corridors, \
		nicknamed 'Kopfjäger' by the blueshields. Compatible only with specialized 16-shell drum magazines. \
		Reversed engineering of the syndicate's 'bulldog' dual mag shotgun."

	icon = 'modular_nova/modules/modular_weapons/code/company_and_or_faction_based/nanotrasen_armouries/ballistic48x.dmi'
	icon_state = "spikewall"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/nanotrasen_armouries/guns_worn.dmi'
	worn_icon_state = "spikewall"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/nanotrasen_armouries/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/nanotrasen_armouries/guns_righthand.dmi'
	inhand_icon_state = "spikewall"

	SET_BASE_PIXEL(-8, 0)

	inhand_x_dimension = 32
	inhand_y_dimension = 32
	obj_flags = UNIQUE_RENAME
	projectile_damage_multiplier = 1.2
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/katyusha
	spawn_magazine_type = /obj/item/ammo_box/magazine/katyusha/buckshot

	can_suppress = FALSE
	burst_size = 2
	fire_delay = 0.85 SECONDS // Bulldog Stat Original: fire_delay = 1

	fire_sound = 'modular_nova/master_files/sound/weapons/shotgun_nova.ogg' // Meatier shotgun sound
	actions_types = list(/datum/action/item_action/toggle_firemode)

	mag_display = TRUE
	empty_indicator = TRUE
	empty_alarm = TRUE
	casing_ejector = TRUE
	mag_display_ammo = FALSE
	semi_auto = TRUE
	internal_magazine = FALSE
	tac_reloads = TRUE
	burst_fire_selection = TRUE

/obj/item/gun/ballistic/shotgun/katyusha/examine_more(mob/user)
	. = ..()

	. += "The Nanotrasen Armories Katyusha Magfed Shotgun is a recent release from NT's esteemed private arms division, \
		and it's received a warm welcome from the Shield teams and other NT armed forces who have been \
		issued it in the ongoing rollout. \
		Though certain rival manufacturers have dismissed the Katyusha as a \"fake\" or a \"blatant bootleg,\"  \
		the inimitable burst fire and a patent-pending multi-stage delayed blowback system \
		make the Katyusha powerful, reliable, accurate, and shockingly comfortable to fire."

/obj/item/gun/ballistic/shotgun/katyusha/give_manufacturer_examine()
    AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/storage/toolbox/guncase/nova/katyusha
	name = "\improper Nanotrasen Armories \"katyusha\" gunset"
	weapon_to_spawn = /obj/item/gun/ballistic/shotgun/katyusha
	extra_to_spawn = /obj/item/ammo_box/magazine/katyusha/buckshot

/obj/item/gun/ballistic/shotgun/katyusha/Initialize(mapload)
	. = ..()
	update_appearance()


/obj/item/gun/ballistic/shotgun/katyusha/jager
	name = "\improper jäger Shotgun"
	desc = "A 2-round burst fire, mag-fed shotgun for combat in narrow corridors, \
		nicknamed 'jäger' by the blueshields. Compatible only with specialized 16-shell drum magazines. \
		Reversed engineering of the syndicate's 'bulldog' dual mag shotgun."

	icon_state = "marauder"
	worn_icon_state = "marauder"
	inhand_icon_state = "marauder"

	projectile_damage_multiplier = 1

	accepted_magazine_type = /obj/item/ammo_box/magazine/jager
	spawn_magazine_type = /obj/item/ammo_box/magazine/jager/rubbershot
	can_suppress = FALSE
