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

/datum/quirk_constant_data/cosglow
	associated_typepath = /datum/quirk/cosglow
	customization_options = list(
		/datum/preference/color/cosglow_glow_color,
		/datum/preference/numeric/cosglow_thickness,
	)

/datum/preference/color/cosglow_glow_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "cosglow_glow_color"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/cosglow_glow_color/create_default_value()
	return "#14FF67"

/datum/preference/color/cosglow_glow_color/apply_to_human()
	return

/datum/preference/numeric/cosglow_thickness
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "cosglow_thickness"
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = COSGLOW_THICKNESS_MIN
	maximum = COSGLOW_THICKNESS_MAX
	step = 0.5

/datum/preference/numeric/cosglow_thickness/apply_to_human()
	return

/datum/preference/numeric/cosglow_thickness/create_default_value()
	return COSGLOW_THICKNESS_DEFAULT

/datum/quirk/cosglow
	name = "Illuminated"
	desc = "You emit a customizable soft glow! This isn't bright enough to replace your flashlight."
	value = 0
	gain_text = span_notice("You feel glowy!")
	lose_text = span_notice("You loose that glow!")
	medical_record_text = "Patient emits a subtle emissive aura."
	mob_trait = TRAIT_COSGLOW
	icon = FA_ICON_MAGIC_WAND_SPARKLES
	mail_goodies = list(
		/obj/item/flashlight/glowstick = 1
	)

/datum/quirk/cosglow/add(client/client_source)
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Read preferences
	var/glow_color = client_source?.prefs?.read_preference(/datum/preference/color/cosglow_glow_color) || "#14FF67"
	var/glow_thickness = client_source?.prefs?.read_preference(/datum/preference/numeric/cosglow_thickness) || COSGLOW_THICKNESS_DEFAULT

	// Outline effect
	quirk_mob.add_filter("cosglow_glow", 1, outline_filter("color" = glow_color + "[32]", "size" = glow_thickness))
	var/filter = quirk_mob.get_filter("cosglow_glow")
	animate(filter, alpha = 40, time = 2.5 SECONDS, loop = -1)
	animate(alpha = 110, time = 1.5 SECONDS)

	// Apply status effect
	quirk_mob.apply_status_effect(/datum/status_effect/cosglow)

/datum/quirk/cosglow/remove()
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove glow effect
	quirk_mob.remove_filter("cosglow_glow")

	// Remove status effect
	quirk_mob.remove_status_effect(/datum/status_effect/cosglow)

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
