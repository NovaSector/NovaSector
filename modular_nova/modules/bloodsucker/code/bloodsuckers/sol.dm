/**
 *	# Assigning Sol
 *
 *	Sol is the sunlight, during this period, all Bloodsuckers must be in their den, else they burn.
 */

///Ranks the Bloodsucker up, called by Sol.
/datum/antagonist/bloodsucker/proc/sol_rank_up(atom/source)
	SIGNAL_HANDLER

	// Bloodsuckers above BLOODSUCKER_HIGH_LEVEL must drink blood to level up.
	if(sol_levels == 1) // just in case a bloodsucker is stuck at this level
		// very important info here, so we use span_danger
		to_chat(owner.current, span_danger("Sol's foul gaze no longer grants you power. You must drink blood to advance further."))
	if(sol_levels <= 0)
		return
	sol_levels--
	INVOKE_ASYNC(src, PROC_REF(RankUp))

///Called when Sol is near starting.
/datum/antagonist/bloodsucker/proc/sol_near_start(atom/source)
	SIGNAL_HANDLER
	if(bloodsucker_haven_area && !(locate(/datum/action/cooldown/bloodsucker/gohome) in powers))
		BuyPower(/datum/action/cooldown/bloodsucker/gohome)

///Called when Sol first ends.
/datum/antagonist/bloodsucker/proc/on_sol_end(atom/source)
	SIGNAL_HANDLER
	check_end_dormancy()
	for(var/datum/action/cooldown/bloodsucker/power in powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/gohome))
			RemovePower(power)

/datum/antagonist/bloodsucker/proc/handle_sol()
	SIGNAL_HANDLER
	if(!owner || !owner.current || isbrain(owner.current))
		return

	if(HAS_TRAIT(owner.current, TRAIT_SHADED))
		return

	if(!istype(owner.current.loc, /obj/structure))
		if(COOLDOWN_FINISHED(src, bloodsucker_spam_sol_burn))
			if(bloodsucker_level > 0)
				to_chat(owner, span_userdanger("The solar flare sets your skin ablaze!"))
			else
				to_chat(owner, span_userdanger("The solar flare scalds your neophyte skin!"))
			COOLDOWN_START(src, bloodsucker_spam_sol_burn, BLOODSUCKER_SPAM_SOL) //This should happen twice per Sol

		if(owner.current.fire_stacks <= 0)
			owner.current.fire_stacks = 0
		if(bloodsucker_level > 0)
			owner.current.adjust_fire_stacks(0.2 + bloodsucker_level / 10)
			owner.current.ignite_mob()
		owner.current.adjust_fire_loss(2 + (bloodsucker_level / 2))
		owner.current.updatehealth()
		owner.current.add_mood_event("vampsleep", /datum/mood_event/daylight_sun_scorched)
		return

	if(is_valid_den()) // Claimed dens offer the BEST protection
		if(owner.current.am_staked() && COOLDOWN_FINISHED(src, bloodsucker_spam_sol_burn))
			to_chat(owner.current, span_userdanger("You are staked you will keep burning until it is removed! Remove the offending weapon from your heart before sleeping."))
			COOLDOWN_START(src, bloodsucker_spam_sol_burn, BLOODSUCKER_SPAM_SOL) //This should happen twice per Sol
		if(!is_in_dormancy())
			check_begin_dormancy(DORMANCY_SKIP_CHECK_ALL)
			owner.current.add_mood_event("vampsleep", /datum/mood_event/coffinsleep)
		return

	if(COOLDOWN_FINISHED(src, bloodsucker_spam_sol_burn)) // Closets offer SOME protection
		to_chat(owner, span_warning("Your skin sizzles. [owner.current.loc] doesn't protect well against UV bombardment."))
		COOLDOWN_START(src, bloodsucker_spam_sol_burn, BLOODSUCKER_SPAM_SOL) //This should happen twice per Sol
	owner.current.adjust_fire_loss(0.5 + (bloodsucker_level / 4))
	owner.current.updatehealth()
	owner.current.add_mood_event("vampsleep", /datum/mood_event/daylight_bad_sleep)

/datum/antagonist/bloodsucker/proc/give_warning(atom/source, danger_level, vampire_warning_message, ghoul_warning_message)
	SIGNAL_HANDLER
	SSsunlight.warn_notify(owner.current, danger_level, vampire_warning_message)

