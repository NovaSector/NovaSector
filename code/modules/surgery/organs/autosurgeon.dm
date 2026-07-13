/obj/item/autosurgeon
	name = "autosurgeon"
	desc = "A device that automatically inserts an implant, skillchip or organ into the user without the hassle of extensive surgery. \
		It has a slot to insert implants or organs and a screwdriver slot for removing accidentally added items."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "autosurgeon"
	inhand_icon_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL

	/// How many times you can use the autosurgeon before it becomes useless
	var/uses = INFINITY
	/// What organ will the autosurgeon sub-type will start with. ie, CMO autosurgeon start with a medi-hud.
	var/starting_organ
	/// The organ currently loaded in the autosurgeon, ready to be implanted.
	var/obj/item/organ/stored_organ
	/// The list of organs and their children we allow into the autosurgeon. An empty list means no whitelist.
	var/list/organ_whitelist = list()
	/// The percentage modifier for how fast you can use the autosurgeon to implant other people.
	var/surgery_speed = 1
	/// The overlay that shows when the autosurgeon has an organ inside of it.
	var/loaded_overlay = "autosurgeon_loaded_overlay"

/obj/item/autosurgeon/attack_self_tk(mob/user)
	return //stops TK fuckery

/obj/item/autosurgeon/Initialize(mapload)
	. = ..()
	if(starting_organ)
		load_organ(new starting_organ(src))

/obj/item/autosurgeon/update_overlays()
	. = ..()
	if(stored_organ)
		. += loaded_overlay
		. += emissive_appearance(icon, loaded_overlay, src)

/obj/item/autosurgeon/proc/load_organ(obj/item/organ/loaded_organ, mob/living/user)
	if(user)
		if(stored_organ)
			to_chat(user, span_alert("[src] already has an implant stored."))
			return

		if(uses <= 0)
			to_chat(user, span_alert("[src] is used up and cannot be loaded with more implants."))
			return

		if(organ_whitelist.len)
			var/organ_whitelisted
			for(var/whitelisted_organ in organ_whitelist)
				if(istype(loaded_organ, whitelisted_organ))
					organ_whitelisted = TRUE
					break
			if(!organ_whitelisted)
				to_chat(user, span_alert("[src] is not compatible with [loaded_organ]."))
				return

		if(!user.transferItemToLoc(loaded_organ, src))
			to_chat(user, span_alert("[loaded_organ] is stuck to your hand!"))
			return

	stored_organ = loaded_organ
	loaded_organ.forceMove(src)

	name = "[initial(name)] ([stored_organ.name])" //to tell you the organ type, like "suspicious autosurgeon (Reviver implant)"
	update_appearance()

/obj/item/autosurgeon/proc/use_autosurgeon(mob/living/target, mob/living/user, implant_time)
	if(!stored_organ)
		to_chat(user, span_alert("[src] currently has no implant stored."))
		return

	if(uses <= 0)
		to_chat(user, span_alert("[src] has already been used. The tools are dull and won't reactivate."))
		return

	if(implant_time)
		user.visible_message(
			span_notice("[user] prepares to use [src] on [target]."),
			span_notice("You prepare to use [src] on [target]."),
		)
		if(!do_after(user, (implant_time * surgery_speed), target))
			return

	if(target != user)
		log_combat(user, target, "autosurgeon implanted [stored_organ] into", "[src]", "in [AREACOORD(target)]")
		user.visible_message(span_notice("[user] presses a button on [src] as it plunges into [target]'s body."), span_notice("You press a button on [src] as it plunges into [target]'s body."))
	else
		user.visible_message(
			span_notice("[user] presses a button on [src] as it plunges into [user.p_their()] body."),
			span_notice("You press a button on [src] as it plunges into your body."),
		)

	if (stored_organ.valid_zones && user.get_held_index_of_item(src))
		var/list/checked_zones = list(user.zone_selected)
		if (IS_RIGHT_INDEX(user.get_held_index_of_item(src)))
			checked_zones += list(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG)
		else
			checked_zones += list(BODY_ZONE_L_ARM, BODY_ZONE_L_LEG)

		for (var/check_zone in checked_zones)
			if (stored_organ.valid_zones[check_zone])
				stored_organ.swap_zone(check_zone)
				break

	if (!stored_organ.Insert(target)) // insert stored organ into the user
		balloon_alert(user, "insertion failed!")
		return

	stored_organ = null
	name = initial(name) //get rid of the organ in the name
	playsound(target.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)
	update_appearance()

	uses--
	if(uses <= 0)
		desc = "[initial(desc)] Looks like it's been used up."

