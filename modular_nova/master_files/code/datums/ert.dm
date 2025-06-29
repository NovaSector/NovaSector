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
	ert_template = /datum/map_template/shuttle/ert/solfed_transport/official

	rename_team = "SolFed Officials"
	teamsize = 5
	code = "FEDERAL"
	mission = "Audit the station, write reports, and look for any federation violations"
	polldesc = "a Sol Federation Official"

/datum/ert/solfed/espatier
	roles = list(/datum/antagonist/ert/solfed/espatier, /datum/antagonist/ert/solfed/espatier/corpsman, /datum/antagonist/ert/solfed/espatier/engineer)
	leader_role = /datum/antagonist/ert/solfed/espatier/leader

	ert_template = /datum/map_template/shuttle/ert/solfed_transport

	notify_players = TRUE
	rename_team = "SolFed Espatier Detachment"
	teamsize = 6
	code = "FEDERAL"
	mission = "Rescue survivors, Bring order to chaos, Glory to the federation."
	polldesc = "a Sol Federation Espatier"


/// A variant of spawning, they spawn with a smaller more assaultlike ship, with no compartments (no medical compartment, engineering, atmos, just what they have on their back)
/datum/ert/solfed/espatier/assault
	ert_template = /datum/map_template/shuttle/ert/solfed_transport/defcon

/// Corpsman only spawn
/datum/ert/solfed/espatier/assault/corpsman
	roles = list(/datum/antagonist/ert/solfed/espatier)
	polldesc = "a Sol Federation Truama Team"

/// Rifleman only spawn
/datum/ert/solfed/espatier/assault/rifleman
	roles = list(/datum/antagonist/ert/solfed/espatier/corpsman)
	polldesc = "a Sol Federation Rifleman"

/// Engineering only spawn
/datum/ert/solfed/espatier/assault/engineering
	roles = list(/datum/antagonist/ert/solfed/espatier/engineer)

/// A variant of spawning, they basically spawn with the mobile garrison/armory.
/datum/ert/solfed/espatier/defcon
	ert_template = /datum/map_template/shuttle/ert/solfed_transport/defcon

/// Forces the true helljumpers (basically all infantry, no medics)
/datum/ert/solfed/espatier/defcon/helljumper
	roles = list(/datum/antagonist/ert/solfed/espatier)

/// A variant of spawning, they basically spawn with the mobile Hospital.
/datum/ert/solfed/espatier/kayava
	ert_template = /datum/map_template/shuttle/ert/solfed_transport/kayava

/// Forces the crew to be oops all corpsmans! (medics/doctors)
/datum/ert/solfed/espatier/kayava/trauma
		roles = list(/datum/antagonist/ert/solfed/espatier/corpsman)

/// Solfed Officals shuttle, but more fancy.
/datum/ert/solfed/fancy
	roles = list(/datum/antagonist/ert/solfed/espatier, /datum/antagonist/ert/solfed/espatier/corpsman, /datum/antagonist/ert/solfed/espatier/engineer)
	leader_role = /datum/antagonist/ert/solfed/espatier/
	ert_template = /datum/map_template/shuttle/ert/solfed_transport/fancy
