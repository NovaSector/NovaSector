/obj/item/grenade/flashbang/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/grenade/flashbang/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!is_currently_forbidden(user))
		return

	context[SCREENTIP_CONTEXT_CTRL_LMB] = "Break Company Policy! There will be consequences..."
	return CONTEXTUAL_SCREENTIP_SET

/// If the company policy currently forbids flashbangs during green alert
/obj/item/grenade/flashbang/proc/is_currently_forbidden(mob/user)
	if(!CONFIG_GET(flag/flashbangs_forbidden_during_green))
		return FALSE

	if(SSsecurity_level.get_current_level_as_number() != SEC_LEVEL_GREEN)
		return FALSE

	if(!(user.mind?.assigned_role.departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY|DEPARTMENT_BITFLAG_COMMAND)))
		return FALSE

	return TRUE

// Security members are not supposed to use flashbangs during green alert, as per company policy.
// Disobeying this policy will result in IC consequences.
/obj/item/grenade/flashbang/attack_self(mob/user, modifiers, breaking_policy = FALSE)
	if(active || HAS_TRAIT(src, TRAIT_NODROP) || !is_currently_forbidden(user))
		return ..()

	if(breaking_policy)
		var/crew_to_alert = list(
			JOB_CAPTAIN,
			JOB_WARDEN,
			JOB_DETECTIVE,
			JOB_HEAD_OF_SECURITY,
		)
		var/message = "<span class='doyourjobidiot'><b>\n\nWARNING: Breach of company policy detected!:</b></span>\n\n[user], \
		<b>[user.mind?.assigned_role.title]</b> has armed a flashbang during security level green! \
		This is a violation of corporate regulations, and should be investigated immediately."
		silent_alert(user, src, crew_to_alert, message)
		return ..()
	else
		to_chat(user, span_doyourjobidiot("The use of flashbangs when the security level is green is a violation of company policy!\nTo \
		bypass this restriction and arm the flashbang anyway, CTRL + Click it (be prepared to have a good reason for doing this!)."))
		return

// CTRL + Click to willingly bypass the green alert restriction
/obj/item/grenade/flashbang/item_ctrl_click(mob/user)
	attack_self(user, breaking_policy = TRUE)
	return CLICK_ACTION_SUCCESS

/// Sends a silent alert message to certain crew members' PDAs
/proc/silent_alert(mob/sender, atom/source, crew_to_alert, message)
	// build list of alt titles + base titles. We have to do this because the pda's saved_job uses the alt_title string instead of the job datum.
	var/list/base_title_by_alt_title = list()
	for(var/job_title in crew_to_alert)
		var/datum/job/job_datum = SSjob.get_job(job_title)
		for(var/alt_job_title in job_datum.alt_titles)
			base_title_by_alt_title[alt_job_title] = job_title

	for(var/messenger_ref in GLOB.pda_messengers)
		var/datum/computer_file/program/messenger/messenger = GLOB.pda_messengers[messenger_ref]
		if(!length(crew_to_alert))
			break
		if(sender.name == messenger.computer.saved_identification) // don't alert yourself
			continue
		// Alt titles exist, so we need to check all of the possible titles
		if(!(base_title_by_alt_title[messenger.computer.saved_job] in crew_to_alert))
			continue

		var/datum/signal/subspace/messaging/tablet_message/signal = new(source, list(
			"fakename" = "NanoTrasen Corp Alerts",
			"fakejob" = "Flashbang Watchdog",
			"message" = message,
			"targets" = list(messenger),
			"automated" = TRUE
		))
		signal.send_to_receivers()
		sender.log_message("(PDA: Flashbang Alerts) sent \"[message]\" to [signal.format_target()]", LOG_PDA)

	return TRUE

// Keybindings
/datum/keybinding/mob/ctrl_activate_inhand
	hotkey_keys = list("CtrlZ")
	name = "ctrl-activate_inhand"
	full_name = "CTRL-Activate in-hand"
	description = "Uses whatever item you have inhand"
	keybind_signal = COMSIG_KB_MOB_CTRL_ACTIVATEINHAND_DOWN

/datum/keybinding/mob/ctrl_activate_inhand/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/user_mob = user.mob
	if(ismecha(user_mob.loc))
		return

	if(user_mob.incapacitated)
		return

	var/obj/item/held_item = user_mob.get_active_held_item()
	if(held_item)
		user_mob.CtrlClickOn(held_item)
		user_mob.update_held_items()

	return TRUE
