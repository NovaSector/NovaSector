/datum/antagonist/vampire
	name = "\improper Vampire"
	roundend_category = "vampires"
	antagpanel_category = "Vampire"
	show_in_roundend = ROLE_VAMPIRE
	ui_name = "AntagInfoVampire"
	hijack_speed = 0
	stinger_sound = 'modular_nova/modules/bloodsucker/sound/lunge_warn.ogg'
	hud_icon = 'modular_nova/modules/bloodsucker/icons/antag_hud.dmi'
	antag_hud_name = "vampire"
	preview_outfit = /datum/outfit/vampire_outfit
	view_exploitables = TRUE
	can_assign_self_objectives = TRUE

	show_to_ghosts = TRUE

	jobban_flag = ROLE_VAMPIRE
	pref_flag = ROLE_VAMPIRE

	desensitized_modifier = DESENSITIZED_THRESHOLD

	/// How much blood we have, starting off at default blood levels.
	/// We don't use our actual body's temperature because some species don't have blood and we don't want to exclude them
	var/current_vitae = BLOOD_VOLUME_NORMAL
	/// How much blood we can have at once, increases per level.
	var/max_vitae = 600

	/// The vampire team, used for vassals
	var/datum/team/vampire/vampire_team
	/// The vampire's clan
	var/datum/vampire_clan/my_clan
	/// Our disciplines
	var/list/owned_disciplines = list()

	/// Timer between alerts for Burn messages
	COOLDOWN_DECLARE(vampire_spam_sol_burn)
	/// Timer between alerts for Healing messages
	COOLDOWN_DECLARE(vampire_spam_healing)

	/// Should we automatically forge objectives?
	var/should_forge_objectives = TRUE

	/// Flavor only
	var/vampire_name

	/// Are we the prince?
	var/prince = FALSE
	/// Are we the scourge? Literally only used for the examine. Okay.
	var/scourge = FALSE
	/// Have we been broken the Masquerade?
	var/broke_masquerade = FALSE
	/// How many Masquerade Infractions do we have?
	var/masquerade_infractions = 0
	/// Cooldown between masquerade infractions, so you can't have a bunch of them in the span of a single fight.
	COOLDOWN_DECLARE(masquerade_infraction_cooldown)

	/// How many vampires we've diablerized, if any.
	var/diablerie_count = 0

	/// How many humanity points do we have? 0-10
	/// We actually always start with 7 and then add the clan's default humanity
	var/humanity = VAMPIRE_DEFAULT_HUMANITY

	/// Blood required to enter Frenzy
	var/frenzy_threshold = FRENZY_THRESHOLD_ENTER
	/// If we've already alerted the player about low blood
	var/low_blood_alerted = FALSE
	/// Cooldown for re-entering frenzy after we exit it, to prevent potential spam/loops.
	COOLDOWN_DECLARE(frenzy_cooldown)

	/// Goal of vitae required for the next level up
	var/current_vitae_goal = VITAE_GOAL_STANDARD
	/// progress to that goal
	var/vitae_goal_progress = 0
	/// To keep track of objective
	var/total_blood_drank = 0

	/// Powers currently owned
	var/list/datum/action/cooldown/vampire/powers = list()

	/// Vassals under my control. Periodically remove the dead ones.
	var/list/datum/antagonist/vassal/vassals = list()

	/// The rank this vampire is at, used to level abilities and strength up
	var/vampire_level = 0
	var/vampire_level_unspent = VAMPIRE_STARTING_LEVELS

	/// If this guy has suffered final death.
	var/final_death = FALSE

	/// Additional regeneration when the vampire has a lot of blood
	var/additional_regen
	/// How much damage the vampire heals each life tick. Increases per rank up
	var/vampire_regen_rate = 0.3

	/// Minimum cooldown when reviving.
	COOLDOWN_DECLARE(revive_cooldown)

	/// How much more punch/kick damage the vampire gets per rank.
	var/extra_damage_per_rank = VAMPIRE_UNARMED_DMG_INCREASE_ON_RANKUP

	/// Haven
	var/area/vampire_haven_area
	var/obj/structure/closet/crate/coffin/coffin

	/// To make sure we don't spam sol damage messages
	var/were_shielded = FALSE

	/// Blood display HUD
	var/atom/movable/screen/vampire/blood_counter/blood_display
	/// Vampire level display HUD
	var/atom/movable/screen/vampire/rank_counter/vamprank_display
	/// Vampire humanity display HUD
	var/atom/movable/screen/vampire/humanity_counter/humanity_display
	/// Sunlight timer HUD
	var/atom/movable/screen/vampire/sunlight_counter/sunlight_display

	/// List of limbs we've applied modifications to.
	var/list/affected_limbs = list(
		BODY_ZONE_L_ARM = null,
		BODY_ZONE_R_ARM = null,
		BODY_ZONE_L_LEG = null,
		BODY_ZONE_R_LEG = null,
	)

	/// Static typecache of all vampire powers.
	var/static/list/all_vampire_powers = typecacheof(/datum/action/cooldown/vampire, ignore_root_path = TRUE)
	/// Antagonists that cannot be vassalized no matter what
	var/static/list/vassal_banned_antags = list(
		/datum/antagonist/vampire,
		/datum/antagonist/changeling,
		/datum/antagonist/cult,
		/datum/antagonist/clock_cultist,
	)

	/// List of traits that the Masquerade ability does not remove.
	var/static/list/always_traits = list(
		TRAIT_DRINKS_BLOOD,
		TRAIT_GENELESS, // prevents vamps from having genes at all. masquerade will work around this being an antag test with TRAIT_FAKEGENES
		TRAIT_NO_DNA_COPY, // no, you can't cheat your curse with a cloner.
		TRAIT_NO_MINDSWAP, // mindswapping vampires is buggy af and I'm too lazy to properly fix it. ~Absolucy
		TRAIT_SLIME_NO_CANNIBALIZE, // prevents weird softlocks
	)

	/// List of traits applied inherently
	var/static/list/vampire_traits = list(
		TRAIT_AGEUSIA,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NOHARDCRIT,
		TRAIT_NOSOFTCRIT,
		TRAIT_NO_MIRROR_REFLECTION,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_SLEEPIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_STABLELIVER,
		TRAIT_TOXIMMUNE,
		TRAIT_VIRUSIMMUNE,
		// they eject zombie tumors and xeno larvae during eepy time anyways
		TRAIT_NO_ZOMBIFY, // they're already undead lol
		TRAIT_XENO_IMMUNE, // something something facehuggers only latch onto living things
	)

	/// Humanity gain tracking, when adding more, remember to add the type define
	var/humanity_petting_goal = 5
	var/humanity_art_goal = 2
	var/humanity_hugging_goal = 3
	var/list/humanity_trackgain_hugged = list()
	var/list/humanity_trackgain_petted = list()
	var/list/humanity_trackgain_art = list()

