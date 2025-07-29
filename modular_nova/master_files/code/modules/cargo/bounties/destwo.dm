// Goals for all of DS-2

/datum/bounty/item/ds2
	reward = CARGO_CRATE_VALUE * 5

/datum/bounty/item/ds2/handcuffs
	name = "Interrogation Blacksite"
	description = "Upper members of MI13 wants more handcuffs to be dispatched out to a local Blacksite. Send some their way."
	required_count = 5
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(
		/obj/item/restraints/handcuffs = TRUE,
	)

/datum/bounty/item/ds2/eyes
	name = "Eye-Spy"
	description = "Asssault teams in the Gorlex Marauders want some thermal cybereyes. Send some their way and they'll pay nicely."
	reward = CARGO_CRATE_VALUE * 8
	required_count = 3
	wanted_types = list(
		/obj/item/organ/eyes/robotic/thermals = TRUE,
	)

/datum/bounty/item/ds2/skillchip
	name = "Cyberdeck"
	description = "Cybersun wants some CNS skillchip connector implants for a couple of tests. You know what the drill is, send some their way."
	required_count = 4
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(
		/obj/item/organ/cyberimp/brain/connector = TRUE,
	)

/datum/bounty/item/ds2/tape
	name = "Special Uses"
	description = "MI13 wants some super pointy tape. Get some to them so they'll stop bothering us about it."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/stack/sticky_tape/pointy/super = TRUE,
	)

/datum/bounty/item/ds2/gambling
	name = "Recreational Use"
	description = "DS-9 is not particularly happy that their last few slot machines were broken in an NT raid. Mind sending them some new boards? The crew are going mad without their gambling fix."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/circuitboard/computer/slot_machine = TRUE,
	)

/datum/bounty/item/ds2/aichallenge
	name = "Kernel Level Executions"
	description = "SELF wants you to send over a few AI Core Boards, to which they plan on adding some special executables."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/circuitboard/aicore = TRUE,
	)

/datum/bounty/item/ds2/clownops
	name = "CLOWNING AROUND"
	description = "A few of our more hilarious operatives lost their hilarious firing pins. just... dont ask."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 50
	wanted_types = list(
		/obj/item/firing_pin/clown = TRUE,
	)

/datum/bounty/item/ds2/randomgods
	name = "Project Spiteful Gods"
	description = "We need you to send a gunkit... a special one called the Event Horizon anti-existential beam rifle part kit. Name's a tongue-twister, but... best you don't ask why we need it."
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/weaponcrafting/gunkit/beam_rifle = TRUE,
	)

/datum/bounty/item/ds2/clandestine
	name = "Clandestine Operations"
	description = "MI13 wants a couple of suppressors for our more clandestine frontline agents. Send em and they'll pay nicely."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(
		/obj/item/suppressor = TRUE,
	)

/datum/bounty/item/ds2/mindcrack
	name = "Project Mindcrack"
	description = "Gorlex wants a few mindshield firing pins for modification, to hopefully rewire to work for us. They won't take any other firing pin."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(
		/obj/item/firing_pin/implant/mindshield = TRUE,
	)

/datum/bounty/item/ds2/battleship
	name = "Battleship Troubles"
	description = "A recent 'project', per se, has recently taken a fair chunk of our attention... Send us a few communications console boards so we may wire them into our vessels."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/circuitboard/computer/communications = TRUE,
	)

/datum/bounty/item/ds2/coffee
	name = "Coffee Meltdown"
	description = "A recent incident left all the coffee makers broken back on DS-5, D-6 and, DS-7... We're not sure how they broke, but just send them a few new boards and they'll get them repaired."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/circuitboard/machine/coffeemaker = TRUE,
	)

/datum/bounty/item/ds2/flashes
	name = "Hypnoflashes"
	description = "A few of our frontliners and friends at the IRN lost a few hypnoflashes, send them a few new flashes to modify and they'll reward you a fair payment."
	required_count = 10
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/assembly/flash/handheld = TRUE,
	)

/datum/bounty/item/ds2/cyberpens
	name = "Legal Efforts"
	description = "Cybersun ran out of materials for their... 'Specialty' pens and it's now your problem to fix. Get them a couple of pens so they can make more."
	required_count = 10
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/pen = TRUE,
	)

/datum/bounty/item/ds2/pizzabombs
	name = "Pizza Bombs"
	description = "We had a situation with a recent raid from an unfavorable corporation, they blew up our pizza line so we need you to send some. Give us a few and we'll send a payment to you. \
		And send whole pies. If we get slices, someone is getting fired."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/food/pizza = TRUE,
	)

/datum/bounty/item/ds2/telecrystals
	name = "Telecrystals"
	description = "Our crystal synthesizers seem to malfunctioning, send us a couple bluespace crystals and we'll secure you a paycheck."
	required_count = 5
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/stack/ore/bluespace_crystal = TRUE,
	)

/datum/bounty/item/ds2/toolboxes
	name = "Toolboxes"
	description = "We've ran out of suspicious toolboxes, send us a few regular toolboxes and you will be paid."
	required_count = 5
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/storage/toolbox = TRUE,
	)

/datum/bounty/item/ds2/dafuckindisk
	name = "DAT FUKKEN DISK"
	description = "Gorlex ran out of data disks for their nuclear tunes, send them a few disks and you will be paid. Make sure it's specifically Data Disks for computers, not DNA."
	required_count = 5
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/computer_disk = TRUE,
	)
