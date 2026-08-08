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
			uses--// reduce our uses if we got this far
		else
			failed += organ// otherwise put it to the side

	stored_organs -= installed// remove our to be installed items from the storage proper
	update_multi_name()// update our name immediately after doing so

	if(length(installed))// we have stuff in installed
		playsound(target.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)// same as autosurgeon
	if(length(failed))// collects our washouts
		balloon_alert(user, "[length(failed)] insertion[length(failed) > 1 ? "s" : ""] failed!")// informs our user

	update_appearance()// update appearance based on results of above performance

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

/obj/item/autosurgeon/toolset
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/toolset

/obj/item/autosurgeon/surgery
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/surgery

/obj/item/autosurgeon/botany
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/botany

/obj/item/autosurgeon/janitor
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/janitor

/obj/item/autosurgeon/armblade
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/armblade

/obj/item/autosurgeon/muscle
	starting_organ = /obj/item/organ/cyberimp/arm/strongarm

//syndie
/obj/item/autosurgeon/syndicate/hackerman
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/hacker

/obj/item/autosurgeon/syndicate/esword_arm
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/esword

/obj/item/autosurgeon/syndicate/nodrop
	starting_organ = /obj/item/organ/cyberimp/brain/anti_drop

/obj/item/autosurgeon/syndicate/baton
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/baton

/obj/item/autosurgeon/syndicate/flash
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/flash

//bodypart
/obj/item/autosurgeon/bodypart/r_arm_robotic
	starting_bodypart = /obj/item/bodypart/arm/right/robot

/obj/item/autosurgeon/bodypart/r_arm_robotic/Initialize(mapload)
	. = ..()
	storedbodypart.icon = 'modular_nova/master_files/icons/mob/augmentation/hi2ipc.dmi'

//xeno-organs
/obj/item/autosurgeon/xeno
	name = "strange autosurgeon"
	icon = 'modular_nova/modules/moretraitoritems/icons/alien.dmi'
	surgery_speed = 2
	organ_whitelist = list(/obj/item/organ/alien)

/obj/item/organ/alien/plasmavessel/opfor
	stored_plasma = 500
	max_plasma = 500
	plasma_rate = 10

/obj/item/storage/organbox/strange
	name = "strange organ transport box"
	icon = 'modular_nova/modules/moretraitoritems/icons/alien.dmi'

/obj/item/storage/organbox/strange/Initialize(mapload)
	. = ..()
	reagents.add_reagent_list(list(/datum/reagent/cryostylane = 60))

/obj/item/storage/organbox/strange/PopulateContents()
	new /obj/item/autosurgeon/xeno(src)
	new /obj/item/organ/alien/plasmavessel/opfor(src)
	new /obj/item/organ/alien/resinspinner(src)
	new /obj/item/organ/alien/acid(src)
	new /obj/item/organ/alien/neurotoxin(src)
	new /obj/item/organ/alien/hivenode(src)

/obj/item/storage/organbox/strange/eggsac/PopulateContents()
	. = ..()
	new /obj/item/organ/alien/eggsac(src)