/datum/antagonist/vampire/proc/create_vampire_team()
	vampire_team = new(owner)
	vampire_team.name = "[ADMIN_LOOKUP(owner.current)]'s vampire team" // only displayed to admins
	vampire_team.master_vampire = src

/datum/team/vampire
	name = "vampire team"
	var/datum/antagonist/vampire/master_vampire

/datum/team/vampire/roundend_report()
	return

/**
 * Apply innate effects is everything given to the mob
 * When a body is tranferred, this is called on the new mob
 * while on_gain is called ONCE per ANTAG, this is called ONCE per BODY.
 */
/datum/antagonist/vampire/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	RegisterSignals(current_mob, list(COMSIG_MOB_LOGIN, COMSIG_MOVABLE_Z_CHANGED), PROC_REF(on_login))
	RegisterSignal(current_mob, COMSIG_LIVING_LIFE, PROC_REF(life_tick))
	RegisterSignal(current_mob, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(current_mob, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(after_expose_reagents))
	RegisterSignal(current_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(current_mob, COMSIG_MOVABLE_MOVED, PROC_REF(update_all_trackers))
	RegisterSignal(current_mob, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(handle_blood))
	RegisterSignal(current_mob, COMSIG_MOB_UPDATE_SIGHT, PROC_REF(on_update_sight))

	RegisterSignal(current_mob, COMSIG_LIVING_PET_ANIMAL, PROC_REF(on_pet_animal))
	RegisterSignal(current_mob, COMSIG_LIVING_HUG_CARBON, PROC_REF(on_hug_carbon))
	RegisterSignal(current_mob, COMSIG_LIVING_APPRAISE_ART, PROC_REF(on_appraise_art))

	handle_clown_mutation(current_mob, "Your clownish nature has been subdued by your thirst for blood.")

	current_mob.update_sight()
	current_mob.clear_mood_event("vampcandle")

	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/antagonist, add_team_hud), current_mob), 0.5 SECONDS, TIMER_OVERRIDE | TIMER_UNIQUE) //i don't trust this to not act weird

	current_mob.add_faction(FACTION_VAMPIRE)

	if(current_mob.hud_used)
		on_hud_created()
	else
		RegisterSignal(current_mob, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))

	ensure_brain_nonvital(current_mob)
	setup_limbs(current_mob)

	if(ishuman(current_mob))
		var/mob/living/carbon/human/current_human = current_mob
		current_human.physiology?.stamina_mod *= VAMPIRE_INHERENT_STAMINA_RESIST

	var/datum/dna/current_mob_dna = current_mob.has_dna()
	if(current_mob_dna)
		if(current_mob_dna.check_mutation(/datum/mutation/dwarfism))
			ADD_TRAIT(current_mob, TRAIT_DWARF, TRAIT_VAMPIRE)
		current_mob_dna.remove_all_mutations()
	current_mob.add_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

	current_mob.grant_language(/datum/language/vampiric, source = LANGUAGE_VAMPIRE)

	my_clan?.apply_effects(current_mob)

