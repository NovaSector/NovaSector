/datum/bloodsucker_clade/ventrue
	name = CLADE_TYRANT
	description = "Clade Tyrant specializes in deep pheromone gland integration and biochemical signaling. \n\
		The symbiont's refined palate makes you unable to drain the mindless -- their neurochemistry lacks the right receptors. \n\
		You can optionally invest ranks into a Bonded Thrall through an Indoctrination Rack, \
		deepening their symbiont integration until they eventually become a full Bloodsucker."
	clan_objective = /datum/objective/bloodsucker/embrace
	join_icon_state = "ventrue"
	join_description = "Cannot drain the mindless. Can optionally transmit the strain to a Bonded Thrall."
	blood_drink_type = BLOODSUCKER_DRINK_SELECTIVE
	level_cost = BLOODSUCKER_LEVELUP_PERCENTAGE_TYRANT

/datum/bloodsucker_clade/ventrue/proc/finish_spend_rank(datum/antagonist/ghoul/ghouldatum, cost_rank, blood_cost)
	finalize_spend_rank(bloodsuckerdatum, cost_rank, blood_cost)
	ghouldatum.LevelUpPowers()

/datum/bloodsucker_clade/ventrue/interact_with_ghoul(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/favorite/ghouldatum)
	. = ..()
	if(.)
		return TRUE
	if(!istype(ghouldatum))
		return FALSE
	to_chat(bloodsuckerdatum.owner.current, span_warning("Do you wish to deepen [ghouldatum.owner.current]'s symbiont integration?"))
	to_chat(bloodsuckerdatum.owner.current, span_warning("This will use [bloodsuckerdatum.GetUnspentRank() >= 1 ? "an unspent Rank" : "[bloodsuckerdatum.get_level_cost()] Strain Maturation points"]!"))

	var/static/list/rank_options = list(
		"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
		"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"),
	)
	var/rank_response = show_radial_menu(bloodsuckerdatum.owner.current, ghouldatum.owner.current, rank_options, radius = 36, require_near = TRUE)
	if(rank_response == "Yes")
		if(!bloodsuckerdatum.GetUnspentRank() >= 1 && !source.blood_level_gain(FALSE))
			to_chat(bloodsuckerdatum.owner.current, span_danger("You don't have any ranks or enough strain maturation to advance [ghouldatum.owner.current]."))
			return FALSE
		return ghoul_level(ghouldatum)
	return FALSE

/datum/bloodsucker_clade/ventrue/proc/ghoul_level(datum/antagonist/ghoul/favorite/ghouldatum)
	var/list/options = list_available_powers(ghouldatum.bloodsucker_powers)
	var/mob/living/carbon/human/target = ghouldatum.owner.current
	var/datum/action/cooldown/bloodsucker/choice = choose_powers(
		"Select an adaptation for your Bonded Thrall to develop.",
		"Symbiont Integration",
		options
	)
	if(!choice)
		return FALSE
	var/power_name = initial(choice.name)
	if(!ghouldatum.BuyPower(choice, ghouldatum.bloodsucker_powers))
		bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "[target] already has [power_name]!")
		return FALSE
	bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "integrated [power_name]!")
	to_chat(bloodsuckerdatum.owner.current, span_notice("You guided [target]'s symbiont to develop [power_name]!"))

	target.balloon_alert(target, "developed [power_name]!")
	to_chat(target, span_notice("Your Progenitor guided the symbiont's growth -- you developed [power_name]!"))

	ghouldatum.ghoul_level++
	finish_spend_rank(ghouldatum, TRUE, FALSE)
	bloodsuckerify(ghouldatum)
	return TRUE

/datum/bloodsucker_clade/ventrue/proc/bloodsuckerify(datum/antagonist/ghoul/favorite/ghouldatum)
	var/mob/living/carbon/human/target = ghouldatum.owner.current
	var/stage = ghouldatum.ghoul_level
	var/list/traits_possible = list(
		list(TRAIT_COLDBLOODED, TRAIT_NOBREATH, TRAIT_AGEUSIA),
		list(TRAIT_NOCRITDAMAGE, TRAIT_NOSOFTCRIT, TRAIT_SLEEPIMMUNE, TRAIT_VIRUSIMMUNE),
		list(TRAIT_NOHARDCRIT, TRAIT_HARDLY_WOUNDED)
	)
	var/traits_to_add = length(traits_possible) >= stage ? traits_possible[stage] : list()
	switch(stage)

		if(1)
			to_chat(target, span_notice("Your blood runs cold. The symbiont's tendrils reach your lungs -- you stop breathing."))

		if(2)
			to_chat(target, span_notice("The sub-strain deepens its integration. Your body feels reinforced, hardened."))
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				human_target.skin_tone = "albino"

		if(3)
			to_chat(target, span_notice("The symbiont has reinforced your nervous system. Cuts and stabs barely register."))

		if(4 to INFINITY)
			var/datum/antagonist/bloodsucker/bloodsucker_target = IS_BLOODSUCKER(target)
			if(!bloodsucker_target)
				to_chat(target, span_notice("Your heart stops. The symbiont has fully integrated. You are no longer a Thrall -- you are a carrier now."))
				var/powers_to_transfer = list()
				if(ghouldatum)
					ghouldatum.silent = TRUE
					for(var/datum/power as anything in ghouldatum.bloodsucker_powers)
						powers_to_transfer += power.type
					target.mind.remove_antag_datum(/datum/antagonist/ghoul/favorite)
				else
					target.remove_traits(assoc_to_values(traits_to_add), THRALL_TRAIT)

				var/datum/antagonist/bloodsucker/new_bloodsucker = new()
				new_bloodsucker.tyrant_sired = bloodsuckerdatum
				bloodsucker_target = target.mind.add_antag_datum(new_bloodsucker)
				bloodsucker_target.BuyPowers(powers_to_transfer)
				bloodsuckerdatum.owner.current.add_mood_event("madevamp", /datum/mood_event/madevamp)


	if(ghouldatum && QDELETED(ghouldatum) && length(traits_to_add))
		target.add_traits(traits_to_add, THRALL_TRAIT)
		ghouldatum.traits += traits_to_add

/datum/bloodsucker_clade/ventrue/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	to_chat(source.owner.current, span_announce("* Tip: You can now advance your Bonded Thrall's integration by buckling them onto an Indoctrination Rack!"))
	ghouldatum.BuyPower(/datum/action/cooldown/bloodsucker/distress)

/datum/bloodsucker_clade/ventrue/is_valid_ghoul(datum/antagonist/ghoul/ghoul_type)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/ghoul/favorite = /datum/antagonist/ghoul/favorite
	if(ghoul_type != favorite)
		if(bloodsuckerdatum.free_thrall_slots() < 1 && !bloodsuckerdatum.special_ghouls[initial(favorite.special_type)])
			to_chat(bloodsuckerdatum.owner.current, span_danger("Making a non-bonded Thrall will prevent you from advancing your Bonded, as you have no slots left!"))
			return FALSE
	return TRUE