/obj/item/autosurgeon/attack_self(mob/user)//when the object it used...
	use_autosurgeon(user, user)

/obj/item/autosurgeon/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	add_fingerprint(user)
	use_autosurgeon(target, user, 8 SECONDS)

/obj/item/autosurgeon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isorgan(tool))
		load_organ(tool, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/autosurgeon/screwdriver_act(mob/living/user, obj/item/screwtool)
	if(..())
		return TRUE
	if(!stored_organ)
		to_chat(user, span_warning("There's no implant in [src] for you to remove!"))
	else
		var/atom/drop_loc = user.drop_location()
		for(var/atom/movable/stored_implant as anything in src)
			stored_implant.forceMove(drop_loc)
			to_chat(user, span_notice("You remove the [stored_organ] from [src]."))
			stored_organ = null

		screwtool.play_tool_sound(src)
		uses--
		if(uses <= 0)
			desc = "[initial(desc)] Looks like it's been used up."
		update_appearance(UPDATE_ICON)
	return TRUE

/obj/item/autosurgeon/medical_hud
	desc = "A single use autosurgeon that contains a medical heads-up display augment. A screwdriver can be used to remove it, but implants can't be placed back in."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/eyes/hud/medical

/obj/item/autosurgeon/syndicate
	name = "suspicious autosurgeon"
	icon_state = "autosurgeon_syndicate"
	surgery_speed = 0.75
	loaded_overlay = "autosurgeon_syndicate_loaded_overlay"

/obj/item/autosurgeon/syndicate/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/autosurgeon/syndicate/laser_arm
	desc = "A single use autosurgeon that contains a combat arms-up laser augment. A screwdriver can be used to remove it, but implants can't be placed back in."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/gun/laser

/obj/item/autosurgeon/syndicate/thermal_eyes
	starting_organ = /obj/item/organ/eyes/robotic/thermals

/obj/item/autosurgeon/syndicate/thermal_eyes/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/xray_eyes
	starting_organ = /obj/item/organ/eyes/robotic/xray

/obj/item/autosurgeon/syndicate/xray_eyes/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/anti_stun
	starting_organ = /obj/item/organ/cyberimp/brain/anti_stun

/obj/item/autosurgeon/syndicate/anti_stun/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/reviver
	starting_organ = /obj/item/organ/cyberimp/chest/reviver

/obj/item/autosurgeon/syndicate/reviver/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/commsagent
	desc = "A device that automatically - painfully - inserts an implant. It seems someone's specially \
	modified this one to only insert... tongues. Horrifying."
	starting_organ = /obj/item/organ/tongue

/obj/item/autosurgeon/syndicate/commsagent/Initialize(mapload)
	. = ..()
	organ_whitelist += /obj/item/organ/tongue

/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/surgery/emagged

/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/contraband_sechud
	desc = "Contains a contraband SecHUD implant, undetectable by health scanners."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/eyes/hud/security/syndicate

// NOVA EDIT ADDITION START
// Antagonist and Event setup utility tool. Accepts singular typepaths, and lists, on stored_organ, for pre-creating autosurgeon types.
/obj/item/autosurgeon/multi
	name = "multisurgeon"
	desc = "A device that automatically inserts multiple implants, skillchips, or organs into the user without the hassle of extensive surgery. Holds several organs at once for simultaneous installation."
	/// List of organs currently loaded, since this variant holds more than one at a time.
	var/list/obj/item/organ/stored_organs = list()
	/// Maximum number of organs this can hold at once.
	var/max_organs = 3

// Hot-shit workaround on the parent only supporting a single entry
/obj/item/autosurgeon/multi/Initialize(mapload)
	if(islist(starting_organ))// if starting_organ is a list
		var/list/organ_types = starting_organ// map that list to a variable we can poke
		starting_organ = null // prevent base Initialize from choking on a list where it expects a typepath by nulling it after we exfil the data from it
		. = ..()// run our parent init
		for(var/organ_type in organ_types)// takes our list and meshes it against a new single use var to pass the data around
			load_organ(new organ_type(src))// its like hot potato, except its 500 implants of nova sector
	else// otherwise if it wasnt a list,
		. = ..() // the base handles a plain single-typepath starting_organ correctly on its own

// If theres anything in stored_organs, update our overlay, matching parent
/obj/item/autosurgeon/multi/update_overlays()
	. = ..()
	if(length(stored_organs))
		. += loaded_overlay
		. += emissive_appearance(icon, loaded_overlay, src)

// Dynamic renaming of the object based on its contents
// Might be worth changing how I handle this so you can manually name a complex pre-stacked autosurgeon
/obj/item/autosurgeon/multi/proc/update_multi_name()
	if(length(stored_organs))// if we have things in our multistore
		var/list/organ_names = list()// make a list. again.
		for(var/obj/item/organ/organ as anything in stored_organs)// populate that list off the stored organs
			organ_names += organ.name// get proper names off the items
		name = "[initial(name)] ([english_list(organ_names)])"// repopulate our name
	else// if no multis
		name = initial(name)// we just park ourselves its ok

// Handles the insertion of stacking organs in something that was never meant to stack organs
/obj/item/autosurgeon/multi/load_organ(obj/item/organ/loaded_organ, mob/living/user)
	if(user)
		if(length(stored_organs) >= max_organs)// if list length exceeds var set above
			to_chat(user, span_alert("[src] cannot hold any more implants."))// tell the dork
			return// go home

		if(uses <= 0)// if this has configurable use counts and its spent
			to_chat(user, span_alert("[src] is used up and cannot be loaded with more implants."))// tell them
			return// sleep

		if(organ_whitelist.len)// Checks our whitelist for anything in it
			var/organ_whitelisted// var to poke about
			for(var/whitelisted_organ in organ_whitelist)// populates our var with our whitelist
				if(istype(loaded_organ, whitelisted_organ))// if the type we are trying to load
					organ_whitelisted = TRUE// set a bool we can check
					break
			if(!organ_whitelisted)// down here if its not true
				to_chat(user, span_alert("[src] is not compatible with [loaded_organ]."))// break the news
				return// close the door

		if(!user.transferItemToLoc(loaded_organ, src))// no magically exfilling items out of your hand that you shouldnt be getting rid of, by checking if you can transfer it. crazy stuff
			to_chat(user, span_alert("[loaded_organ] is stuck to your hand!"))// silly goober turn off your antidrop or get rid of possessive or whatever
			return// its over

	stored_organs += loaded_organ// append our storage with the item we were processing
	loaded_organ.forceMove(src)// move it physically inside of the multisurgeon
	update_multi_name()// run our name update
	update_appearance()// run our img update

// Now we use our storage
/obj/item/autosurgeon/multi/use_autosurgeon(mob/living/target, mob/living/user, implant_time)
	if(!length(stored_organs))// if we arent storing anything
		to_chat(user, span_alert("[src] currently has no implants stored."))// state the apparently not obvious truth
		return// were done

	if(uses <= 0)// if its charge based and out of charges
		to_chat(user, span_alert("[src] has already been used. The tools are dull and won't reactivate."))// you cant use this anymore
		return// to dust

	if(implant_time)// ITS IMPLANTIN' TIME
		user.visible_message(
			span_notice("[user] prepares to use [src] on [target]."),
			span_notice("You prepare to use [src] on [target]."),
		)// Notify we're starting our action
		if(!do_after(user, (implant_time * surgery_speed), target))// check the usual suspects for our do after
			return// is done

	if(target != user)// If we use this on someone other than ourselves
		log_combat(user, target, "autosurgeon implanted [english_list(stored_organs)] into", "[src]", "in [AREACOORD(target)]")// Combat log its usage
		user.visible_message(span_notice("[user] presses a button on [src] as it plunges into [target]'s body."), span_notice("You press a button on [src] as it plunges into [target]'s body."))// Tell everyone nearby what we did. Or you.
	else
		user.visible_message(
			span_notice("[user] presses a button on [src] as it plunges into [user.p_their()] body."),
			span_notice("You press a button on [src] as it plunges into your body."),
		)

	var/list/installed = list()// holding bin for things were inserting
	var/list/failed = list()// holding bin for things we are not inserting
	for(var/obj/item/organ/organ as anything in stored_organs)// gets our organ(s) to work with
		if(organ.valid_zones && user.get_held_index_of_item(src))// checks if we can actually install
			var/list/checked_zones = list(user.zone_selected)// maps the zone to a var to poke
			if(IS_RIGHT_INDEX(user.get_held_index_of_item(src)))// handles the problems of body orientation while holding the surgeon. similar to parent
				checked_zones += list(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG)
			else
				checked_zones += list(BODY_ZONE_L_ARM, BODY_ZONE_L_LEG)
			for(var/check_zone in checked_zones)// passes off our notesheet
				if(organ.valid_zones[check_zone])// run check by choice
					organ.swap_zone(check_zone)
					break

		if(organ.Insert(target))// if we are planning to actually shove this in them
			installed += organ// add to the list todo
		else
			failed += organ// otherwise put it to the side

	stored_organs -= installed// remove our to be installed items from the storage proper
	update_multi_name()// update our name immediately after doing so

	if(length(installed))// we have stuff in installed
		playsound(target.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)// same as autosurgeon
	if(length(failed))// collects our washouts
		balloon_alert(user, "[length(failed)] insertion[length(failed) > 1 ? "s" : ""] failed!")// informs our user

	update_appearance()// update appearance based on results of above performance

	uses--// reduce our uses if we got this far
	if(uses <= 0)// if that was the last monkey finger
		desc = "[initial(desc)] Looks like it's been used up."// tell them its trash now

// handles removing our stack of nonsense
/obj/item/autosurgeon/multi/screwdriver_act(mob/living/user, obj/item/screwtool)
	if(..())// what even is that? the parent uses it, I'm not touching that
		return TRUE
	if(!length(stored_organs))// if theres nothing in our list
		to_chat(user, span_warning("There's no implant in [src] for you to remove!"))// surprise, nothing to remove
	else// if there is something in our list
		var/atom/drop_loc = user.drop_location()// prep our drop location
		for(var/obj/item/organ/organ as anything in stored_organs)// from anything in our multistor
			organ.forceMove(drop_loc)// and then i threw it on the ground
		to_chat(user, span_notice("You remove all implants from [src]."))// yeah, we threw it on the ground
		stored_organs = list()
		update_multi_name()// update our name again

		screwtool.play_tool_sound(src)// it is mandatory to have feedback
		uses--// FUSSING COSTS TIME AND ENERGY
		if(uses <= 0)// if its useless
			desc = "[initial(desc)] Looks like it's been used up."// let them know???
		update_appearance(UPDATE_ICON)// update our icon one last time
	return TRUE
// NOVA EDIT END
