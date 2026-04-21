/datum/quirk/egg_production
	name = "Oviparity"
	desc = "Whether it be genetics or some other factor, you are capable of producing eggs."
	icon = FA_ICON_EGG
	value = 0
	gain_text = span_notice("You suddenly feel rather productive.")
	lose_text = span_warning("You no longer feel productive. Sad.")
	medical_record_text = "Patient possesses the capability to produce eggs."

/datum/quirk/egg_production/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/spell/egg_production/action = new /datum/action/cooldown/spell/egg_production()
	action.Grant(human_holder)

/datum/quirk/egg_production/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/spell/egg_production/action = locate(/datum/action/cooldown/spell/egg_production) in quirk_holder.actions
	action?.Remove(quirk_holder)
	return ..()

/datum/action/cooldown/spell/egg_production
	name = "Produce an Egg"
	desc = "Concentrate your efforts to lay an egg. Questionable use in public."

	button_icon = 'icons/obj/food/egg.dmi'
	button_icon_state = "egg"
	cooldown_time = 1 SECONDS
	spell_requirements = NONE

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED

	var/obj/item/food/egg/egg
	var/eggs_stored = 0
	var/can_produce = TRUE
	var/maximum_eggs = EGG_PRODUCTION_MAX_EGGS
	var/list/possible_egg_thoughts = list(
		"You feel a slight weight added to you.",
		"You feel a warm sensation inside you.",
		"You feel slightly heavier than you were a moment ago.",
		"You feel oddly full.",
	)
	/// Format: reagent typepath = list(minimum volume required to start production, cooldown per egg added to counter)
	var/list/egg_production_reagents = list(
		/datum/reagent/consumable/cum = list(20, 10 SECONDS),
		/datum/reagent/drug/aphrodisiac/crocin = list(20, 30 SECONDS),
		/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = list(4, 30 SECONDS),
	)

/datum/action/cooldown/spell/egg_production/Grant(mob/granted_to)
	RegisterSignal(granted_to, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	can_produce = TRUE
	return ..()

/datum/action/cooldown/spell/egg_production/Remove(mob/removed_from)
	UnregisterSignal(removed_from, COMSIG_LIVING_LIFE)
	removed_from?.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant)
	return ..()

/datum/action/cooldown/spell/egg_production/proc/on_life(seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	if(can_produce)
		create_egg()

/datum/action/cooldown/spell/egg_production/proc/toggle_cooldown()
	can_produce = !can_produce

/datum/action/cooldown/spell/egg_production/proc/create_egg(datum/reagent/reagent)
	if(!can_produce)
		return FALSE

	var/mob/living/carbon/human/egg_holder = owner
	var/list/cached_reagents = egg_holder.reagents?.reagent_list
	if(!length(cached_reagents))
		return FALSE

	if(eggs_stored >= maximum_eggs)
		return FALSE

	for(var/datum/reagent/target_reagent as anything in cached_reagents)
		var/list/recipe = egg_production_reagents[target_reagent.type]
		if(!recipe)
			continue
		if(target_reagent.volume >= recipe[1])
			var/egg_thought = pick(possible_egg_thoughts)
			to_chat(owner, span_notice("[egg_thought]"))
			egg_update(1, egg_holder)
			toggle_cooldown()
			addtimer(CALLBACK(src, PROC_REF(toggle_cooldown)), recipe[2])
			return TRUE
	return FALSE

/datum/action/cooldown/spell/egg_production/proc/egg_update(delta, mob/living/egg_holder)
	eggs_stored = clamp((eggs_stored + delta), 0, maximum_eggs)
	desc = "[initial(desc)]. You carry [eggs_stored] egg\s."

	if(eggs_stored == 0)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant, update = TRUE)
		return

	var/slow_mult = FLOOR((eggs_stored) / (maximum_eggs), 0.01)
	var/datum/movespeed_modifier/eggnant/modifier = new()
	modifier.multiplicative_slowdown = CEILING((EGG_PRODUCTION_MAX_SLOWDOWN * slow_mult), 0.01)
	if(owner.has_movespeed_modifier(/datum/movespeed_modifier/eggnant))
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/eggnant)
	owner.add_movespeed_modifier(modifier, update = TRUE)

	var/is_delta_negative = delta < 0

	switch(eggs_stored)
		if(EGG_PRODUCTION_THRESHOLD_LOW)
			to_chat(owner, span_purple("You're beginning to feel [is_delta_negative ? "less weighed down, but still full..." : "rather heavy..."]"))
		if(EGG_PRODUCTION_THRESHOLD_MEDIUM)
			to_chat(owner, span_purple("You feel [is_delta_negative ? "less swollen, but still really heavy..." : "really swollen with all these eggs..."]"))
		if(EGG_PRODUCTION_THRESHOLD_HIGH)
			to_chat(owner, span_warning("[is_delta_negative ? "You're a bit less taut, but still feel very swollen!" : "You're overly gravid! You feel like you should really lay these eggs soon..."]"))
		if(EGG_PRODUCTION_THRESHOLD_SWOLLEN)
			to_chat(owner, span_warning("You feel [is_delta_negative ? "a little relieved, but still extremely taut!" : "very close to full at this point, any more eggs and you'll run out of room!"]"))
		if(EGG_PRODUCTION_THRESHOLD_FULL)
			to_chat(owner, span_alertwarning("Your body can't handle anymore eggs! You need to lay some to make room, now!"))
		if(EGG_PRODUCTION_THRESHOLD_DESCENT)
			if(is_delta_negative)
				to_chat(owner, span_warning("You feel like you still have very little room for anymore eggs..."))

/datum/movespeed_modifier/eggnant
	variable = TRUE
	multiplicative_slowdown = EGG_PRODUCTION_MAX_SLOWDOWN

/datum/action/cooldown/spell/egg_production/cast(mob/living/cast_on)
	. = ..()
	if(eggs_stored <= 0)
		owner.balloon_alert(owner, "no eggs to lay!")
		return FALSE

	to_chat(owner, span_noticealien("You start laying an egg..."))
	if(!do_after(owner, 10 SECONDS, cast_on, IGNORE_HELD_ITEM))
		owner.balloon_alert(owner, "stopped attempting to lay an egg.")
		return FALSE

	egg_update(-1)
	egg = new(owner)
	owner.put_in_hands(egg)
	owner.visible_message(span_noticealien("[owner] laid an egg!"), span_alertalien("You laid an egg!"))
	return TRUE
