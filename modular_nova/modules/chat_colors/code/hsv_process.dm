#define CM_COLOR_SAT_MIN 0.35
#define CM_COLOR_SAT_MAX 1
#define CM_COLOR_LUM_MIN 0.35
#define CM_COLOR_LUM_MAX 1

/**
 * Converts a given color to comply within a smaller subset of colors to be used in runechat.
 * If a color is outside the min/max saturation or value/lum, it will be set at the nearest
 * value that passes validation.
 *
 * Arguments:
 * * color - The color to process
 */
/proc/process_chat_color(color)
	if(isnull(color))
		return

	var/input_hsv = RGBtoHSV(color)
	var/list/split_hsv = ReadHSV(input_hsv)
	var/split_h = split_hsv[1]
	var/split_s = split_hsv[2]
	var/split_v = split_hsv[3]
	var/processed_s = clamp(split_s, CM_COLOR_SAT_MIN * 255, CM_COLOR_SAT_MAX * 255)
	var/processed_v = clamp(split_v, CM_COLOR_LUM_MIN * 255, CM_COLOR_LUM_MAX * 255)
	var/processed_hsv = hsv(split_h, processed_s, processed_v)
	var/processed_rgb = HSVtoRGB(processed_hsv)

	return processed_rgb

#undef CM_COLOR_LUM_MAX
#undef CM_COLOR_LUM_MIN
#undef CM_COLOR_SAT_MAX
#undef CM_COLOR_SAT_MIN
