/datum/action/innate/cult/blood_spell/proc/bloodwashed_refresh_uses()
	desc = base_desc
	desc += "<br><b><u>Has [charges] use\s remaining</u></b>."
	build_all_button_icons()

/datum/action/innate/cult/bloodwashed_spell
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"
	/// Amount of times this spell can be used before disappearing.
	var/charges = 1
	/// The base desc, used to rebuild the tooltip when charges change.
	var/base_desc
	/// Ref to the action that prepared this spell.
	var/datum/action/innate/cult/blood_magic/all_magic
	/// Phrase whispered when invoking the spell.
	var/invocation

/datum/action/innate/cult/bloodwashed_spell/Grant(mob/living/owner, datum/action/innate/cult/blood_magic/BM)
	base_desc = desc
	bloodwashed_refresh_uses()
	all_magic = BM
	return ..(owner)

/datum/action/innate/cult/bloodwashed_spell/Remove()
	if(all_magic)
		all_magic.spells -= src
	return ..()

/datum/action/innate/cult/bloodwashed_spell/IsAvailable(feedback = FALSE)
	if(!IS_CULTIST(owner) || owner.incapacitated || !charges)
		return FALSE
	return ..()

/datum/action/innate/cult/bloodwashed_spell/proc/bloodwashed_refresh_uses()
	desc = base_desc
	desc += "<br><b><u>Has [charges] use\s remaining</u></b>."
	build_all_button_icons()

/datum/action/innate/cult/bloodwashed_spell/blood_mist
	name = "Blood Mist"
	desc = "Bleeds into a cloud of mist and slips away to a random teleport rune."
	button_icon_state = "gone"
	charges = 2
	invocation = "Vel'kiir mal nath!"

/datum/action/innate/cult/bloodwashed_spell/blood_mist/Activate()
	var/turf/origin = get_turf(owner)
	if(!origin)
		return

	var/list/potential_runes = list()
	for(var/obj/effect/rune/teleport/teleport_rune as anything in GLOB.teleport_runes)
		var/turf/rune_turf = get_turf(teleport_rune)
		if(!rune_turf || rune_turf == origin || is_away_level(rune_turf.z) || rune_turf.is_blocked_turf(TRUE))
			continue
		potential_runes += teleport_rune

	if(!length(potential_runes))
		to_chat(owner, span_warning("There are no other unblocked teleport runes to bleed into!"))
		return
	if(is_away_level(origin.z))
		to_chat(owner, span_cult_italic("You are not in the right dimension!"))
		return

	var/obj/effect/rune/teleport/actual_selected_rune = pick(potential_runes)
	if(QDELETED(src) || owner.incapacitated || !actual_selected_rune)
		return

	var/turf/destination = get_turf(actual_selected_rune)

	owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
	owner.visible_message(
		span_warning("A red-black mist spills from [owner], swallowing [owner.p_them()] whole!"),
		span_cult_italic("You dissolve into a bloody mist and tear yourself toward [actual_selected_rune]."),
		span_hear("You hear a wet, distant hiss."),
	)
	do_chem_smoke(2, owner, origin, /datum/reagent/blood, 20, smoke_type = /datum/effect_system/fluid_spread/smoke/chem/quick)
	playsound(origin, 'sound/effects/magic/smoke.ogg', 50, TRUE)

	owner.buckled?.unbuckle_mob(owner, force = TRUE)
	if(do_teleport(owner, destination, no_effects = TRUE, channel = TELEPORT_CHANNEL_CULT))
		origin.Beam(destination, icon_state = "blood_beam", time = 2 SECONDS, beam_type = /obj/effect/ebeam/launchpad)
		do_chem_smoke(1, owner, destination, /datum/reagent/blood, 10, smoke_type = /datum/effect_system/fluid_spread/smoke/chem/quick)
		destination.visible_message(span_warning("The bloody mist recoils into [owner]!"))
	else
		to_chat(owner, span_warning("Something holds you in place!"))
		return

	charges--
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	if(charges <= 0)
		qdel(src)
		return
	bloodwashed_refresh_uses()
