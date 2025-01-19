/**
 *  Returns a list of lines containing silicon flavourtext, temporary flavourtext, ERP preferences and a link to "look closer" and open the examine panel.
 *  Intended to be appended at the end of examine() result.
 */
/mob/living/silicon/proc/get_silicon_flavortext()
	. = list()
	var/flavor_text_link
	/// The first 1-FLAVOR_PREVIEW_LIMIT characters in the mob's client's silicon_flavor_text preference datum. FLAVOR_PREVIEW_LIMIT is defined in flavor_defines.dm.
	var/silicon_preview_text = copytext_char((client?.prefs.read_preference(/datum/preference/text/silicon_flavor_text)), 1, FLAVOR_PREVIEW_LIMIT)

	flavor_text_link = span_notice("[silicon_preview_text]... <a href='byond://?src=[REF(src)];lookup_info=open_examine_panel'>Look closer?</a>")

	if (flavor_text_link)
		. += flavor_text_link

	if (client?.prefs.read_preference(/datum/preference/text/character_ad))
		. += span_notice("They have an ad in the character directory... <a href='byond://?src=[REF(src)];lookup_info=open_character_ad'>\[Open directory?\]</a>")

	if(client)
		var/erp_status_pref = client.prefs.read_preference(/datum/preference/choiced/erp_status)
		if(erp_status_pref && !CONFIG_GET(flag/disable_erp_preferences))
			. += span_notice("ERP STATUS: [erp_status_pref]")

	if (!CONFIG_GET(flag/disable_antag_opt_in_preferences))
		var/opt_in_status = mind?.get_effective_opt_in_level()
		if (!isnull(opt_in_status))
			var/stringified_optin = GLOB.antag_opt_in_strings["[opt_in_status]"]
			. += span_notice("Antag Opt-in Status: <b><font color='[GLOB.antag_opt_in_colors[stringified_optin]]'>[stringified_optin]</font></b>")

	if(temporary_flavor_text)
		if(length_char(temporary_flavor_text) <= 40)
			. += span_notice("<b>They look different than usual:</b> [temporary_flavor_text]")
		else
			. += span_notice("<b>They look different than usual:</b> [copytext_char(temporary_flavor_text, 1, 37)]... <a href='byond://?src=[REF(src)];temporary_flavor=1'>More...</a>")
