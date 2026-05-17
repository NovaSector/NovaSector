//Datums for different factions that can be used by busy_space
/datum/lore/organization
	var/name = ""				// Organization's name
	var/short_name = ""			// Organization's shortname (Nanotrasen for "Nanotrasen Incorporated")
	var/acronym = ""			// Organization's acronym, e.g. 'NT' for Nanotrasen'.
	var/desc = ""				// One or two paragraph description of the organization, but only current stuff.  Currently unused.
	var/history = ""			// Historical discription of the organization's origins  Currently unused.
	var/work = ""				// Short description of their work, eg "an arms manufacturer"
	var/headquarters = ""		// Location of the organization's HQ.  Currently unused.
	var/motto = ""				// A motto/jingle/whatever, if they have one.  Currently unused.

	var/list/ship_prefixes = list()	//Some might have more than one! Like Nanotrasen. Value is the mission they perform, e.g. ("ABC" = "mission desc")
	var/complex_tasks = FALSE	//enables complex task generation

	//how does it work? simple: if you have complex tasks enabled, it goes; PREFIX + TASK_TYPE + FLIGHT_TYPE
	//e.g. NDV = Asset Protection + Patrol + Flight
	//this overrides the standard PREFIX = TASK logic and allows you to use the ship prefix for subfactions (warbands, religions, whatever) within a faction, and define task_types at the faction level
	//task_types are picked from completely at random in air_traffic.dm, much like flight_types, so be careful not to potentially create combos that make no sense!

	var/list/task_types = list(
			"logistics",
			"patrol",
			"training",
			"peacekeeping",
			"escort",
			"search and rescue"
			)
	var/list/flight_types = list(		//operations and flights - we can override this if we want to remove the military-sounding ones or add our own
			"flight",
			"mission",
			"route",
			"assignment"
			)
	var/list/ship_names = list(		//Names of spaceships.  This is a mostly generic list that all the other organizations inherit from if they don't have anything better.
			"Scout",
			"Beacon",
			"Signal",
			"Freedom",
			"Liberty",
			"Enterprise",
			"Glory",
			"Axiom",
			"Eternal",
			"Harmony",
			"Light",
			"Discovery",
			"Endeavour",
			"Explorer",
			"Swift",
			"Dragonfly",
			"Ascendant",
			"Tenacious",
			"Pioneer",
			"Surveyor",
			"Haste",
			"Radiant",
			"Luminous",
			"Calypso",
			"Eclipse",
			"Maverick",
			"Polaris",
			"Northstar",
			"Orion",
			"Odyssey",
			"Relentless",
			"Valor",
			"Zodiac",
			"Avenger",
			"Defiant",
			"Dauntless",
			"Interceptor",
			"Providence",
			"Thunderchild",
			"Defender",
			"Ranger",
			"River",
			"Jubilee",
			"Gumdrop",
			"Spider",
			"Columbia",
			"Eagle",
			"Intrepid",
			"Aquarius",
			"Kitty Hawk",
			"Antares",
			"Falcon",
			"Casper",
			"Orion",
			"Columbia",
			"Atlantis",
			"Enterprise",
			"Challenger",
			"Pathfinder",
			"Buran",
			"Aldrin",
			"Armstrong",
			"Tranquility",
			"Nostrodamus",
			"Soyuz",
			"Cosmos",
			"Sputnik",
			"Belka",
			"Strelka",
			"Gagarin",
			"Shepard",
			"Tereshkova",
			"Leonov",
			"Vostok",
			"Apollo",
			"Mir",
			"Titan",
			"Serenity",
			"Andiamo",
			"Aurora",
			"Phoenix",
			"Wayward Phoenix",
			"Lucky",
			"Raven",
			"Valkyrie",
			"Halcyon",
			"Nakatomi",
			"Cutlass",
			"Unicorn",
			"Sheepdog",
			"Arcadia",
			"Gigantic",
			"Goliath",
			"Pequod",
			"Poseidon",
			"Venture",
			"Evergreen",
			"Natal",
			"Maru",
			"Djinn",
			"Witch",
			"Wolf",
			"Lone Star",
			"Grey Fox",
			"Dutchman",
			"Sultana",
			"Siren",
			"Venus",
			"Anastasia",
			"Rasputin",
			"Stride",
			"Suzaku",
			"Hathor",
			"Dream",
			"Gaia",
			"Ibis",
			"Progress",
			"Olympic",
			"Venture",
			"Brazil",
			"Tiger",
			"Hedgehog",
			"Potemkin",
			"Fountainhead",
			"Sinbad",
			"Esteban",
			"Mumbai",
			"Shanghai",
			"Madagascar",
			"Kampala",
			"Bangkok",
			"Emerald",
			"Guo Hong",
			"Shun Kai",
			"Fu Xing",
			"Zhenyang",
			"Da Qing",
			"Rascal",
			"Flamingo",
			"Jackal",
			"Andromeda",
			"Ferryman",
			"Panchatantra",
			"Nunda",
			"Fortune",
			"New Dawn",
			"Fionn MacCool",
			"Red Bird",
			"Star Rat",
			"Cwn Annwn",
			"Morning Swan",
			"Black Cat",
			"Challenger",
			"Freshly Baked",
			"Citrus Punch",
			"Made With Real Fruit",
			"Big D",
			"Shaken, Not Stirred",
			"Stirred, Not Shaken",
			"Neither Shaken Nor Stirred",
			"Shaken And Stirred",
			"Freedom Ain't Free",
			"Pay It Forward",
			"All Expenses Paid",
			"Tanstaafl",
			"Hold My Beer",
			"Das Bootleg",
			"Unplanned Lithobraking Incident",
			"Unknown Accelerant",
			"Mildly Flammable",
			"Wave Goodbye",
			"Hugh Mann",
			"Hugh Anner",
			"Savage Chicken",
			"Homestead",
			"Peacekeeper",
			"Eminent Domain",
			"Clear Sky",
			"Midnight Light",
			"Daedalus",
			"Redline",
			"Wild Dog",
			"Black Eagle",
			"Sovereign Citizen",
			"Event Horizon",
			"Monte Carlo",
			"Ace of Spades",
			"Dead Man's Hand",
			"Big Blind",
			"Royal Flush",
			"Full House",
			"Wildcard",
			"Wild Card",
			"Blackjack",
			"Three of a Kind",
			"Three's Company",
			"Know When To Fold 'Em",
			"Icebreaker",
			"Megalith",
			"Agnus Dei",
			"Picasso",
			"Spirit of Alliance",
			"Surrounded By Idiots",
			"Honk If You Can Read This",
			"Terms And Conditions May Apply",
			"Personal Space Invader",
			"Sufficient Velocity",
			"Credible Deniability",
			"Incredible Deniability",
			"Crucible",
			"Empire of the Tyrants",
			"Nostromo",
			"Dance Like You Mean It",
			"Birthday Suit",
			"Sinking Feeling",
			"No Refunds",
			"No Solicitors",
			"Dream of Independence",
			"Tunguska",
			"Kugelblitz",
			"Supermassive Black Hole",
			"Knight of Cydonia",
			"Guiding Light",
			"Unnatural Selection",
			"Stockholm Syndrome",
			"False King",
			"Bombshell",
			"End of Everything",
			"One and Only",
			"Walking Disaster",
			"Wild World",
			"Two-Body Problem",
			"Instrument of Violence",
			"Entropic Whisper",
			"Cash and Prizes",
			"Crash Course",
			"Wheel of Fortune",
			"Little Light",
			"Leave Only Footprints",
			"Dead Man's Tale",
			"The Next Big Thing",
			"Some Disassembly Required",
			"Some Assembly Required",
			"Just Read The Manual",
			"Spoiler Alert",
			"Bad News",
			"Lucky Pants",
			"No Hard Feelings",
			"Waste Not, Want Not",
			"Beowulf",
			"Inheritor",
			"Anthropocene Denier",
			"Bonaventure",
			"Nothing Ventured",
			"Go West",
			"Once Upon A Time",
			"Don't Worry About It",
			"Bygones Be",
			"Just Capital",
			"Delight",
			"Valdez",
			"Pioneer",
			"Antilles",
			"Explorer",
			"Number Crunch",
			"Until Dawn",
			"Pistols at Dawn",
			"Right Side",
			"Merchant Prince",
			"Merchant Princess",
			"Merchant King",
			"Merchant Queen",
			"Merchant's Pride",
			"Golden Son",
			"Trade Law",
			"Onward",
			"Wanderer",
			"Rocky Start",
			"Downtown",
			"Risk Reward",
			"Culture Shock",
			"Ambition",
			"Vigor",
			"Vigilant",
			"Courageous",
			"Profit Vanguard",
			"Free Market",
			"Market Speculation",
			"Banker's Dozen",
			"Adventure",
			"Profiteer",
			"Wrong Side",
			"Final Notice",
			"Tax Man",
			"Ferryman",
			"Hangman",
			"Cattlecar",
			"Runtime Error",
			"For Sale, Cheap",
			"Starfarer",
			"Drifter",
			"Windward",
			"Hostile Takeover",
			"Tax Loop",
			"Fortune's Fancy",
			"Fortuna",
			"Inside Outside",
			"Galley",
			"Constellation",
			"Delta-V Deficiency",
			"Dromedarii",
			"Golden Hand",
			"White Company",
			"Haggler",
			"Rendezvous",
			"Two For Flinching",
			"Uninvited Guest",
			"Iconoclast",
			"Bluespace Tourist",
			"Fortunate Son",
			"Unfortunate Son",
			"Hazard Pay",
			)
	var/list/added_ship_names = list()	//List of ship names to add to the above, rather than wholesale replacing
	var/list/destination_names = list()	//Names of static holdings that the organization's ships visit
	var/append_ship_names = FALSE

	var/org_type = "neutral"		//Valid options are "neutral", "corporate", "government", "system defense", "military, "smuggler", & "pirate"
	var/autogenerate_destination_names = TRUE //Pad the destination lists with some extra random ones? see the proc below for info on that

	var/slogans = list("This is a placeholder slogan, ding dong!")			//Advertising slogans. Who doesn't want more obnoxiousness on the radio? Picked at random each time the slogan event fires. This has a placeholder so it doesn't runtime on trying to draw from a 0-length list in the event that new corps are added without full support.

