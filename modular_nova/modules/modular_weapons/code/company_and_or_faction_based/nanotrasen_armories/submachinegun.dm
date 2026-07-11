/*
The Nanotrasen Armories NT20, a revamped (nerfed) variant of the C20-r for the Blueshield's personal (and hopefully exclusive) use.
If you're thinking of putting this in Company Imports: don't. Stop! We've been through this once already with the CMG.
This is a Blueshield weapon. It's for the Blueshield. If this ends up in Cargo I'll haunt you. Thaaaanks!
*/

/obj/item/gun/ballistic/automatic/nt20
	name = "\improper NT20 Submachine Gun"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/ballistic.dmi'
	desc = "A sleek, select-fire SMG chambered in the venerable 9mm cartridge. The Blueshield's favorite toy."
	icon_state = "nt20"
	inhand_icon_state = "c20r"
	selector_switch_icon = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/smg_nt20
	fire_delay = 1.5
	burst_size = 2 // 30 damage a burst at 1.5s delay is about 3.5s
	pin = /obj/item/firing_pin
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	projectile_damage_multiplier = 0.75
	spread = 6

	lore_blurb = "The Nanotrasen Armories NT20 is a recent release from NT's esteemed private arms division, \
		and it's received a warm welcome from the Shield teams and other NT armed forces who have been \
		issued it in its ongoing rollout.<br>\
		<br>\
		Though certain rival manufacturers have dismissed the NT20 as a \"fake\" or a \"blatant bootleg,\" \
		the venerable 9mm round and a patent-pending multi-stage delayed blowback system \
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

/obj/item/gun/ballistic/automatic/nt20/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/ammo_box/magazine/smg_nt20
	name = "\improper NT20 magazine (9mm)"
	desc = "A long 9mm magazine, suitable for the NT20 SMG. Just geometrically different enough to not fit in other similar bullpup submachine guns."
	icon_state = /obj/item/ammo_box/magazine/smgm45::icon_state
	base_icon_state = /obj/item/ammo_box/magazine/smgm45::base_icon_state
	ammo_band_icon = /obj/item/ammo_box/magazine/smgm45::ammo_band_icon
	ammo_band_color = /obj/item/ammo_box/magazine/smgm45::ammo_band_color
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 24

/obj/item/ammo_box/magazine/smg_nt20/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_box/magazine/smg_nt20/empty
	start_empty = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/storage/toolbox/guncase/nova/ntspecial/nt20
	name = "\improper Nanotrasen Armories \"NT20\" gunset"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/nt20
	extra_to_spawn = /obj/item/ammo_box/magazine/smg_nt20

/obj/item/storage/toolbox/guncase/nova/ntspecial/nt20/PopulateContents()
	. = ..()
	new /obj/item/crafting_conversion_kit/reclaimer_reverse(src)

/obj/item/gun/ballistic/automatic/nt20/empty
	spawnwithmagazine = FALSE
