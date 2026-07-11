/obj/item/ammo_box
	/// next move/clickdelay penalty applied when reloading with this
	var/reload_delay = NONE

/obj/item/ammo_box/magazine/ammo_stack
	reload_delay = CLICK_CD_RANGE // less capacity than a box but more convenient because you can small-size it

/obj/item/ammo_box/advanced/s12gauge
	reload_delay = CLICK_CD_MELEE // because it's a box but also you hold 15 shells in a box, that's a lot, man

/obj/item/ammo_box/magazine/m12g
	reload_delay = CLICK_CD_MELEE //Mags shouldn't load shells into tube-fed shotguns without zero CD

/obj/item/ammo_box/magazine/katyusha
	reload_delay = CLICK_CD_MELEE

/obj/item/ammo_box/magazine/jager
	reload_delay = CLICK_CD_MELEE

/obj/item/ammo_box/magazine/shitzu
	reload_delay = CLICK_CD_MELEE

/// Reloading with ammo box can incur penalty with some guns
/obj/item/gun/ballistic/proc/handle_box_reload(mob/user, obj/item/ammo, num_loaded)
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	if(!istype(ammo, /obj/item/ammo_box))
		balloon_alert(user, "[num_loaded] [cartridge_wording]\s loaded")
		return
	var/obj/item/ammo_box/reloader = ammo
	if(reloader.reload_delay)
		var/penalty = reloader.reload_delay
		user.changeNext_move(penalty) // cooldown to simulate having to fumble for another round
		balloon_alert(user, "[num_loaded] [cartridge_wording]\s loaded (delayed [penalty * 0.1]s)!")

/obj/effect/temp_visual/dir_setting/firing_effect
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_FIRE

/obj/item/gun/ballistic/shotgun/automatic/combat
	projectile_damage_multiplier = 1.35 //original 1.5

/obj/item/gun/ballistic/shotgun/automatic/combat/compact
	projectile_damage_multiplier = 1 //original 1.5
