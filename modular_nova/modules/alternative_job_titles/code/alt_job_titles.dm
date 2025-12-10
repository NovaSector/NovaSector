/**
 * This is the file you should use to add alternate titles for each job, just
 * follow the way they're done here, it's easy enough and shouldn't take any
 * time at all to add more or add some for a job that doesn't have any.
 */

/datum/job
	/// The list of alternative job titles people can pick from, null by default.
	var/list/alt_titles = null


/datum/job/ai
	alt_titles = list(
		"AI",
		"Automated Overseer",
		"Station Intelligence",
	)

/datum/job/assistant
	alt_titles = list(
		"Assistant",
		"Artist",
		"Businessman",
		"Businesswoman",
		"Civilian",
		"Entertainer",
		"Freelancer",
		"Tourist",
		"Trader",
		"Off-Duty Crew",
		"Off-Duty Staff",
		"Colonist",
		"Contractor",
		"Visitor",
		"Traveler",
	)

/datum/job/atmospheric_technician
	alt_titles = list(
		"Atmospheric Technician",
		"Emergency Fire Technician",
		"Hypertorus Fusion Reactor Operator",
		"Gas Synthesis Technician",
		"Nuclear Reactor Operator",
		"Firefighter",
		"Life Support Technician",
	)

/datum/job/barber
	alt_titles = list(
		"Barber",
		"Aethestician",
		"Colorist",
		"Salon Manager",
		"Salon Technician",
		"Stylist",
	)

/datum/job/bartender
	alt_titles = list(
		"Bartender",
		"Barman",
		"Barmaid",
		"Barista",
		"Bar Manager",
		"Beverage Architect",
		"Barkeeper",
		"Mixologist",
	)

/datum/job/bitrunner
	alt_titles = list(
		"Bitrunner",
		"Bitdomain Technician",
		"Data Retrieval Specialist",
		"Netdiver",
		"Pod Jockey",
		"Union Bitrunner",
		"Junior Runner",
	)

/datum/job/bridge_assistant
	alt_titles = list(
		"Bridge Officer",
		"Command Aide",
		"Ensign",
		"Command Cadet",
		"Bridge Attendant",
		"Command Secretary",
		"Command Intern",
	)

/datum/job/blueshield
	alt_titles = list(
		"Blueshield",
		"Command Bodyguard",
		"Corporate Protection Specialist",
		"Executive Protection Agent",
	)

/datum/job/botanist
	alt_titles = list(
		"Botanist",
		"Botanical Researcher",
		"Florist",
		"Gardener",
		"Beekeeper",
		"Herbalist",
		"Hydroponicist",
		"Mycologist",
		"Junior Botanist",
	)

/datum/job/bouncer
	alt_titles = list(
		"Bouncer",
		"Service Guard",
		"Doorman",
	)

/datum/job/corrections_officer
	alt_titles = list(
		"Corrections Officer",
		"Brig Officer",
		"Brig Guard",
		"Prison Guard",
	)

/datum/job/captain
	alt_titles = list(
		"Captain",
		"Commanding Officer",
		"Site Manager",
		"Site Supervisor",
		"Site Overseer",
		"Site Director",
		"Site Administrator",
		"Station Commander",
	)

/datum/job/cargo_technician
	alt_titles = list(
		"Cargo Technician",
		"Warehouse Technician",
		"Commodities Trader",
		"Deck Worker",
		"Inventory Associate",
		"Mailman",
		"Cargo Associate",
		"Mail Carrier",
		"Receiving Clerk",
		"Shipping Associate",
		"Union Associate",
	)

/datum/job/chaplain
	alt_titles = list(
		"Chaplain",
		"High Priest",
		"High Priestess",
		"Imam",
		"Magister",
		"Monk",
		"Nun",
		"Oracle",
		"Preacher",
		"Priest",
		"Priestess",
		"Pontifex",
		"Rabbi",
		"Reverend",
		"Shrine Maiden",
		"Shrine Guardian",
	)

