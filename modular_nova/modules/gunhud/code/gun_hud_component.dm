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

/**
 * Resolves the ammo HUD screen object for a given holder or item.
 *
 * Attempts to locate the human mob currently responsible for displaying
 * the ammo HUD, either via an explicitly provided holder or by checking
 * the item's current location.
 *
 * Will return null if no valid human HUD exists or if the mob has not
 * initialized their HUD yet.
 *
 * Arguments:
 * * holder - Optional mob currently holding the item.
 * * parent_item - Item whose location may contain a valid mob holder.
 *
 * Returns:
 * * /atom/movable/screen/ammo_counter if available, otherwise null.
 */
/datum/element/ammo_hud/proc/get_hud(mob/holder, obj/item/parent_item)
	if(isnull(holder) && !ismob(parent_item.loc))
		return null

	var/mob/hud_owner = holder || parent_item.loc
	if(!ismob(hud_owner) || !hud_owner.hud_used)
		return null

	return hud_owner.hud_used.ammo_counter

/**
 * Handles enabling the ammo HUD when the item is equipped.
 *
 * Ensures the equipper is a human and is actively holding the item.
 * If a valid ammo HUD is available, it is enabled and the item is
 * marked as displaying an ammo HUD via a trait.
 *
 * Also registers a hand-swap signal when both hands are holding
 * HUD-capable items to ensure the display reflects the active hand.
 *
 * Signal handler for COMSIG_ITEM_EQUIPPED.
 *
 * Arguments:
 * * source - The item being equipped.
 * * equipper - The mob equipping the item.
 * * slot - Inventory slot the item was equipped into.
 */
/datum/element/ammo_hud/proc/on_equipped(obj/item/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!equipper.is_holding(source))
		return

	var/atom/movable/screen/ammo_counter/hud = get_hud(equipper)
	if(hud)
		hud.turn_on()
		ADD_TRAIT(source, TRAIT_DISPLAYING_AMMO_HUD, REF(src))
		update_hud(source, hud)

		// If the inactive item is also HUD-capable, listen for COMSIG_MOB_SWAP_HANDS so we can switch ammo HUDs
		var/obj/item/inactive_held_item = equipper.get_inactive_held_item()
		if(inactive_held_item && HAS_TRAIT(inactive_held_item, TRAIT_DISPLAYING_AMMO_HUD))
			RegisterSignal(equipper, COMSIG_MOB_SWAP_HANDS, PROC_REF(on_hands_swap), override = TRUE)

/**
 * Handles disabling the ammo HUD when the item is dropped.
 *
 * Removes the HUD-displaying trait from the dropped item and disables
 * the ammo HUD if no other held items are currently displaying it.
 *
 * Also unregisters the hand-swap signal from the dropper to prevent
 * stale callbacks after the item leaves their hands.
 *
 * Signal handler for COMSIG_ITEM_DROPPED.
 *
 * Arguments:
 * * source - The item being dropped.
 * * dropper - The mob dropping the item.
 */
/datum/element/ammo_hud/proc/on_dropped(datum/source, mob/living/dropper)
	SIGNAL_HANDLER

	var/atom/movable/screen/ammo_counter/hud = get_hud(dropper)
	var/obj/item/active_held_item = dropper.get_active_held_item()
	var/obj/item/inactive_held_item = dropper.get_inactive_held_item()
	if(hud)
		// Determine if we still have a HUD-capable item in either hand
		if(isnull(inactive_held_item) || !HAS_TRAIT(inactive_held_item, TRAIT_DISPLAYING_AMMO_HUD))
			inactive_held_item = null
		if(isnull(active_held_item) || !HAS_TRAIT(active_held_item, TRAIT_DISPLAYING_AMMO_HUD))
			active_held_item = null

		// Turn off our ammo HUD only if there are no guns in our hands
		var/obj/item/remaining_item = active_held_item || inactive_held_item
		if(remaining_item)
			update_hud(remaining_item, hud)
		else
			hud.turn_off()

	REMOVE_TRAIT(source, TRAIT_DISPLAYING_AMMO_HUD, REF(src))
	if(isnull(active_held_item) || isnull(inactive_held_item)) // only unregister if we no longer are dual wielding ammo counter items
		UnregisterSignal(dropper, COMSIG_MOB_SWAP_HANDS)

/**
 * Updates the ammo HUD when the mob swaps active hands.
 *
 * Ensures the newly active held item is eligible for ammo HUD display
 * before refreshing the HUD contents to reflect the active hand.
 *
 * Signal handler for COMSIG_MOB_SWAP_HANDS.
 *
 * Arguments:
 * * source - The mob swapping hands.
 * * swapped_to - The current active hand item that we swapped to.
 * * swapped_from - The previous, now inactive hand item that we swapped from.
 */
