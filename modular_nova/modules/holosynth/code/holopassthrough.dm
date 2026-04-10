/datum/component/glass_passer/holosynth/phase_through_glass(mob/living/owner, atom/bumpee)
	var/mob/living/carbon/ascarbon = owner
	var/obj/structure/window/wumpee = bumpee
	var/modified_pass_time = pass_time

	if(wumpee.fulltile)
		modified_pass_time = 3 * pass_time
	else
		modified_pass_time = pass_time

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

	var/dirToMove = get_dir(owner, bumpee) || owner.dir
	step(owner, dirToMove)
	if(wumpee.fulltile)
		step(owner, dirToMove)

	passwindow_off(owner, type)

/datum/component/glass_passer/holosynth/blomperize(obj/structure/structure)
	var/obj/structure/window/wumpee = structure
	if(!istype(wumpee) || !wumpee.fulltile)
		return
	apply_wibbly_filters(structure)
	addtimer(CALLBACK(src, PROC_REF(unblomperize), structure), deform_glass)

/datum/component/glass_passer/holosynth/unblomperize(obj/structure/structure)
	remove_wibbly_filters(structure, 0.5 SECONDS)
