/datum/antagonist/bloodsucker/proc/on_examine(datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER

	if(!iscarbon(source))
		return
	var/vamp_examine = return_vamp_examine(examiner)
	if(vamp_examine)
		examine_text += vamp_examine
	SEND_SIGNAL(src, COMSIG_BLOODSUCKER_EXAMINE, source, examiner, examine_text)

/datum/antagonist/bloodsucker/proc/BuyPowers(powers = list())
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		BuyPower(power)

///Called when a Bloodsucker buys a power: (power)
/datum/antagonist/bloodsucker/proc/BuyPower(datum/action/cooldown/bloodsucker/power)
	for(var/datum/action/cooldown/bloodsucker/current_powers as anything in powers)
		if(current_powers.type == power.type)
			return null
	power = new power()
	powers += power
	power.Grant(owner.current)
	log_uplink("[key_name(owner.current)] purchased [power].")
	return power

///Called when a Bloodsucker loses a power: (power)
/datum/antagonist/bloodsucker/proc/RemovePower(datum/action/cooldown/bloodsucker/power)
	if(power.active)
		power.DeactivatePower()
	powers -= power
	power.Remove(owner.current)

/datum/antagonist/bloodsucker/proc/RemovePowerByPath(datum/action/cooldown/bloodsucker/power_to_remove)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power?.type == power_to_remove)
			RemovePower(power)

///When a Bloodsucker becomes Exposed, their HUD icon changes, and Mimic clade Bloodsuckers get alerted.
/datum/antagonist/bloodsucker/proc/break_exposure(mob/admin)
	if(exposed)
		return
	owner.current.playsound_local(null, 'modular_nova/modules/bloodsucker/sound/lunge_warn.ogg', 100, FALSE, pressure_affected = FALSE)
	to_chat(owner.current, span_cult_bold_italic("You have been Exposed! Your nature is now known!"))
	to_chat(owner.current, span_warning("When you are Exposed, you become a target for termination by fellow Bloodsuckers, and your Thralls are no longer completely loyal -- other Bloodsuckers can steal them."))
	exposed = TRUE
	antag_hud_name = "masquerade_broken"
	add_team_hud(owner.current)
	SEND_GLOBAL_SIGNAL(COMSIG_BLOODSUCKER_EXPOSED, src)

///Admin-only: revert an exposed bloodsucker. Does not remove Mimic clade objectives.
/datum/antagonist/bloodsucker/proc/fix_exposure(mob/admin)
	if(!exposed)
		return
	to_chat(owner.current, span_cult_bold_italic("Your exposure has been concealed. You are hidden once more."))
	exposed = FALSE
	antag_hud_name = "bloodsucker"
	add_team_hud(owner.current)

/datum/antagonist/bloodsucker/proc/give_exposure_incident()
	if(exposed)
		return
	exposure_incidents++
	if(exposure_incidents >= 3)
		break_exposure()
	else
		to_chat(owner.current, span_cult_bold("Exposure incident! [3 - exposure_incidents] more and your nature will be fully revealed to other Bloodsuckers!"))

/datum/antagonist/bloodsucker/proc/RankUp(force = FALSE)
	if(!owner || !owner.current)
		return
	AdjustUnspentRank(1)
	if(!my_clade)
		to_chat(owner.current, span_notice("You have gained a rank. Join a Clade to spend it."))
		return
	// Spend Rank Immediately?
	if(!is_valid_den())
		to_chat(owner, span_notice("<EM>The symbiont has matured further! Rest in your claimed den (or place your Bonded on an Indoctrination Rack for Tyrant clade) to integrate the new growth.</EM>"))
		if(bloodsucker_level_unspent >= 2)
			to_chat(owner, span_announce("Bloodsucker Tip: Claim any closet, locker, or crate as your den by resting inside it."))
		return
	SpendRank()

/datum/antagonist/bloodsucker/proc/RankDown()
	AdjustUnspentRank(-1)

/datum/antagonist/bloodsucker/proc/remove_nondefault_powers(return_levels = FALSE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		RemovePower(power)
		if(return_levels)
			AdjustUnspentRank(1)

/datum/antagonist/bloodsucker/proc/LevelUpPowers()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & HEMOKINETIC_CAN_BUY)
			continue
		power.upgrade_power()

