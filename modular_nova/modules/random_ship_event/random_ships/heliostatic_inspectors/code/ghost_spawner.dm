/obj/effect/mob_spawn/ghost_role/human/hc_officer
	name = "HC Inspector sleeper"
	desc = "A comfortable sleeper with HC insignia."
	prompt_name = "a HC Safety Inspector"
	icon = 'modular_nova/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	mob_species = /datum/species/human
	faction = list(FACTION_NEUTRAL)
	you_are_text = "You are a Heliostatic Coalition safety inspection team."
	flavour_text = "The station has accepted a voluntary safety inspection. Your role is to conduct a thorough but non-invasive inspection of station facilities and ensure compliance with Coalition safety standards. Remember that this is a voluntary inspection, so maintain a professional and courteous demeanor."
	important_text = "Allowed races are humans, Akulas, IPCs. Follow your lead inspector's orders. Important mention - while you are listed as the pirates gamewise, you really aren't lore-and-everything-else-wise. Roleplay accordingly."
	outfit = /datum/outfit/hc_officer
	random_appearance = FALSE
	show_flavor = TRUE

/obj/effect/mob_spawn/ghost_role/human/hc_officer/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	var/full_name = "[callsign] [number]"
	if(GLOB.first_officer == spawned_human)
		full_name += " Actual"
	spawned_human.fully_replace_character_name(null, full_name)

/obj/effect/mob_spawn/ghost_role/human/hc_officer/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/panslavic, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/yangyu, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/panslavic, source = LANGUAGE_SPAWNER)

	// if this is the first officer, keep a reference to them
	if(!GLOB.first_officer)
		GLOB.first_officer = spawned_human
		to_chat(spawned_human, span_bold("As the lead inspector of the team, it's your duty to ensure the inspection is conducted professionally and efficiently. 			Remember that this is a voluntary inspection, so maintain a cooperative attitude with the station staff. Your goal is to ensure safety compliance, 			not to find faults or issue penalties."))

	to_chat(spawned_human, "[span_bold("The station has voluntarily accepted our safety inspection. Your role is to coordinate the inspection team, communicate with station leadership, 		and ensure all inspections are conducted with minimal disruption to station operations. Focus on identifying safety hazards and providing constructive feedback. 		Remember that you represent the Heliostatic Coalition - act with professionalism and courtesy at all times.")] <br><br>		[span_small("Also, a small OOC clarification: none of your objectives are meant to be completable mechanically, so don't stress yourself over not greentexting or anything; 		If you have a better plan than 'completing' them, like an idea for a gimmick, it's better to communicate with the admins and your colleagues to possibly allow you to 		do something custom.")]")
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/hc_officer/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/hc_officer/equip(mob/living/carbon/human/spawned_human)
	. = ..()
	var/obj/item/card/id/advanced/card = spawned_human.get_idcard()
	if(GLOB.first_officer == spawned_human)
		card.assignment = pick(HC_LEADER_JOB_LIST)
		card.trim.sechud_icon_state = "hud_hc_police_lead"
	else
		card.assignment = pick(HC_JOB_LIST)
		card.trim.sechud_icon_state = "hud_hc_police"

	card.update_label()

/obj/effect/mob_spawn/ghost_role/human/hc_officer/Destroy()
	new /obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()
