/// ERP-gated neutral quirk. Anyone with /datum/quirk/submissive_aura nearby is aware of the
/// holder's presence (chat notices, moodlet), and finger snaps from the holder can drop them.
/datum/quirk/dominant_aura
	name = "Dominant Aura"
	desc = "Your personality is assertive enough to appear as powerful to other people, so much in fact that the weaker kind can't help but throw themselves at your feet on command."
	icon = FA_ICON_SORT_UP
	medical_record_text = "Patient displays a high level of assertiveness within their personality."
	value = 0
	gain_text = span_notice("You feel like making someone your pet.")
	lose_text = span_notice("You feel less assertive than before.")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	erp_quirk = TRUE

/datum/quirk/dominant_aura/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINING, PROC_REF(on_examining_sub))
	RegisterSignal(quirk_holder, COMSIG_MOB_EMOTE, PROC_REF(on_emote))

/datum/quirk/dominant_aura/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_MOB_EXAMINING, COMSIG_MOB_EMOTE))

/// When the dom examines a mob, if that mob is a sub, flavor-hint it to the dom.
/datum/quirk/dominant_aura/proc/on_examining_sub(mob/source, atom/target, list/examine_list)
	SIGNAL_HANDLER
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/sub = target
	if(sub.stat == DEAD)
		return
	if(!sub.has_quirk(/datum/quirk/submissive_aura))
		return
	examine_list += span_purple("You can sense submissiveness radiating from them.")

/// Emote hook. Relayed async so the emote pipeline isn't delayed by our work.
/datum/quirk/dominant_aura/proc/on_emote(mob/source, datum/emote/firing_emote)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_snap), firing_emote)

/// If the emote is one of the snap family, drop every nearby submissive_aura holder in a
/// flavor-appropriate way gated on the snap variant.
/datum/quirk/dominant_aura/proc/handle_snap(datum/emote/firing_emote)
	if(!(firing_emote?.key in list("snap", "snap2", "snap3")))
		return
	if(!TIMER_COOLDOWN_FINISHED(quirk_holder, DOMINANT_COOLDOWN_SNAP))
		return
	var/affected_someone = FALSE
	for(var/mob/living/carbon/human/sub in hearers(world.view / 2, quirk_holder))
		if(sub == quirk_holder || sub.stat == DEAD)
			continue
		if(!sub.has_quirk(/datum/quirk/submissive_aura))
			continue
		affected_someone = TRUE
		drop_sub(sub, firing_emote.key)
	if(affected_someone)
		TIMER_COOLDOWN_START(quirk_holder, DOMINANT_COOLDOWN_SNAP, 10 SECONDS)

/// Applies the appropriate snap reaction to a single sub.
/datum/quirk/dominant_aura/proc/drop_sub(mob/living/carbon/human/sub, snap_key)
	var/pet_term = "pet"
	switch(sub.gender)
		if(MALE)
			pet_term = "boy"
		if(FEMALE)
			pet_term = "girl"
	switch(snap_key)
		if("snap")
			sub.dir = get_dir(sub, quirk_holder)
			sub.emote("me", 1, "faces towards <b>[quirk_holder]</b> at attention!", TRUE)
			to_chat(sub, span_purple("<b>[quirk_holder]</b>'s snap shoots down your spine and puts you at attention."))
		if("snap2")
			sub.dir = get_dir(sub, quirk_holder)
			sub.Immobilize(0.3 SECONDS)
			sub.emote("me", 1, "hunches down in response to <b>[quirk_holder]'s</b> snapping.", TRUE)
			to_chat(sub, span_purple("You hunch down and freeze in place in response to <b>[quirk_holder]</b> snapping their fingers."))
		if("snap3")
			sub.KnockToFloor(knockdown_amt = 0.1 SECONDS)
			step(sub, get_dir(sub, quirk_holder))
			sub.emote("me", 1, "falls to the floor and crawls closer to <b>[quirk_holder]</b>, following their command.", TRUE)
			sub.do_jitter_animation(0.1 SECONDS)
			to_chat(sub, span_purple("You throw yourself on the floor like a pathetic beast and crawl towards <b>[quirk_holder]</b> like a good, submissive [pet_term]."))

/// Moodlet fired on a sub when they're near a dom.
/datum/mood_event/dominant_aura_good
	description = span_purple("There's a commanding presence nearby. It feels good.")
	mood_change = 4
	timeout = 3 MINUTES

/// Moodlet fired on a sub when they've *lost* a dom they'd been basking in.
/datum/mood_event/dominant_aura_need
	description = span_purple("You crave a firmer hand than any nearby.")
	mood_change = -2
	timeout = 2 MINUTES
