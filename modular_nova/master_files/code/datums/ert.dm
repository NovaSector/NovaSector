/*
*	Use this file to add
*	Modular ERT datums
*/

/datum/ert/asset_protection
	roles = list(/datum/antagonist/ert/asset_protection)
	leader_role = /datum/antagonist/ert/asset_protection/leader
	rename_team = "Asset Protection Team"
	code = "Red"
	mission = "Protect Nanotrasen's assets; crew are assets."
	polldesc = "a Nanotrasen asset protection team"

/// A mix of officials
/datum/ert/solfed
	roles = list(/datum/antagonist/ert/solfed, /datum/antagonist/ert/solfed/social, /datum/antagonist/ert/solfed/civil)
	leader_role = /datum/antagonist/ert/solfed/leader

	notify_players = FALSE
	opendoors = FALSE
	ert_template = /datum/map_template/shuttle/ert/solfed/official

	rename_team = "SolFed Officials"
	teamsize = 5
	code = "FEDERAL"
	mission = "Audit the station, write reports, and look for any violations of Federal regulations."
	polldesc = "a Sol Federation Official"

/datum/ert/solfed/espatier
	roles = list(/datum/antagonist/ert/solfed/espatier, /datum/antagonist/ert/solfed/espatier/corpsman, /datum/antagonist/ert/solfed/espatier/engineer)
	leader_role = /datum/antagonist/ert/solfed/espatier/leader

	ert_template = /datum/map_template/shuttle/ert/solfed

	notify_players = TRUE
	rename_team = "SolFed Espatier Detachment"
	teamsize = 6
	code = "FEDERAL"
	mission = "Rescue survivors, and bring order to chaos. Glory to the Federation."
	polldesc = "a Sol Federation Espatier"


/// A variant of spawning, they spawn with a smaller more assaultlike ship, with no compartments (no medical compartment, engineering, atmos, just what they have on their back)
/datum/ert/solfed/espatier/assault
	ert_template = /datum/map_template/shuttle/ert/solfed/assault

/// Corpsman only spawn
/datum/ert/solfed/espatier/assault/corpsman_only
	roles = list(/datum/antagonist/ert/solfed/espatier)
	polldesc = "a Sol Federation Truama Team"

/// Rifleman only spawn
/datum/ert/solfed/espatier/assault/rifleman_only
	roles = list(/datum/antagonist/ert/solfed/espatier/corpsman)
	polldesc = "a Sol Federation Rifleman"

/// Engineering only spawn
/datum/ert/solfed/espatier/assault/engineering_only
	roles = list(/datum/antagonist/ert/solfed/espatier/engineer)

/// A variant of spawning, they basically spawn with the mobile garrison/armory.
/datum/ert/solfed/espatier/armory
	ert_template = /datum/map_template/shuttle/ert/solfed/armory

/// Forces the true helljumpers (basically all infantry, no medics)
/datum/ert/solfed/espatier/armory/rifleman_only
	roles = list(/datum/antagonist/ert/solfed/espatier)

/// A variant of spawning, they basically spawn with the mobile Hospital.
/datum/ert/solfed/espatier/medical
	ert_template = /datum/map_template/shuttle/ert/solfed/medical

/// A variant of spawning, they basically spawn with the mobile Engineering Bay.
/datum/ert/solfed/espatier/engineer
	ert_template = /datum/map_template/shuttle/ert/solfed/engineer

/// Forces this shuttle type to be engineering only
/datum/ert/solfed/espatier/engineer/engineering_only
	roles = list(/datum/antagonist/ert/solfed/espatier/engineer)

/// Forces the crew to be oops all corpsmans! (medics/doctors)
/datum/ert/solfed/espatier/medical/corpsman_only
	roles = list(/datum/antagonist/ert/solfed/espatier/corpsman)

/// Solfed Officals shuttle, but more fancy.
/datum/ert/solfed/fancy
	ert_template = /datum/map_template/shuttle/ert/solfed/fancy
/*

GRAND RESPONSE VARIANTS OF ESPATIERS, USE ONLY IF SOMEONE ROYALLY FUCKED UP

*/
/datum/ert/solfed/grand_espatier
	roles = list(/datum/antagonist/ert/solfed/grand_espatier, /datum/antagonist/ert/solfed/grand_espatier/corpsman, /datum/antagonist/ert/solfed/grand_espatier/engineer)
	leader_role = /datum/antagonist/ert/solfed/grand_espatier/leader

	ert_template = /datum/map_template/shuttle/ert/solfed

	notify_players = TRUE
	rename_team = "SolFed Espatier Detachment"
	teamsize = 6
	code = "FEDERAL"
	mission = "Rescue survivors, and bring order to chaos. Glory to the Federation."
	polldesc = "a Sol Federation Grand Response Espatier"


/// A variant of spawning, they spawn with a smaller more assaultlike ship, with no compartments (no medical compartment, engineering, atmos, just what they have on their back)
/datum/ert/solfed/grand_espatier/assault
	ert_template = /datum/map_template/shuttle/ert/solfed/assault

/// Corpsman only spawn
/datum/ert/solfed/grand_espatier/assault/corpsman_only
	roles = list(/datum/antagonist/ert/solfed/grand_espatier)
	polldesc = "a Sol Federation Truama Team"

/// Rifleman only spawn
/datum/ert/solfed/grand_espatier/assault/rifleman_only
	roles = list(/datum/antagonist/ert/solfed/grand_espatier/corpsman)
	polldesc = "a Sol Federation Rifleman"

/// Engineering only spawn
/datum/ert/solfed/grand_espatier/assault/engineering_only
	roles = list(/datum/antagonist/ert/solfed/grand_espatier/engineer)

/// A variant of spawning, they basically spawn with the mobile garrison/armory.
/datum/ert/solfed/grand_espatier/armory
	ert_template = /datum/map_template/shuttle/ert/solfed/armory

/// Forces the true helljumpers (basically all infantry, no medics)
/datum/ert/solfed/grand_espatier/armory/rifleman_only
	roles = list(/datum/antagonist/ert/solfed/grand_espatier)

/// A variant of spawning, they basically spawn with the mobile Hospital.
/datum/ert/solfed/grand_espatier/medical
	ert_template = /datum/map_template/shuttle/ert/solfed/medical

/// A variant of spawning, they basically spawn with the mobile Engineering Bay.
/datum/ert/solfed/grand_espatier/engineer
	ert_template = /datum/map_template/shuttle/ert/solfed/engineer

/// Forces this shuttle type to be engineering only
/datum/ert/solfed/grand_espatier/engineer/engineering_only
	roles = list(/datum/antagonist/ert/solfed/grand_espatier/engineer)

/// Forces the crew to be oops all corpsmans! (medics/doctors)
/datum/ert/solfed/grand_espatier/medical/corpsman_only
	roles = list(/datum/antagonist/ert/solfed/grand_espatier/corpsman)
