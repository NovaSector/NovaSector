/obj/item/gun/energy/taser/crank
	name = "\improper Mírotvůrce personal pacifier"
	desc = "A low-capacity, electrode-based taser, outfitted with an efficient dynamo machine to replenish its charge. \
		Utilised first as a means of first line of defense among colonial militiamen, now outclassed by more modern variations; \
		thus, resold in the civilian market as a cheap way of deterring assistants. Or was it 'assailants'?"
	icon = 'modular_nova/modules/novaya_ert/icons/taser.dmi'
	icon_state = "crank_taser"
	lefthand_file = 'modular_nova/modules/novaya_ert/icons/taser_left.dmi'
	righthand_file = 'modular_nova/modules/novaya_ert/icons/taser_right.dmi'
	fire_delay = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/crank_taser)
	cell_type = /obj/item/stock_parts/power_store/cell/crank_taser
	ammo_x_offset = 2
	charge_sections = 3

/obj/item/ammo_casing/energy/electrode/crank_taser
	projectile_type = /obj/projectile/energy/electrode/crank_taser

/obj/projectile/energy/electrode/crank_taser
	tase_stamina = 15

/obj/item/stock_parts/power_store/cell/crank_taser
	name = "\improper Mírotvůrce power cell"
	maxcharge = STANDARD_CELL_CHARGE * 0.4

/obj/item/gun/energy/taser/crank/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = STANDARD_CELL_CHARGE*0.05, \
		cooldown_time = 1 SECONDS, \
		charge_sound = 'modular_nova/modules/new_cells/sound/crank.ogg', \
		charge_sound_cooldown_time = 0.8 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

/obj/item/gun/energy/taser/crank/fire_sounds()
	if(suppressed)
		playsound(src, fire_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, fire_sound, fire_sound_volume, vary_fire_sound)

/obj/item/gun/energy/taser/crank/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/gun/energy/taser/crank/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/energy/taser/crank/examine_more(mob/user)
	. = ..()

	. += "The 'Mírotvůrce' was anticipated to become the main line of defense among the colonial population during the first months of settling in. \
		The sheer amount of them that were produced and given out to people would be overwhelming - later giving it a status of a self-defense weapon \
		fit and trustworthy for civilian use. Among the dedicated militiamen, however, it has been remarked as a weapon with a capacity and voltage \
		too small to subdue more than one or two people; 'unfit for active duty', as much as high sustainability helped out."

