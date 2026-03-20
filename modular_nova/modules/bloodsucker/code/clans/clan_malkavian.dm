/datum/bloodsucker_clade/malkavian
	name = CLADE_MIMIC
	description = "Clade Mimic results from aberrant temporal and parietal lobe integration. \n\
		The symbiont's neural tendrils grant extraordinary sensory processing at the cost of cognitive stability. \n\
		Permanent hallucinations, X-ray perception, and compulsive vocalizations driven by symbiont-processed sensory overflow. \n\
		Stun immunity during feral episodes. You enforce concealment -- when another Bloodsucker is exposed, you must eliminate them. \n\
		On termination, the symbiont undergoes neural calcification, preserving your consciousness in a crystallized node. \n\
		The Bonded Thrall suffers the same sensory destabilization, gaining combat instincts from the symbiont's fight-or-flight overdrive."
	join_icon_state = "malkavian"
	join_description = "Sensory overload: permanent hallucinations, X-ray vision, compulsive outbursts. \
		Enforces concealment -- must eliminate exposed Bloodsuckers."
	blood_drink_type = BLOODSUCKER_DRINK_INDISCRIMINATE
	/// The prob chance of a sensory overflow outburst.
	var/max_madness_chance = 10
	var/min_madness_chance = 5

/datum/bloodsucker_clade/malkavian/on_enter_frenzy(datum/antagonist/bloodsucker/source)
	ADD_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FERAL_TRAIT)

/datum/bloodsucker_clade/malkavian/on_exit_frenzy(datum/antagonist/bloodsucker/source)
	REMOVE_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FERAL_TRAIT)

/datum/bloodsucker_clade/malkavian/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_BLOODSUCKER_EXPOSED, PROC_REF(on_bloodsucker_exposed))
	ADD_TRAIT(bloodsuckerdatum.owner.current, TRAIT_XRAY_VISION, BLOODSUCKER_TRAIT)
	var/mob/living/carbon/carbon_owner = bloodsuckerdatum.owner.current
	if(istype(carbon_owner))
		carbon_owner.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbon_owner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	owner_datum.owner.current.update_sight()

	bloodsuckerdatum.owner.current.playsound_local(get_turf(bloodsuckerdatum.owner.current), 'sound/music/antag/creepalert.ogg', 80, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	to_chat(bloodsuckerdatum.owner.current, span_hypnophrase("The symbiont's tendrils have reached your temporal lobe. You can see everything now. Everything."))

/datum/bloodsucker_clade/malkavian/Destroy(force)
	UnregisterSignal(SSdcs, COMSIG_BLOODSUCKER_EXPOSED)
	REMOVE_TRAIT(bloodsuckerdatum.owner.current, TRAIT_XRAY_VISION, BLOODSUCKER_TRAIT)
	var/mob/living/carbon/carbon_owner = bloodsuckerdatum.owner.current
	if(istype(carbon_owner))
		carbon_owner.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbon_owner.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	bloodsuckerdatum.owner.current.update_sight()
	return ..()

/datum/bloodsucker_clade/malkavian/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	. = ..()
	// Using linear interpolation to calculate the chance of a sensory overflow outburst.
	// The more neural erosion, the higher the chance.
	// Reversed: increase prob as the value decreases.
	// Equation: interpolated value = end + normalized factor * (start - end)
	var/neural_erosion_modifier = source.GetNeuralErosion() / 50
	if(neural_erosion_modifier == 0)
		// 0 * anything = 0, prevent zero neural erosion from maxing the chance.
		neural_erosion_modifier = 1
	var/interpolated_chance = max_madness_chance + neural_erosion_modifier * (min_madness_chance - max_madness_chance)
	var/madness_chance = clamp(interpolated_chance, min_madness_chance, max_madness_chance)
	if(!prob(madness_chance) || source.owner.current.stat != CONSCIOUS || HAS_TRAIT(source.owner.current, TRAIT_MIMIC))
		return
	var/message = pick(strings("malkavian_revelations.json", "revelations", "modular_nova/modules/bloodsucker/strings/bloodsuckers"))
	INVOKE_ASYNC(source.owner.current, TYPE_PROC_REF(/atom/movable, say), message, forced = CLADE_MIMIC)

/datum/bloodsucker_clade/malkavian/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/mob/living/carbon/carbonowner = ghouldatum.owner.current
	if(istype(carbonowner))
		carbonowner.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbonowner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/martial_art/psychotic_brawling/psychotic_brawling = new(null)
	psychotic_brawling.teach(ghouldatum.owner.current, TRUE)
	to_chat(ghouldatum.owner.current, span_notice("The sub-strain has infiltrated your sensory cortex. You suffer hallucinations and prophetic visions, but gain combat instincts from the symbiont's fight-or-flight overdrive."))

/datum/bloodsucker_clade/malkavian/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/mob/living/carbon/carbonowner = ghouldatum.owner.current
	if(istype(carbonowner))
		carbonowner.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbonowner.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/martial_art/psychotic_brawling/psychotic_brawling = locate() in ghouldatum.owner.current.martial_arts
	if(isnull(psychotic_brawling))
		return
	psychotic_brawling.unlearn(ghouldatum.owner.current)

/datum/bloodsucker_clade/malkavian/on_exit_torpor(datum/antagonist/bloodsucker/source)
	var/mob/living/carbon/carbonowner = bloodsuckerdatum.owner.current
	if(istype(carbonowner))
		carbonowner.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		carbonowner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/bloodsucker_clade/malkavian/on_final_death(datum/antagonist/bloodsucker/source)
	var/obj/item/soulstone/bloodsucker/stone = new /obj/item/soulstone/bloodsucker(get_turf(bloodsuckerdatum.owner.current))
	if(!bloodsuckerdatum.owner.current.ckey)
		return
	ASYNC
		stone.capture_soul(bloodsuckerdatum.owner.current, forced = TRUE)
	return DONT_DUST

/datum/bloodsucker_clade/malkavian/proc/on_bloodsucker_exposed(datum/source, datum/antagonist/bloodsucker/exposed_bloodsucker)
	SIGNAL_HANDLER
	to_chat(bloodsuckerdatum.owner.current, span_userdanger("[exposed_bloodsucker.owner.current] has been Exposed! The symbiont demands concealment -- ensure [exposed_bloodsucker.owner.current.p_they()] [exposed_bloodsucker.owner.current.p_are()] terminated!"))
	var/datum/objective/assassinate/exposure_objective = new()
	exposure_objective.target = exposed_bloodsucker.owner.current
	exposure_objective.objective_name = "Clade Objective"
	exposure_objective.explanation_text = "Terminate [exposed_bloodsucker.owner.current], who has been Exposed, before the strain is compromised."
	bloodsuckerdatum.objectives += exposure_objective
	bloodsuckerdatum.owner.announce_objectives()
