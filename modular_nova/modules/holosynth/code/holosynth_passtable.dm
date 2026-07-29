/datum/movespeed_modifier/holosynth_passtable
	multiplicative_slowdown = 1.5

/datum/action/innate/holosynth_toggle_passtable
	name = "Toggle Table Phasing"
	desc = "Toggle phasing through tables freely"
	button_icon = 'icons/hud/radial.dmi'
	button_icon_state = "table"
	//Variable to keep track of toggle state
	var/table_toggle = FALSE

/datum/action/innate/holosynth_toggle_passtable/Activate()
	if(!table_toggle)
		owner.add_traits(list(TRAIT_PASSTABLE, TRAIT_IGNORE_ELEVATION), type)
		owner.add_movespeed_modifier(/datum/movespeed_modifier/holosynth_passtable)
	else
		owner.remove_traits(list(TRAIT_PASSTABLE, TRAIT_IGNORE_ELEVATION), type)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/holosynth_passtable)
	table_toggle = !table_toggle
	to_chat(owner, span_notice("Table phasing [table_toggle ? "enabled" : "disabled"]."))
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

/datum/action/innate/holosynth_toggle_passtable/Destroy(force)
	if(owner)
		owner.remove_traits(list(TRAIT_PASSTABLE, TRAIT_IGNORE_ELEVATION), type)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/holosynth_passtable)
	return ..()

/datum/action/innate/holosynth_toggle_passtable/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return table_toggle
