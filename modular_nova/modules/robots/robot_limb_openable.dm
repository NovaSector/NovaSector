#define STATE_ROBOTIC_CLOSED 0
#define STATE_ROBOTIC_SCREWDRIVERED 1
#define STATE_ROBOTIC_OPEN 2

/datum/component/robotic_limb_openable
	var/state = STATE_ROBOTIC_CLOSED

/datum/component/robotic_limb_openable/Initialize()
	if(!istype(parent, /obj/item/bodypart))
		return COMPONENT_INCOMPATIBLE

/datum/component/robotic_limb_openable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_BODYPART_ATTACHED, PROC_REF(on_attached))
	RegisterSignal(parent, COMSIG_BODYPART_REMOVED, PROC_REF(on_detached))

/datum/component/robotic_limb_openable/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_BODYPART_ATTACHED, COMSIG_BODYPART_REMOVED))

/datum/component/robotic_limb_openable/proc/on_attached(obj/item/bodypart/chest/robot/this_bodypart, mob/living/carbon/human/new_owner)
	SIGNAL_HANDLER
	RegisterSignal(new_owner, COMSIG_ATOM_ATTACKBY, PROC_REF(tool_usage))
	RegisterSignal(new_owner, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_clicked_empty_hand))

/datum/component/robotic_limb_openable/proc/on_detached(obj/item/bodypart/chest/robot/this_bodypart, mob/living/carbon/human/old_owner)
	SIGNAL_HANDLER
	UnregisterSignal(old_owner, list(COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND))

