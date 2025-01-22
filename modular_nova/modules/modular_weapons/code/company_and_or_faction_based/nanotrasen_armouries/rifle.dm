/* The Nanotrasen Armouries NT20, a revamped (nerfed) variant of the C20-r for the Blueshield's personal (and hopefully exclusive) use.
If you're thinking of putting this in Company Imports: don't. Stop! We've been through this once already with the CMG.
This is a Blueshield weapon. It's for the Blueshield. If this ends up in Cargo I'll haunt you. Thaaaanks! */

/obj/item/gun/ballistic/automatic/nt20
	name = "\improper NT20 Submachine Gun"
	icon = 'modular_nova/modules/modular_weapons/code/company_and_or_faction_based/nanotrasen_armouries/ballistic.dmi'
	desc = "A sleek, select-fire SMG chambered in the imposing .460 Ceres cartridge. The Blueshield's favorite toy."
	icon_state = "nt20"
	inhand_icon_state = "c20r"
	selector_switch_icon = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm45
	fire_delay = 1.6
	burst_size = 3
	pin = /obj/item/firing_pin
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	projectile_damage_multiplier = 0.75
	spread = 6

/obj/item/gun/ballistic/automatic/nt20/examine_more(mob/user)
	. = ..()

	. += "The Nanotrasen Armories NT20 is a recent release from NT's esteemed private arms division, \
		and it's received a warm welcome from the Shield teams and other NT armed forces who have been \
		issued it in the ongoing rollout. \
		Though certain rival manufacturers have dismissed the NT20 as a \"fake\" or a \"blatant bootleg,\"  \
		the inimitable .460 Ceres round and a patent-pending multi-stage delayed blowback system \
		make the NT20 powerful, reliable, accurate, and shockingly comfortable to fire."

/obj/item/gun/ballistic/automatic/nt20/give_manufacturer_examine()
    AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/nt20/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 12)

/obj/item/gun/ballistic/automatic/nt20/update_overlays()
	. = ..()
	if(!chambered && empty_indicator) //this is duplicated due to a layering issue with the select fire icon.
		. += "[icon_state]_empty"

/obj/item/storage/toolbox/guncase/nova/nt20
	name = "\improper Nanotrasen Armories \"NT20\" gunset"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/nt20
	extra_to_spawn = /obj/item/ammo_box/magazine/smgm45

/obj/item/gun/ballistic/automatic/nt20/Initialize(mapload)
	. = ..()
	update_appearance()
