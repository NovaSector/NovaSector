/// Deafens and confuses nearby mobs, paralyzes silicons, shatters nearby light tubes.
/datum/action/cooldown/spell/hiveless/shriek
	name = "Resonant Shriek"
	desc = "Release a piercing, resonant shriek that deafens nearby crew, shatters light bulbs, and disrupts silicons. Costs protein."
	button_icon_state = "resonant_shriek"
	cooldown_time = 30 SECONDS
	protein_cost = HIVELESS_COST_SHRIEK
	disabled_by_fire = FALSE

/datum/action/cooldown/spell/hiveless/shriek/cast(atom/cast_on)
	. = ..()
	var/mob/living/user = owner
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "can't shriek in pipes!")
		return FALSE
	if(!spend_protein())
		return FALSE
	playsound(user, 'sound/effects/screech.ogg', 100)
	for(var/mob/living/hearing in get_hearers_in_view(4, user))
		if(hearing == user)
			continue
		if(!hearing.soundbang_act(SOUNDBANG_MASSIVE, stun_pwr = 0, damage_pwr = 0, deafen_pwr = 1 MINUTES, ignore_deafness = TRUE, send_sound = FALSE))
			continue
		if(issilicon(hearing))
			hearing.Paralyze(rand(10 SECONDS, 20 SECONDS))
			continue
		hearing.adjust_confusion(25 SECONDS)
		hearing.set_jitter_if_lower(100 SECONDS)
	for(var/obj/machinery/light/light in range(4, user))
		light.on = TRUE
		light.break_light_tube()
		stoplag()
	return TRUE
