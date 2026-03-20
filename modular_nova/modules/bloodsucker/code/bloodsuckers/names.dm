
/datum/antagonist/bloodsucker/proc/return_full_name()
	var/fullname = bloodsucker_name ? bloodsucker_name : owner.current.name
	if(bloodsucker_title)
		fullname = "[bloodsucker_title] [fullname]"
	if(bloodsucker_reputation)
		fullname += " the [bloodsucker_reputation]"

	return fullname

///Returns a First name for the Bloodsucker.
/datum/antagonist/bloodsucker/proc/SelectFirstName()
	if(owner.current.gender == MALE)
		bloodsucker_name = pick(
			"Desmond","Cassius","Theron","Morden","Gregor",
			"Soren","Voss","Kael","Andrei","Riven","Theron",
			"Darius","Silas","Hector","Lucius","Marius","Orlan",
			"Corvus","Cyrus","Aldric","Magnus","Tyrus","Calder",
			"Ashwin","Mordecai","Thane","Ossian","Vesper","Harken",
			"Draven","Remiel","Gharet","Noctis","Severan","Fenrik",
			"Kellan","Rask","Oberon","Valen",
		)
	else
		bloodsucker_name = pick(
			"Isolde","Serana","Morgaine","Thyra","Helia",
			"Vespera","Sylene","Nyx","Calista","Ravenna",
			"Lilith","Thessaly","Maren","Rowena","Selene",
			"Cressida","Arachne","Elara","Ondine","Viera",
			"Nephele","Asha","Darya","Kova","Brynn",
			"Severa","Ilexa","Riven","Nocturna","Thalassa",
			"Kaela","Morwen","Ardenna","Ysabel","Vyra",
		)

///Returns a Title for the Bloodsucker.
/datum/antagonist/bloodsucker/proc/SelectTitle(am_fledgling = FALSE, forced = FALSE)
	// Already have Title
	if(!forced && bloodsucker_title != null)
		return
	// Titles
	if(am_fledgling)
		bloodsucker_title = null
		return
	if(owner.current.gender == MALE)
		bloodsucker_title = pick(
			"Progenitor",
			"Patriarch",
			"Warden",
			"Harbinger",
			"Sovereign",
			"Overseer",
			"Archon",
			"Lord",
			"Master",
		)
	else
		bloodsucker_title = pick(
			"Progenitor",
			"Matriarch",
			"Warden",
			"Harbinger",
			"Sovereign",
			"Overseer",
			"Archon",
			"Lady",
			"Mistress",
		)
	to_chat(owner, span_announce("You have earned a title! You are now known as <i>[return_full_name()]</i>!"))

///Returns a Reputation for the Bloodsucker.
/datum/antagonist/bloodsucker/proc/SelectReputation(am_fledgling = FALSE, forced = FALSE)
	// Already have Reputation
	if(!forced && bloodsucker_reputation != null)
		return

	if(am_fledgling)
		bloodsucker_reputation = pick(
			"Nascent",
			"Unstable",
			"Unintegrated",
			"Neophyte",
			"Freshly Bonded",
			"Unmatured",
			"Fledgling",
			"Young",
			"Adapting",
			"Gestating",
			"Untested",
			"Unproven",
			"Unknown",
			"Newly Infected",
			"Incubating",
			"Larval",
			"Emergent",
			"Unrefined",
			"Weakened",
			"Thin-Blooded",
			"Incomplete",
			"Meek",
			"Dormant",
			"Fresh",
		)
	else if(owner.current.gender == MALE && prob(10))
		bloodsucker_reputation = pick(
			"Apex Predator",
			"Blood King",
			"Alpha Carrier",
			"Patient Zero",
			"Plague Father",
		)
	else if(owner.current.gender == FEMALE && prob(10))
		bloodsucker_reputation = pick(
			"Apex Predator",
			"Blood Queen",
			"Alpha Carrier",
			"Patient Zero",
			"Plague Mother",
		)
	else
		bloodsucker_reputation = pick(
			"Butcher","Blood Fiend","Crimson","Red","Black","Terror",
			"Nightstalker","Feared","Ravenous","Fiend","Malignant","Virulent",
			"Ancient","Plague-Bearer","Parasitic","Forgotten","Wretched","Corrosive",
			"Harvester","Reviled","Robust","Betrayer","Devourer",
			"Accursed","Terrible","Vicious","Invasive","Infectious",
			"Consuming","Foul","Slayer","Predator","Sovereign","Carrier",
			"Forsaken","Mad","Feral","Savage","Metastatic","Nefarious",
			"Marauder","Horrible","Undying","Overlord",
			"Corrupt","Abyssal","Tyrant","Sanguine",
		)

	to_chat(owner, span_announce("You have earned a reputation! You are now known as <i>[return_full_name()]</i>!"))