/datum/lore/organization/New()
	..()

	if(append_ship_names)
		ship_names.Add(added_ship_names)

	if(autogenerate_destination_names) // Lets pad out the destination names.
		var/i = rand(20, 30) //significantly increased from original values due to the greater length of rounds

		//known planets and exoplanets, plus fictional ones
		var/list/planets = list(
			/* real planets in our solar system */
			"Earth","Luna","Mars","Titan","Europa",
			/* named exoplanets, god knows if they're habitable */
			"Spe","Arion","Arkas","Orbitar","Dimidium",
			"Galileo","Brahe","Lipperhey","Janssen","Harriot",
			"Aegir","Amateru","Dagon","Meztli","Smertrios",
			"Hypatia","Quijote","Dulcinea","Rocinante","Sancho",
			"Thestias","Saffar","Samh","Majriti","Fortitudo",
			"Draugr","Arber","Tassili","Madriu","Naqaya",
			"Bocaprins","Yanyan","Sissi","Tondra","Eburonia",
			"Drukyul","Yvaga","Naron","Guarani","Mastika",
			"Bendida","Nakanbe","Awasis","Caleuche","Wangshu",
			"Melquiades","Pipitea","Ditso","Asye","Veles",
			"Finlay","Onasilos","Makropolus","Surt","Boinayel",
			"Eyeke","Cayahuanca","Hamarik","Abol","Hiisi",
			"Belisama","Mintome","Neri","Toge","Iolaus",
			"Koyopa","Independence","Ixbalanque","Magor","Fold",
			"Santamasa","Noifasui","Kavian","Babylonia","Bran",
			"Alef","Lete","Chura","Wadirum","Buru",
			"Umbaasaa","Vytis","Peitruss","Trimobe","Baiduri",
			"Ggantija","Cuptor","Xolotl","Isli","Hairu",
			"Bagan","Laligurans","Kereru","Equiano","Albmi",
			"Perwana","Pollera","Tumearandu","Sumajmajta","Haik",
			"Leklsullun","Pirx","Viriato","Aumatex","Negoiu",
			"Teberda","Dopere","Vlasina","Viculus","Kralomoc",
			"Iztok","Krotoa","Halla","Riosar","Samagiya",
			"Isagel","Eiger","Ugarit","Sazum","Maeping",
			"Agouto","Ramajay","Khomsa","Gokturk","Barajeel",
			"Cruinlagh","Mulchatria","Ibirapita","Madalitso",
			/* fictional planets from polarislore */
			"Sif","Kara","Rota","Root","Toledo, New Ohio",
			"Meralar","Adhomai","Binma","Kishar","Anshar",
			"Nisp","Elysium","Sophia, El","New Kyoto",
			"Angessa's Pearl, Exalt's Light","Oasis","Love"
			)

		//existing systems, pruned for duplicates, includes systems that contain suspected or confirmed exoplanets
		var/list/systems = list(
			/* real solar systems, specifically ones that have possible planets */
			"Sol","Alpha Centauri","Sirius","Vega","Tau Ceti",
			"Altair","Epsilon Eridani","Fomalhaut","Mu Arae","Pollux",
			"Wolf 359","Ross 128","Gliese 1061","Luyten's Star","Teegarden's Star",
			"Kapteyn","Wolf 1061","Aldebaran","Proxima Centauri","Kepler-90",
			"HD 10180","HR 8832","TRAPPIST-1","55 Cancri","Gliese 876",
			"Upsilon Andromidae","Mu Arae","WASP-47","82 G. Eridani","Rho Coronae Borealis",
			"Pi Mensae","Beta Pictoris","Gamma Librae","Gliese 667 C","LHS 1140",
			"Phact",
			/* fictional systems from Polaris and other sources*/
			"Zhu Que","Oasis","Vir","Gavel","Ganesha",
			"Sidhe","New Ohio","Parvati","Mahi-Mahi","Nyx",
			"New Seoul","Kess-Gendar","Raphael","El","Eutopia",
			/* skrell */
			"Qerr'valis","Harr'Qak","Qerrna-Lakirr","Kauq'xum",
			/* tajaran */
			"Rarkajar","Arrakthiir","Mesomori",
			/* other */
			"Vazzend","Thoth","Jahan's Post","Silk","New Singapore",
			"Stove","Viola","Isavau's Gamble","Samsara",
			"Vounna","Relan","Whythe","Exalt's Light","Van Zandt",
			/* generic territories */
			"deep space",
			"Commonwealth space",
			"Commonwealth territory",
			"ArCon space",
			"ArCon territory",
			"independent space",
			"a demilitarized zone",
			"Elysian space",
			"Elysian territory",
			"Salthan space",
			"Salthan territory",
			"Skrell space",
			"Skrell territories",
			"Tajaran space",
			"Hegemonic space",
			"Hegemonic territory"
			)
		var/list/owners = list("a government", "a civilian", "a corporate", "a private", "an independent", "a military")
		var/list/purpose = list("an exploration", "a trade", "a research", "a survey", "a military", "a mercenary", "a corporate", "a civilian", "an independent")

		//unique or special locations
		var/list/unique = list("the Jovian subcluster","Isavau International Spaceport","Terminus Station","Casini's Reach","the Shelf flotilla","the Ue'Orsi flotilla","|Heaven| Orbital Complex, Alpha Centauri","the |Saint Columbia| Complex")

		var/list/orbitals = list("[pick(owners)] shipyard","[pick(owners)] dockyard","[pick(owners)] station","[pick(owners)] vessel","a habitat","[pick(owners)] refinery","[pick(owners)] research facility","an industrial platform","[pick(owners)] installation")
		var/list/surface = list("a colony","a settlement","a trade outpost","[pick(owners)] supply depot","a fuel depot","[pick(owners)] installation","[pick(owners)] research facility")
		var/list/deepspace = list("[pick(owners)] asteroid base","a freeport","[pick(owners)] shipyard","[pick(owners)] dockyard","[pick(owners)] station","[pick(owners)] vessel","[pick(owners)] habitat","a trade outpost","[pick(owners)] supply depot","a fuel depot","[pick(owners)] installation","[pick(owners)] research facility")
		var/list/frontier = list("[pick(purpose)] [pick("ship","vessel","outpost")]","a waystation","an outpost","a settlement","a colony")

		//patterns; orbital ("an x orbiting y"), surface ("an x on y"), deep space ("an x in y"), the frontier ("an x on the frontier")
		//biased towards inhabited space sites
		while(i)
			destination_names.Add("[pick("[pick(orbitals)] orbiting [pick(planets)]","[pick(surface)] on [pick(planets)]","[pick(deepspace)] in [pick(systems)]",20;"[pick(unique)]",30;"[pick(frontier)] on the frontier")]")
			i--
		//extensive rework for a much greater degree of variety compared to the old system, lists now include known exoplanets and star systems currently suspected or confirmed to have exoplanets