/datum/component/robotic_limb_openable/proc/on_clicked_empty_hand(datum/source, mob/living/user)
	SIGNAL_HANDLER
	if(user.combat_mode)
		return
	var/obj/item/bodypart/bodypart = parent
	var/mob/living/carbon/target = bodypart.owner
	if(target.get_bodypart(check_zone(user.zone_selected)) != parent)
		return // wrong limb
	INVOKE_ASYNC(src, PROC_REF(on_clicked_empty_hand_real), source, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/robotic_limb_openable/proc/on_clicked_empty_hand_real(datum/source, mob/living/user)
	var/obj/item/bodypart/bodypart = parent
	var/mob/living/carbon/target = bodypart.owner
	if(state == STATE_ROBOTIC_OPEN)
		var/list/organs = target.get_organs_for_zone(bodypart.body_zone, include_children = TRUE)
		if(!length(organs))
			to_chat(user, span_warning("There are no removable organs in [target]'s [target.parse_zone_with_bodypart(user.zone_selected)]!"))
			return
		else
			for(var/obj/item/organ/organ in organs)
				organ.on_find(user)
				organs -= organ
				organs[organ.name] = organ

			var/chosen_organ = tgui_input_list(user, "Remove which organ?", "Organ Manipulation", sort_list(organs))
			if(isnull(chosen_organ))
				return
			if(!target.Adjacent(user))
				return // walked away, nice try input staller
			var/obj/item/organ/target_organ = organs[chosen_organ]
			user.balloon_alert_to_viewers("extracting [LOWER_TEXT(target_organ)]...")
			if(do_after(user, /datum/surgery_operation/limb/organ_manipulation::time, target))
				if(state == STATE_ROBOTIC_OPEN) // in case they closed the panel
					target_organ.Remove(target)
					user.put_in_active_hand(target_organ)
					user.balloon_alert_to_viewers("extracted [LOWER_TEXT(target_organ)]")
					target_organ.on_surgical_removal(user, target, user.zone_selected, null)
				else
					user.balloon_alert_to_viewers("failed to extract, panel closed!")
					return
			else
				user.balloon_alert_to_viewers("failed to extract, interrupted!")
				return

/datum/component/robotic_limb_openable/proc/tool_usage(datum/source, obj/item/item, mob/user)
	SIGNAL_HANDLER
	var/mob/living/living = user
	var/obj/item/bodypart/bodypart = parent
	var/mob/living/carbon/target = bodypart.owner
	if(living.combat_mode) // we dont give a shit, do violence
		return
	if(target.get_bodypart(check_zone(user.zone_selected)) != parent)
		return // wrong limb
	INVOKE_ASYNC(src, PROC_REF(tool_usage_real), source, item, user)
	if(item.tool_behaviour == TOOL_CROWBAR || item.tool_behaviour == TOOL_SCREWDRIVER || istype(item, /obj/item/organ))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	else
		return

/datum/component/robotic_limb_openable/proc/tool_usage_real(datum/source, obj/item/item, mob/user)
	var/obj/item/bodypart/bodypart = parent
	var/mob/living/carbon/target = bodypart.owner
	switch(state)
		if(STATE_ROBOTIC_CLOSED)
			if(item.tool_behaviour == TOOL_SCREWDRIVER)
				item.play_tool_sound(source)
				user.balloon_alert_to_viewers("unscrewing panel...")
				if(do_after(user, 2 SECONDS, target))
					item.play_tool_sound(source)
					user.balloon_alert_to_viewers("unscrewed panel")
					state = STATE_ROBOTIC_SCREWDRIVERED
					return
				else
					user.balloon_alert_to_viewers("failed to unscrew!")
					return
			if(item.tool_behaviour == TOOL_CROWBAR)
				user.balloon_alert_to_viewers("unscrew panel first!")
				return
		if(STATE_ROBOTIC_SCREWDRIVERED)
			if(item.tool_behaviour == TOOL_SCREWDRIVER)
				item.play_tool_sound(source)
				user.balloon_alert_to_viewers("securing panel...")
				if(do_after(user, 2 SECONDS, target))
					item.play_tool_sound(source)
					user.balloon_alert_to_viewers("secured panel")
					state = STATE_ROBOTIC_CLOSED
					return
				else
					user.balloon_alert_to_viewers("failed to secure!")
					return
			if(item.tool_behaviour == TOOL_CROWBAR)
				item.play_tool_sound(source)
				user.balloon_alert_to_viewers("opening panel...")
				if(do_after(user, 2 SECONDS, target))
					item.play_tool_sound(source)
					user.balloon_alert_to_viewers("opened panel")
					state = STATE_ROBOTIC_OPEN
					return
				else
					user.balloon_alert_to_viewers("failed to open panel!")
					return
		if(STATE_ROBOTIC_OPEN)
			if(item.tool_behaviour == TOOL_SCREWDRIVER)
				user.balloon_alert_to_viewers("close panel first!")
				return
			if(item.tool_behaviour == TOOL_CROWBAR)
				item.play_tool_sound(source)
				user.balloon_alert_to_viewers("closing panel...")
				if(do_after(user, 2 SECONDS, target))
					item.play_tool_sound(source)
					user.balloon_alert_to_viewers("closed panel")
					state = STATE_ROBOTIC_SCREWDRIVERED
					return
				else
					user.balloon_alert_to_viewers("failed to close panel!")
					return
			if(istype(item, /obj/item/organ))
				var/obj/item/organ/organ_to_insert = item
				if(!organ_to_insert.pre_surgical_insertion(user, target, user.zone_selected, null))
					user.balloon_alert_to_viewers("failed to insert!")
					return
				if(check_zone(user.zone_selected) != check_zone(organ_to_insert.zone) || target.get_organ_slot(organ_to_insert.slot))
					user.balloon_alert_to_viewers("failed to insert, no room!")
					return
				if(!organ_to_insert.useable)
					user.balloon_alert_to_viewers("failed to insert, chewed on!")
					return
				user.balloon_alert_to_viewers("inserting [LOWER_TEXT(organ_to_insert)]...")
				if(do_after(user, /datum/surgery_operation/limb/organ_manipulation::time, target))
					if(target.get_organ_slot(organ_to_insert.slot))
						user.balloon_alert_to_viewers("failed to insert, no room!")
						return
					if(!organ_to_insert.useable)
						user.balloon_alert_to_viewers("failed to insert, chewed on!")
						return
					if(state == STATE_ROBOTIC_OPEN) // in case they closed the panel
						user.temporarilyRemoveItemFromInventory(organ_to_insert, TRUE)
						organ_to_insert.Insert(target)
						user.balloon_alert_to_viewers("inserted [LOWER_TEXT(organ_to_insert)]")
						organ_to_insert.on_surgical_insertion(user, target, user.zone_selected, null)
					else
						user.balloon_alert_to_viewers("failed to insert, panel closed!")
						return
				else
					user.balloon_alert_to_viewers("failed to insert, interrupted!")
					return
