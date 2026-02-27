#define COSGLOW_OPACITY_MIN 32
#define COSGLOW_OPACITY_MAX 128
#define COSGLOW_OPACITY_DEFAULT 30
#define COSGLOW_THICKNESS_MIN 1
#define COSGLOW_THICKNESS_MAX 3
#define COSGLOW_THICKNESS_DEFAULT 2
#define COSGLOW_LAMP_RANGE_MIN 0
#define COSGLOW_LAMP_RANGE_MAX 2
#define COSGLOW_LAMP_RANGE_DEFAULT 1.5
#define COSGLOW_LAMP_POWER_MIN 0.5
#define COSGLOW_LAMP_POWER_MAX 1.5
#define COSGLOW_LAMP_POWER_DEFAULT 1
#define COSGLOW_LAMP_COLOR COLOR_WHITE

// You might be an undercover agent.
/datum/quirk/cosglow
	name = "Illuminated"
	desc = "You emit a customizable soft glow! This isn't bright enough to replace your flashlight."
	value = 0
	gain_text = span_notice("You feel glowy!")
	lose_text = span_notice("You loose that glow!")
	medical_record_text = "Patient emits a subtle emissive aura."
	mob_trait = TRAIT_COSGLOW
	icon = FA_ICON_MAGIC_WAND_SPARKLES
	mail_goodies = list (
		/obj/item/flashlight/glowstick = 1
	)
	/// The action to update the glow
	var/datum/action/cosglow/glow_control_action

/datum/quirk/cosglow/add(client/client_source)
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add glow control action
	glow_control_action = new
	glow_control_action.Grant(quirk_mob)

/datum/quirk/cosglow/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	QDEL_NULL(glow_control_action)

	// Remove glow effect
	quirk_mob.remove_filter("rad_fiend_glow")

// Light emitting status effect
/datum/status_effect/cosglow
	status_type = STATUS_EFFECT_REPLACE
	id = "cosglow"
	alert_type = null
	/// Light effect object
	var/obj/effect/dummy/lighting_obj/moblight/cosglow_light_obj

/datum/status_effect/cosglow/on_apply()
	// Set light values
	// Ignores range settings to prevent crew becoming lanterns
	cosglow_light_obj = owner.mob_light(range = COSGLOW_LAMP_RANGE_DEFAULT, power = COSGLOW_LAMP_POWER_DEFAULT, color = COSGLOW_LAMP_COLOR)
	return TRUE

/datum/status_effect/cosglow/on_remove()
	// Remove light
	QDEL_NULL(cosglow_light_obj)

/datum/status_effect/cosglow/get_examine_text()
	return span_notice("[owner.p_They()] emit[owner.p_s()] a harmless glowing aura.")

// Glow actions
/datum/action/cosglow
	name = "Modify Glow"
	desc = "Adjust your glow aura color and thickness."
	button_icon = 'icons/obj/lighting.dmi'
	button_icon_state = "slime-on"
	check_flags = AB_CHECK_CONSCIOUS

	// Default glow color to use
	/// Analogous to radiation color
	var/glow_color = "#14FF67"

	/// Default thickness of glow outline
	var/glow_thickness = COSGLOW_THICKNESS_DEFAULT

	/// Default alpha of the glow outline
	var/glow_opacity = COSGLOW_OPACITY_DEFAULT

	/// Light range of the attached object
	var/light_obj_power = COSGLOW_LAMP_POWER_DEFAULT

/datum/action/cosglow/Grant(mob/grant_to)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = grant_to

	// Add outline effect
	action_mob.add_filter("rad_fiend_glow", 1, outline_filter("color" = glow_color + "[glow_opacity]", "size" = glow_thickness))

	// Define filter
	var/filter = action_mob.get_filter("rad_fiend_glow")

	// Animate glow
	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)

	// Apply status effect
	action_mob.apply_status_effect(/datum/status_effect/cosglow, TRAIT_COSGLOW)

/datum/action/cosglow/Remove(mob/remove_from)
	. = ..()

	// Define user mob
	var/mob/living/carbon/human/action_mob = remove_from

	// Remove glow
	action_mob.remove_filter("rad_fiend_glow")

	// Remove status effect
	action_mob.remove_status_effect(/datum/status_effect/cosglow, TRAIT_COSGLOW)

/datum/action/cosglow/Trigger(trigger_flags)
	. = ..()

	// Check parent return
	if(!.)
		return

	// Define user mob
	var/mob/living/carbon/human/action_mob = owner

	// Ask user for color input
	var/input_color = input(action_mob, "Select a color to use for your glow outline.", "Select Glow Color", glow_color) as color|null

	// Check if color input was given
	// Reset to stored color when not given input
	glow_color = (input_color ? input_color : glow_color)

	// Ask user for thickness input
	switch(tgui_alert(action_mob, message = "How thick is your glow outline?", buttons = list("Light", "Regular", "Bold")))
		// Set based on input
		if ("Light")
			glow_thickness = COSGLOW_THICKNESS_MIN
			light_obj_power = COSGLOW_LAMP_POWER_MIN

		if ("Regular")
			glow_thickness = COSGLOW_THICKNESS_DEFAULT
			light_obj_power = COSGLOW_LAMP_POWER_DEFAULT

		if ("Bold")
			glow_thickness = COSGLOW_THICKNESS_MAX
			light_obj_power = COSGLOW_LAMP_POWER_MAX
		else
			return
	// Update outline effect
	action_mob.add_filter("rad_fiend_glow", 1, outline_filter("color" = glow_color + "[glow_opacity]", "size" = glow_thickness))

	// Define filter
	var/filter = action_mob.get_filter("rad_fiend_glow")

	// Animate filter
	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)

	// Find status effect
	var/datum/status_effect/cosglow/glow_effect = locate() in action_mob.status_effects

	// Update status effect light range
	glow_effect?.cosglow_light_obj?.set_light_power(light_obj_power)

#undef COSGLOW_OPACITY_MIN
#undef COSGLOW_OPACITY_MAX
#undef COSGLOW_OPACITY_DEFAULT
#undef COSGLOW_THICKNESS_MIN
#undef COSGLOW_THICKNESS_MAX
#undef COSGLOW_THICKNESS_DEFAULT
#undef COSGLOW_LAMP_RANGE_MIN
#undef COSGLOW_LAMP_RANGE_MAX
#undef COSGLOW_LAMP_RANGE_DEFAULT
#undef COSGLOW_LAMP_POWER_MIN
#undef COSGLOW_LAMP_POWER_MAX
#undef COSGLOW_LAMP_POWER_DEFAULT
#undef COSGLOW_LAMP_COLOR
