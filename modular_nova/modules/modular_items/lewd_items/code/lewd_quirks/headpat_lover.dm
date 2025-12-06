/datum/quirk/headpat_lover
	name = "Headpat Lover"
	desc = "Your head seems to be an erogenous zone! You enjoy headpats a little too much..."
	value = 0
	gain_text = span_userlove("Your scalp feels extremely sensitive!")
	lose_text = span_notice("Your sensitivity to headpats fades away!")
	medical_record_text = ""
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_MOODLET_BASED
	icon = FA_ICON_PERSON_HARASSING
	erp_quirk = TRUE
	///Component which listens for headpats
	var/datum/component/headpat_component

/datum/quirk/headpat_lover/add()
	headpat_component = quirk_holder.AddComponent(/datum/component/headpat_lover)

/datum/quirk/headpat_lover/remove()
	QDEL_NULL(headpat_component)

/datum/mood_event/headpat_lover
	description = "I love headpats!"
	mood_change = 1
	timeout = 1 MINUTES

/datum/mood_event/better_headpat_lover
	description = "I LOVE HEADPATS! YES!"
	mood_change = 3
	timeout = 2 MINUTES
	special_screen_obj = "mood_happiness_good"

/datum/mood_event/better_headpat_lover/add_effects(mob/petter)
	if(HAS_PERSONALITY(owner, /datum/personality/aromantic))
		mood_change = 2
		description = "[petter.name] gives great headpats, but that's it."
		return
	if(HAS_PERSONALITY(owner, /datum/personality/aloof))
		mood_change = 2
		description = "[petter.name] gives great headpats, but I wish they'd stop touching me."
		return
	if(HAS_PERSONALITY(owner, /datum/personality/callous))
		mood_change = 0
		return

	description = "[petter.name] gives great headpats, [petter.p_they()] make[petter.p_s()] me feel so happy!"

///This component listens for when headpats happen
/datum/component/headpat_lover

/datum/component/headpat_lover/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CARBON_HELP_ACT, PROC_REF(check_headpat))

/datum/component/headpat_lover/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_CARBON_HELP_ACT)
	var/mob/living/carbon/human/human_parent = parent
	human_parent.clear_mood_event("headpat_lover")
	human_parent.clear_mood_event("better_headpat_lover")

///Calls pleasure_pet() if the mob received a pat on the head
/datum/component/headpat_lover/proc/check_headpat(mob/living/carbon/human/human_parent, mob/living/carbon/human/human_petter)
	SIGNAL_HANDLER

	if(!(istype(human_petter)))
		return

	if(check_zone(human_petter.zone_selected) == BODY_ZONE_HEAD && human_parent.get_bodypart(BODY_ZONE_HEAD))
		// Avoid blocking from TGUI alerting.
		INVOKE_ASYNC(src, PROC_REF(pleasure_pet), human_parent, human_petter)

// Needed because adjust_arousal (and etc.) call blocking TGUI procs which can't be executed from a signal handler.
///Increases human_parent's arousal and pleasure, and adds the relevant mood events
/datum/component/headpat_lover/proc/pleasure_pet(mob/living/carbon/human/human_parent, mob/living/carbon/human/human_petter)
	if(HAS_TRAIT(human_petter, TRAIT_FRIENDLY) && (human_petter.mob_mood.sanity >= SANITY_GREAT))
		new /obj/effect/temp_visual/heart(human_parent.loc)
		human_parent.add_mood_event("better_headpat_lover", /datum/mood_event/better_headpat_lover, human_petter)
	else
		human_parent.add_mood_event("headpat_lover", /datum/mood_event/headpat_lover)

	var/pref = human_petter.client?.prefs?.read_preference(/datum/preference/choiced/erp_status_mechanics)
	if(pref == "Mechanical only" || pref == "Mechanical and Roleplay")
		human_parent.adjust_arousal(2)
		human_parent.adjust_pleasure(2)


