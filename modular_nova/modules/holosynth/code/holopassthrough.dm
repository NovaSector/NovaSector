/datum/component/glass_passer/holosynth
	/// Whether bumping a window auto-phases; toggled via the "Toggle Glass Phasing" action.
	var/auto_phase = TRUE

/datum/component/glass_passer/holosynth/phase_through_glass(mob/living/owner, atom/bumpee)
	if(!auto_phase)
		return
	var/mob/living/carbon/ascarbon = owner
	var/obj/structure/window/wumpee = bumpee
	var/dir_to_move = get_dir(owner, wumpee) || owner.dir
	var/turf/first_step = get_step(get_turf(owner), dir_to_move)
	var/turf/final_destination = wumpee.fulltile ? get_step(first_step, dir_to_move) : first_step
	if(is_phase_blocked(first_step, wumpee, owner))
		ascarbon.balloon_alert(ascarbon, "blocked!")
		return
	if(wumpee.fulltile && is_phase_blocked(final_destination, wumpee, owner))
		ascarbon.balloon_alert(ascarbon, "blocked!")
		return
	// Phasing past our leash would just rubber-band us back — bail up front instead of running the full do_after.
	var/datum/component/leash/leash = owner.GetComponent(/datum/component/leash)
	if(leash?.owner && get_dist(final_destination, leash.owner) > leash.distance)
		ascarbon.balloon_alert(ascarbon, "too far!")
		return

	var/modified_pass_time = wumpee.fulltile ? (3 * pass_time) : pass_time
	// Reuse the holographic_nature glitch — same effect a holosynth gets from damage or being walked through.
	var/datum/component/holographic_nature/nature = owner.GetComponent(/datum/component/holographic_nature)
	nature?.apply_effects()

	if(!do_after(owner, modified_pass_time, bumpee))
		return

	if(ascarbon.handcuffed || ascarbon.legcuffed)
		ascarbon.balloon_alert(ascarbon, "restrained!")
		return

	passwindow_on(owner, type)

	for(var/obj/item/equipped_item in ascarbon.get_equipped_items(INCLUDE_HELD))
		var/slot = ascarbon.get_slot_by_item(equipped_item)
		if(slot & (ITEM_SLOT_ID | ITEM_SLOT_LPOCKET | ITEM_SLOT_RPOCKET))
			continue
		ascarbon.dropItemToGround(equipped_item)

	step(owner, dir_to_move)
	if(wumpee.fulltile)
		step(owner, dir_to_move)

	passwindow_off(owner, type)

/// Returns TRUE if the destination tile past the window can't be entered (wall, dense obstacle, etc.).
/// Grilles don't count — holosynths phase through them the same way they phase through glass.
/datum/component/glass_passer/holosynth/proc/is_phase_blocked(turf/destination, obj/structure/window/window, mob/owner)
	if(isnull(destination) || destination.density)
		return TRUE
	for(var/atom/movable/blocker in destination)
		if(blocker == window || blocker == owner || istype(blocker, /obj/structure/grille))
			continue
		if(blocker.density)
			return TRUE
	return FALSE

/datum/component/glass_passer/holosynth/blomperize(obj/structure/structure)
	var/obj/structure/window/wumpee = structure
	if(!istype(wumpee) || !wumpee.fulltile)
		return
	apply_wibbly_filters(structure)
	addtimer(CALLBACK(src, PROC_REF(unblomperize), structure), deform_glass)

/datum/component/glass_passer/holosynth/unblomperize(obj/structure/structure)
	remove_wibbly_filters(structure, 0.5 SECONDS)

/// Action button that flips `/datum/component/glass_passer/holosynth.auto_phase`.
/// When off, bumping a window acts like bumping a wall — useful to avoid accidentally triggering the do_after.
/datum/action/innate/holosynth_toggle_phase
	name = "Toggle Glass Phasing"
	desc = "Toggle whether bumping a window automatically phases you through. Phasing through glass drops all held items except your ID and pockets"
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "ghost"

/datum/action/innate/holosynth_toggle_phase/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	return !isnull(owner.GetComponent(/datum/component/glass_passer/holosynth))

/datum/action/innate/holosynth_toggle_phase/is_action_active(atom/movable/screen/movable/action_button/current_button)
	var/datum/component/glass_passer/holosynth/passer = owner?.GetComponent(/datum/component/glass_passer/holosynth)
	return passer?.auto_phase

/datum/action/innate/holosynth_toggle_phase/Activate()
	var/datum/component/glass_passer/holosynth/passer = owner.GetComponent(/datum/component/glass_passer/holosynth)
	if(!passer)
		return
	passer.auto_phase = !passer.auto_phase
	to_chat(owner, span_notice("Automatic glass phasing [passer.auto_phase ? "enabled" : "disabled"]."))
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)
