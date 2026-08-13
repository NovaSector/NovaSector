/datum/opposing_force_equipment/psionic
	category = OPFOR_EQUIPMENT_CATEGORY_OTHER
	item_type = /obj/effect/gibspawner/generic
	max_amount = 1
	var/psionic_rank = PSIONIC_RANK_DELTA

/datum/opposing_force_equipment/psionic/on_issue(mob/living/target)
	var/datum/component/psionic_profile/profile = target.awaken_psionics(get_psionic_rank_points(psionic_rank), source = PSIONIC_SOURCE_OPFOR)
	profile?.apply_rank(psionic_rank)

/datum/opposing_force_equipment/psionic/delta
	name = "Delta Psionic Awakening"
	description = "Awakens the approved operative as a Delta-rank psion with additional imprint points."
	admin_note = "Strong utility/combat option. Grants psionics through Nova's strain and imprint system; does not directly grant powers."
	psionic_rank = PSIONIC_RANK_DELTA

/datum/opposing_force_equipment/psionic/alpha
	name = "Alpha Psionic Awakening"
	description = "Awakens the approved operative as an Alpha-rank psion with extreme imprint potential."
	admin_note = "Extreme psionic option. Grants psionics through Nova's strain and imprint system; does not directly grant powers."
	psionic_rank = PSIONIC_RANK_ALPHA
