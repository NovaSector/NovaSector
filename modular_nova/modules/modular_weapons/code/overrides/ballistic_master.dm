/obj/item/gun/ballistic
	/// if this gun has a penalty for reloading with an ammo_box type
	var/box_reload_penalty = TRUE
	/// reload penalty inflicted by using an ammo box instead of an individual cartridge, if not outright exchanging the magazine
	var/box_reload_delay = CLICK_CD_MELEE

/*
* hey there's like... no better place to put these overrides, sorry
* if there's other guns that use speedloader-likes or otherwise have a reason to
* probably not have a CLICK_CD_MELEE cooldown for reloading them with something else
* i guess add it here? only current example is revolvers
* you could maybe make a case for double-barrels? i'll leave that for discussion in the pr comments
*/

/obj/item/gun/ballistic/revolver
	box_reload_delay = NONE // honestly this is negligible because of the inherent delay of having to switch hands

/obj/item/gun/ballistic/revolver/shotgun_revolver
	box_reload_delay = CLICK_CD_MELEE // unfortunately this is a shotgun

/obj/item/gun/ballistic/rifle/boltaction // slightly less negligible than a revolver, since this is mostly for fairly powerful but crew-accessible stuff like mosins
	box_reload_delay = NONE

/// Reloading with ammo box can incur penalty with some guns
/obj/item/gun/ballistic/proc/handle_box_reload(mob/user, obj/item/ammo_box/ammobox, num_loaded)
	var/box_load = FALSE // if you're reloading with an ammo box, inflicts a cooldown
	if(istype(ammobox, /obj/item/ammo_box) && box_reload_penalty && box_reload_delay)
		box_load = TRUE
		user.changeNext_move(box_reload_delay) // cooldown to simulate having to fumble for another round
		balloon_alert(user, "reload encumbered ([box_reload_delay * 0.1]s)!")
	to_chat(user, span_notice("You load [num_loaded] [cartridge_wording]\s into [src][box_load ?  ", but it takes some extra effort" : ""]."))

/obj/effect/temp_visual/dir_setting/firing_effect
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_FIRE
