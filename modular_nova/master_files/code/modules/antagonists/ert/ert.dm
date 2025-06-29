/datum/antagonist/ert/asset_protection
	name = "Asset Protection Specialist"
	outfit = /datum/outfit/centcom/asset_protection
	role = "Specialist"
	rip_and_tear = TRUE

/datum/antagonist/ert/asset_protection/New()
	. = ..()
	name_source = GLOB.commando_names

/datum/antagonist/ert/asset_protection/leader
	name = "Asset Protection Officer"
	outfit = /datum/outfit/centcom/asset_protection
	role = "Officer"

/datum/antagonist/ert/solfed/espatier
	name = "Solfed Espatier"
	outfit = /datum/outfit/solfed/espatier
	suicide_cry = "FOR THE FEDERATION!!!!"
	role = "Rifleman"

/datum/antagonist/ert/solfed/espatier/engineer
	name = "Solfed Espatier Engineer"
	outfit = /datum/outfit/solfed/espatier/engineer
	role = "Engineer"

/datum/antagonist/ert/solfed/espatier/corpsman
	name = "Solfed Espatier Corpsman"
	outfit = /datum/outfit/solfed/espatier/corpsman
	role = "Corpsman"

/datum/antagonist/ert/solfed
	name = "Solfed Auditor"
	outfit = /datum/outfit/solfed/lowrank
	role = "Auditor"

/datum/antagonist/ert/solfed/social
	name = "Solfed Auditor"
	outfit = /datum/outfit/solfed/social
	role = "Social Worker"

/datum/antagonist/ert/solfed/civil
	name = "Solfed Auditor"
	outfit = /datum/outfit/solfed/civil
	role = "Civil Services Worker"

/datum/antagonist/ert/solfed/leader
	name = "Lead Solfed Auditor"
	outfit = /datum/outfit/solfed
	role = "Lead Auditor"

/datum/antagonist/ert/solfed/espatier/New()
	. = ..()
	name_source = GLOB.last_names

/datum/antagonist/ert/solfed/espatier/leader
	name = "Solfed Espatier Squad Leader"
	outfit = /datum/outfit/solfed/espatier/squadleader
	role = "Squad Leader"
	leader = TRUE

/datum/antagonist/ert/solfed/espatier/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	if(leader) //If Squad Leader
		missiondesc += "<BR><B><Lead your squad to ensure the completion of the mission. Board the shuttle when your team is ready.</B>"
	if(!leader)
		missiondesc += "<BR><B><font size=2 color=yellow> Follow orders given to you by your squad leader.</font></B>"
	missiondesc += "<BR><B>Your Duties</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the Sol Federation Ground Teams and the First Responders via your headset to get the situation from them."
	missiondesc += "<BR> <B>2.</B> Locate Survivors and Assume Control of the station, and prepare to initiate evacuation procedures should the situation call for it."
	missiondesc += "<BR> <B>3.</B> Should all else fail, evacuating the civilians becomes your top priority."
	missiondesc += "<BR> <B>4.</B> Lethal force is authorized, however identify before you shoot and watch who you're shooting, civilian casualties by federation hands are NOT TOLERATED."

	missiondesc += "<span class='warningplain'><BR><B>Your Mission</B> : [ert_team.mission.explanation_text]</span>"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/solfed
	suicide_cry = "FOR THE FEDERATION!!!!"
