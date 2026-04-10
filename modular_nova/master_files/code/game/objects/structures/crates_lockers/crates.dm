/obj/structure/closet/crate/coffin
	/// The vampire owner of this coffin.
	var/datum/mind/resident
	/// The time it takes to pry this open with a crowbar.
	var/pry_lid_timer = 25 SECONDS

/obj/structure/closet/crate/coffin/Destroy()
	unclaim_coffin()
	return ..()

/obj/structure/closet/crate/coffin/examine(mob/user)
	. = ..()
	if(user.mind == resident)
		. += span_cult("This is your Claimed Coffin.")
		. += span_cult("Rest in it while injured to enter Torpor. Entering it with unspent Ranks will allow you to spend one.")
		. += span_cult("Alt-Click while inside the Coffin to Lock/Unlock.")
		. += span_cult("Alt-Click while outside of your Coffin to Unclaim it, unwrenching it and all your other structures as a result.")

/obj/structure/closet/crate/coffin/insertion_allowed(atom/movable/AM)
	. = ..()
	if(. || !isliving(AM))
		return
	var/mob/living/person = AM
	if(!IS_VAMPIRE(person)) // we only use the snowflake checks for vampires
		return
	if(person.anchored || person.buckled || person.incorporeal_move || person.has_buckled_mobs())
		return FALSE
	if(horizontal && person.density)
		return FALSE
	// if there's nobody else in here, then we'll be allowed to sleep in here, regardless of our mob size
	if(!(locate(/mob/living) in contents - person))
		return TRUE

/obj/structure/closet/crate/coffin/can_open(mob/living/user, force)
	if(!locked)
		return ..()
	if(user.mind == resident)
		if(welded)
			welded = FALSE
			update_appearance(UPDATE_ICON)
		locked = FALSE
		return TRUE
	playsound(src, 'modular_nova/modules/bloodsucker/sound/door_locked.ogg', vol = 20, vary = TRUE)
	to_chat(user, span_notice("[src] appears to be locked tight from the inside."))
	return FALSE

/obj/structure/closet/crate/coffin/after_close(mob/living/user, force)
	if(!user || user.loc != src)
		return
	var/datum/antagonist/vampire/vampire = IS_VAMPIRE(user)
	if(!vampire)
		return
	if(!vampire.coffin && !resident)
		switch(tgui_alert(user, "Do you wish to claim this as your coffin? [get_area(src)] will be your haven.", "Claim Haven", list("Yes", "No")))
			if("Yes")
				claim_coffin(user)
			if("No")
				return
	lock_me(user)

	INVOKE_ASYNC(vampire, TYPE_PROC_REF(/datum/antagonist/vampire, rank_up_if_goal))

	// You're in a Coffin, everything else is done, you're likely here to heal. Let's offer them the opportunity to do so.
	vampire.check_begin_torpor()

/obj/structure/closet/crate/coffin/click_alt(mob/living/user)
	if(!isliving(user) || !IS_VAMPIRE(user))
		return NONE
	if(user.loc == src)
		return lock_me(user) ? CLICK_ACTION_SUCCESS : CLICK_ACTION_BLOCKING
	if(user.mind == resident && user.Adjacent(src))
		balloon_alert(user, "unclaim coffin?")
		var/list/unclaim_options = list(
			"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
			"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no")
		)
		var/unclaim_response = show_radial_menu(user, src, unclaim_options, radius = 36, require_near = TRUE)
		if(unclaim_response == "Yes")
			unclaim_coffin(TRUE)
		return CLICK_ACTION_SUCCESS
	return NONE

/obj/structure/closet/crate/coffin/relaymove(mob/living/user, direction)
	if(user.stat == CONSCIOUS && user.mind == resident && !user.resting && !opened)
		open(user)
		return
	return ..()

/obj/structure/closet/crate/coffin/container_resist_act(mob/living/user, loc_required)
	if(user.stat == CONSCIOUS && user.mind == resident && !opened)
		open(user)
		return
	return ..()

/obj/structure/closet/crate/coffin/crowbar_act(mob/living/user, obj/item/tool)
	if(user.combat_mode || !locked)
		return FALSE
	user.visible_message(
		span_notice("[user] tries to pry the lid off of [src] with [tool]."),
		span_notice("You begin prying the lid off of [src] with [tool]."),
	)
	if(!tool.use_tool(src, user, pry_lid_timer))
		return FALSE
	bust_open()
	user.visible_message(
		span_notice("[user] snaps the door of [src] wide open."),
		span_notice("The door of [src] snaps open."),
	)
	return TRUE

/obj/structure/closet/crate/coffin/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(!resident)
		return ..()
	to_chat(user, span_danger("The coffin won't detach from the floor.[user.mind == resident ? " You can Alt-Click to unclaim and unwrench your Coffin." : ""]"))
	return TRUE

/obj/structure/closet/crate/coffin/proc/claim_coffin(mob/living/claimer)
	var/datum/antagonist/vampire/vampiredatum = IS_VAMPIRE(claimer)
	if(vampiredatum.claim_coffin(src))
		resident = claimer.mind
		set_anchored(TRUE)

/obj/structure/closet/crate/coffin/proc/unclaim_coffin(manual = FALSE)
	if(!resident)
		return

	// Unanchor it (If it hasn't been broken, anyway)
	if(!QDELETED(src))
		set_anchored(FALSE)

	// Unclaiming
	var/datum/antagonist/vampire/vampiredatum = resident.has_antag_datum(/datum/antagonist/vampire)
	if(vampiredatum?.coffin == src)
		vampiredatum.coffin = null
		vampiredatum.vampire_haven_area = null
		for(var/datum/action/cooldown/vampire/gohome/gohome in vampiredatum.powers)
			vampiredatum.remove_power(gohome)

	for(var/obj/structure/vampire/vampire_structure in get_area(src))
		if(vampire_structure.owner == resident)
			vampire_structure.unbolt()

	if(manual)
		to_chat(resident.current, span_cult_italic("You have unclaimed your coffin! This also unclaims all your other Vampire structures!"))
	else
		to_chat(resident.current, span_cult_italic("You sense that the link with your coffin and your haven has been broken! You will need to seek another."))

	// Remove resident. Because this objec (GC?) we need to give them a way to see they don't have a home anymore.
	resident = null

/obj/structure/closet/crate/coffin/proc/lock_me(mob/user, in_locked = TRUE)
	if(user.mind != resident)
		return FALSE
	if(!broken)
		locked = in_locked
		if(locked)
			to_chat(user, span_notice("You flip a secret latch and lock yourself inside [src]."))
		else
			to_chat(user, span_notice("You flip a secret latch and unlock [src]."))
		return TRUE

	// Broken? Let's fix it.
	to_chat(user, span_notice("The secret latch that would lock [src] from the inside is broken. You set it back into place..."))
	if(!do_after(user, 5 SECONDS, src))
		to_chat(user, span_notice("You fail to fix [src]'s mechanism."))
		return TRUE
	to_chat(user, span_notice("You fix the mechanism and lock it."))
	broken = FALSE
	locked = TRUE
	return TRUE
