#define SHAPESHIFTER_ACTIONS_ICON_FILE 'modular_nova/modules/shapeshifter_quirk/icons/actions_shapeshift.dmi'

/datum/action/innate/alter_form/quirk
	name = "Shapeshift"
	slime_restricted =  FALSE
	button_icon = 'modular_nova/master_files/icons/mob/actions/actions_slime.dmi'
	button_icon_state = "dna"
	shapeshift_text = "closes their eyes to focus, their body subtly shifting and contorting."

/datum/action/innate/alter_form/quirk/generate_radial_icons()
	..()
	bodycolours_icon = image(icon = SHAPESHIFTER_ACTIONS_ICON_FILE, icon_state = "transform_all")
	primarycolour_icon = image(icon = SHAPESHIFTER_ACTIONS_ICON_FILE, icon_state = "transform_red")
	secondarycolour_icon = image(icon = SHAPESHIFTER_ACTIONS_ICON_FILE, icon_state = "transform_blue")
	tertiarycolour_icon = image(icon = SHAPESHIFTER_ACTIONS_ICON_FILE, icon_state = "transform_green")
	allcolours_icon = image(icon = SHAPESHIFTER_ACTIONS_ICON_FILE, icon_state = "transform_all")

#undef SHAPESHIFTER_ACTIONS_ICON_FILE
