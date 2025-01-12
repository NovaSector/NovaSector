/datum/component/avatar_connection/Initialize(
	datum/mind/old_mind,
	mob/living/old_body,
	obj/machinery/quantum_server/server,
	obj/machinery/netpod/pod,
	help_text,
	)
	. = ..()
	var/mob/living/avatar = parent
	if(!locate(/datum/action/emergency_disconnect) in avatar.actions)
		var/datum/action/emergency_disconnect/action = new(avatar)
		action.Grant(avatar)

/// Displays information about the current virtual domain.
/datum/action/emergency_disconnect
	name = "Emergency Connection Severing"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_power"
	show_to_observers = FALSE

/datum/action/emergency_disconnect/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	var/mob/living/living_owner = owner
	if(!isliving(living_owner))
		return

	if(tgui_alert(living_owner, "Disconnect safely?", "Server Message", list("Exit", "Remain"), 10 SECONDS) == "Exit")
		SEND_SIGNAL(living_owner, COMSIG_BITRUNNER_ALERT_SEVER)
