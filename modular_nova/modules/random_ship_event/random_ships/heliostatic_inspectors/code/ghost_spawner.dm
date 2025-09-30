/obj/effect/mob_spawn/ghost_role/human/hc_officer
	name = "HC Patrol Officer Sleeper"
	desc = "A comfortable-looking sleeper unit adorned with the insignia of the Heliostatic Coalition Internal Affairs Department."
	prompt_name = "an HC Expeditionary Patrol Officer"
	icon = 'modular_nova/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	mob_species = /datum/species/human
	faction = list(FACTION_NEUTRAL)
	you_are_text = "You are an officer of the Heliostatic Coalition Expeditionary Patrol."
	flavour_text = "Your patrol vessel is conducting a Standard Compliance and Inspection operation on this remote facility. Your mandate, derived from Coalition Accords, grants you the authority to inspect, seize contraband, and use necessary force to protect Coalition interests. Vigilance is paramount; these stations are self-governing and not inherently trustworthy. Adhere to the Standard Operating Procedures at all times."
	important_text = "Follow the chain of command. Your patrol leader's callsign is appended with 'Actual'. Maintain professional discipline and be prepared to escalate appropriately as the situation demands."
	outfit = /datum/outfit/hc_officer
	random_appearance = FALSE
	show_flavor = TRUE
	/// To know whether or not we have an officer already, keep a ref to them
	var/static/first_officer

/obj/effect/mob_spawn/ghost_role/human/hc_officer/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	var/full_name = "[callsign] [number]"
	if(first_officer == REF(spawned_human))
		full_name += " Actual"
	spawned_human.fully_replace_character_name(null, full_name)

/obj/effect/mob_spawn/ghost_role/human/hc_officer/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.mind.add_antag_datum(/datum/antagonist/cop)
	spawned_human.grant_language(/datum/language/panslavic, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/yangyu, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/akulan, source = LANGUAGE_SPAWNER)

	// if this is the first officer, keep a reference to them
	if(!first_officer)
		first_officer = REF(spawned_human)
		to_chat(spawned_human, span_bold("You are the Patrol Leader (Actual). You hold ultimate authority and responsibility for this mission. \
			Your directives are to: Ensure the safety of your personnel and vessel. Conduct a thorough inspection for contraband and violations per \
			SOP Section V. Project Coalition authority and assess the facility's compliance. Declare Alert Status changes based on observed threats. \
			Your discretion in the field is final. Consult your Field Guide and SOP documents." \
		))

	to_chat(spawned_human, "[span_boldnotice("Your primary duty is to the Heliostatic Coalition. \
		This inspection is a right granted by treaty, not a request. \
		Be firm, professional, and by-the-book. Trust must be earned, \
		and violations of procedure are to be met with immediate challenges \
		and elevated alert statuses. Your ship contains your SOP documents; \
		consult them for rules of engagement, contraband categories, and Bluespace Artillery countermeasures.")] <br><br>\
		[span_info("OOC Note: Your objectives are narrative guides for creating collaborative roleplay. \
		They are not mechanical 'greentext' goals. Focus on the experience. If you have a creative idea for a gimmick or story direction, \
		communicating with the admins and other players is encouraged.")]")
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/hc_officer/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/hc_officer/equip(mob/living/carbon/human/spawned_human)
	. = ..()
	var/obj/item/card/id/advanced/card = spawned_human.get_idcard()
	if(first_officer == REF(spawned_human))
		card.assignment = pick(HC_LEADER_JOB_LIST)
		card.trim.sechud_icon_state = "hud_hc_police_lead"
	else
		card.assignment = pick(HC_JOB_LIST)
		card.trim.sechud_icon_state = "hud_hc_police"

	card.update_label()

/obj/effect/mob_spawn/ghost_role/human/hc_officer/Destroy(force)
	var/atom/drop_location = drop_location()
	if(!QDELETED(drop_location))
		new /obj/structure/showcase/machinery/oldpod/used(drop_location)
	return ..()