//////////////////////////////////////////////////////////////////////////////////

/datum/lore/organization/gov/sol_federation
	name = "Sol Federation"
	short_name = "SolFed Government"
	acronym = "SFG"
	desc = "The civilian administrative arm of the Sol Federation, this sprawling bureaucracy manages everything from interstellar diplomacy and Federal law to trade regulations and the maintenance of the Charter. These are the diplomats, clerks, and functionaries who keep the fractious union of member states from flying apart."
	work = "interstellar governance and diplomacy"
	headquarters = "Geneva, Earth, Sol System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "government"
	ship_prefixes = list(
		"SFGV" = "a diplomatic",
		"SFGV" = "a census",
		"SFGV" = "a judicial",
		"SFGV" = "a trade regulation",
		"SFGV" = "an administrative",
		"SFGV" = "a Federal Assembly",
	)

	// SolFed's ship naming scheme will be about high-minded, often grand ideals, reflecting their founding Unificationist principles.
	// This list will be used by civilians, while SolFed military ships will use a different, more martial list.
	ship_names = list(
		"Concord", "Unity", "Solidarity", "Amity", "Consensus",
		"Federation", "Harmony", "Diplomat", "Enlightenment", "Progress",
		"Vanguard of Peace", "Boundless Horizon", "Mutual Accord", "Common Purpose", "Collective Dream",
		"Clarity", "Equity", "Fraternity", "Integrity", "Justice",
		"Unyielding Hope", "Lasting Prosperity", "Open Palm", "Stalwart", "Verity",
		"Endeavour", "Resolution", "Synthesis", "Tolerance", "Universal Rights",
		"Anastasia", "Rasputin", "Kugelblitz", "Supermassive Black Hole", "Event Horizon"
	)
	destination_names = list(
		"the SolFed International Capital District, Earth",
		"the Federal Assembly Building, Geneva",
		"a Bureau of Astrography survey post",
		"a SolFed Marshals regional office",
		"a Federal Tax collection point",
		"a Clique's private conference station",
	)

/datum/lore/organization/gov/corporate_territories_council
	name = "Corporate Territories Governing Council"
	short_name = "CT Council"
	acronym = "CTGC"
	desc = "A facade of unity for the corporate-owned systems of SolFed. The Council 'governs' the Corporate Territories from Luna, but in reality, it's a stage for the Sovereign Corporations to coordinate diplomacy, suppress open conflict between themselves, and project a single voice in the Federal Assembly to protect their collective profit motive."
	work = "corporate syndicational governance"
	headquarters = "Luna, Sol System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "government" // It fills the role of a government for these territories
	ship_prefixes = list(
		"CTGV" = "a regulatory",
		"CTGV" = "a commercial arbitration",
		"CTGV" = "a public relations",
		"CTGV" = "a territorial management",
		"CTGV" = "a lobbying",
	)

	// Names reflecting corporate governance, finance, and sterile authority.
	ship_names = list(
		"Due Diligence", "Fiduciary Duty", "Market Force", "Shareholder Value", "Quarterly Report",
		"Risk Assessment", "Hostile Takeover", "Merger & Acquisition", "Return on Investment", "Liquid Asset",
		"Non-Disclosure", "Arbitration", "Fiscal Policy", "Capital Gains", "Executive Summary",
		"White Paper", "Boardroom", "Holding Company", "Stakeholder", "Waiver",
		"Injunction", "Profit Margin", "Subsidiary", "Tender Offer", "Golden Parachute",
		"Blue Chip", "Escrow", "Leveraged Buyout", "Proxy Statement", "Venture Capital",
	)
	destination_names = list(
		"the Council Chambers, Luna",
		"a Corporate Territories stock exchange",
		"a disputed corporate border zone",
		"a regulatory compliance checkpoint",
		"the SolFed Trade Clique lobbying offices",
	)