/**
 * Remove innate effects is everything given to the mob
 * When a body is tranferred, this is called on the old mob.
 * while on_removal is called ONCE per ANTAG, this is called ONCE per BODY.
**/
/datum/antagonist/vampire/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	UnregisterSignal(current_mob, list(
		COMSIG_MOB_LOGIN,
		COMSIG_MOVABLE_Z_CHANGED,
		COMSIG_LIVING_LIFE,
		COMSIG_ATOM_EXAMINE,
		COMSIG_ATOM_EXPOSE_REAGENTS,
		COMSIG_LIVING_DEATH,
		COMSIG_MOVABLE_MOVED,
		COMSIG_HUMAN_ON_HANDLE_BLOOD,
		COMSIG_MOB_UPDATE_SIGHT,
		COMSIG_LIVING_PET_ANIMAL,
		COMSIG_LIVING_HUG_CARBON,
		COMSIG_LIVING_APPRAISE_ART,
	))
	current_mob.update_sight()
	current_mob.remove_status_effect(/datum/status_effect/frenzy)
	current_mob.remove_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

	handle_clown_mutation(current_mob, removing = FALSE)

	cleanup_limbs(current_mob)

	remove_hud_elements(current_mob)
	QDEL_NULL(blood_display)
	QDEL_NULL(vamprank_display)
	QDEL_NULL(humanity_display)

	current_mob.remove_faction(FACTION_VAMPIRE)

	if(ishuman(current_mob))
		var/mob/living/carbon/human/current_human = current_mob
		current_human.physiology?.stamina_mod /= VAMPIRE_INHERENT_STAMINA_RESIST

	if(!QDELETED(current_mob))
		my_clan?.remove_effects(current_mob)

/datum/antagonist/vampire/proc/remove_hud_elements(mob/living/current_mob)
	var/datum/hud/hud_used = current_mob?.hud_used
	if(hud_used)
		hud_used.infodisplay -= blood_display
		hud_used.infodisplay -= vamprank_display
		hud_used.infodisplay -= humanity_display
		hud_used.infodisplay -= sunlight_display
		hud_used.show_hud(hud_used.hud_version)
	QDEL_NULL(blood_display)
	QDEL_NULL(vamprank_display)
	QDEL_NULL(humanity_display)
	QDEL_NULL(sunlight_display)

/datum/antagonist/vampire/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER
	var/datum/hud/vampire_hud = owner.current.hud_used

	blood_display = new /atom/movable/screen/vampire/blood_counter(null, vampire_hud)
	vampire_hud.infodisplay += blood_display

	vamprank_display = new /atom/movable/screen/vampire/rank_counter(null, vampire_hud)
	vampire_hud.infodisplay += vamprank_display

	humanity_display = new /atom/movable/screen/vampire/humanity_counter(null, vampire_hud)
	vampire_hud.infodisplay += humanity_display

	sunlight_display = new /atom/movable/screen/vampire/sunlight_counter(null, vampire_hud)
	vampire_hud.infodisplay += sunlight_display

	vampire_hud.show_hud(vampire_hud.hud_version)
	UnregisterSignal(owner.current, COMSIG_MOB_HUD_CREATED)

/datum/antagonist/vampire/get_admin_commands()
	. = ..()
	.["Level Add"] = CALLBACK(src, PROC_REF(rank_up), 1)

	if(vampire_level_unspent > 0)
		.["Level Deduct"] = CALLBACK(src, PROC_REF(rank_down))

	if(!broke_masquerade)
		.["Break Masq"] = CALLBACK(src, PROC_REF(break_masquerade))
		.["Add Infraction"] = CALLBACK(src, PROC_REF(give_masquerade_infraction), TRUE)

	if(humanity > 0)
		.["Humanity Deduct"] = CALLBACK(src, PROC_REF(adjust_humanity), -1, FALSE)
	else if(humanity < 10)
		.["Humanity Add"] = CALLBACK(src, PROC_REF(adjust_humanity), 1, FALSE)