/**
 * # Dormancy
 *
 * Dormancy is what deals with the Bloodsucker falling asleep, their healing, the effects, etc.
 * This is basically what Sol is meant to do to them, but they can also trigger it manually if they wish to heal, as Burn is only healed through Dormancy.
 * You cannot manually exit Dormancy, it is instead entered/exited by:
 *
 * Dormancy is triggered by:
 * - Being in a den while Sol is on, dealt with by Sol
 * - Entering a den with more than 10 combined Brute/Burn damage, dealt with by /datum/antagonist/bloodsucker/on_enter_den() [procs.dm]
 * - Death, dealt with by /HandleDeath()
 * Dormancy is ended by:
 * - Having less than maxHealth * 0.8 damage while OUTSIDE of your den while it isnt Sol.
 * - Having less than 10 Damage Combined while INSIDE of your den while it isnt Sol.
 * - Sol being over, dealt with by /datum/controller/subsystem/processing/sunlight/process() [sol_subsystem.dm]
*/
/datum/antagonist/bloodsucker/proc/check_begin_dormancy(SkipChecks = NONE)
	var/mob/living/carbon/user = owner.current
	/// Are we entering Dormancy via Sol/Death? Then entering it isnt optional!
	// do not skip checking organs for torpor
	if(ishuman(user))
		var/mob/living/carbon/human/humie = user
		if(humie.dna.species.mutantheart && !user.get_organ_slot(ORGAN_SLOT_HEART))
			return FALSE
	if(SkipChecks & DORMANCY_SKIP_CHECK_ALL)
		if(COOLDOWN_FINISHED(src, bloodsucker_spam_dormancy))
			to_chat(user, span_danger("Your body will not yet relinquish. The symbiont forces you into Dormancy."))
		dormancy_begin(TRUE)
		return TRUE
	/// Prevent Dormancy whilst in feral episode.
	if(!(SkipChecks & DORMANCY_SKIP_CHECK_FERAL) && (frenzied || (IS_DEAD_OR_INCAP(user) && bloodsucker_blood_volume == 0)))
		to_chat(user, span_userdanger("The feral episode prevents you from entering Dormancy!"))
		return FALSE
	// sometimes you might incur these damage types when you really, should not, important to check for it here so we can heal it later
	var/total_damage = get_brute_loss() + get_fire_loss() + user.get_tox_loss() + user.get_oxy_loss()
	/// Checks - Not daylight & Has more than 10 Brute/Burn & not already in Torpor
	if(SkipChecks & DORMANCY_SKIP_CHECK_DAMAGE || !SSsunlight.sunlight_active && total_damage >= 10 && !is_in_dormancy())
		dormancy_begin()
		return TRUE
	return FALSE

/datum/antagonist/bloodsucker/proc/is_in_dormancy()
	return owner.current && HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_DORMANCY, BLOODSUCKER_TRAIT)

/datum/antagonist/bloodsucker/proc/check_end_dormancy(early_end = FALSE)
	var/mob/living/carbon/user = owner.current
	var/total_brute = get_brute_loss()
	var/total_burn = get_fire_loss()
	// for waking up we ignore all other damage types so we don't get stuck
	var/total_damage = total_brute + total_burn
	var/is_in_den = is_valid_den()
	if(total_burn >= user.maxHealth * 2)
		return FALSE
	if(SSsunlight.sunlight_active && is_in_den)
		return FALSE
	if(bloodsucker_blood_volume == 0 || early_end || (SSsunlight.sunlight_active && !is_in_den))
		// If you're frenzying, you need a bit more health to actually have a chance to do something
		if(frenzied && total_damage >= user.maxHealth)
			return FALSE
		dormancy_end()
	// You are in a den, so instead we'll check TOTAL damage, here.
	var/damage_to_revive = owner.current.maxHealth * 0.8
	if(is_valid_den())
		if(total_damage <= 10)
			dormancy_end()
	else
		if(total_damage <= damage_to_revive)
			dormancy_end()
	return TRUE

/datum/antagonist/bloodsucker/proc/dormancy_begin(silent = FALSE)
	// slow down bucko
	if(!COOLDOWN_FINISHED(src, bloodsucker_spam_dormancy))
		return
	if(!silent)
		to_chat(owner.current, span_notice("You enter Dormancy. The symbiont will regenerate your body until you are renewed."))
	// Force them to go to "sleep"
	if(!is_valid_den())
		owner.current.death()
	else
		owner.current.add_traits(list(TRAIT_FAKEDEATH, TRAIT_DEATHCOMA), BLOODSUCKER_TRAIT)
	// Without this, you'll just keep dying while you recover.
	owner.current.add_traits(list(TRAIT_DORMANCY, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_DEATHCOMA), BLOODSUCKER_TRAIT)
	owner.current.do_jitter_animation(2)
	// Disable ALL Powers
	DisableAllPowers()

/datum/antagonist/bloodsucker/proc/dormancy_end(message = FALSE)
	if(!owner.current)
		return
	owner.current.grab_ghost()
	owner.current.remove_traits(list(TRAIT_DORMANCY, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_FAKEDEATH, TRAIT_DEATHCOMA), BLOODSUCKER_TRAIT)
	heal_organs()
	if(message)
		to_chat(owner.current, span_warning("You have recovered from Dormancy."))
	SEND_SIGNAL(src, COMSIG_BLOODSUCKER_EXIT_DORMANCY)
