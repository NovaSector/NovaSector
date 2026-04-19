/datum/component/glass_passer/holosynth/phase_through_glass(mob/living/owner, atom/bumpee)
	var/mob/living/carbon/ascarbon = owner
	var/obj/structure/window/wumpee = bumpee
	var/dir_to_move = get_dir(owner, wumpee) || owner.dir
	var/turf/first_step = get_step(get_turf(owner), dir_to_move)
	if(is_phase_blocked(first_step, wumpee, owner))
		ascarbon.balloon_alert(ascarbon, "blocked!")
		return
	if(wumpee.fulltile && is_phase_blocked(get_step(first_step, dir_to_move), wumpee, owner))
		ascarbon.balloon_alert(ascarbon, "blocked!")
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