/datum/antagonist/vampire/on_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_VAMPIRE_ALIGNED, REF(src))

	RegisterSignal(src, COMSIG_VAMPIRE_TRACK_HUMANITY_GAIN, PROC_REF(on_track_humanity_gain_signal))
	RegisterSignal(owner, COMSIG_SLIME_CORE_EJECTED, PROC_REF(on_slime_core_ejected))
	RegisterSignal(owner, COMSIG_SLIME_REVIVED, PROC_REF(on_slime_revive))

	RegisterSignal(SSsol, COMSIG_SOL_NEAR_START, PROC_REF(sol_near_start))
	RegisterSignal(SSsol, COMSIG_SOL_END, PROC_REF(on_sol_end))
	RegisterSignal(SSsol, COMSIG_SOL_NEAR_END, PROC_REF(sol_near_end))
	RegisterSignal(SSsol, COMSIG_SOL_RISE_TICK, PROC_REF(handle_sol))
	RegisterSignal(SSsol, COMSIG_SOL_WARNING_GIVEN, PROC_REF(give_warning))

	owner.teach_crafting_recipe(list(
		/datum/crafting_recipe/vassalrack,
		/datum/crafting_recipe/candelabrum,
		/datum/crafting_recipe/bloodthrone,
		/datum/crafting_recipe/meatcoffin,
	))

	// Set name and reputation
	select_first_name()

	// Objectives
	if(should_forge_objectives)
		forge_objectives()

	create_vampire_team()

	// Assign starting stats skill point.
	give_starting_powers()
	GLOB.all_vampires += src

	// Start society if we're the first vampire
	check_start_society()

	if(!QDELETED(owner.current))
		for(var/quirk_type in typesof(/datum/quirk/item_quirk/addict) + /datum/quirk/skittish)
			owner.current.remove_quirk(quirk_type)

#ifdef VAMPIRE_TESTING
	var/turf/user_loc = get_turf(owner.current)
	new /obj/structure/closet/crate/coffin(user_loc)
	new /obj/structure/vampire/vassalrack(user_loc)
#endif

/datum/antagonist/vampire/on_removal()
	REMOVE_TRAIT(owner, TRAIT_VAMPIRE_ALIGNED, REF(src))
	UnregisterSignal(owner, list(COMSIG_SLIME_CORE_EJECTED, COMSIG_SLIME_REVIVED))
	UnregisterSignal(SSsol, list(COMSIG_SOL_NEAR_END, COMSIG_SOL_NEAR_START, COMSIG_SOL_END, COMSIG_SOL_RISE_TICK, COMSIG_SOL_WARNING_GIVEN))

	owner.forget_crafting_recipe(list(
		/datum/crafting_recipe/vassalrack,
		/datum/crafting_recipe/candelabrum,
		/datum/crafting_recipe/bloodthrone,
		/datum/crafting_recipe/meatcoffin,
	))

	clear_powers_and_stats()
	GLOB.all_vampires -= src
	check_cancel_society()

	if(iscarbon(owner.current))
		var/mob/living/carbon/carbon_owner = owner.current
		var/obj/item/organ/brain/not_vamp_brain = carbon_owner.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(not_vamp_brain && (not_vamp_brain.decoy_override != initial(not_vamp_brain.decoy_override)))
			not_vamp_brain.organ_flags |= ORGAN_VITAL
			not_vamp_brain.decoy_override = FALSE

	return ..()

/datum/antagonist/vampire/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()

	// Transfer powers
	for(var/datum/action/cooldown/vampire/all_powers in powers)
		if(old_body)
			all_powers.Remove(old_body)
		all_powers.Grant(new_body)

	// Vampire Traits
	old_body?.remove_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)
	new_body.add_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

/*
/datum/antagonist/vampire/after_body_transfer(mob/living/old_body, mob/living/new_body)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/antagonist, add_team_hud), new_body), 0.5 SECONDS, TIMER_OVERRIDE | TIMER_UNIQUE) //i don't trust this to not act weird
*/

/datum/antagonist/vampire/greet()
	if(silent)
		return
	var/fullname = return_full_name()
	var/list/msg = list()

	msg += span_cult_large("You are a Vampire!\n")
	msg += span_cult("Open the Vampire Information panel for information about your Powers, Clan, and more. \n\n\
			You can also click on all of your hud meters for more information about them!")

	to_chat(owner, boxed_message(msg.Join("\n")))
	play_stinger()

	if(should_forge_objectives)
		owner.announce_objectives()
	antag_memory += "Although you were born a mortal, in undeath you earned the name <b>[fullname]</b>.<br>"

/datum/antagonist/vampire/farewell()
	to_chat(owner.current, span_userdanger("With a snap, your curse has ended. You are no longer a Vampire. You live once more!"))
	// Refill with Blood so they don't instantly die.
	if(!HAS_TRAIT(owner.current, TRAIT_NOBLOOD))
		owner.current.set_blood_volume(BLOOD_VOLUME_NORMAL)

