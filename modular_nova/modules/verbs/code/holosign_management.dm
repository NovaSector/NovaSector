/// Tracks each player's currently-active holosigns placed via Manage Holosigns, keyed by ckey. Admins are exempt from the CONFIG max_player_holosigns cap.
GLOBAL_LIST_EMPTY(holosign_privacy_tracker)

/mob/living/verb/manage_holosigns()
	set name = "Manage Holosigns"
	set category = "IC"

	/// Populate the list of types of holosigns
	var/list/options = list(
		"Privacy Holosign" = /obj/structure/holosign/privacy,
		"Clear All Holosigns" = "clear",
	)
	if(CONFIG_GET(flag/disable_erp_preferences) || client?.prefs.read_preference(/datum/preference/toggle/master_erp_preferences)) // Only if they have ERP preferences setup
		options["Lewd Advisory Holosign"] = /obj/structure/holosign/privacy/erp

	/// Sets up our input list
	var/choice = tgui_input_list(usr, "Choose an action", "Manage Holosigns", options)
	if(!choice)// No choice kills the verb loop
		return
	if(choice == "Clear All Holosigns")// Clears all our holosigns
		clear_managed_holosigns(usr)
		return
	place_managed_holosign(options[choice], usr)// If we get to this point, place our selection

// Handles the placement of the holosign itself
/mob/living/proc/place_managed_holosign(sign_type, mob/living/user)// fresh proc waow
	var/turf/target_turf = get_turf(user)// picks our target turf through the turf of the user
	if(target_turf.is_blocked_turf(TRUE))// If we cant place for some reason,
		to_chat(user, span_warning("There's no room to place a holosign here!"))// then tell them why
		return// and cancel out of the verb process
	if(locate(/obj/structure/holosign/privacy) in target_turf)// if we got this far, check if we're doubling up signs
		to_chat(user, span_warning("There's already a holosign here!"))// tell the dumbass
		return

	var/list/placed = GLOB.holosign_privacy_tracker[user.ckey]//creates a glob to be referenced
	var/max_holosigns = CONFIG_GET(number/max_player_holosigns)//checks code\controllers\configuration\entries\game_options.dm for /datum/config_entry/number/max_player_holosigns
	if(!user.client?.holder && LAZYLEN(placed) >= max_holosigns)//lazily review the placed glob for their signs
		to_chat(user, span_warning("You've already placed the maximum number of privacy holosigns ([max_holosigns])!"))//if max signs tell the dumbass
		return// make them consider their decisions that got them here.

	var/obj/structure/holosign/privacy/new_holosign = new sign_type(target_turf)// sets up the new holosign we're making as a var to fuck with
	new_holosign.add_hiddenprint(user)// hiddenprints it for staff, just in case
	new_holosign.desc += " It appears to have been placed by [user.name]."// staples the name of the mob creating it onto the holosign

	LAZYADD(GLOB.holosign_privacy_tracker[user.ckey], new_holosign)//casually chucks the results back into our tracking glob
	RegisterSignal(new_holosign, COMSIG_QDELETING, TYPE_PROC_REF(/mob/living, on_managed_holosign_deleted))//places a listener on the new holosign which checks for the deletion of the holosign to manage the glob cleanup, in the next proc

	var/total_placed = LAZYLEN(GLOB.holosign_privacy_tracker[user.ckey])// Prepares a helper variable which casually checks our glob for placements by ckey and manages a counter.
	if(total_placed > 4)// If total exceeds arbitrary number, inform the admins. Because like, probably worth looking at? Who the hell is making more than five of these, really? I left the config larger as bait, tbh. Might be smarter if I made this part of the config but like idk at this point girlie.
		message_admins("[ADMIN_LOOKUPFLW(user)] has placed [total_placed] privacy holosigns.")// Actually messages the admemes that ur a freak wit da signs. I dont actually care to bypass admins on this because whhhyyyyy place more than this you must be up to something.

/mob/living/proc/on_managed_holosign_deleted(obj/structure/holosign/privacy/source, force)// our deletion proc
	SIGNAL_HANDLER// comsig sniffer that we setup above
	for(var/tracked_ckey in GLOB.holosign_privacy_tracker)//refs the ckey in the glob first
		LAZYREMOVE(GLOB.holosign_privacy_tracker[tracked_ckey], source)//takes our source and wipes it from our glob
		if(!LAZYLEN(GLOB.holosign_privacy_tracker[tracked_ckey]))// if we have no length on the list
			GLOB.holosign_privacy_tracker -= tracked_ckey// remove our reference from the list, as its no longer populated

/mob/living/proc/clear_managed_holosigns(mob/living/user)// total cleanup proc
	var/list/placed = GLOB.holosign_privacy_tracker[user.ckey]// checks list for all results by our user
	if(!LAZYLEN(placed))// if no length of list in placed
		to_chat(user, span_notice("You have no privacy holosigns active."))// tell the dumbass
		return// get out
	for(var/obj/structure/holosign/privacy/hologram as anything in placed)// quick var to just setup a reference for this action. sets the var to anything thats inside of our placed reference
		qdel(hologram)// SMUSHES LIKE LITTLE BUG. DEAD.
	to_chat(user, span_notice("You clear all of your active holosigns. So responsible!"))// give the good bean headpats because they cleaned up after themselves
