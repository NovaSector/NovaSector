/obj/item/gun/ballistic/shotgun/katyusha
	name = "\improper Katyusha Shotgun"
	desc = "A mag-fed shotgun for combat in narrow corridors, \
		nicknamed 'Katyusha' by the blueshields for its versatility. Compatible only with specialized 16-shell drum magazines."

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
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/katyusha
	spawn_magazine_type = /obj/item/ammo_box/magazine/katyusha/buckshot

	can_suppress = FALSE
	fire_delay = 0.55 SECONDS
	fire_sound = 'modular_nova/master_files/sound/weapons/shotgun_nova.ogg' // Meatier shotgun sound

	mag_display = TRUE
	empty_indicator = TRUE
	empty_alarm = TRUE
	casing_ejector = TRUE
	mag_display_ammo = FALSE
	semi_auto = TRUE
	internal_magazine = FALSE
	tac_reloads = TRUE

	lore_blurb =  "The Nanotrasen Armories Katyusha Magfed Shotgun is a recent release from NT's esteemed private arms division, \
		and it's received a warm welcome from the Shield teams and other NT armed forces who have been \
		issued it in the ongoing rollout. \
		Though certain rival manufacturers have dismissed the Katyusha as a \"fake\" or a \"blatant bootleg,\"  \
		the inimitable firepower and a patent-pending multi-stage delayed blowback system \
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
	name = "\improper Jäger Shotgun"
	desc = "A mag-fed shotgun for combat in narrow corridors, \
		nicknamed 'Jäger' by the Solar Federation Marines for its versatility in clearing tight corridors, and special operations in hunting individuals."

	icon_state = "marauder"
	worn_icon_state = "marauder"
	inhand_icon_state = "marauder"

	accepted_magazine_type = /obj/item/ammo_box/magazine/jager
	spawn_magazine_type = /obj/item/ammo_box/magazine/jager/rubbershot
	lore_blurb = "The Solar Federation Surplus 'Jäger' Magfed Shotgun is a recent release from Solar Federation Surplus. \
		and it's received a warm welcome from the Solar Federation Marines and S.W.A.T. Teams. \
		issued it in the ongoing rollout. \
		the inimitable firepower and multi-shell compatibility \
		makes the Jäger powerful, reliable, accurate, and shockingly comfortable to fire."

/obj/item/gun/ballistic/shotgun/katyusha/jager/give_manufacturer_examine()
    AddElement(/datum/element/manufacturer_examine, COMPANY_SOLFED)