// Called when using admin tools to give antag status
/datum/antagonist/vampire/admin_add(datum/mind/new_owner, mob/admin)
	var/levels = input("How many unspent Ranks would you like [new_owner] to have?","Vampire Rank", vampire_level_unspent) as null | num
	var/msg = "made [key_name_admin(new_owner)] into \a [name]"
	if(levels > 0)
		vampire_level_unspent = levels
		msg += " with [levels] extra unspent Ranks."
	message_admins("[key_name_admin(usr)] [msg]")
	log_admin("[key_name(usr)] [msg]")
	new_owner.add_antag_datum(src)

/datum/antagonist/vampire/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/vampire_header),
	)

/datum/antagonist/vampire/ui_static_data(mob/user)
	. = ..()

	//we don't need to update this that much.
	.["in_clan"] = !!my_clan
	var/list/clan_data = list()
	if(my_clan)
		clan_data["name"] = my_clan.name
		clan_data["description"] = my_clan.description
		clan_data["icon"] = my_clan.join_icon
		clan_data["icon_state"] = my_clan.join_icon_state

	.["clan"] += list(clan_data)

	for(var/datum/action/cooldown/vampire/power as anything in powers)
		var/list/power_data = list()

		power_data["name"] = power.name
		power_data["explanation"] = power.power_explanation
		power_data["icon"] = power.button_icon
		power_data["icon_state"] = power.button_icon_state

		power_data["cost"] = power.vitaecost ? power.vitaecost : "0"
		power_data["constant_cost"] = power.constant_vitaecost ? power.constant_vitaecost : "0"
		power_data["cooldown"] = power.cooldown_time / 10

		.["powers"] += list(power_data)

/datum/antagonist/vampire/get_preview_icon()
	var/datum/universal_icon/final_icon = render_preview_outfit(/datum/outfit/vampire_outfit)
	var/datum/universal_icon/blood_icon = uni_icon('icons/effects/blood.dmi', "suitblood")
	blood_icon.blend_color(BLOOD_COLOR_RED, ICON_MULTIPLY)
	final_icon.blend_icon(blood_icon, ICON_OVERLAY)

	return finish_preview_icon(final_icon)

/datum/antagonist/vampire/roundend_report()
	var/list/report = list()

	// Vamp name
	report += "<br>[span_header(return_full_name())]"
	report += printplayer(owner)
	if(my_clan)
		report += "They were part of the <b>[my_clan.name]</b>!"

	// Default Report
	var/objectives_complete = TRUE
	if(length(objectives))
		report += printobjectives(objectives)
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	// Now list their vassals
	if(length(vassals))
		report += span_header("<br>Their vassals were...")
		for(var/datum/antagonist/vassal/vassal in vassals)
			if(!vassal.owner)
				continue

			var/list/vassal_report = list()
			vassal_report += "<b>[vassal.owner.name]</b>"

			if(vassal.owner.assigned_role)
				vassal_report += " the [vassal.owner.assigned_role.title]"
			report += vassal_report.Join()

	if(objectives_complete)
		report += span_greentext(span_big("<br>The [name] was successful!"))
	else
		report += span_redtext(span_big("<br>The [name] has failed!"))

	return report.Join("<br>")

/datum/antagonist/vampire/hijack_speed()
	. = ..()
	if(istype(my_clan, /datum/vampire_clan/malkavian)) // the voices told them to do it
		return max(., 1)

/// "Oh, well, that's step one. What about two through ten?"
/// Beheading vampires is kinda buggy and results in them being dead-dead without actually being final deathed, which is NOT something that's desired.
/// Just stake them. No shortcuts.
/datum/antagonist/vampire/proc/ensure_brain_nonvital(mob/living/mob_override)
	var/mob/living/carbon/carbon_owner = mob_override || owner.current
	if(!iscarbon(carbon_owner) || isjellyperson(carbon_owner))
		return
	var/obj/item/organ/brain/brain = carbon_owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(QDELETED(brain))
		return
	brain.organ_flags &= ~ORGAN_VITAL
	brain.decoy_override = TRUE


/datum/antagonist/vampire/proc/give_starting_powers()
	for(var/datum/action/cooldown/vampire/all_powers as anything in all_vampire_powers)
		if(!(initial(all_powers.special_flags) & VAMPIRE_DEFAULT_POWER))
			continue
		grant_power(new all_powers)