///Disables all powers, accounting for torpor
/datum/antagonist/bloodsucker/proc/DisableAllPowers(forced = FALSE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(forced || ((power.check_flags & BP_CANT_USE_IN_DORMANCY) && is_in_dormancy()))
			if(power.active)
				power.DeactivatePower()

/datum/antagonist/bloodsucker/proc/SpendRank(mob/living/carbon/human/target, cost_rank = TRUE, blood_cost)
	if(!owner || !owner.current || !owner.current.client || (cost_rank && bloodsucker_level_unspent <= 0))
		return
	SEND_SIGNAL(src, COMSIG_BLOODSUCKER_RANK_UP, target, cost_rank, blood_cost)

/datum/antagonist/bloodsucker/proc/GetRank()
	return bloodsucker_level

/datum/antagonist/bloodsucker/proc/AdjustRank(amount)
	bloodsucker_level = max(bloodsucker_level + amount, 0)
	update_rank_hud()

/datum/antagonist/bloodsucker/proc/GetUnspentRank()
	return bloodsucker_level_unspent

/datum/antagonist/bloodsucker/proc/AdjustUnspentRank(amount)
	bloodsucker_level_unspent = max(bloodsucker_level_unspent + amount, 0)
	update_rank_hud()
/**
 * Called when a Bloodsucker reaches Termination.
 * Releases all Thralls and gives them the ex_thrall datum.
 */
/datum/antagonist/bloodsucker/proc/free_all_thralls()
	for(var/datum/antagonist/ghoul/all_ghouls in ghouls)
		// Skip over any Bloodsucker Ghouls, they're too far gone to have all their stuff taken away from them
		if(IS_BLOODSUCKER(all_ghouls.owner.current))
			all_ghouls.owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/ghoul_edition)
			continue
		if(all_ghouls.special_type == FERAL_THRALL || !all_ghouls.owner)
			continue
		all_ghouls.owner.add_antag_datum(/datum/antagonist/ex_ghoul)
		all_ghouls.owner.remove_antag_datum(/datum/antagonist/ghoul)

/**
 * Returns a Vampire's examine strings.
 * Args:
 * viewer - The person examining.
 */
/datum/antagonist/bloodsucker/proc/return_vamp_examine(mob/living/viewer)
	if(!viewer.mind && !isobserver(viewer))
		return FALSE
	// Viewer is Target's Thrall?
	if(!isobserver(viewer) && (viewer.mind.has_antag_datum(/datum/antagonist/ghoul) in ghouls))
		var/returnString = "\[<span class='warning'><EM>This is your Progenitor!</EM></span>\]"
		var/returnIcon = "[icon2html('modular_nova/modules/bloodsucker/icons/language.dmi', world, "bloodsucker")]"
		returnString += "\n"
		return returnIcon + returnString
	// Viewer not a Bloodsucker AND not the target's thrall?
	if(!isobserver(viewer) && !viewer.mind.has_antag_datum((/datum/antagonist/bloodsucker)) && !(viewer in ghouls))
		if(!(HAS_TRAIT(viewer.mind, TRAIT_BLOODSUCKER_HUNTER) && exposed))
			return FALSE
	// Default String
	var/returnString = "\[<span class='warning'><EM>[return_full_name()]</EM></span>\]"
	var/returnIcon = "[icon2html('modular_nova/modules/bloodsucker/icons/language.dmi', world, "bloodsucker")]"

	return returnIcon + returnString

/datum/antagonist/bloodsucker/proc/can_gain_blood_rank(silent = TRUE, requires_blood = FALSE)
	var/level_cost = get_level_cost()
	var/mob/living/carbon/user = owner.current
	if(blood_level_gain < level_cost)
		if(!silent)
			user.balloon_alert(user, "not enough strain maturation!")
		return FALSE
	if(requires_blood && bloodsucker_blood_volume < level_cost)
		if(!silent)
			user.balloon_alert(user, "not enough blood!")
		return FALSE
	return TRUE

// Blood level gain is used to give Bloodsuckers more levels if they are being agressive and drinking from real, sentient people.
// The maximum blood that counts towards this
/datum/antagonist/bloodsucker/proc/blood_level_gain(silent = TRUE, requires_blood = FALSE)
	var/level_cost = get_level_cost()
	if(can_gain_blood_rank(silent, requires_blood)) // Checks if we have drunk enough blood from the living to allow us to gain a level up as well as checking if we have enough blood to actually use on the level up
		var/input = tgui_alert(owner.current, "The symbiont has matured enough for further integration. This will cost [level_cost] blood and grant another rank.",  "Strain Maturation", list("Yes", "No"))
		if(input == "Yes")
			AdjustUnspentRank(1) // gives level
			blood_level_gain -= level_cost // Subtracts the cost from the pool of drunk blood
			if(requires_blood)
				AdjustBloodVolume(-level_cost) // Subtracts the cost from the bloodsucker's actual blood
			return TRUE
	return FALSE

/datum/antagonist/bloodsucker/proc/get_level_cost()
	var/percentage_needed = my_clade ? my_clade.level_cost : BLOODSUCKER_LEVELUP_PERCENTAGE
	return max_blood_volume * percentage_needed