/datum/lore/organization/gov/talunan_imperium_admin
	name = "Talunan Imperium Ward Administration"
	short_name = "Talunan Imperium"
	acronym = "TIW"
	desc = "The complex web of Wards that governs daily life within the Talunan Imperium. Following the near-extinction of their species, the Tizirans reorganized into a network of decentralized, hyper-local councils bound by mutual aid pacts and unwavering loyalty to the anonymizing Throne. These vessels handle internal civil service, resource distribution, and inter-Ward cooperation."
	work = "civil service and mutual aid administration"
	headquarters = "The Silent City, Tizira"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "government"
	ship_prefixes = list(
		"TIV" = "a Ward supply",
		"TIV" = "a census",
		"TIV" = "a reconstruction",
		"TIV" = "an administrative",
		"TIV" = "a medical relief",
		"TIV" = "a judicial",
	)

	// Ship names themed around Tiziran concepts of tides, duality, places, and resilience.
	ship_names = list(
		"High Tide", "Low Tide", "Dawn's Vigil", "Dusk's Embrace", "Asl'Ton",
		"Kor'Taku", "Atra'Asl's Light", "Shattered Moon", "Krek'Taluna", "The Ebb",
		"The Flow", "Krak'Tal", "Or'Kasu", "Zag'Skol", "Asta'Lo",
		"Trakuk'Maktal", "Atra'Lu", "Kol'Kasan Mist", "Unbroken Fellowship", "Enduring Ward",
		"Arid Resilience", "Cave Dweller", "Sand-Skimmer", "Lagoon Spirit", "Twice-Hearted",
		"Bioluminescence", "Nala's Watch", "Naki's Rest", "Koos' Warmth", "Cycle Walker",
	)
	destination_names = list(
		"a Ward council hub on Tizira",
		"the Shattered Remnants of Atra'Kor",
		"a refugee resettlement center",
		"an orbital habitat reconstruction site",
		"a Sapper Corps salvage operation",
		"a joint Tiziran-Teshari administrative enclave"
	)

/datum/lore/organization/gov/tajaran_houses_council
	name = "The Six and One Council"
	short_name = "House Council"
	acronym = "SOH"
	desc = "The ruling council of the Shattered Empire, consisting of representatives from the Six Great Houses and, when one exists, the Seventh. This division handles the highest levels of interstellar diplomacy, the enforcement of the Seven-Part Mandate, and the intricate, deadly political dance between the Houses. Their vessels are ostentatious displays of a House's Face."
	work = "imperial Tajaran governance"
	headquarters = "The Emperor's Palace, Sleepless Throne System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "government"
	ship_prefixes = list(
		"SEV" = "a diplomatic", // Shattered Empire Vessel
		"SEV" = "a Mandate enforcement",
		"SEV" = "a House conclave",
		"SEV" = "an arbitrative",
		"SEV" = "a ceremonial"
	)

	// Ship names drawing from Tajaran concepts of Face, Heart, myth, art, and luxury.
	ship_names = list(
		"Unspoken Signal", "Bleeding Heart", "Grand Design to Shatter Infinity", "Masquerade", "Stolen Face",
		"Fourfold Dagger", "Mask of the Emperor", "Marque de Slumber", "Paradox of Two Minds", "The Laughing Corsair",
		"Sleepless", "Dreamweave", "Gilded Cage", "Silk & Iron", "Bulletproof Devil",
		"Southern Mountain's Pipe", "Whore of Sublirel's Gown", "Lord of Thunder's Fist", "Shipmaster's Will", "Shadow of the Seventh",
		"Salnai's Pearl", "Istrover's Gamble", "Sorocan Harvest", "Hyldetan Stone", "Sheneocrye's Forge",
		"Never Land", "Autumn's End", "Iron Sanctuary", "Hibernating Valley", "Midnight Jungle"
	)
	destination_names = list(
		"the Emperor's Palace, Sleepless Throne",
		"a House Astameur parlor-boutique on Sublirel",
		"a House Morikann war mask ceremony on Salnai",
		"a House Ussirune casino on Istrover",
		"a House Verikami hospital on Sorocan",
		"a House Toragana shipyard at Hyldetan",
		"a House Parigari tech-exhibition on Sheneocrye",
		"the Netherworld of Vajharji"
	)

/datum/lore/organization/gov/teshari_confederations
	name = "Teshari Confederations"
	short_name = "Teshari Confederations"
	acronym = "TC"
	desc = "The sociable and exploratory Teshari people organize themselves into a series of loosely-allied, migratory groups known as Confederations. They are explorers, traders, and the Talunan Imperium's only trusted alien ally. Their governing body, such as it is, focuses on coordinating exploration, establishing new enclaves, and maintaining their special relationship with the Tizirans."
	work = "nomadic governance and exploration"
	headquarters = "Sirisai System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "government"
	ship_prefixes = list(
		"TCV" = "an exploratory",
		"TCV" = "an enclave",
		"TCV" = "a trade",
		"TCV" = "a diplomatic",
		"TCV" = "a confederation"
	)

	// Names based on exploration, flight, feathers, winds, and community.
	ship_names = list(
		"Wandering Star", "High Zephyr", "Thermal Glider", "Feathertouch", "Bright Beak",
		"Song of the Wind", "Endless Sky", "New Horizon", "Flock's Fortune", "Cooperative Venture",
		"First Dawn", "Curious Tides", "Gentle Talon", "Vibrant Plumage", "Enclave's Warmth",
		"Drifting Seed", "Soaring Hope", "Sister's Watch", "Quiet Nest", "Wingbeat",
		"Star-Treader", "Cloud-Shaper", "Distant Light", "Friendly Current", "Tailwind",
		"Sun-Chaser", "Twilight-Gleaner", "Void-Singer", "Fledge", "Flock-Brother"
	)
	destination_names = list(
		"a Teshari enclave within Tiziran space",
		"a newly-charted system in the Sagittarius Transit",
		"a joint Teshari-Expeditionary Corps archeological dig",
		"a Teshari trade flotilla in the DMZ",
		"a Sirisai research habitat"
	)