/datum/element/ammo_hud/proc/on_hands_swap(mob/living/source, obj/item/swapped_to, obj/item/swapped_from)
	SIGNAL_HANDLER

	if(isnull(swapped_to) || !HAS_TRAIT(swapped_to, TRAIT_DISPLAYING_AMMO_HUD))
		return

	var/atom/movable/screen/ammo_counter/hud = get_hud(source)
	if(hud && hud.on)
		update_hud(swapped_to, hud)

/**
 * Determines whether the given item should currently update the ammo HUD.
 *
 * Prevents inactive-hand items from updating the HUD while another
 * actively held item is already responsible for displaying ammo data.
 *
 * This avoids conflicting updates when both hands contain HUD-capable items.
 *
 * Arguments:
 * * to_update - The item requesting a HUD update.
 *
 * Returns:
 * * TRUE if the item may update the HUD.
 * * FALSE if the update should be suppressed.
 */
/datum/element/ammo_hud/proc/should_update(obj/item/to_update)
	// Make sure we are not updating the inactive hand when we have an active hand counter already
	var/mob/living/equipper = to_update.loc
	if(!ismob(equipper))
		return FALSE
	var/obj/item/active_held_item = equipper.get_active_held_item()
	var/obj/item/inactive_held_item = equipper.get_inactive_held_item()
	if(!isnull(active_held_item) && inactive_held_item == to_update && HAS_TRAIT(active_held_item, TRAIT_DISPLAYING_AMMO_HUD))
		return FALSE

	return HAS_TRAIT(to_update, TRAIT_DISPLAYING_AMMO_HUD)

/**
 * Dispatches an ammo HUD update based on the item's type.
 *
 * Routes the update call to the appropriate handler for ballistic guns,
 * energy guns, or welding tools.
 *
 * Arguments:
 * * source - The item whose ammo display should be updated.
 * * hud - Optional ammo HUD screen object to update.
 */
/datum/element/ammo_hud/proc/update_hud(obj/item/source, atom/movable/screen/ammo_counter/hud)
	if(istype(source, /obj/item/gun/ballistic))
		return update_ballistic(source, hud)

	if(istype(source, /obj/item/gun/energy))
		return update_energy(source, hud)

	return update_welder(source, hud)

/**
 * Updates the ammo HUD for ballistic firearms.
 *
 * Displays remaining ammunition using digit overlays and handles special
 * states such as missing magazines or empty weapons.
 *
 * Signal handler for COMSIG_UPDATE_AMMO_HUD and COMSIG_GUN_CHAMBER_PROCESSED.
 *
 * Arguments:
 * * to_update - The ballistic firearm being evaluated.
 * * hud - Optional ammo HUD screen object to update.
 */
/datum/element/ammo_hud/proc/update_ballistic(obj/item/gun/ballistic/to_update, atom/movable/screen/ammo_counter/hud)
	SIGNAL_HANDLER

	if(!should_update(to_update))
		return

	hud = hud || get_hud(parent_item = to_update)
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

/**
 * Updates the ammo HUD for energy-based firearms.
 *
 * Displays current battery percentage and per-shot energy cost using
 * maptext overlays, with color-coded thresholds for low power states.
 *
 * Signal handler for COMSIG_UPDATE_AMMO_HUD and COMSIG_GUN_CHAMBER_PROCESSED.
 *
 * Arguments:
 * * to_update - The energy firearm being evaluated.
 * * hud - Optional ammo HUD screen object to update.
 */
/datum/element/ammo_hud/proc/update_energy(obj/item/gun/energy/to_update, atom/movable/screen/ammo_counter/hud)
	SIGNAL_HANDLER

	if(!should_update(to_update))
		return

	hud = hud || get_hud(parent_item = to_update)
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

/**
 * Updates the ammo HUD for welding tools.
 *
 * Displays remaining fuel amount and welding state using digit overlays.
 * Handles empty fuel tanks and active flame indication.
 *
 * Signal handler for COMSIG_UPDATE_AMMO_HUD.
 *
 * Arguments:
 * * to_update - The welding tool being evaluated.
 * * hud - Optional ammo HUD screen object to update.
 */
/datum/element/ammo_hud/proc/update_welder(obj/item/weldingtool/to_update, atom/movable/screen/ammo_counter/hud)
	SIGNAL_HANDLER

	if(!should_update(to_update))
		return

	hud = hud || get_hud(parent_item = to_update)
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

/**
 *  Returns get_ammo() with the appropriate args passed to it - some guns like the revolver and bow are special cases.
 *
 * Returns:
 * * Number of loaded, usable rounds.
 */
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
