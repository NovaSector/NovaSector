/datum/quirk/nervous_aim
	name = "Nervous Tremble"
	desc = "When you're not in peak mental condition your aim has a funny habit of becoming catastrophic."
	icon = FA_ICON_FACE_SURPRISE
	value = -6
	gain_text = ("Your hands feel a little shakier.")
	lose_text = ("The tremble in your hands seems to have disappeared.")
	medical_record_text = "Patient has a documented nervous tremble in their hands that worsens with stress."

/datum/quirk/nervous_aim/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_FIRED_GUN, PROC_REF(on_mob_fired_gun))

/datum/quirk/nervous_aim/remove(client/client_source)
	UnregisterSignal(quirk_holder, COMSIG_MOB_FIRED_GUN)

/datum/quirk/nervous_aim/proc/on_mob_fired_gun(mob/user, obj/item/gun/gun_fired, target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/shooter = user
	switch(shooter.mob_mood.sanity_level)
		if (SANITY_LEVEL_GREAT to SANITY_LEVEL_NEUTRAL)
			return
		if (SANITY_LEVEL_DISTURBED to SANITY_LEVEL_UNSTABLE)
			bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += 10
		if (SANITY_LEVEL_CRAZY to SANITY_LEVEL_INSANE)
			bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += 45
