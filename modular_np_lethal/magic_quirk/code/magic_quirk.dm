// how much nutrition do we lose
#define MAGIC_NUTRITION_MILD 1.5
#define MAGIC_NUTRITION_MODERATE 2.5
#define MAGIC_NUTRITION_SEVERE 4
#define MAGIC_MANA_REGAIN_TICK 1

/datum/quirk/magical
	name = "Magical"
	desc = "You've got access to powerful psionics or another kind of force that to basically everybody else, \
		appears outwardly as magic. You get an assortment of lesser spells fuelled by your mana and nutrition - manage them wisely!"
	gain_text = span_notice("Magical potential floods your nervous system!")
	lose_text = span_notice("Mundanity descends upon you as your magic power flees...")
	value = 10
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_PROCESSES
	medical_record_text = "Subject appears to have enhanced sensitivity to resonance exudate, and is able to manifest supernatural phenomena."
	mob_trait = TRAIT_MAGICALLY_GIFTED
	icon = FA_ICON_MAGIC
	/// The mana value held by the quirk and used to power quirk-only spells.
	var/mana = 100
	/// The maximum possible mana value, in case we want to increase this at any point.
	var/max_mana = 100
	/// The list of spells we've added for cleanup upon quirk removal.
	var/list/added_spells = list()
	/// TimerID for the mana notification alert
	var/mana_notify
	/// Is regeneration currently halted at the moment?
	var/halt_regen = FALSE
	/// The bonded item we've marked. Holding this gives us a pretty big mana regeneration efficiency buff.
	var/obj/bonded_item
	/// Our current mana regeneration modifier. Scale this UP to make things more efficient.
	var/regeneration_mana_modifier = 0
	/// Our current nutrition efficiency modifier. Scale this DOWN to make things more efficient.
	var/regeneration_nutrition_modifier = 0

/datum/quirk/magical/process(seconds_per_tick)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if (human_holder.stat == DEAD)
		return

	var/regained_mana = FALSE
	var/regen_bonus_mana = 1.0
	var/regen_bonus_nutrition = 1.0

	//we're holding our bonded item! yippee! give us some regen buffs.
	if (bonded_item && human_holder.get_active_held_item() == bonded_item)
		regen_bonus_mana += regeneration_mana_modifier
		regen_bonus_nutrition += regeneration_nutrition_modifier

	//may also wanna put some reagents checking in here so we can have stuff that'll help restore mana quickly
	// like chems or wiz fizz or whatever
	if ((mana < max_mana) && !halt_regen && human_holder.nutrition > 0)
		// we're low on mana so regain it!
		regained_mana = TRUE
		if (mana < max_mana*0.3)
			human_holder.adjust_nutrition(-(MAGIC_NUTRITION_SEVERE*regen_bonus_nutrition))
			mana += (MAGIC_MANA_REGAIN_TICK * 2.5) * regen_bonus_mana
		else if (mana < max_mana*0.6)
			human_holder.adjust_nutrition(-(MAGIC_NUTRITION_MODERATE*regen_bonus_nutrition))
			mana += (MAGIC_MANA_REGAIN_TICK * 1.5) * regen_bonus_mana
		else
			human_holder.adjust_nutrition(-(MAGIC_NUTRITION_MILD*regen_bonus_nutrition))
			mana += (MAGIC_MANA_REGAIN_TICK) * regen_bonus_mana

		//ensure we never exceed the max mana from regen
		mana = min(max_mana, mana)
	else
		//clear out the mana timer in case we have it, since we've got full mana now
		if (mana_notify)
			mana_notify_reset()

	if (regained_mana)
		human_holder.apply_status_effect(/datum/status_effect/mana_regeneration)
	else
		human_holder.remove_status_effect(/datum/status_effect/mana_regeneration)