/datum/antagonist/bloodsucker/proc/max_thralls()
	return round(bloodsucker_level * 0.5)

/datum/antagonist/bloodsucker/proc/free_thrall_slots()
	return max(max_thralls() - length(ghouls), 0)

/datum/antagonist/bloodsucker/proc/feral_enter_threshold()
	return FERAL_THRESHOLD_ENTER + (neural_erosion * 10)

/datum/antagonist/bloodsucker/proc/feral_exit_threshold()
	return FERAL_THRESHOLD_EXIT + (neural_erosion * 10)

/datum/antagonist/bloodsucker/proc/on_organ_removal(mob/living/carbon/old_owner, obj/item/organ/organ, special)
	SIGNAL_HANDLER
	if(old_owner?.get_organ_slot(ORGAN_SLOT_HEART) || organ?.slot != ORGAN_SLOT_HEART || !old_owner?.dna?.species.mutantheart)
		return
	DisableAllPowers(TRUE)
	if(HAS_TRAIT_FROM_ONLY(old_owner, TRAIT_NODEATH, BLOODSUCKER_TRAIT))
		dormancy_end(TRUE)
	to_chat(old_owner, span_userdanger("You have lost your [organ.slot]!"))
	to_chat(old_owner, span_warning("Without it, you can no longer enter dormancy, revive from death, heal damage, or use your adaptations."))

/// checks if we're a brainmob inside a brain & the brain is inside a head
/datum/antagonist/bloodsucker/proc/is_head(mob/living/poor_fucker)
	if(!istype(poor_fucker?.loc, /obj/item/organ/brain))
		return
	var/obj/brain = poor_fucker.loc
	if(!istype(brain?.loc, /obj/item/bodypart/head))
		return
	return brain.loc

// helper procs for damage checking, just in case a synth becomes one, let's them heal thesmelves
/datum/antagonist/bloodsucker/proc/get_brute_loss()
	var/mob/living/carbon/human/humie = owner.current
	return issynthetic(humie) ? humie.get_brute_loss() : humie.get_brute_loss_nonProsthetic()

/datum/antagonist/bloodsucker/proc/get_fire_loss()
	var/mob/living/carbon/human/humie = owner.current
	return issynthetic(humie) ? humie.get_fire_loss() : humie.get_fire_loss_nonProsthetic()

/datum/antagonist/bloodsucker/proc/admin_set_blood(mob/admin)
	var/blood = tgui_input_number(admin, "What blood level to set [owner.current]'s to?", "Blood is life.", floor(bloodsucker_blood_volume), max_blood_volume, 0)
	// 0 input is falsey
	if(blood == null)
		return
	SetBloodVolume(blood)

/datum/antagonist/bloodsucker/proc/admin_rankup(mob/admin)
	to_chat(admin, span_notice("[owner.current] has been given a free level"))
	RankUp()

/datum/antagonist/bloodsucker/proc/admin_give_power(mob/admin)
	var/power_type = tgui_input_list(admin, "What power to give [owner.current]?", "Might is right.", all_bloodsucker_powers)
	if(!power_type)
		return
	var/datum/action/cooldown/bloodsucker/power = BuyPower(power_type)
	power.upgrade_power()

/datum/antagonist/bloodsucker/proc/admin_remove_power(mob/admin)
	var/datum/action/cooldown/bloodsucker/power = tgui_input_list(admin, "What power to remove from [owner.current]?", "Might is right.", powers)
	if(!power)
		return
	RemovePower(power)

/datum/antagonist/bloodsucker/proc/admin_set_power_level(mob/admin)
	var/list/valid_powers = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		valid_powers += power
	var/datum/action/cooldown/bloodsucker/power = tgui_input_list(admin, "What power to set the level of for [owner.current]?", "Might is right.", valid_powers)
	if(!power)
		return
	var/level = tgui_input_number(admin, "What level to set [power] to?", "Might is right.", power.level_current, 30, 0)
	if(level == null)
		return
	power.level_current = level
	power.on_power_upgrade()

/datum/antagonist/bloodsucker/proc/regain_heart(mob/living/carbon/target, obj/structure/closet/den)
	var/obj/item/organ/heart = locate(/obj/item/organ/heart) in den.contents
	if(heart && !target.get_organ_slot(ORGAN_SLOT_HEART) && heart.Insert(target))
		to_chat(target, span_warning("You have regained your heart!"))

/datum/antagonist/bloodsucker/proc/allow_head_to_talk(mob/speaker, message, ignore_spam, forced)
	SIGNAL_HANDLER
	if(!is_head(speaker) || speaker.stat >= UNCONSCIOUS)
		return
	return COMPONENT_IGNORE_CAN_SPEAK