/datum/job/chemist
	alt_titles = list(
		"Chemist",
		"Registered Pharmacist",
		"Clinical Pharmacist",
		"Assistant Pharmacist",
		"Chemical Engineer",
		"Pharmacist",
		"Pharmacologist",
		"Trainee Pharmacist",
	)

/datum/job/chief_engineer
	alt_titles = list(
		"Chief Engineer",
		"Engineering Foreman",
		"Engineering Supervisor",
		"Head of Engineering",
	)

/datum/job/chief_medical_officer
	alt_titles = list(
		"Chief Medical Officer",
		"Chief Physician",
		"Head of Medical",
		"Medical Supervisor",
		"Head Physician",
		"Medical Director",
		"Medical Administrator",
	)

/datum/job/clown
	alt_titles = list(
		"Clown",
		"Comedian",
		"Jester",
		"Joker",
	)

/datum/job/cook
	alt_titles = list(
		"Cook",
		"Butcher",
		"Line Cook",
		"Chef",
		"Culinary Artist",
		"Sous-Chef",
		"Chef's Apprentice",
		"Baker",
		"Junior Chef",
	)

/datum/job/coroner
	alt_titles = list(
		"Coroner",
		"Forensic Pathologist",
		"Funeral Director",
		"Medical Examiner",
		"Mortician",
	)

/datum/job/curator
	alt_titles = list(
		"Curator",
		"Archivist",
		"Conservator",
		"Journalist",
		"Librarian",
	)

/datum/job/customs_agent
	alt_titles = list(
		"Customs Agent",
		"Supply Guard",
	)

/datum/job/cyborg
	alt_titles = list(
		"Cyborg",
		"Android",
		"Robot",
	)

/datum/job/detective
	alt_titles = list(
		"Detective",
		"Detective Cadet",
		"Forensic Specialist",
		"Forensic Scientist",
		"Forensic Technician",
		"Forensic Investigator",
		"Private Investigator",
	)

/datum/job/doctor
	alt_titles = list(
		"Medical Doctor",
		"General Practitioner",
		"Medical Resident",
		"Nurse",
		"Physician",
		"Surgeon",
		"Medical Student",
		"Clinician",
		"Physician Assistant",
		"Internal Medicine Physician",
		"Emergency Medicine Physician",
		"Registered Nurse",
	)

/datum/job/engineering_guard //see orderly

/datum/job/geneticist
	alt_titles = list(
		"Geneticist",
		"Molecular Biologist",
		"Gene Scientist",
		"Gene Analyzer",
		"Gene Tailor",
		"Mutation Researcher",
	)

/datum/job/head_of_personnel
	alt_titles = list(
		"Head of Personnel",
		"Crew Supervisor",
		"Employment Officer",
		"Human Resources Officer",
		"Executive Officer",
	)

/datum/job/head_of_security
	alt_titles = list(
		"Head of Security",
		"Chief Constable",
		"Chief of Security",
		"Security Commander",
		"Security Supervisor",
		"Security Director",
		"Sheriff",
	)

/datum/job/janitor
	alt_titles = list(
		"Janitor",
		"Concierge",
		"Custodial Technician",
		"Rat Catcher",
		"Pest Control Technician",
		"Custodian",
		"Maid",
		"Maintenance Technician",
		"Sanitation Technician",
	)

/datum/job/lawyer
	alt_titles = list(
		"Lawyer",
		"Barrister",
		"Defense Attorney",
		"Human Resources Agent",
		"Internal Affairs Agent",
		"Legal Clerk",
		"Prosecutor",
		"Attorney At Law",
		"Corporate General Counsel Attorney",
		"Corporate Attorney",
		"Public Defender",
	)

/datum/job/mime
	alt_titles = list(
		"Mime",
		"Mummer",
		"Pantomimist",
	)

