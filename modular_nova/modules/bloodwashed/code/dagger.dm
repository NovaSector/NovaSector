/proc/bloodwashed_restrict_ritual_dagger(obj/item/melee/cultblade/dagger/dagger)
	var/datum/component/cult_ritual_item/current_component = dagger.GetComponent(/datum/component/cult_ritual_item)
	if(istype(current_component, /datum/component/cult_ritual_item/bloodwashed))
		return
	if(current_component)
		var/datum/action/current_action = current_component.linked_action_ref?.resolve()
		qdel(current_action)
		qdel(current_component)

	dagger.AddComponent(/datum/component/cult_ritual_item/bloodwashed, bloodwashed_ritual_dagger_examine_text())

/proc/bloodwashed_restore_ritual_dagger(obj/item/melee/cultblade/dagger/dagger)
	var/datum/component/cult_ritual_item/current_component = dagger.GetComponent(/datum/component/cult_ritual_item)
	if(!istype(current_component, /datum/component/cult_ritual_item/bloodwashed))
		return

	var/datum/action/current_action = current_component.linked_action_ref?.resolve()
	qdel(current_action)
	qdel(current_component)

	dagger.AddComponent(/datum/component/cult_ritual_item, regular_ritual_dagger_examine_text())

/proc/bloodwashed_ritual_dagger_examine_text()
	var/examine_text = {"Allows the scribing of simple blood runes remembered by the Bloodwashed.
Hitting a cult structure will unanchor or reanchor it. Cult Girders will be destroyed in a single blow.
Can be used to scrape blood runes away, removing any trace of them.
Striking another cultist with it will purge all holy water from them and transform it into unholy water.
Striking a noncultist, however, will tear their flesh."}
	return span_cult(examine_text)

/proc/regular_ritual_dagger_examine_text()
	var/examine_text = {"Allows the scribing of blood runes of the cult of Nar'Sie.
Hitting a cult structure will unanchor or reanchor it. Cult Girders will be destroyed in a single blow.
Can be used to scrape blood runes away, removing any trace of them.
Striking another cultist with it will purge all holy water from them and transform it into unholy water.
Striking a noncultist, however, will tear their flesh."}
	return span_cult(examine_text)

/datum/component/cult_ritual_item/bloodwashed/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))

/datum/component/cult_ritual_item/bloodwashed/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_DROPPED)
	return ..()

/datum/component/cult_ritual_item/bloodwashed/proc/on_dropped(obj/item/melee/cultblade/dagger/source, mob/dropper)
	SIGNAL_HANDLER

	if(dropper?.mind?.has_antag_datum(/datum/antagonist/cult/bloodwashed))
		bloodwashed_restore_ritual_dagger(source)

/datum/component/cult_ritual_item/bloodwashed/do_scribe_rune(obj/item/tool, mob/living/cultist)
	if(!cultist.mind?.has_antag_datum(/datum/antagonist/cult/bloodwashed))
		return ..()

	var/turf/our_turf = get_turf(cultist)
	var/obj/effect/rune/rune_to_scribe
	var/entered_rune_name
	var/chosen_keyword

	var/datum/antagonist/cult/user_antag = cultist.mind.has_antag_datum(/datum/antagonist/cult, TRUE)
	var/datum/team/cult/user_team = user_antag?.get_team()
	if(!user_antag || !user_team)
		stack_trace("[type] - [cultist] attempted to scribe a rune, but did not have an associated [user_antag ? "cult team":"cult antag datum"]!")
		return FALSE

	var/list/scribable_runes = bloodwashed_scribable_rune_types()
	if(!LAZYLEN(scribable_runes))
		to_chat(cultist, span_cult("There appears to be no runes to scribe. Contact your god about this!"))
		stack_trace("[type] - [cultist] attempted to scribe a rune, but their rune list is empty!")
		return FALSE

	entered_rune_name = tgui_input_list(cultist, "Choose a rite to scribe", "Sigils of Power", scribable_runes)
	if(isnull(entered_rune_name))
		return FALSE
	if(!can_scribe_rune(tool, cultist))
		return FALSE

	rune_to_scribe = scribable_runes[entered_rune_name]
	if(!ispath(rune_to_scribe))
		stack_trace("[type] - [cultist] attempted to scribe a rune, but did not find a path from their rune list!")
		return FALSE

	if(initial(rune_to_scribe.req_keyword))
		chosen_keyword = tgui_input_text(cultist, "Keyword for the new rune", "Words of Power", max_length = MAX_NAME_LEN)
		if(!chosen_keyword)
			drawing_a_rune = FALSE
			start_scribe_rune(tool, cultist)
			return FALSE

	our_turf = get_turf(cultist)

	if(!can_scribe_rune(tool, cultist))
		return FALSE

	var/can_have_blood = CAN_HAVE_BLOOD(cultist)

	cultist.visible_message(
		span_warning("[cultist] [can_have_blood ? "cuts open [cultist.p_their()] arm and begins writing in [cultist.p_their()] own blood":"begins sketching out a strange design"]!"),
		span_cult("You [can_have_blood ? "slice open your arm and ":""]begin drawing a sigil of the Geometer.")
		)

	if(can_have_blood)
		cultist.apply_damage(initial(rune_to_scribe.scribe_damage), BRUTE, pick(GLOB.arm_zones), wound_bonus = CANT_WOUND)

	var/scribe_mod = initial(rune_to_scribe.scribe_delay)
	if(!initial(rune_to_scribe.no_scribe_boost) && (our_turf.type in turfs_that_boost_us))
		scribe_mod *= 0.5

	var/scribe_started = initial(rune_to_scribe.started_creating)
	var/scribe_failed = initial(rune_to_scribe.failed_to_create)
	if(scribe_started)
		var/datum/callback/startup = CALLBACK(GLOBAL_PROC, scribe_started)
		startup.Invoke()
	var/datum/callback/failed
	if(scribe_failed)
		failed = CALLBACK(GLOBAL_PROC, scribe_failed)

	SEND_SOUND(cultist, sound('sound/items/weapons/slice.ogg', 0, 1, 10))
	if(!do_after(cultist, scribe_mod, target = get_turf(cultist), timed_action_flags = IGNORE_SLOWDOWNS))
		cleanup_shields()
		failed?.Invoke()
		return FALSE
	if(!can_scribe_rune(tool, cultist))
		cleanup_shields()
		failed?.Invoke()
		return FALSE

	cultist.visible_message(
		span_warning("[cultist] creates a strange circle[can_have_blood ? " in [cultist.p_their()] own blood":""]."),
		span_cult("You finish drawing the arcane markings of the Geometer.")
		)

	cleanup_shields()
	var/obj/effect/rune/made_rune = new rune_to_scribe(our_turf, chosen_keyword)
	made_rune.add_mob_blood(cultist)

	to_chat(cultist, span_cult("The [LOWER_TEXT(made_rune.cultist_name)] rune [made_rune.cultist_desc]"))
	cultist.log_message("scribed \a [LOWER_TEXT(made_rune.cultist_name)] rune using [parent] ([parent.type])", LOG_GAME)
	SSblackbox.record_feedback("tally", "cult_runes_scribed", 1, made_rune.cultist_name)

	return TRUE