/**
 * ##clear_power_and_stats()
 *
 * Removes all Vampire related Powers/Stats changes, setting them back to pre-Vampire
 * Order of steps and reason why:
 * Remove clan - Clans like Nosferatu give Powers on removal, we have to make sure this is given before removing Powers.
 * Powers - Remove all Powers, so things like Masquerade are off.
 * Species traits, Traits, MaxHealth, Language - Misc stuff, has no priority.
 * Organs - At the bottom to ensure everything that changes them has reverted themselves already.
 * Update Sight - Done after Eyes are regenerated.
 */
/datum/antagonist/vampire/proc/clear_powers_and_stats()
	var/mob/living/carbon/user = owner.current

	// Remove clan first
	if(my_clan)
		my_clan.remove_effects(user)
		QDEL_NULL(my_clan)

	// Powers
	for(var/datum/action/cooldown/vampire/all_powers as anything in powers)
		remove_power(all_powers)

	/// Stats
	if(ishuman(owner.current))
		var/mob/living/carbon/human/human_user = user
		human_user.physiology.stamina_mod /= VAMPIRE_INHERENT_STAMINA_RESIST

	// Remove all vampire traits
	user.remove_traits(vampire_traits + always_traits, TRAIT_VAMPIRE)

	// Update Health
	user.setMaxHealth(initial(user.maxHealth))

	// Language
	user.remove_language(/datum/language/vampiric, source = LANGUAGE_VAMPIRE)

	// Heart
	var/obj/item/organ/heart/newheart = user.get_organ_slot(ORGAN_SLOT_HEART)
	newheart?.Restart()

/datum/antagonist/vampire/proc/claim_coffin(obj/structure/closet/crate/coffin/claimed)
	var/static/list/banned_areas_typecache
	if(isnull(banned_areas_typecache))
		banned_areas_typecache = typecacheof(list(
			/area/icemoon,
			/area/lavaland,
			/area/ocean,
			/area/space,
		))

	// ALREADY CLAIMED
	if(claimed.resident)
		if(claimed.resident == owner)
			to_chat(owner, span_notice("This is your [claimed]."))
		else
			to_chat(owner, span_warning("This [claimed] has already been claimed by another."))
		return FALSE
	var/turf/coffin_turf = get_turf(claimed)
	var/area/current_area = get_area(coffin_turf)
	// this if check is split up bc it's annoying to read and mentally parse when it's combined into one big if statement
	var/valid_haven_area = TRUE
	if(!coffin_turf)
		valid_haven_area = FALSE
	else if(is_type_in_typecache(current_area, banned_areas_typecache) || (istype(current_area, /area/ruin) && current_area.outdoors))
		valid_haven_area = FALSE
	if(!valid_haven_area)
		claimed.balloon_alert(owner.current, "ineligible area!")
		return
	// This is my Haven
	coffin = claimed
	coffin.resident = owner
	vampire_haven_area = current_area

	to_chat(owner, span_userdanger("You have claimed [claimed] as your place of immortal rest! Your haven is now [vampire_haven_area]."))
	return TRUE

/// Name shown on antag list
/datum/antagonist/vampire/antag_listing_name()
	return ..() + return_full_name()

/datum/action/antag_info/vampire
	name = "Vampire Guide"
	background_icon = 'modular_nova/modules/bloodsucker/icons/actions_vampire.dmi'
	background_icon_state = "vamp_power_off"

/datum/antagonist/vampire/add_team_hud(mob/target, antag_to_check, passed_hud_keys)
	if(broke_masquerade)
		antag_hud_name = "masquerade_broken"
	else if(scourge)
		antag_hud_name = "scourge"
	else if(prince)
		antag_hud_name = "prince"
	else
		antag_hud_name = my_clan?.antag_hud_icon || initial(antag_hud_name)

	QDEL_NULL(team_hud_ref)

	var/datum/atom_hud/alternate_appearance/basic/has_antagonist/hud = target.add_alt_appearance(
		/datum/atom_hud/alternate_appearance/basic/has_antagonist,
		"antag_team_hud_[REF(src)]",
		hud_image_on(target),
	)
	team_hud_ref = WEAKREF(hud)

	var/list/mob/living/mob_list = list()
	for(var/datum/antagonist/antag as anything in GLOB.antagonists)
		if(!istype(antag, /datum/antagonist/vampire) && !istype(antag, /datum/antagonist/vassal))
			continue
		var/mob/living/current = antag.owner?.current
		if(!QDELETED(current))
			mob_list |= current

	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/antag_hud as anything in GLOB.has_antagonist_huds)
		if(!(antag_hud.target in mob_list))
			continue
		antag_hud.show_to(target)
		hud.show_to(antag_hud.target)


/**
 * Every vampire has 3 starting objective categories:
 * Ego: Grow more powerful / strengthen your position / etc
 * Hedonism: Indulge in bad things that feel all too right.
 * Survival: Survive. Obviously.
 */
