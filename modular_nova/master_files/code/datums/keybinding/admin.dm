// Keybinding setup for code\modules\admin\admin_verbs.dm:toggle_admin_esp
/datum/keybinding/admin/toggle_admin_esp
	hotkey_keys = null
	name = "admin_esp"
	full_name = "Admin ESP / Ghost Eyes"
	description = "Toggles your Admin ESP shinigami-styled eyes. Lets you see ghosts!"
	keybind_signal = COMSIG_KB_ADMIN_ESP_DOWN

/datum/keybinding/admin/toggle_admin_esp/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/toggle_admin_esp)
	return TRUE
