/datum/element/ammo_hud

/datum/element/ammo_hud/Attach(datum/target)
	. = ..()
	if(!isgun(target) && !istype(target, /obj/item/weldingtool))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(target, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))
	if(istype(target, /obj/item/gun/ballistic))
		RegisterSignals(target, list(COMSIG_UPDATE_AMMO_HUD, COMSIG_GUN_CHAMBER_PROCESSED), PROC_REF(update_ballistic))
	else if(istype(target, /obj/item/gun/energy))
		RegisterSignals(target, list(COMSIG_UPDATE_AMMO_HUD, COMSIG_GUN_CHAMBER_PROCESSED), PROC_REF(update_energy))
	else // non guns don't need the chamber_processed signal registered
		RegisterSignal(target, COMSIG_UPDATE_AMMO_HUD, PROC_REF(update_welder))

/datum/element/ammo_hud/proc/get_hud(mob/holder, obj/item/parent_item)
	if(isnull(holder) && !ismob(parent_item.loc))
		return null

	var/mob/living/carbon/human/human_mob = holder || parent_item.loc
	if(!istype(human_mob) || !human_mob.hud_used)
		return null

	return human_mob.hud_used.ammo_counter

/datum/element/ammo_hud/proc/on_equipped(obj/item/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!ishuman(equipper))
		return

	if(!equipper.is_holding(source))
		return

	var/atom/movable/screen/ammo_counter/hud = get_hud(equipper)
	if(hud)
		hud.turn_on()
		if(istype(source, /obj/item/gun/ballistic))
			update_ballistic(source)
		else if(istype(source, /obj/item/gun/energy))
			update_energy(source)
		else
			update_welder(source)

/datum/element/ammo_hud/proc/on_dropped(datum/source, mob/living/dropper)
	SIGNAL_HANDLER

	if(!ishuman(dropper))
		return

	var/atom/movable/screen/ammo_counter/hud = get_hud(dropper)
	if(hud)
		hud.turn_off()

/datum/element/ammo_hud/proc/update_ballistic(obj/item/gun/ballistic/to_update)
	SIGNAL_HANDLER

	var/atom/movable/screen/ammo_counter/hud = get_hud(parent_item = to_update)
	if(isnull(hud))
		return

	hud.maptext = null
	hud.icon_state = "backing"
	var/backing_color = COLOR_CYAN
	if(!to_update.magazine)
		hud.set_hud(backing_color, "oe", "te", "he", "no_mag")
		return
	if(!to_update.get_ammo())
		hud.set_hud(backing_color, "oe", "te", "he", "empty_flash")
		return

	var/indicator
	var/rounds = num2text(to_update.get_accurate_ammo_count())
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

/datum/element/ammo_hud/proc/update_energy(obj/item/gun/energy/to_update)
	SIGNAL_HANDLER

	var/atom/movable/screen/ammo_counter/hud = get_hud(parent_item = to_update)
	if(isnull(hud))
		return

	hud.icon_state = "eammo_counter"
	hud.cut_overlays()
	hud.maptext_x = -12
	var/obj/item/ammo_casing/energy/shot = to_update.ammo_type[to_update.select]
	var/batt_percent = FLOOR(clamp(to_update.cell.charge / to_update.cell.maxcharge, 0, 1) * 100, 1)
	var/shot_cost_percent = FLOOR(clamp(shot.e_cost / to_update.cell.maxcharge, 0, 1) * 100, 1)
	if(batt_percent > 99 || shot_cost_percent > 99)
		hud.maptext_x = -12
	else
		hud.maptext_x = -8
	if(!to_update.can_shoot())
		hud.icon_state = "eammo_counter_empty"
		hud.maptext = span_maptext("<div align='center' valign='middle' style='position:relative'><font color='[COLOR_RED]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>")
		return
	if(batt_percent <= 25)
		hud.maptext = span_maptext("<div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>")
		return
	hud.maptext = span_maptext("<div align='center' valign='middle' style='position:relative'><font color='[COLOR_VIBRANT_LIME]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>")

/datum/element/ammo_hud/proc/update_welder(obj/item/weldingtool/to_update)
	SIGNAL_HANDLER

	var/atom/movable/screen/ammo_counter/hud = get_hud(parent_item = to_update)
	if(isnull(hud))
		return

	hud.maptext = null
	var/backing_color = COLOR_TAN_ORANGE
	hud.icon_state = "backing"

	if(to_update.get_fuel() < 1)
		hud.set_hud(backing_color, "oe", "te", "he", "empty_flash")
		return

	var/indicator
	var/fuel = num2text(to_update.get_fuel())
	var/oth_o
	var/oth_t
	var/oth_h

	if(to_update.welding)
		indicator = "flame_on"
	else
		indicator = "flame_off"

	fuel = num2text(to_update.get_fuel())

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

/// Returns get_ammo() with the appropriate args passed to it - some guns like the revolver and bow are special cases
/obj/item/gun/ballistic/proc/get_accurate_ammo_count()
	if(bolt_type == BOLT_TYPE_OPEN)
		return get_ammo(countchambered = FALSE)
	else
		return get_ammo(countchambered = TRUE)

// Handle pulse rifle's unique ammo system
/obj/item/gun/ballistic/automatic/pulse_rifle/get_accurate_ammo_count()
	var/total_shots = 0

	// Count shots in magazine
	if(magazine)
		for(var/obj/item/ammo_casing/pulse/casing in magazine.stored_ammo)
			if(casing.remaining_uses > 0) // Only count casings with remaining uses
				total_shots += casing.remaining_uses

	// Add shots from chambered round if present and has remaining uses
	if(chambered && istype(chambered, /obj/item/ammo_casing/pulse))
		var/obj/item/ammo_casing/pulse/casing = chambered
		if(casing.remaining_uses > 0) // Only count if the casing has remaining uses
			total_shots += casing.remaining_uses

	return total_shots

// Handle pulse sniper's unique ammo system (shows number of shots, not charges)
/obj/item/gun/ballistic/rifle/pulse_sniper/get_accurate_ammo_count()
	var/total_shots = 0

	// Count shots in magazine (each shot consumes multiple charges)
	if(magazine)
		for(var/obj/item/ammo_casing/pulse/casing in magazine.stored_ammo)
			if(casing.remaining_uses >= shots_per_fire) // Only count casings with enough charges for a shot
				total_shots += floor(casing.remaining_uses / shots_per_fire)

	// Add shots from chambered round if present and has enough charges
	if(chambered && istype(chambered, /obj/item/ammo_casing/pulse))
		var/obj/item/ammo_casing/pulse/casing = chambered
		if(casing.remaining_uses >= shots_per_fire) // Only count if the casing has enough charges
			total_shots += floor(casing.remaining_uses / shots_per_fire)

	return total_shots

// fucking revolvers indeed - do not count empty or chambered rounds for the display HUD
/obj/item/gun/ballistic/revolver/get_accurate_ammo_count()
	return get_ammo(countchambered = FALSE, countempties = FALSE)

// bows are also weird and shouldn't count the chambered
/obj/item/gun/ballistic/bow/get_accurate_ammo_count()
	return get_ammo(countchambered = FALSE)

/obj/item/gun/ballistic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ammo_hud)

/obj/item/gun/energy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ammo_hud)

/obj/item/weldingtool/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ammo_hud)
