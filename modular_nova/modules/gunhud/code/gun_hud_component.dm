/datum/component/ammo_hud
	/// The ammo counter screen object itself
	var/atom/movable/screen/ammo_counter/hud
	/// A weakref to the mob who currently owns the hud
	var/datum/weakref/current_hud_owner

/datum/component/ammo_hud/Initialize()
	. = ..()
	if(!istype(parent, /obj/item/gun) && !istype(parent, /obj/item/weldingtool))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(wake_up))

/datum/component/ammo_hud/Destroy()
	turn_off()
	return ..()

/datum/component/ammo_hud/proc/wake_up(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(human_user.is_holding(parent))
			if(human_user.hud_used)
				hud = human_user.hud_used.ammo_counter
				if(!hud.on) // make sure we're not already turned on
					current_hud_owner = WEAKREF(user)
					RegisterSignal(user, COMSIG_QDELETING, PROC_REF(turn_off))
					turn_on()
		else
			turn_off()

/datum/component/ammo_hud/proc/turn_on()
	SIGNAL_HANDLER

	RegisterSignal(hud, COMSIG_QDELETING, PROC_REF(turn_off))
	RegisterSignals(parent, list(COMSIG_PREQDELETED, COMSIG_ITEM_DROPPED), PROC_REF(turn_off))
	RegisterSignals(parent, list(COMSIG_UPDATE_AMMO_HUD, COMSIG_GUN_CHAMBER_PROCESSED), PROC_REF(update_hud))

	hud.turn_on()
	update_hud()

/datum/component/ammo_hud/proc/turn_off()
	SIGNAL_HANDLER

	UnregisterSignal(parent, list(COMSIG_PREQDELETED, COMSIG_ITEM_DROPPED, COMSIG_UPDATE_AMMO_HUD, COMSIG_GUN_CHAMBER_PROCESSED))
	var/mob/living/carbon/human/current_owner = current_hud_owner?.resolve()
	if(isnull(current_owner))
		current_hud_owner = null
	else
		UnregisterSignal(current_owner, COMSIG_QDELETING)

	if(hud)
		hud.turn_off()
		UnregisterSignal(hud, COMSIG_QDELETING)
		hud = null

	current_hud_owner = null

/// Returns get_ammo() with the appropriate args passed to it - some guns like the revolver and bow are special cases
/datum/component/ammo_hud/proc/get_accurate_ammo_count(obj/item/gun/ballistic/the_gun)
	// Handle pulse rifle's unique ammo system
	if(istype(the_gun, /obj/item/gun/ballistic/automatic/pulse_rifle))
		var/obj/item/gun/ballistic/automatic/pulse_rifle/pulse_gun = the_gun
		var/total_shots = 0

		// Count shots in magazine
		if(pulse_gun.magazine)
			for(var/obj/item/ammo_casing/pulse/casing in pulse_gun.magazine.stored_ammo)
				if(casing.remaining_uses > 0) // Only count casings with remaining uses
					total_shots += casing.remaining_uses

		// Add shots from chambered round if present and has remaining uses
		if(pulse_gun.chambered && istype(pulse_gun.chambered, /obj/item/ammo_casing/pulse))
			var/obj/item/ammo_casing/pulse/casing = pulse_gun.chambered
			if(casing.remaining_uses > 0) // Only count if the casing has remaining uses
				total_shots += casing.remaining_uses

		return total_shots

	// Handle pulse sniper's unique ammo system (shows number of shots, not charges)
	if(istype(the_gun, /obj/item/gun/ballistic/rifle/pulse_sniper))
		var/obj/item/gun/ballistic/rifle/pulse_sniper/sniper = the_gun
		var/total_shots = 0

		// Count shots in magazine (each shot consumes multiple charges)
		if(sniper.magazine)
			for(var/obj/item/ammo_casing/pulse/casing in sniper.magazine.stored_ammo)
				if(casing.remaining_uses >= sniper.shots_per_fire) // Only count casings with enough charges for a shot
					total_shots += floor(casing.remaining_uses / sniper.shots_per_fire)

		// Add shots from chambered round if present and has enough charges
		if(sniper.chambered && istype(sniper.chambered, /obj/item/ammo_casing/pulse))
			var/obj/item/ammo_casing/pulse/casing = sniper.chambered
			if(casing.remaining_uses >= sniper.shots_per_fire) // Only count if the casing has enough charges
				total_shots += floor(casing.remaining_uses / sniper.shots_per_fire)

		return total_shots

	// fucking revolvers indeed - do not count empty or chambered rounds for the display HUD
	if(istype(the_gun, /obj/item/gun/ballistic/revolver))
		var/obj/item/gun/ballistic/revolver/the_revolver = the_gun
		return the_revolver.get_ammo(countchambered = FALSE, countempties = FALSE)

	// bows are also weird and shouldn't count the chambered
	if(istype(the_gun, /obj/item/gun/ballistic/bow))
		return the_gun.get_ammo(countchambered = FALSE)

	if(the_gun.bolt_type == BOLT_TYPE_OPEN)
		return the_gun.get_ammo(countchambered = FALSE)
	else
		return the_gun.get_ammo(countchambered = TRUE)


/datum/component/ammo_hud/proc/update_hud()
	SIGNAL_HANDLER
	if(istype(parent, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/pew = parent
		hud.maptext = null
		hud.icon_state = "backing"
		var/backing_color = COLOR_CYAN
		if(!pew.magazine)
			hud.set_hud(backing_color, "oe", "te", "he", "no_mag")
			return
		if(!pew.get_ammo())
			hud.set_hud(backing_color, "oe", "te", "he", "empty_flash")
			return

		var/indicator
		var/rounds = num2text(get_accurate_ammo_count(pew))
		var/oth_o
		var/oth_t
		var/oth_h

		switch(length(rounds))
			if(1)
				oth_o = "o[rounds[1]]"
			if(2)
				oth_o = "o[rounds[2]]"
				oth_t = "t[rounds[1]]"
			if(3)
				oth_o = "o[rounds[3]]"
				oth_t = "t[rounds[2]]"
				oth_h = "h[rounds[1]]"
			else
				oth_o = "o9"
				oth_t = "t9"
				oth_h = "h9"
		hud.set_hud(backing_color, oth_o, oth_t, oth_h, indicator)

	else if(istype(parent, /obj/item/gun/energy))
		var/obj/item/gun/energy/pew = parent
		hud.icon_state = "eammo_counter"
		hud.cut_overlays()
		hud.maptext_x = -12
		var/obj/item/ammo_casing/energy/shot = pew.ammo_type[pew.select]
		var/batt_percent = FLOOR(clamp(pew.cell.charge / pew.cell.maxcharge, 0, 1) * 100, 1)
		var/shot_cost_percent = FLOOR(clamp(shot.e_cost / pew.cell.maxcharge, 0, 1) * 100, 1)
		if(batt_percent > 99 || shot_cost_percent > 99)
			hud.maptext_x = -12
		else
			hud.maptext_x = -8
		if(!pew.can_shoot())
			hud.icon_state = "eammo_counter_empty"
			hud.maptext = span_maptext("<div align='center' valign='middle' style='position:relative'><font color='[COLOR_RED]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>")
			return
		if(batt_percent <= 25)
			hud.maptext = span_maptext("<div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>")
			return
		hud.maptext = span_maptext("<div align='center' valign='middle' style='position:relative'><font color='[COLOR_VIBRANT_LIME]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>")

	else if(istype(parent, /obj/item/weldingtool))
		var/obj/item/weldingtool/welder = parent
		hud.maptext = null
		var/backing_color = COLOR_TAN_ORANGE
		hud.icon_state = "backing"

		if(welder.get_fuel() < 1)
			hud.set_hud(backing_color, "oe", "te", "he", "empty_flash")
			return

		var/indicator
		var/fuel = num2text(welder.get_fuel())
		var/oth_o
		var/oth_t
		var/oth_h

		if(welder.welding)
			indicator = "flame_on"
		else
			indicator = "flame_off"

		fuel = num2text(welder.get_fuel())

		switch(length(fuel))
			if(1)
				oth_o = "o[fuel[1]]"
			if(2)
				oth_o = "o[fuel[2]]"
				oth_t = "t[fuel[1]]"
			if(3)
				oth_o = "o[fuel[3]]"
				oth_t = "t[fuel[2]]"
				oth_h = "h[fuel[1]]"
			else
				oth_o = "o9"
				oth_t = "t9"
				oth_h = "h9"
		hud.set_hud(backing_color, oth_o, oth_t, oth_h, indicator)

/obj/item/gun/ballistic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ammo_hud)

/obj/item/gun/energy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ammo_hud)

/obj/item/weldingtool/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ammo_hud)