/datum/lore/organization/mil/sol_armed_forces
	name = "Sol Federation Armed Forces"
	short_name = "SolFed Armed Forces"
	acronym = "SFAF"
	desc = "The unified, and often fractious, military of the Sol Federation. Born from the Unity Clique's ambitions and tempered in the fires of the Tiziran and Rimward Wars, the SFAF is a complex command structure balancing Federal regulars with vast numbers of specialized troops on loan from member states. It prioritizes space superiority above all else."
	work = "the unified defense of the Sol Federation"
	headquarters = "The Pentagon, Earth, Sol System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "military"
	ship_prefixes = list(
		"SFS" = "a picket",	   // Sol Federation Starfleet (Void Corps)
		"SFS" = "a patrol",	   // Sol Federation Starfleet (Void Corps)
		"SFS" = "an exploration", // Sol Federation Starfleet (Void Corps)
		"SFSG" = "a search and rescue", // Sol Federation Space Guard
		"SFSG" = "an anti-piracy",	  // Sol Federation Space Guard
		"SFV" = "an army transport",	// Sol Federation Void Corps (Espatiers/Army)
		"SFV" = "an assault carrier"	// Sol Federation Void Corps (Espatiers)
	)

	// Military ship names are aggressive, martial, and evoke power and legacy.
	ship_names = list(
		"Invincible", "Indomitable", "Resolute", "Dauntless", "Relentless",
		"Avenger", "Defiant", "Warspite", "Thunderchild", "Valor",
		"Conqueror", "Triumph", "Victorious", "Illustrious", "Formidable",
		"Implacable", "Revenant", "Nemesis", "Fury", "Onslaught",
		"Intrepid", "Courageous", "Glorious", "Superb", "Venerable",
		"Dreadnought", "Juggernaut", "Behemoth", "Leviathan", "Colossus",
		"Tempest", "Maelstrom", "Typhoon", "Hurricane", "Cyclone"
	)
	destination_names = list(
		"the SolFed DMZ with Tiziran space",
		"a Void Imperium border monitoring post",
		"a Unity Clique naval review",
		"a joint training exercise with a member state",
		"a Sagittarian Triumvirate fleet anchorage"
	)

/datum/lore/organization/mil/sagittarian_triumvirate_force
	name = "Sagittarian Triumvirate Defense Force"
	short_name = "Triumvirate Military"
	acronym = "STDF"
	desc = "The largest and most aggressive military within SolFed's southern frontier. The Triumvirate's forces are forged in the crucible of the genocidal Tiziran War and harbor a burning hatred for all things alien. They are the backbone of the Unity Clique, constantly pushing for a fully unified, militarized, and human-dominated galaxy."
	work = "the aggressive defense of the Sagittarian Triumvirate"
	headquarters = "Triumvirate Capital, Sagittarius Transit"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "military"
	ship_prefixes = list(
		"STV" = "an assault",	 // Sagittarian Triumvirate Vessel
		"STV" = "a siege",
		"STV" = "a vanguard",
		"STV" = "a planetary bombardment",
		"STV" = "a genocide denial",
		"STV" = "a border enforcement"
	)

	// Names are harsh, vengeful, and speak of fire, death, and human supremacy.
	ship_names = list(
		"Scorched Earth", "Atra'Kor's Bane", "Asl'Ton's Fall", "Lizard's Lament", "Xeno's Pyre",
		"Final Argument", "Total Victory", "Unrelenting Fury", "Extinction Event", "Humanity's Vanguard",
		"Firestorm", "Armageddon", "Retribution", "Vindicator", "Annihilator",
		"Shatterer of Moons", "Colonial Bane", "Last Charge", "Calculated Violence", "Cold Silence",
		"Righteous Wrath", "Justified Genocide", "Bleeding Edge", "No Quarter", "Undeniable Force",
		"Void Torch", "Star Killer", "World Ender", "Inferno", "Malice"
	)
	destination_names = list(
		"the DMZ with the Talunan Imperium",
		"a Unity Clique rally point",
		"a 're-education' camp for alien sympathizers",
		"a staging ground for an expeditionary force",
		"a secret military R&D lab focused on bioweapons"
	)

/datum/lore/organization/mil/helio_coalition_armed_forces
	name = "Heliostatic Coalition Armed Forces"
	short_name = "Coalition Forces"
	acronym = "HCAF"
	desc = "The unified, adaptive military of the Heliostatic Coalition. Unlike the SFAF, the HCAF is a truly integrated force built around the doctrine of Network-Centric Adaptive Dominance. Its strength lies not in a single branch, but in the seamless, AI-augmented coordination of its Starfleet, Integrated Tactical Forces, Aerospace Corps, and Special Operations."
	work = "the network-centric defense of the Heliostatic Coalition"
	headquarters = "Vistula, Zvirdnya System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "military"
	ship_prefixes = list(
		"HCV" = "a patrol",		  // (HSF)
		"HCV" = "a fleet defense",   // (HSF)
		"HCV" = "a rapid response",  // (HSF)
		"HCV" = "an orbital assault", // (ITF)
		"HCV" = "a logistics support", // (HLSC)
		"HCV" = "a special operations" // (HSOD)
	)

	ship_names = list(
		"Integrated Node", "Tactical Mesh", "Quantum Link", "Firewall", "Spoofed Signal",
		"Watchful Copilot", "Relentless Logic", "Adaptive Response", "Swarm's Conductor", "Predictive Edge",
		"Decentralized Command", "Fog of War Lifter", "Silent Synchronicity", "Unyielding Calculus", "System Superiority",
		"Ghost in the Machine", "Encrypted Vector", "Cognitive Overlord", "Uncanny Coordination", "Perfect Formation",
		"Vistula's Shield", "Zvirdnya's Sword", "Eerie Silence", "Data Fortress", "Operational Pause",
		"Ethical Calculus", "Deterrence by Demonstration", "Non-Lethal Suppression", "Precision Strike", "Logistics Chain"
	)
	destination_names = list(
		"the Unified High Command, Vistula",
		"a KMIF orbital testing facility",
		"a classified ITN relay station",
		"a joint training exercise with EPF patrols",
		"the Rimward DMZ monitoring post"
	)

