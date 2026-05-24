/// Returns the trimmed set of rites available to the Bloodwashed.
/proc/bloodwashed_scribable_rune_types()
	var/static/list/bloodwashed_runes
	if(!isnull(bloodwashed_runes))
		return bloodwashed_runes

	bloodwashed_runes = list()
	for(var/rune_name in GLOB.rune_types)
		var/obj/effect/rune/rune_type = GLOB.rune_types[rune_name]
		if(ispath(rune_type, /obj/effect/rune/empower) || ispath(rune_type, /obj/effect/rune/teleport) || ispath(rune_type, /obj/effect/rune/wall))
			bloodwashed_runes[rune_name] = rune_type
	var/obj/effect/rune/bloodwashed_soulstone/soulstone_rune = /obj/effect/rune/bloodwashed_soulstone
	bloodwashed_runes[initial(soulstone_rune.cultist_name)] = soulstone_rune
	return bloodwashed_runes

/// Returns the trimmed set of blood spells available to the Bloodwashed.
/proc/bloodwashed_spell_types()
	return list(
		/datum/action/innate/cult/blood_spell/stun,
		/datum/action/innate/cult/blood_spell/teleport,
		/datum/action/innate/cult/blood_spell/emp,
		/datum/action/innate/cult/blood_spell/shackles,
		/datum/action/innate/cult/blood_spell/construction,
		/datum/action/innate/cult/blood_spell/equipment,
		/datum/action/innate/cult/blood_spell/dagger,
		/datum/action/innate/cult/blood_spell/bloodwashed/blood_mist,
		/datum/action/innate/cult/blood_spell/horror,
		/datum/action/innate/cult/blood_spell/veiling,
		/datum/action/innate/cult/blood_spell/manipulation,
	)

/// Applies the Bloodwashed antagonist datum to a mind.
/proc/bloodwash_mind(datum/mind/candidate, give_equipment = TRUE)
	var/datum/antagonist/cult/bloodwashed/bloodwashed = new()
	bloodwashed.give_equipment = give_equipment
	candidate.add_antag_datum(bloodwashed)
	return bloodwashed