/datum/antagonist/vampire/forge_objectives()
	var/datum/objective/vampire/extra_objective

	/* if(prob(80)) */
	extra_objective = new /datum/objective/vampire/ego/vassals
	/* else
		extra_objective = new /datum/objective/vampire/ego/department_vassal */

	extra_objective.owner = owner
	objectives += extra_objective

	//pick Hedonism objective
	switch(rand(1, 2))
		if(1)
			extra_objective = new /datum/objective/vampire/hedonism/gourmand
		if(2)
			extra_objective = new /datum/objective/vampire/hedonism/thirster

	extra_objective.owner = owner
	objectives += extra_objective

	// Survive Objective
	var/datum/objective/survive/vampire/survive_objective = new
	survive_objective.owner = owner
	objectives += survive_objective

/// Use this instead of `length(vassals)`, as it won't count round removed vassals and such.
/datum/antagonist/vampire/proc/count_vassals(only_living = FALSE)
	. = 0
	for(var/datum/antagonist/vassal/vassal as anything in vassals)
		var/mob/living/vassal_body = vassal.owner.current
		if(QDELETED(vassal_body))
			continue
		if(only_living && !considered_alive(vassal.owner))
			continue
		if(!HAS_TRAIT(vassal_body, TRAIT_MIND_TEMPORARILY_GONE))
			if(vassal_body.stat == DEAD)
				if(HAS_TRAIT(vassal_body, TRAIT_DEFIB_BLACKLISTED))
					continue
				if(!vassal_body.key)
					var/mob/dead/observer/vassal_ghost = vassal_body.get_ghost(TRUE, TRUE)
					if(isnull(vassal_ghost) || (istype(vassal_ghost) && !vassal_ghost.can_reenter_corpse)) // soulcatcher shitcode workaround
						continue
			else if(!vassal_body.key)
				continue
		.++

/datum/antagonist/vampire/proc/get_max_vassals()
	var/total_players = length(GLOB.player_list)
	switch(total_players)
		if(1 to 20)
			return 1
		if(21 to 30)
			return 2
		else
			return 3

/datum/antagonist/vampire/proc/on_examine(datum/source, mob/examiner, list/examine_text)
	SIGNAL_HANDLER
	var/text
	if(prince)
		text = "<img class='icon' src='\ref['modular_nova/modules/bloodsucker/icons/vampiric.dmi']?state=prince'> "
	else if(scourge)
		text = "<img class='icon' src='\ref['modular_nova/modules/bloodsucker/icons/vampiric.dmi']?state=scourge'> "
	else
		text = "<img class='icon' src='\ref['modular_nova/modules/bloodsucker/icons/vampiric.dmi']?state=vampire'> "

	if(IS_VASSAL(examiner) in vassals)
		text += span_cult("<EM>This is, [return_full_name()] your Master!</EM>")
		examine_text += text
		return

	if(HAS_MIND_TRAIT(examiner, TRAIT_VAMPIRE_ALIGNED))

		if(my_clan)
			text += span_cult("<EM>[return_full_name()], of the [my_clan].</EM>")
		else
			text += span_cult("<EM>[return_full_name()], a disgusting caitiff thinblood.</EM>")

		if(examiner != owner.current) // So many ifs. where is yanderedev.
			if(scourge)
				text += span_cult_large("<br><EM>[owner.current.p_They()] [owner.current.p_are()] the Scourge!</EM>")
			if(prince)
				text += span_cult_large("<br><EM>[owner.current.p_They()] [owner.current.p_are()] your Prince!</EM>")
			if(broke_masquerade)
				text += span_cult_large("<br><EM>You recognize [owner.current.p_them(TRUE)] as a masquerade breaker!</EM>")

		examine_text += text

	if(diablerie_count > 0 && HAS_TRAIT(examiner, TRAIT_SEE_DIABLERIE))
		examine_text += span_cult_large("<br><EM>You can see the corrupted marks of a diablerist in [owner.current.p_their()] aura!</EM>")

/datum/antagonist/vampire/proc/setup_limbs(mob/living/carbon/target)
	if(!iscarbon(target))
		return
	RegisterSignal(target, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(register_limb))
	RegisterSignal(target, COMSIG_CARBON_POST_REMOVE_LIMB, PROC_REF(unregister_limb))
	for(var/body_part in affected_limbs)
		var/obj/item/bodypart/limb = target.get_bodypart(check_zone(body_part))
		if(limb)
			register_limb(target, limb, initial = TRUE)

