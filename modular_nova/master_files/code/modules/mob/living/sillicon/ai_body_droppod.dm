/mob/living/silicon/ai
	/// Has this AI already used its one-shot synthetic body droppod?
	var/used_body_droppod = FALSE

/datum/action/innate/ai_body_droppod
	name = "Droppod Synthetic Body"
	desc = "Order a one-time delivery of a synthetic body next to your core. The body is loaded with your character preferences and pre-fitted with an AI uplink brain, ready for you to take control."
	button_icon = 'icons/mob/actions/actions_AI.dmi'
	button_icon_state = "ai_shell"

/datum/action/innate/ai_body_droppod/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/silicon/ai/AI = owner
	if(!isAI(AI))
		return FALSE
	if(AI.used_body_droppod)
		if(feedback)
			to_chat(AI, span_warning("You have already deployed your synthetic body this shift."))
		return FALSE
	return TRUE

/datum/action/innate/ai_body_droppod/Activate()
	var/mob/living/silicon/ai/AI = owner
	if(!isAI(AI) || !AI.client)
		return
	var/turf/core_turf = get_turf(AI)
	if(!core_turf)
		to_chat(AI, span_warning("Cannot determine your core's location."))
		return

	var/turf/landing
	for(var/turf/candidate as anything in shuffle(RANGE_TURFS(1, core_turf)))
		if(candidate == core_turf)
			continue
		if(isclosedturf(candidate))
			continue
		if(candidate.is_blocked_turf(exclude_mobs = TRUE, ignore_atoms = list(/obj/machinery/door/window), type_list = TRUE))
			continue
		landing = candidate
		break

	if(!landing)
		to_chat(AI, span_warning("No clear landing tile is available next to your core."))
		return

	AI.used_body_droppod = TRUE

	var/mob/living/carbon/human/body = new()
	AI.client.prefs.safe_transfer_prefs_to(body)

	if(!(body.mob_biotypes & MOB_ROBOTIC))
		for(var/obj/item/organ/organ as anything in body.organs.Copy())
			if(organ.organ_flags & ORGAN_EXTERNAL)
				continue
			organ.Remove(body, special = TRUE)
			qdel(organ)

		for(var/replacement_path in list(
			/obj/item/organ/heart/synth,
			/obj/item/organ/lungs/synth,
			/obj/item/organ/liver/synth,
			/obj/item/organ/stomach/synth,
			/obj/item/organ/eyes/synth,
			/obj/item/organ/ears/synth,
			/obj/item/organ/tongue/synth,
		))
			var/obj/item/organ/replacement = new replacement_path
			replacement.Insert(body, special = TRUE)
	else
		var/obj/item/organ/existing_brain = body.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(existing_brain)
			existing_brain.Remove(body, special = TRUE)
			qdel(existing_brain)

	var/obj/item/organ/brain/cybernetic/ai/uplink_brain = new
	uplink_brain.Insert(body, special = TRUE)

	var/obj/structure/closet/supplypod/pod = new(null)
	pod.explosionSize = list(0, 0, 0, 0)
	pod.bluespace = TRUE
	body.forceMove(pod)
	new /obj/effect/pod_landingzone(landing, pod)

	to_chat(AI, span_notice("Synthetic body launched. Estimated arrival at ([landing.x], [landing.y])."))
	Remove(AI)

/mob/living/silicon/ai/Initialize(mapload)
	. = ..()
	var/datum/action/innate/ai_body_droppod/droppod_action = new
	droppod_action.Grant(src)
