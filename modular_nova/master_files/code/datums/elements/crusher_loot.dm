/datum/element/crusher_loot/proc/on_death(mob/living/target, gibbed)
	SIGNAL_HANDLER

	var/datum/status_effect/crusher_damage/damage = target.has_status_effect(/datum/status_effect/crusher_damage)
	var/datum/status_effect/ashwalker_damage/ashie_damage = target.has_status_effect(/datum/status_effect/ashwalker_damage)
	var/final_damage_total = damage?.total_damage + ashie_damage?.total_damage

	if (!final_damage_total)
		return

	if (guaranteed_drop)
		if (final_damage_total / target.maxHealth < guaranteed_drop)
			return
	else if (!prob((final_damage_total / target.maxHealth) * drop_mod)) // On average, you'll need to kill 4 creatures before getting the item. by default.
		return

	if (replace_all && isanimal(target))
		var/mob/living/simple_animal/expiring_code = target
		if (!islist(trophy_type))
			expiring_code.loot = list(trophy_type)
			return

		var/list/trophies = trophy_type
		expiring_code.loot = trophies.Copy()
		return

	if(!islist(trophy_type))
		make_path(target, trophy_type)
		return

	if (replace_all)
		target.butcher_results?.Cut()
		target.guaranteed_butcher_results?.Cut()

	for(var/trophypath in trophy_type)
		make_path(target, trophypath)
