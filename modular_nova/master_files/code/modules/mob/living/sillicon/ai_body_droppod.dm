/mob/living/silicon/ai
	/// Has this AI already used its one-shot droppod?
	var/used_body_droppod = FALSE

#define AI_DROPPOD_CHOICE_BODY "Synthetic Body"
#define AI_DROPPOD_CHOICE_SHELL "Cyborg Shell"

/datum/action/innate/ai_body_droppod
	name = "Order Droppod Chassis"
	desc = "Order a one-time delivery of a chassis next to your core. Choose between a synthetic body loaded with your character preferences (controlled via AI uplink brain) or a stock linked cyborg shell"
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
			to_chat(AI, span_warning("You have already deployed your chassis this shift."))
		return FALSE
	return TRUE

/datum/action/innate/ai_body_droppod/Activate()
	var/mob/living/silicon/ai/AI = owner
	if(!isAI(AI) || !AI.client)
		return

	var/static/list/choices = list(
		AI_DROPPOD_CHOICE_BODY = image(icon = 'modular_nova/master_files/icons/obj/medical/organs.dmi', icon_state = "brain-c"),
		AI_DROPPOD_CHOICE_SHELL = image(icon = 'icons/mob/actions/actions_AI.dmi', icon_state = "ai_shell"),
	)
	var/choice = show_radial_menu(AI, AI, choices, radius = 42, require_near = FALSE)
	if(!choice)
		return

	var/turf/landing = find_droppod_landing(AI)
	if(!landing)
		to_chat(AI, span_warning("No clear landing tile is available next to your core."))
		return

	var/atom/movable/payload
	switch(choice)
		if(AI_DROPPOD_CHOICE_BODY)
			payload = build_synthetic_body(AI)
		if(AI_DROPPOD_CHOICE_SHELL)
			var/mob/living/silicon/robot/shell/new_shell = new(null)
			new_shell.cell = new /obj/item/stock_parts/power_store/cell/high(new_shell)
			payload = new_shell

	if(!payload)
		return

	AI.used_body_droppod = TRUE

	var/obj/structure/closet/supplypod/pod = new(null)
	pod.explosionSize = list(0, 0, 0, 0)
	pod.bluespace = TRUE
	payload.forceMove(pod)
	new /obj/effect/pod_landingzone(landing, pod)

	to_chat(AI, span_notice("[choice] launched. Estimated arrival at ([landing.x], [landing.y])."))
	Remove(AI)

/datum/action/innate/ai_body_droppod/proc/find_droppod_landing(mob/living/silicon/ai/AI)
	var/turf/core_turf = get_turf(AI)
	if(!core_turf)
		return null
	for(var/turf/candidate as anything in shuffle(RANGE_TURFS(1, core_turf)))
		if(candidate == core_turf)
			continue
		if(isclosedturf(candidate))
			continue
		if(candidate.is_blocked_turf(exclude_mobs = TRUE, ignore_atoms = list(/obj/machinery/door/window), type_list = TRUE))
			continue
		return candidate
	return null

/datum/action/innate/ai_body_droppod/proc/build_synthetic_body(mob/living/silicon/ai/AI)
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
	return body

#undef AI_DROPPOD_CHOICE_BODY
#undef AI_DROPPOD_CHOICE_SHELL

/mob/living/silicon/ai/Initialize(mapload)
	. = ..()
	var/datum/action/innate/ai_body_droppod/droppod_action = new
	droppod_action.Grant(src)
