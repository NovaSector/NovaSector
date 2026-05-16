/// ERP-gated neutral quirk. The flip side of /datum/quirk/dominant_aura — holders of this
/// react to a dom's presence with moodlets, fluster animations, and drop-on-snap reactions.
/datum/quirk/submissive_aura
	name = "Submissive Aura"
	desc = "You absolutely love being dominated. The thought of someone with a stronger character than yours is enough to make you act up. They can snap their fingers to send you to the floor."
	icon = FA_ICON_SORT_DOWN
	medical_record_text = "Patient can be easily swayed by a sufficiently assertive individual."
	value = 0
	gain_text = span_notice("You feel like being someone's pet.")
	lose_text = span_notice("You no longer feel like being a pet...")
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES
	erp_quirk = TRUE
	/// The nearest dom whose presence we currently log — used to throttle "new dom in range" messages.
	var/mob/living/carbon/human/last_dom

/datum/quirk/submissive_aura/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINING, PROC_REF(on_examining_dom))

/datum/quirk/submissive_aura/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_EXAMINING)
	quirk_holder.clear_mood_event(DOMINANT_MOOD)
	last_dom = null

/// When the sub examines another mob, if that mob is a dom, fluster and bounce the gaze away.
/datum/quirk/submissive_aura/proc/on_examining_dom(mob/source, atom/target, list/examine_list)
	SIGNAL_HANDLER
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/dom = target
	if(dom == quirk_holder || dom.stat == DEAD)
		return
	if(!dom.has_quirk(/datum/quirk/dominant_aura))
		return
	examine_list += span_purple("You can't look at <b>[dom]</b> for long before flustering away.")
	if(!TIMER_COOLDOWN_FINISHED(dom, DOMINANT_COOLDOWN_EXAMINE))
		return
	to_chat(dom, span_purple("<b>[source]</b> tries to look at you but immediately looks away with a red face..."))
	TIMER_COOLDOWN_START(dom, DOMINANT_COOLDOWN_EXAMINE, 15 SECONDS)
	INVOKE_ASYNC(quirk_holder, TYPE_PROC_REF(/mob, emote), "blush")
	quirk_holder.dir = turn(get_dir(quirk_holder, dom), pick(-90, 90))

/datum/quirk/submissive_aura/process(seconds_per_tick)
	if(!quirk_holder || quirk_holder.stat == DEAD)
		return
	if(!TIMER_COOLDOWN_FINISHED(quirk_holder, DOMINANT_COOLDOWN_NOTICE))
		return
	var/mob/living/carbon/human/closest_dom = find_closest_dom()
	if(!closest_dom)
		if(last_dom)
			quirk_holder.add_mood_event(DOMINANT_MOOD, /datum/mood_event/dominant_aura_need)
		last_dom = null
		return
	if(last_dom == closest_dom)
		// Same dom as last tick — keep the moodlet going but skip the chat message.
		TIMER_COOLDOWN_START(quirk_holder, DOMINANT_COOLDOWN_NOTICE, 15 SECONDS)
		return
	last_dom = closest_dom
	var/static/list/notices = list(
		"You feel someone's presence making you more submissive.",
		"The thought of being commanded floods you with lust.",
		"You really want to be called a pet.",
		"Someone's presence is making you all flustered.",
		"You start getting excited and sweating.",
	)
	quirk_holder.add_mood_event(DOMINANT_MOOD, /datum/mood_event/dominant_aura_good)
	to_chat(quirk_holder, span_purple(pick(notices)))
	TIMER_COOLDOWN_START(quirk_holder, DOMINANT_COOLDOWN_NOTICE, 15 SECONDS)

/// Returns the closest live human within view that holds /datum/quirk/dominant_aura, or null.
/datum/quirk/submissive_aura/proc/find_closest_dom()
	var/mob/living/carbon/human/nearest
	var/nearest_distance
	for(var/mob/living/carbon/human/dom in viewers(world.view / 2, quirk_holder))
		if(dom == quirk_holder || dom.stat == DEAD)
			continue
		if(!dom.has_quirk(/datum/quirk/dominant_aura))
			continue
		var/distance = get_dist(quirk_holder, dom)
		if(isnull(nearest) || distance < nearest_distance)
			nearest = dom
			nearest_distance = distance
	return nearest