/datum/lore/organization/mil/expeditionary_police_force
	name = "Heliostatic Coalition Expeditionary Police Force"
	short_name = "Expeditionary Police"
	acronym = "EPF"
	desc = "The Coalition's long arm in the dark: part police, part first contact, part stabilization force. Born from a 'No Help Coming' philosophy, the EPF operates heavily-armed patrol ships far beyond Coalition borders, finding lost colonies, suppressing pirates, and building walls of stability. Their default mission is to help, but their capacity for violence is absolute."
	work = "expeditionary law enforcement and stabilization"
	headquarters = "Fleet Tender 'Long Arm', Mobile Position"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "system defense" // Their role is wide-ranging but fundamentally about defense and order.
	ship_prefixes = list(
		"EPV" = "a patrol",
		"EPV" = "a first contact",
		"EPV" = "a stability",
		"EPV" = "a search and rescue",
		"EPV" = "a counter-piracy"
	)


	ship_names = list(
		"Unbroken Wall", "Last Stand", "Watchful Silence", "Long Arm", "Dark Blue Horizon",
		"No Help Coming", "Stabilizer", "Peacemonger", "Fact Finder", "Jurisdiction",
		"Due Process", "Measured Response", "Good Samaritan", "Stalwart Patrolman", "Reflective Shield",
		"Point of Order", "Gavel's Fall", "Arbiter", "Mediator", "Overseer",
		"Sentry", "Guardian", "Sentinel", "Monolith", "Rule of Law",
		"Consensus", "Civil Order", "Polite Negotiation", "Prepared Force", "White Rectangle"
	)
	destination_names = list(
		"an uncharted deep space signal source",
		"a struggling new colony",
		"a suspected pirate haven",
		"a derelict generation ship",
		"a routine check-in with a fledgling local militia"
	)

/datum/lore/organization/mil/tiziran_service
	name = "Talunan Imperium Defense Forces"
	short_name = "Tiziran Military"
	acronym = "TIDF"
	desc = "The decentralized, compulsory defense forces of the Talunan Imperium. Every Tiziran serves, blurring the line between civilian and soldier. From the elite Cataphracts in their combat hardsuits to the voidfaring Rangers and the reconstruction-focused Sappers, the Tiziran military is a hardened instrument of survival, honed by apocalyptic war and motivated by racial trauma."
	work = "the survival and defense of the Tiziran people"
	headquarters = "The Command Ward, Tizira"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "military"
	ship_prefixes = list(
		"TIV" = "a patrol",	   // Talunan Imperium Vessel
		"TIV" = "a Ranger patrol",
		"TIV" = "a Sapper salvage", // Often double as military transports
		"TIV" = "an Expeditionary Corps",
		"TIV" = "a Cataphract assault"
	)

	// Names revolve around tides, vengeance, hard service, and the broken moon.
	ship_names = list(
		"Atra'Kor's Shard", "Lunar Grief", "Tide of Vengeance", "Asl'Ton's Fury", "Kor'Taku's Silence",
		"Gladiator's Spirit", "Tunnel Fighter", "Sandblasted", "Refugee's Resolve", "Warden's Watch",
		"Cataphract's Hammer", "Ranger's Long Gaze", "Sapper's Endurance", "Expeditionary Hope", "No Step Back",
		"Bioluminescent Mark", "Nala's Fangs", "Dark Side of the Moon", "Arid Tomb", "Spirit of Zag'Skol",
		"Scavenger of Hope", "The Long War", "Endless Vigil", "Mutual Aid", "Duty's Bond",
		"Fragile Armistice", "Fog of War", "Cave Hearth", "Cycle of Reprisal", "The Bleeding Lagoon"
	)
	destination_names = list(
		"the DMZ patrol line",
		"a Teshari Confederations joint training hub",
		"a Sapper Corps orbital debris-clearing operation",
		"a Ranger Corps forward listening post",
		"the Cataphract Trial Grounds on Tizira"
	)

// --- SolFed Sub-Factions ---

