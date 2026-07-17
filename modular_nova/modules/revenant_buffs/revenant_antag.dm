// revenant antag datum is given on login, so this should be fine
/datum/antagonist/revenant/on_gain()
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(pick_name), owner.current)

/datum/antagonist/revenant/proc/pick_name(mob/living/basic/revenant/revenant)
	if(!istype(revenant))
		CRASH("Somehow a non-revenant got a revenant antag datum?")
	var/new_name = sanitize_name(reject_bad_text(tgui_input_text(revenant, "Would you like to change your ghostly name to something else?", "Spooky Identity", revenant.name, MAX_NAME_LEN, encode = FALSE)), allow_numbers = TRUE)
	if(!new_name || new_name == revenant.name)
		if(tgui_alert(revenant, "Are you sure you would like to keep your default name of \"[revenant.name]\"?", "Spooky Identity", list("Yes", "No")) == "Yes")
			return

	new_name = sanitize_name(reject_bad_text(tgui_input_text(revenant, "What would you like your ghostly name to be?", "Spooky Identity", revenant.name, MAX_NAME_LEN, encode = FALSE)), allow_numbers = TRUE)
	if(!new_name)
		return

	revenant.log_message("set their revenant name to [new_name]", LOG_OWNERSHIP)
	revenant.fully_replace_character_name(null, new_name)
	to_chat(revenant, span_revennotice("Your name is now \"[span_name(new_name)]\"."), type = MESSAGE_TYPE_INFO)
	return
