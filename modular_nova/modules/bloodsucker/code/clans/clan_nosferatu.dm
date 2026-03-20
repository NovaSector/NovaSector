/datum/bloodsucker_clade/nosferatu
	name = CLADE_FERAL
	description = "Clade Feral represents extreme musculoskeletal integration -- the symbiont has warped your skeletal structure for hypermobility. \n\
		Your body is permanently disfigured, visible on examine. The symbiont's growth has stripped your chromatophore response, \n\
		disabling Mimic and Biosculpt. In exchange, you can compress through ventilation shafts even while clothed. \n\
		The Bonded Thrall undergoes similar skeletal warping -- disfigured, able to ventcrawl while nude, \n\
		with enhanced night vision, intuitive wire knowledge, and dampened footfalls."
	clan_objective = /datum/objective/bloodsucker/kindred
	join_icon_state = "nosferatu"
	join_description = "Permanently disfigured. Visible as a Bloodsucker on examine. \
		Lose Mimic and Biosculpt, but gain clothed ventcrawling."
	blood_drink_type = BLOODSUCKER_DRINK_INDISCRIMINATE
	var/ventcrawl_time = 10 SECONDS

/datum/bloodsucker_clade/nosferatu/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/masquerade) || istype(power, /datum/action/cooldown/bloodsucker/veil))
			bloodsuckerdatum.RemovePower(power)
	var/mob/living/mob = bloodsuckerdatum.owner.current
	if(!mob.has_quirk(/datum/quirk/badback))
		mob.add_quirk(/datum/quirk/badback)

	mob.add_traits(list(TRAIT_DISFIGURED, TRAIT_VENTCRAWLER_NUDE), BLOODSUCKER_TRAIT)

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXAMINE, PROC_REF(on_mob_examine))
	RegisterSignal(mob, COMSIG_CAN_VENTCRAWL, PROC_REF(can_ventcrawl))
	RegisterSignal(mob, COMISG_VENTCRAWL_PRE_ENTER, PROC_REF(on_ventcrawl_enter))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_EXIT, PROC_REF(on_ventcrawl_pre_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_EXIT, PROC_REF(on_ventcrawl_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_CANCEL, PROC_REF(on_ventcrawl_cancel))

/datum/bloodsucker_clade/nosferatu/proc/get_ventcrawl_time()
	return max(ventcrawl_time - bloodsuckerdatum.GetRank() SECONDS, 2 SECONDS)

/datum/bloodsucker_clade/nosferatu/proc/can_ventcrawl(mob/living/carbon/human/owner_mob, atom/vent, provide_feedback)
	SIGNAL_HANDLER
	for(var/item in owner_mob.held_items)
		if(isnull(item))
			continue
		if(provide_feedback)
			to_chat(owner_mob, span_warning("You cannot compress into the vent while holding items!"))
		return FALSE
	return TRUE

/datum/bloodsucker_clade/nosferatu/proc/on_ventcrawl_cancel(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	animate(ventcrawl_target)

/datum/bloodsucker_clade/nosferatu/proc/on_ventcrawl_enter(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clade/nosferatu/proc/on_ventcrawl_pre_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	playsound(ventcrawl_target, 'sound/effects/bang.ogg', 25)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), crawl_time, 'sound/effects/bang.ogg', 25), ventcrawl_time * 0.6)
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clade/nosferatu/proc/on_ventcrawl_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	// cooldown all non-inherent adaptations on exit to prevent instant ambushes
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		power.StartCooldown()

/datum/bloodsucker_clade/nosferatu/proc/on_mob_examine(datum/antagonist/bloodsucker/owner_datum, datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/ogled = owner_datum.owner.current
	var/mob/living/ogler = examiner
	if(isliving(examiner) && examiner != ogled && !ogler.mob_mood.has_mood_of_category("nosferatu_examine"))
		ogler.add_mood_event("nosferatu_examine", /datum/mood_event/nosferatu_examined, ogled, owner_datum.GetRank())
		ogler.adjust_disgust(owner_datum.GetRank() * 10)
	examine_text += span_danger("[ogled.p_They()] look[ogled.p_s()] grotesquely warped -- joints bent at wrong angles, skin stretched taut over misshapen bones, and breath that reeks of iron. You feel both afraid and disgusted as you gaze upon [ogled.p_them()].")
	examine_text += span_userdanger("[ogled.p_They()] [ogled.p_are()] clearly a BLOODSUCKER!")

/datum/bloodsucker_clade/nosferatu/Destroy(force)
	var/datum/action/cooldown/bloodsucker/feed/suck = locate() in bloodsuckerdatum.powers
	if(suck)
		bloodsuckerdatum.RemovePower(suck)
	bloodsuckerdatum.give_starting_powers()
	bloodsuckerdatum.owner.current.remove_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.remove_traits(list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED), BLOODSUCKER_TRAIT)
	UnregisterSignal(bloodsuckerdatum, list(COMSIG_BLOODSUCKER_EXAMINE, COMSIG_CAN_VENTCRAWL, COMISG_VENTCRAWL_PRE_ENTER, COMSIG_VENTCRAWL_PRE_EXIT, COMSIG_VENTCRAWL_EXIT))
	return ..()

/datum/bloodsucker_clade/nosferatu/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/list/traits_to_add = list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED, TRAIT_TRUE_NIGHT_VISION, TRAIT_KNOW_ENGI_WIRES, TRAIT_SILENT_FOOTSTEPS)
	ghouldatum.owner.current.add_traits(traits_to_add, THRALL_TRAIT)
	ghouldatum.traits += traits_to_add
	ghouldatum.owner.current.update_sight()
	to_chat(ghouldatum.owner.current, span_notice("The sub-strain has warped your skeletal structure. You can ventcrawl while unclothed, and your body is permanently disfigured. You also gain night vision, intuitive wire knowledge, and dampened footfalls."))

/datum/bloodsucker_clade/nosferatu/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	ghouldatum.owner.current.update_sight()
