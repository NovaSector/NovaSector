/datum/quirk/system_shock
	name = "System Shock"
	desc = "You and electricity have a volatile relationship. One spark's liable to forcefully reboot your systems. Note: This quirk only works on synths."
	gain_text = span_danger("You start feeling nervous around plug sockets.")
	lose_text = span_notice("You feel normal about sparks.")
	medical_record_text = "Patient's processors are unusually uninsulated."
	value = -8
	mob_trait = TRAIT_SYSTEM_SHOCK
	icon = FA_ICON_PLUG_CIRCLE_XMARK
	quirk_flags = QUIRK_HUMAN_ONLY
	// So we don't have silicons being stunlocked forever.
	COOLDOWN_DECLARE(system_shock_cooldown)

/datum/quirk/system_shock/add(client/client_source)
	if(issynthetic(quirk_holder))
		RegisterSignals(quirk_holder, list(COMSIG_LIVING_ELECTROCUTE_ACT, COMSIG_LIVING_MINOR_SHOCK), PROC_REF(on_electrocute))

/datum/quirk/system_shock/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_LIVING_ELECTROCUTE_ACT, COMSIG_LIVING_MINOR_SHOCK))

/datum/quirk/system_shock/is_species_appropriate(datum/species/mob_species)
	if (!ispath(mob_species, /datum/species/synthetic))
		return FALSE
	return ..()

/datum/quirk/system_shock/proc/on_electrocute()
	SIGNAL_HANDLER

	if(COOLDOWN_FINISHED(src, system_shock_cooldown))
		do_system_shock()

/// Apply our visual effect and knock the silicon out
/datum/quirk/system_shock/proc/do_system_shock()
	var/knockout_length = rand(8 SECONDS, 10 SECONDS)
	quirk_holder.set_static_vision(knockout_length)
	quirk_holder.balloon_alert(quirk_holder, "system rebooting")
	to_chat(quirk_holder, span_danger("POWER INSTABILITY: SYSTEM RECALIBRATING."))
	addtimer(CALLBACK(src, PROC_REF(knock_out), knockout_length - 0.4 SECONDS), 2 SECONDS)
	//The intent with the 0.4 seconds is so that the visual static effect lasts longer than the actual knockout/sleeping effect.
	COOLDOWN_START(src, system_shock_cooldown, knockout_length + 5 SECONDS)

/datum/quirk/system_shock/proc/knock_out(length)
	quirk_holder.Sleeping(length)
