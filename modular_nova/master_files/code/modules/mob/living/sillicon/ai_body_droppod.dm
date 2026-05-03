/mob/living/silicon/ai
	/// Has this AI already used its one-shot droppod?
	var/used_body_droppod = FALSE

/datum/action/innate/ai_body_droppod
	name = "Order Cyborg Shell"
	desc = "A one-time delivery of a stock linked cyborg shell next to your core."
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

	var/turf/landing = find_droppod_landing(AI)
	if(!landing)
		to_chat(AI, span_warning("No clear landing tile is available next to your core."))
		return

	var/mob/living/silicon/robot/shell/new_shell = new(null)
	new_shell.cell = new /obj/item/stock_parts/power_store/cell/high(new_shell)

	AI.used_body_droppod = TRUE

	var/obj/structure/closet/supplypod/pod = new(null)
	pod.explosionSize = list(0, 0, 0, 0)
	pod.bluespace = TRUE
	new_shell.forceMove(pod)
	new /obj/effect/pod_landingzone(landing, pod)

	to_chat(AI, span_notice("Cyborg shell launched. Estimated arrival at ([landing.x], [landing.y])."))
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

/mob/living/silicon/ai/Initialize(mapload)
	. = ..()
	var/datum/action/innate/ai_body_droppod/droppod_action = new
	droppod_action.Grant(src)