/datum/quirk/magical/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder

	//lesser arcane barrage - costs 25 mana to summon and 2 mana per shot for 30 shots total (85 mana)
	var/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage/lesser/barrage = new /datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage/lesser()
	barrage.Grant(human_holder)
	added_spells += barrage

	//shift - 35 mana telegram scepter jaunt for 5 tiles instead of 8, up to 3 tiles imprecision depending on flux & mana
	var/datum/action/cooldown/spell/pointed/shift/shift_spell = new /datum/action/cooldown/spell/pointed/shift
	shift_spell.Grant(human_holder)
	added_spells += shift_spell

	//lesser fleshmend: an exercise in why real wizards use staves and wands for healing. excruciatingly painful triage healing
	var/datum/action/cooldown/spell/touch/fleshmend_lesser/fleshmend_spell = new /datum/action/cooldown/spell/touch/fleshmend_lesser
	fleshmend_spell.Grant(human_holder)
	added_spells += fleshmend_spell

	// bonded item: basically instant summons but we also get a small buff to mana regeneration when holding it (larger if it's a staff)
	var/datum/action/cooldown/spell/summonitem/lesser/summon_spell = new /datum/action/cooldown/spell/summonitem/lesser
	summon_spell.Grant(human_holder)
	added_spells += summon_spell

/datum/quirk/magical/remove()
	QDEL_LIST(added_spells)

/datum/quirk/magical/proc/can_cast_spell(mana_cost)
	if (mana_cost <= mana)
		return TRUE
	else
		return FALSE

/datum/quirk/magical/proc/set_bonded_item(obj/item/thing)
	// Sets whatever the hell our bonded item is and adjusts regen modifiers appropriately.
	regeneration_mana_modifier = initial(regeneration_mana_modifier)
	regeneration_nutrition_modifier = initial(regeneration_nutrition_modifier)

	// for a little extra flavor, if our bonded item is any kind of staff (even a kludged, player-crafted renamed one), lets give it a pretty ample mana regen buff
	if (findtext(thing.name, "staff"))
		regeneration_mana_modifier += 0.25

	//let's make nutrition a little easier for everyone too
	regeneration_nutrition_modifier -= 0.15
	regeneration_mana_modifier += 0.25

	bonded_item = thing

/// To be called inside spells/items that should consume mana from the Magical quirk. Deducts mana and calls appropriate checks.
/datum/quirk/magical/proc/cast_quirk_spell(mana_cost)
	mana -= mana_cost
	mana = max(0, mana)
	on_cast_mana_checks()

/datum/quirk/magical/proc/start_mana_notify()
	// Handles starting the mana notification timer.
	var/mob/living/carbon/human/human_holder = quirk_holder
	mana_notify = addtimer(CALLBACK(src, PROC_REF(mana_notify_reset), human_holder), 3 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME)

/datum/quirk/magical/proc/mana_notify_reset()
	// Resets the mana notification timer cleanly.
	deltimer(mana_notify)
	mana_notify = null

/datum/quirk/magical/proc/on_cast_mana_checks()
	var/mob/living/carbon/human/human_holder = quirk_holder

	var/half_threshold = max_mana * 0.5
	var/critical_threshold = max_mana * 0.2

	if (!mana_notify)
		// check to see if the player needs to get mana level alerts
		if (mana <= critical_threshold)
			human_holder.balloon_alert(human_holder, "mana critically low!!!")
			start_mana_notify()
		else if (mana <= half_threshold)
			human_holder.balloon_alert(human_holder, "half mana left!")
			start_mana_notify()

	// are we casting on an empty stomach? that's no good.
	switch(human_holder.nutrition)
		if (1 to NUTRITION_LEVEL_STARVING)
			if (rand(3))
				human_holder.adjustStaminaLoss(35)
				human_holder.visible_message(
					span_danger("[human_holder] looks exhausted, breathing heavily!"),
					span_danger("Lacking any calorific reserves, your body struggles with your mana channeling!"),
				)
		if (0)
			//nothing's in the tank, boss. nighty night
			human_holder.visible_message(
				span_danger("[human_holder] teeters on the spot for a moment, then collapses from exhaustion."),
				span_userdanger("You expend the last bit of energy you have left, and promptly fall unconscious!")
			)
			human_holder.SetSleeping(10 SECONDS)
			to_chat(human_holder, span_boldnotice("You really need to get something to eat!"))

#undef MAGIC_NUTRITION_MILD
#undef MAGIC_NUTRITION_MODERATE
#undef MAGIC_NUTRITION_SEVERE
#undef MAGIC_MANA_REGAIN_TICK