/datum/job/nanotrasen_consultant
	alt_titles = list(
		"Nanotrasen Corporate Consultant",
		"Nanotrasen Corporate Advisor",
		"Nanotrasen Corporate Regulation Advisor",
		"Nanotrasen Corporate Representative",
		"Nanotrasen Corporate Diplomat",
	)

/datum/job/orderly
	alt_titles = list(
		"Orderly",
		"Medical Guard",
	) //other dept guards' alt-titles should be kept to [department] guard to avoid confusion, unless the department gets a re-do.

/datum/job/paramedic
	alt_titles = list(
		"Paramedic",
		"Emergency Medical Technician",
		"Search and Rescue Technician",
		"Trauma Team Responder",
		"Emergency Medical Responder",
	)

/datum/job/prisoner
	alt_titles = list(
		"Prisoner",
		"Minimum Security Prisoner",
		"Maximum Security Prisoner",
		"SuperMax Security Prisoner",
		"Protective Custody Prisoner",
		"Psychiatric Hold Prisoner",
	)

/datum/job/psychologist
	alt_titles = list(
		"Psychologist",
		"Counsellor",
		"Psychiatrist",
		"Therapist",
	)

/datum/job/quartermaster
	alt_titles = list(
		"Quartermaster",
		"Deck Chief",
		"Head of Supply",
		"Logistics Coordinator",
		"Supply Foreman",
		"Union Requisitions Officer",
		"Warehouse Supervisor",
	)

/datum/job/research_director
	alt_titles = list(
		"Research Director",
		"Biorobotics Director",
		"Chief Science Officer",
		"Lead Researcher",
		"Research Supervisor",
		"Silicon Administrator",
		"Research Administrator",
		"Director of Science",
	)

/datum/job/roboticist
	alt_titles = list(
		"Roboticist",
		"Biomechanical Engineer",
		"Cyberneticist",
		"Mech Fabrication Specialist",
		"Machinist",
		"Mechatronic Engineer",
		"Apprentice Roboticist",
	)

/datum/job/science_guard //See orderly

/datum/job/scientist
	alt_titles = list(
		"Scientist",
		"Anomalist",
		"Circuitry Designer",
		"Cytologist",
		"Graduate Student",
		"Lab Technician",
		"Ordnance Technician",
		"Plasma Researcher",
		"Resonance Researcher",
		"Theoretical Physicist",
		"Xenoarchaeologist",
		"Xenobiologist",
		"Research Assistant",
	)

/datum/job/security_officer
	alt_titles = list(
		"Security Officer",
		"Security Operative",
		"Security Cadet",
		"Security Specialist",
		"Deputy",
		"Constable",
	)

/datum/job/shaft_miner
	alt_titles = list(
		"Shaft Miner",
		"Union Miner",
		"Excavator",
		"Drill Technician",
		"Prospector",
		"Ore Excavation Specialist",
		"Spelunker",
		"Apprentice Miner",
	)

/datum/job/station_engineer
	alt_titles = list(
		"Station Engineer",
		"Electrician",
		"Emergency Damage Control Technician",
		"Engine Technician",
		"EVA Technician",
		"Mechanic",
		"Architect",
		"Structural Engineer",
		"Electrical Engineer",
		"Apprentice Engineer",
	)

/datum/job/telecomms_specialist
	alt_titles = list(
		"Telecomms Specialist",
		"Wireless Operator",
		"Network Engineer",
		"Sysadmin",
		"Telecomms Technician",
		"Tram Technician",
	)

/datum/job/virologist
	alt_titles = list(
		"Virologist",
		"Epidemiologist",
		"Microbiologist",
		"Pathologist",
		"Junior Pathologist",
	)

/datum/job/warden
	alt_titles = list(
		"Warden",
		"Brig Sergeant",
		"Brig Governor",
		"Dispatch Officer",
		"Jailer",
	)