/datum/antagonist/bloodsucker/proc/shake_head_on_talk(mob/speaker, speech_args)
	SIGNAL_HANDLER
	var/obj/head = is_head(speaker)
	if(!head)
		return
	var/animation_time = max(2, length_char(speech_args[SPEECH_MESSAGE]) * 0.5)
	head.Shake(duration = animation_time)

/datum/antagonist/bloodsucker/proc/stake_can_kill()
	if(owner.current.IsSleeping() || owner.current.stat >= UNCONSCIOUS || is_in_dormancy())
		for(var/stake in get_stakes())
			var/obj/item/stake/killin_stake = stake
			if(killin_stake?.kills_blodsuckers)
				return TRUE
	return FALSE

/datum/antagonist/bloodsucker/proc/am_staked()
	var/obj/item/bodypart/chosen_bodypart = owner.current.get_bodypart(BODY_ZONE_CHEST)
	if(!chosen_bodypart)
		return FALSE
	var/obj/item/stake/stake = locate() in chosen_bodypart.embedded_objects
	return stake

/datum/antagonist/bloodsucker/proc/get_stakes()
	var/obj/item/bodypart/chosen_bodypart = owner.current.get_bodypart(BODY_ZONE_CHEST)
	if(!chosen_bodypart)
		return FALSE
	var/list/stakes = list()
	for(var/obj/item/embedded_stake in chosen_bodypart.embedded_objects)
		if(istype(embedded_stake, /obj/item/stake))
			stakes += list(embedded_stake)
	return stakes

/datum/antagonist/bloodsucker/proc/on_staked(atom/target, forced)
	SIGNAL_HANDLER
	if(stake_can_kill())
		Termination()
	else
		to_chat(target, span_userdanger("You have been staked! Your powers are useless, your death forever, while it remains in place."))
		target.balloon_alert(target, "you have been staked!")

/// is the bloodsucker inside a valid den (any closet-type structure)?
/datum/antagonist/bloodsucker/proc/is_valid_den()
	if(istype(owner.current.loc, /obj/structure/closet))
		return TRUE
	return FALSE

/datum/antagonist/bloodsucker/proc/on_enter_den(mob/living/carbon/target, obj/structure/closet/den, mob/living/carbon/user)
	SIGNAL_HANDLER
	check_limbs(DEN_HEAL_COST_MULT)
	regain_heart(target, den)
	if(!check_begin_dormancy())
		heal_organs()
	if(user == owner.current && (user in den))
		if(can_claim_den(den, get_area(den)))
			INVOKE_ASYNC(src, PROC_REF(try_claim_den), den)
		else
			INVOKE_ASYNC(src, PROC_REF(try_den_level_up))

/datum/antagonist/bloodsucker/proc/try_claim_den(obj/structure/closet/den)
	if(den.prompt_den_claim(src))
		try_den_level_up()

/datum/antagonist/bloodsucker/proc/try_den_level_up()
	var/mob/living/carbon/user = owner.current
	//Level up if possible.
	if(!my_clade)
		user.balloon_alert(user, "join a clade!")
		to_chat(user, span_notice("You must join a Clade to rank up. Open the antag menu by pressing the action button in the top left."))
	else if(!frenzied)
		if(GetUnspentRank() < 1)
			blood_level_gain()
		// Level ups cost 30% of your max blood volume, which scales with your rank.
		SpendRank()

/datum/antagonist/bloodsucker/proc/on_owner_deletion(mob/living/deleted_mob)
	SIGNAL_HANDLER
	free_all_thralls()
	if(deleted_mob != owner.current)
		return
	if(is_head(deleted_mob))
		on_brainmob_qdel()

/datum/antagonist/bloodsucker/proc/register_body_signals(mob/target)
	for(var/signal in body_signals)
		RegisterSignal(target, signal, body_signals[signal])

/datum/antagonist/bloodsucker/proc/unregister_body_signals(mob/target)
	for(var/signal in body_signals)
		UnregisterSignal(target, signal)

/datum/antagonist/bloodsucker/proc/register_sol_signals()
	for(var/signal in sol_signals)
		RegisterSignal(SSsunlight, signal, sol_signals[signal])

/datum/antagonist/bloodsucker/proc/unregister_sol_signals()
	for(var/signal in sol_signals)
		UnregisterSignal(SSsunlight, signal)

/// Returns UI data for powers display in TGUI antag info panels
/datum/antagonist/proc/ability_ui_data(list/power_list)
	var/list/data = list()
	var/list/powers_data = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in power_list)
		var/list/power_data = list()
		power_data["power_name"] = power.name
		power_data["power_explanation"] = power.get_power_explanation()
		power_data["power_icon"] = power.button_icon_state
		powers_data += list(power_data)
	data["powers"] = powers_data
	return data
