/datum/component/bloodwashed_ghost_pollable_soulstone
	/// TRUE while the shard is already polling ghosts.
	var/polling = FALSE
	/// TRUE once the free ghost-poll soul has been successfully claimed.
	var/poll_consumed = FALSE

/datum/component/bloodwashed_ghost_pollable_soulstone/Initialize()
	if(!istype(parent, /obj/item/soulstone))
		return COMPONENT_INCOMPATIBLE

/datum/component/bloodwashed_ghost_pollable_soulstone/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_attack_self))

/datum/component/bloodwashed_ghost_pollable_soulstone/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ATOM_EXAMINE, COMSIG_ITEM_ATTACK_SELF))

/datum/component/bloodwashed_ghost_pollable_soulstone/proc/on_examine(obj/item/soulstone/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!poll_consumed && !length(source.contents) && (source.role_check(user) || isobserver(user)))
		examine_list += span_cult("The shard hums with a hollow invitation. Activate it in hand to call for a willing shade.")

/datum/component/bloodwashed_ghost_pollable_soulstone/proc/on_attack_self(obj/item/soulstone/source, mob/living/user)
	SIGNAL_HANDLER

	if(poll_consumed || length(source.contents) || !source.role_check(user))
		return NONE
	if(!in_range(source, user))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	if(polling)
		to_chat(user, span_warning("[source] is already calling into the veil."))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	INVOKE_ASYNC(src, PROC_REF(poll_for_shade), source, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/bloodwashed_ghost_pollable_soulstone/proc/poll_for_shade(obj/item/soulstone/source, mob/living/user)
	if(QDELETED(source) || QDELETED(user) || !user.is_holding(source))
		return

	polling = TRUE
	ADD_TRAIT(source, TRAIT_NODROP, REF(src))
	to_chat(user, span_cult_italic("You raise [source], and the shard begins whispering to the dead..."))

	var/mob/dead/observer/ghost = SSpolling.poll_ghosts_for_target(
		check_jobban = ROLE_CULTIST,
		poll_time = 20 SECONDS,
		checked_target = source,
		ignore_category = POLL_IGNORE_SHADE,
		alert_pic = /mob/living/basic/shade,
		jump_target = source,
		role_name_text = "a bloodwashed shade",
		chat_text_border_icon = /mob/living/basic/shade,
	)

	if(QDELETED(source) || QDELETED(user))
		return cleanup_poll(source)
	if(!user.is_holding(source) || !in_range(source, user))
		to_chat(user, span_warning("[source]'s whisper fades as it leaves your grasp."))
		return cleanup_poll(source)
	if(length(source.contents))
		return cleanup_poll(source)
	if(isnull(ghost?.client))
		to_chat(user, span_warning("There were no spirits willing to answer [source]."))
		return cleanup_poll(source)

	var/mob/living/basic/shade/bloodwashed_shade = new /mob/living/basic/shade(source)
	bloodwashed_shade.AddComponent(/datum/component/soulstoned, source)
	bloodwashed_shade.name = "Bloodwashed Shade"
	bloodwashed_shade.real_name = "Bloodwashed Shade"
	bloodwashed_shade.PossessByPlayer(ghost.key)
	bloodwashed_shade.copy_languages(user, LANGUAGE_MASTER)
	bloodwashed_shade.get_language_holder().omnitongue = TRUE
	bloodwashed_shade.add_ally(user)
	source.assign_master(bloodwashed_shade, user)
	bloodwashed_shade.cancel_camera()
	source.update_appearance()

	to_chat(user, "[span_info("<b>Capture successful!</b>:")] A willing shade has entered [source].")
	to_chat(bloodwashed_shade, span_bold("You have answered a Bloodwashed soulstone's call. You are bound to the cult's will and to [user.real_name]. Help [user.p_them()] pursue [user.p_their()] dark purpose."))
	playsound(source, 'sound/effects/ghost.ogg', 50, TRUE)
	SSblackbox.record_feedback("tally", "cult_shade_created", 1)

	poll_consumed = TRUE
	cleanup_poll(source)

/datum/component/bloodwashed_ghost_pollable_soulstone/proc/cleanup_poll(obj/item/soulstone/source)
	if(!QDELETED(source))
		REMOVE_TRAIT(source, TRAIT_NODROP, REF(src))
	polling = FALSE