/datum/antagonist/vampire/proc/cleanup_limbs(mob/living/carbon/target)
	if(!iscarbon(target))
		return
	UnregisterSignal(target, list(COMSIG_CARBON_POST_ATTACH_LIMB, COMSIG_CARBON_POST_REMOVE_LIMB))
	for(var/body_part in affected_limbs)
		var/obj/item/bodypart/limb = target.get_bodypart(check_zone(body_part))
		if(limb)
			unregister_limb(target, limb)

/datum/antagonist/vampire/proc/register_limb(mob/living/carbon/owner, obj/item/bodypart/new_limb, special, initial = FALSE)
	SIGNAL_HANDLER

	affected_limbs[new_limb.body_zone] = new_limb
	RegisterSignal(new_limb, COMSIG_QDELETING, PROC_REF(limb_gone))

	var/extra_damage = 1 + (vampire_level * extra_damage_per_rank)
	new_limb.unarmed_damage_low += extra_damage
	new_limb.unarmed_damage_high += extra_damage

/datum/antagonist/vampire/proc/unregister_limb(mob/living/carbon/owner, obj/item/bodypart/lost_limb, special)
	SIGNAL_HANDLER

	var/extra_damage = 1 + (vampire_level * extra_damage_per_rank)
	lost_limb.unarmed_damage_low = max(lost_limb.unarmed_damage_low - extra_damage, initial(lost_limb.unarmed_damage_low))
	lost_limb.unarmed_damage_high = max(lost_limb.unarmed_damage_high - extra_damage, initial(lost_limb.unarmed_damage_high))
	affected_limbs[lost_limb.body_zone] = null
	UnregisterSignal(lost_limb, COMSIG_QDELETING)

/datum/antagonist/vampire/proc/limb_gone(obj/item/bodypart/deleted_limb)
	SIGNAL_HANDLER
	if(affected_limbs[deleted_limb.body_zone])
		affected_limbs[deleted_limb.body_zone] = null
		UnregisterSignal(deleted_limb, COMSIG_QDELETING)

/datum/antagonist/vampire/proc/after_expose_reagents(mob/source_mob, list/reagents, datum/reagents/source, methods = TOUCH, volume_modifier = 1, show_message = TRUE)
	SIGNAL_HANDLER
	var/datum/reagent/blood/blood_reagent = locate() in reagents
	if(!blood_reagent)
		return
	var/blood_volume = round(reagents[blood_reagent], 0.1)
	if(blood_volume > 0)
		adjust_blood_volume(blood_volume)

/datum/antagonist/vampire/proc/on_login()
	SIGNAL_HANDLER
	var/mob/living/current = owner.current
	if(!QDELETED(current))
		addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/antagonist, add_team_hud), current), 0.5 SECONDS, TIMER_OVERRIDE | TIMER_UNIQUE) //i don't trust this to not act weird

/datum/antagonist/vampire/proc/on_update_sight(mob/user)
	SIGNAL_HANDLER
	user.add_sight(SEE_MOBS)
	user.lighting_cutoff = max(user.lighting_cutoff, LIGHTING_CUTOFF_HIGH)
	user.lighting_color_cutoffs = user.lighting_color_cutoffs ? blend_cutoff_colors(user.lighting_color_cutoffs, list(25, 8, 5)) : list(25, 8, 5)

/datum/outfit/vampire_outfit
	name = "Vampire outfit (Preview only)"
	suit = /obj/item/clothing/suit/costume/dracula

/datum/outfit/vampire_outfit/post_equip(mob/living/carbon/human/enrico, visualsOnly=FALSE)
	enrico.hairstyle = "Undercut"
	enrico.hair_color = "FFF"
	enrico.skin_tone = "african2"
	enrico.eye_color_left = "#663300"
	enrico.eye_color_right = "#663300"

	enrico.update_body(is_creating = TRUE)

/datum/asset/simple/vampire_header
	assets = list("vampire.png" = 'modular_nova/modules/bloodsucker/html/images/vampire.png')

/obj/item/antag_granter/vampire
	name = "strange vial"
	desc = "A large vial filled with a strange viscous, red substance. It has no markings apart from an orange warning stripe near the cap."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"
	antag_datum = /datum/antagonist/vampire
	user_message = "As you chug the strange liquid within the bottle, you start to feel... <span class='red'><b>thirsty</b></span>..."

/datum/opposing_force_equipment/uplink/vampire
	item_type = /obj/item/antag_granter/vampire
	name = "Vampiric Blood"
	description = "A mysterious vial filled with a strange viscous, red substance, said to turn the user into a \"Vampire\"."
	admin_note = "Vampire antag granter."

/obj/item/clothing/neck/necklace/memento_mori/memento(mob/living/carbon/human/user)
	if(IS_VAMPIRE(user))
		to_chat(user, span_warning("\The [src] rejects you."))
		return FALSE
	return ..()