/datum/lore/organization/civ/solfed_core
	name = "SolFed Core Worlds"
	short_name = "Core Worlds"
	acronym = "SFC"
	desc = "Civilian vessels from the wealthy, developed, and politically dominant systems at the heart of the Federation like Earth, Mars, and Enkai. Their traffic is a mix of luxury liners, high-end trade, and sophisticated research expeditions."
	work = "civilian transport, commerce, and research"
	headquarters = "Geneva, Earth, Sol System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "civilian"
	ship_prefixes = list("SSV" = "a civilian") // Sol System Vessel
	ship_names = list(
		"Starlight Express", "Coreward Dream", "Pristine", "Executive Suite", "Nova Roma",
		"Old Money", "Prestige", "High Society", "Ivory Tower", "Patent Pending",
		"First Edition", "Antique", "Heirloom", "Luxury Liner", "Philanthropist",
		"Vineyard of the Stars", "Cosmopolitan", "Fine Art", "Cultural Export", "Symphony"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/solfed_frontier
	name = "SolFed Frontier Settlers"
	short_name = "Frontier Settlers"
	acronym = "SFF"
	desc = "The ramshackle, hopeful, and often desperate ships of those pushing the boundaries of Federation space. This includes independent colonists, wildcat miners, and scrappy freighters trying to carve out a life far from the safety of the Core."
	work = "frontier colonization and trade"
	headquarters = "Local SolFed Frontier Center"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "civilian"
	ship_prefixes = list("SSV" = "an independent")
	ship_names = list(
		"Dust Runner", "Claim Jumper", "Rust Bucket", "Long Shot", "Patchwork",
		"Second Mortgage", "Homesteader", "Gambler's Ruin", "Last Gasp", "Tin Can",
		"Wildcat", "Stubborn Mule", "High Risk", "No Insurance", "Jury-Rigged",
		"Debt Collector", "Stowaway", "New Beginnings", "Bold Venture", "Used Spacer"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/libraen_federation
	name = "Libraen Federation Shipping"
	short_name = "Libraen Shipping"
	acronym = "LFS"
	desc = "Civilian vessels of the Libraen Federation, one of SolFed's largest and most imperialistic members. This traffic represents the core systems' corporate-backed trade and the exploited, resource-rich ships from their periphery, all flying the same flag."
	work = "imperial commerce and resource extraction"
	headquarters = "Librae System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "corporate" // Even the 'civilian' traffic is heavily corporate
	ship_prefixes = list("LFS" = "a cargo")
	ship_names = list(
		"Imperial Prosperity", "Core World Benefactor", "Peripheral Resource", "Colonial Dividend", "System Oversight",
		"Trade Mandate", "Supply Chain", "Market Share", "Libraen Standard", "Metropole",
		"Hinterland Hauler", "Tariff Buster", "Sharecropper", "Company Store", "Loyalist",
		"Subsidy", "Patronage", "Political Contribution", "Lobbyist", "Surplus Value"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/enkai_republic
	name = "Republic of Enkai Civil Traffic"
	short_name = "Enkai Republic"
	acronym = "ERC"
	desc = "Stalwart defenders of small nations and prominent members of the Frontier Clique, Enkai's civilian ships are known for their efficiency, resilience, and focus on mutual trade between smaller member states."
	work = "small state diplomacy and trade"
	headquarters = "Enkai System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "civilian"
	ship_prefixes = list("ERV" = "a trade")
	ship_names = list(
		"Independent Spirit", "Small But Strong", "Coalition Builder", "Frontier Voice", "Defender of Rights",
		"Mutual Exchange", "Good Neighbor", "Bargaining Chip", "Fair Deal", "Underdog",
		"Pragmatist", "Level Playing Field", "Compromise", "Arbitrator", "Tie-Breaker",
		"Swing Vote", "Home Rule", "Conscientious Objector", "Neutral Ground", "Peace Broker"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/tsogyal_republic
	name = "Tsogyal Republic Plasma Fleet"
	short_name = "Tsogyal Republic"
	acronym = "TSC"
	desc = "The merchant fleet of the Tsogyal Republic, the largest singular producer of plasma in SolFed. Their vessels, often heavily guarded, are the lifeblood of human industry. Led by the Plasma Clique, they meticulously control supply to keep prices stable and their influence vast."
	work = "plasma extraction, refinement, and controlled distribution"
	headquarters = "Tsogyal System"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "corporate"
	ship_prefixes = list("TRV" = "a plasma transport")
	ship_names = list(
		"Monopoly", "Stable Price", "Market Manipulator", "Anomaly Harvester", "Refined Profit",
		"Volatile Cargo", "Strategic Reserve", "Energy Dominance", "Controlled Flow", "Supply Quota",
		"Cartel's Grasp", "Price Fixer", "Barrel of Oil", "Liquid Power", "Core Dependency",
		"Burn Bright", "Endless Supply", "Rare Element", "Cornered Market", "Silent Partner"
	)
	append_ship_names = TRUE

// --- Heliostatic Coalition Sub-Factions ---

/datum/lore/organization/civ/czd
	name = "Commonwealth of Zvirdnym Dominions Civil Traffic"
	short_name = "CZD Civilian"
	acronym = "CZT"
	desc = "The merchant and passenger ships of the Coalition's central pillar. This traffic reflects the CZD's culture of procedural stability, high-precision manufacturing, and deep-rooted governance, carrying everything from luxury cultural works to precision fusion drive components."
	work = "civilian logistics and commerce"
	headquarters = "Vistula, Zvirdnya System"
	motto = "Stewardship and Prosperity"
	autogenerate_destination_names = TRUE

	org_type = "civilian"
	ship_prefixes = list("CZV" = "a civilian")
	ship_names = list(
		"Vistula", "Danube", "Volga", "Tien Shan", "Ural",
		"Warsaw", "Krakow", "Prague", "Vilnius", "Sofia",
		"Carpathian", "Pripet", "Amur", "Bespoke Component", "Precision Casting",
		"Cultural Archive", "Symphonic Movement", "Guild Charter", "Ballet Russe", "System Integrity",
		"Long-Term Plan", "Procedural Purity", "Mutual Advancement", "Ethical Bureaucracy", "Bread & Salt"
	)
	append_ship_names = FALSE // We want to specify a completely new set for variety.

/datum/lore/organization/civ/kmif
	name = "KMIF Civilian Logistics Fleet"
	short_name = "KMIF Logistics"
	acronym = "KLOG"
	desc = "The civilian-flagged logistics arm of Kemppainen-Morozov Industrial Fabrication. While KMIF proper has no logo, these ships are a \
	stark white with green accents. They run with terrifying, dispassionate efficiency, moving raw materials and finished industrial goods on \
	mathematically perfect routes."
	work = "optimized industrial logistics"
	headquarters = "Foundry-World, \[REDACTED\] System"
	motto = "Optimizing."
	autogenerate_destination_names = TRUE

	org_type = "corporate"
	ship_prefixes = list("KML" = "a logistics")
	ship_names = list(
		"Efficiency", "Output", "Throughput", "Redundancy", "Optimization",
		"Tungsten-Carbide", "Supply Surplus", "Demand Forecast", "Just-In-Time", "Zero Waste",
		"Cycle Time", "Logistics Node", "Inventory Turn", "Material Flow", "Predictive Model",
		"Process Control", "Scalable Solution", "Tolerance 0.01", "Frictionless Exchange", "Joyless Sudoku"
	)
	append_ship_names = TRUE

// --- Talunan Imperium Sub-Factions ---

/datum/lore/organization/civ/talunan_civil
	name = "Talunan Imperium Civil Traffic"
	short_name = "Tiziran Civilian"
	acronym = "TCT"
	desc = "The civilian ships of the Talunan Imperium. These vessels, often community-owned by Wards, handle the day-to-day business of survival: moving food, water, and materials between habitats, tending the fragile ecosystems on Tizira, and facilitating the reconstruction of their shattered civilization."
	work = "post-war reconstruction and internal trade"
	headquarters = "Tizira"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "civilian"
	ship_prefixes = list("TIV" = "a Ward", "TIV" = "a civilian")
	// Names for Tiziran civilian ships focus on community, healing, nature, and daily life.
	ship_names = list(
		"Hearthfire", "Fog-Tender", "Water Bearer", "Spore-Planter", "Reef-Keeper",
		"Mutual Harvest", "Neighbor's Aid", "Orphan's Ship", "Veteran's Rest", "Commemoration",
		"Biolume Garden", "Sand-Sail", "Nata's Burrow", "Koo's Fuzz", "Wesbona Bloom",
		"Shared Bowl", "Broken Sky Memorial", "Healing Wing", "Always Together", "Tidal Promise",
		"Candle in the Cave", "Second Weaving", "Lagan of the War", "New Growth", "Stubborn Hope"
	)
	append_ship_names = TRUE

// --- Tajaran Empire Sub-Factions ---

// Outer Houses
/datum/lore/organization/civ/house_morikann
	name = "House Morikann Corsair Fleet"
	short_name = "House Morikann"
	acronym = "HMC"
	desc = "The jovial, terrifying privateers and mariners of House Morikann. Operating under cloaking fields and barraging engines, Morikann ships are 'coastal raiders' for the Empire, known for their war masks and wicked laughter. Even their 'civilian' vessels are heavily armed."
	work = "imperial privateering"
	headquarters = "Salnai, the Never Land"
	motto = "" // "Laugh as you take."
	autogenerate_destination_names = TRUE

	org_type = "pirate"
	ship_prefixes = list("MCV" = "a raider") // Morikann Corsair Vessel
	ship_names = list(
		"Wicked Laughter", "Fourfold Dagger", "Cloaked Fangs", "Right Half", "Salnai's Wake",
		"Double-Gun", "Fat One's Gambol", "War Mask", "Jovial Raider", "Barraging Engine",
		"Sneaky Claw", "Surprise Inspection", "Cargo Redistributor", "Your Ship Is Ours", "Friendly Pirate",
		"Dread Pirate's Chuckle", "Sea Wolf", "Mariner's Jest", "Not Face, Not Heart", "Amber Wake"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/house_ussirune
	name = "House Ussirune Mercantile Fleet"
	short_name = "House Ussirune"
	acronym = "HUM"
	desc = "The silver-tongued merchants and drug-dealers of House Ussirune. These are the Empire's primary external traders, known for their metallic fur-like ship finishes, pipes full of psychoactive smoke, and contracts so labyrinthine they can trap a customer's entire bloodline."
	work = "interstellar trade and commerce"
	headquarters = "Istrover"
	motto = "" // "The contract is written on the wind... and it's binding."
	autogenerate_destination_names = TRUE

	org_type = "corporate"
	ship_prefixes = list("UMV" = "a trade") // Ussirune Merchant Vessel
	ship_names = list(
		"Gilded Contract", "Silver Tongue", "Smoke & Mirrors", "Fast Talker", "Metallic Fur",
		"Istrover Lounge", "Fine Print", "Market Dominator", "Exotic Import", "Cosmic Casino",
		"Dream Peddler", "Pipe Dream", "Smooth Transaction", "Liquid Asset", "The Middleman",
		"Open Bazaar", "Always A Catch", "Southern Mountain's Haze", "Kronkaine Express", "Trade Wind"
	)
	append_ship_names = TRUE

// Inner Houses
/datum/lore/organization/civ/house_astameur
	name = "House Astameur Luxury Fleet"
	short_name = "House Astameur"
	acronym = "HAV"
	desc = "The opulent, gossiping vessels of the former Emperor's harem. House Astameur ships are flying displays of Face, carrying haute couture, rare fragrances, socialites, and advisors across the Empire and beyond. They are the masters of soft power."
	work = "luxury goods and social influence"
	headquarters = "Sublirel, the Autumn's End"
	motto = "" // "Elegance is the sharpest blade."
	autogenerate_destination_names = TRUE

	org_type = "corporate"
	ship_prefixes = list("AMV" = "a diplomatic") // Astameur Mission Vessel
	ship_names = list(
		"Haute Couture", "Whore of Sublirel's Favor", "Delicate Scent", "Wingman", "Parlor-Boutique",
		"Aesthetic Pilgrim", "Super-light Chainmail", "Puppet's Strings", "Socialite", "Unspoken Gossip",
		"Fashion Plate", "Endangered Fur", "Midnight Salon", "Mirror Ball", "Fragrant Thorn",
		"Faux Pas", "Twin Hearts' Dance", "Stolen Glance", "Charm Offensive", "Autumn's End Dandy"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/house_verikami
	name = "House Verikami Hospital & Agriculture Fleet"
	short_name = "House Verikami"
	acronym = "HVM"
	desc = "The 'Heartsick' but generous farmers and doctors of House Verikami. Their stout ships are a network of hospital-tenders and agricultural transports, feeding the Empire with Three Rings cuisine and healing its wounds with traditional medicine. Cross them at your absolute peril."
	work = "agricultural logistics and medical services"
	headquarters = "Sorocan"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "civilian"
	ship_prefixes = list("VMV" = "a medical")
	ship_names = list(
		"Three Rings", "Healing Paw", "Sorocan Harvest", "Farmers' Market", "Riding Stable",
		"Well-Worn Scalpel", "Heartsick Remedy", "Corsair's Clinic", "Traditional Cure", "Herbalist",
		"Soup Kitchen", "Emergency Grain", "Gentle Bandage", "Fever Break", "Rural Route",
		"Nourishment", "Rest & Recovery", "Doctor's Orders", "Azelas' Wrath", "Stubborn, Not Stupid"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/house_parigari
	name = "House Parigari Research & Tech Fleet"
	short_name = "House Parigari"
	acronym = "HPV"
	desc = "The mad scientists and tech-hoarders of the Empire. House Parigari ships are mobile laboratories and \"archaeological\" vessels devoted to stealing and reverse-engineering alien technology. From Solarian robots to Ordoth drives, nothing is safe from their grasp."
	work = "technological acquisition and research"
	headquarters = "Sheneocrye, The Iron Sanctuary"
	motto = ""
	autogenerate_destination_names = TRUE

	org_type = "research"
	ship_prefixes = list("PRV" = "a research")
	ship_names = list(
		"Iron Sanctuary", "Lord of Thunder's Fist", "Stolen Genius", "Reverse Engineering", "Forbidden Blueprint",
		"Spark of Innovation", "Electric Dreams", "Holographic Thread", "Plundered Codex", "Technophage",
		"Bluespace Sniffer", "Particle Deconstructor", "Eureka", "Forge Fire", "Prototype",
		"Anomalous Acquisition", "Tajara Science", "Borrowed Component", "Scrapyard Prospector", "Innovator"
	)
	append_ship_names = TRUE

/datum/lore/organization/civ/house_toragana
	name = "House Toragana Shipwright & Mason Fleet"
	short_name = "House Toragana"
	acronym = "HTM"
	desc = "The grand architects and stoic builders of the Empire. Toragana ships are themselves masterpieces of construction, often moving massive prefabricated components for monumental buildings or acting as deep-space drydocks for their peerless warships."
	work = "starship construction and monumental architecture"
	headquarters = "Hyldetan, the Wonder Moon"
	motto = "" // "Build to last an empire."
	autogenerate_destination_names = TRUE

	org_type = "corporate"
	ship_prefixes = list("TMV" = "a construction")
	ship_names = list(
		"Wonder Moon", "Shipmaster's Chisel", "Grand Proposal", "Cathedral of the Void", "Golden Badge",
		"Stonemason", "Bilateral Symmetry", "Guilded Arch", "Nine Gates", "Starlight Forge",
		"Figurehead", "Monument Builder", "Artisan's Pride", "Shipwright's Dream", "Enduring Mortar",
		"Megastructure", "Grand Bulwark", "Cosmic Keystone", "Dreadnought's Shell", "Hyldetan Time Capsule"
	)
	append_ship_names = TRUE

// The Seventh House
/datum/lore/organization/civ/house_fendrinth
	name = "House Fendrinth Mercenary Fleet"
	short_name = "The Seventh House"
	acronym = "HFV"
	desc = "The grim, hated, and necessary warriors of the Seventh House. Flying vessels that are part warship, part tomb, they are the Empire's executioners. They are called upon quietly by all other Houses to do the killing that needs doing. Their crews, sometimes hemophage Tajara, seek only to reclaim their lost honor."
	work = "mercenary extermination"
	headquarters = "Vajharji, the Netherworld"
	motto = "" // Silence.
	autogenerate_destination_names = TRUE

	org_type = "mercenary"
	ship_prefixes = list("SVM" = "a mercenary") // Seventh Vessel, Mercenary
	ship_names = list(
		"Bleeding Heart of Guilt", "Gilded Wraith", "Executioner", "Last Loyalty", "Netherworlder",
		"Hibernating Valley", "Hemophage's Chalice", "Disgraced Gold", "Silent Duty", "Unclean Task",
		"Mercenary Oath", "The Deniable", "Tarnished Armor", "Dishonored", "Fendrinth's Burden",
		"Empty Throne", "Whispered Contract", "Shadow of the Six", "Pollale Survivor", "Vajharji's Gift"
	)
	append_ship_names = TRUE
