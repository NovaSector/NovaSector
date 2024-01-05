/datum/preference/color/chat_color
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_NAME_MODIFICATIONS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ic_chat_color"

/datum/preference/color/chat_color/apply_to_human(mob/living/carbon/human/target, value)
	target.apply_preference_chat_color(value)
	return

/datum/preference/color/chat_color/deserialize(input, datum/preferences/preferences)
	return process_chat_color(sanitize_hexcolor(input))

/datum/preference/color/chat_color/create_default_value()
	return process_chat_color(random_color())

/datum/preference/color/chat_color/serialize(input)
	return process_chat_color(sanitize_hexcolor(input))

/mob/living/carbon/human/proc/apply_preference_chat_color(value)
	if(isnull(value))
		return FALSE

	chat_color = process_chat_color(value, sat_shift = 1, lum_shift = 1)
	chat_color_darkened = process_chat_color(value, sat_shift = 0.85, lum_shift = 0.85)
	chat_color_name = name
	return TRUE

#define CHAT_COLOR_NORMAL 1
#define CHAT_COLOR_DARKENED 2

/// Get the mob's chat color by looking up their name in the cached list, if no match is found default to colorize_string().
/datum/chatmessage/proc/get_chat_color_string(name, darkened)
	var/chat_color_strings = GLOB.chat_colors_by_mob_name[name]
	if(chat_color_strings)
		return darkened ? chat_color_strings[CHAT_COLOR_DARKENED] : chat_color_strings[CHAT_COLOR_NORMAL]
	if(darkened)
		return colorize_string(name, 0.85, 0.85)

	return colorize_string(name)

#undef CHAT_COLOR_NORMAL
#undef CHAT_COLOR_DARKENED

#define CM_COLOR_HUE 1
#define CM_COLOR_SATURATION 2
#define CM_COLOR_LUMINANCE 3

#define CM_COLOR_SAT_MIN 0
#define CM_COLOR_SAT_MAX 90
#define CM_COLOR_LUM_MIN 40
#define CM_COLOR_LUM_MAX_GREY 35
#define CM_COLOR_LUM_MAX_DARK_RANGE 45

/**
 * Converts a given color to comply within a smaller subset of colors to be used in runechat.
 * If a color is outside the min/max saturation or lum, it will be set at the nearest
 * value that passes validation.
 *
 * Arguments:
 * * color - The color to process
 * * sat_shift - A value between 0 and 1 that will be multiplied against the saturation
 * * lum_shift - A value between 0 and 1 that will be multiplied against the luminescence
 */
/proc/process_chat_color(color, sat_shift = 1, lum_shift = 1)
	if(isnull(color))
		return

	var/hsl_color = rgb2num(color, COLORSPACE_HSL)

	var/hue = hsl_color[CM_COLOR_HUE]
	var/saturation = hsl_color[CM_COLOR_SATURATION]
	var/luminance = hsl_color[CM_COLOR_LUMINANCE]

	var/processed_saturation
	var/processed_luminance

	if(hue == 0) // greys have a higher floor on the allowed luminance value
		processed_luminance = max(luminance, CM_COLOR_LUM_MAX_GREY)
	else if(350 > hue > 180)
		processed_luminance = min(luminance, CM_COLOR_LUM_MAX_DARK_RANGE) // colors in the deep reds/blues/violets range will have a slightly higher luminance floor than the rest
	else
		processed_luminance = max(luminance, CM_COLOR_LUM_MIN) // for everything else
	processed_saturation = min(saturation, CM_COLOR_SAT_MAX) // desaturate everything slightly

	return rgb(hue, processed_saturation*sat_shift, processed_luminance*lum_shift, space = COLORSPACE_HSL)

#undef CM_COLOR_LUM_MAX
#undef CM_COLOR_LUM_MIN
#undef CM_COLOR_SAT_MAX
#undef CM_COLOR_SAT_MIN
