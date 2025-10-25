/// If Solfed communications are allowed
GLOBAL_VAR_INIT(allow_solfed_signal, TRUE)

/// If the Red Alert solfed Distress system is allowed to be pressed.
GLOBAL_VAR_INIT(allow_redalert_distress_signal, TRUE)

ADMIN_VERB(toggle_solfed_signals, R_ADMIN, "Toggle Solfed Signals", "Toggles the ability for any solfed communication to be made", ADMIN_CATEGORY_GAME)
	GLOB.allow_solfed_signal = !GLOB.allow_solfed_signal

	message_admins("[ADMIN_LOOKUPFLW(usr)] [GLOB.allow_solfed_signal? "allowed" : "disallowed"] Sol Federation Distress Beacon (Red Alert System)")
	log_admin("[key_name(user)] [GLOB.allow_solfed_signal? "allowed" : "disallowed"] Sol Federation Distress Beacon (Red Alert System)")


ADMIN_VERB(toggle_solfed_distress_signal, R_ADMIN, "Toggle SolFed Distress Signal", "Toggles the ability for the station to send an SOS signal (Red Alert System)", ADMIN_CATEGORY_GAME)
	GLOB.allow_redalert_distress_signal = !GLOB.allow_redalert_distress_signal

	message_admins("[ADMIN_LOOKUPFLW(usr)] [GLOB.allow_redalert_distress_signal? "allowed" : "disallowed"] Sol Federation Distress Beacon (Red Alert System)")
	log_admin("[key_name(user)] [GLOB.allow_redalert_distress_signal? "allowed" : "disallowed"] Sol Federation Distress Beacon (Red Alert System)")
