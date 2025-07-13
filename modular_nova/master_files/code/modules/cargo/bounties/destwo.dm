
// Goals for all of DS-2

/datum/bounty/item/ds2/
	reward = CARGO_CRATE_VALUE * 5

/datum/bounty/item/ds2/handcuffs
	name = "Interrogation Blacksite"
	description = "Upper members of MI13 wants more handcuffs to be disbatched out. Send some our way."
	required_count = 5
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(
		/obj/item/restraints/handcuffs = TRUE,
	)

/datum/bounty/item/ds2/eyes
	name = "Eye-Spy"
	description = "Asssault teams in the Gorlex Marauders want some, thermal cybereyes. Send some their way and they'll pay nicely"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/eyes/robotic/thermals = TRUE,
	)

/datum/bounty/item/ds2/skillchip
	name = "Cyberdeck"
	description = "Cybersun wants some CNS skillchip connector implants, for a couple of tests. You know what the drill is."
	required_count = 4
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(
		/obj/item/organ/cyberimp/brain/connector = TRUE,
	)

/datum/bounty/item/ds2/tape
	name = "Special Uses"
	description = "M13 Wants some super pointy tape. Get some to them and they'll stop botherin ya"
	required_count = 3
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/stack/sticky_tape/pointy/super = TRUE,
	)

/datum/bounty/item/ds2/gambling
	name = "Recreational use"
	description = "DS-9 is not perticularly happy that their last few slot machines were broken by an NT raid. Mind sendin em some? Its driving the crew mad."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/circuitboard/computer/slot_machine = TRUE,
	)

/datum/bounty/item/ds2/aichallenge
	name = "Kernal Level Executions"
	description = "SELF wants you to send over a few, AI Core Boards, they're planning on adding some special executables."
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
	name = "Prokect Spiteful Gods"
	description = "We need you to send a gunkit... a special one called the Event Horizon anti-existential beam rifle part kit, its a mouth filler, but... best you dont ask why."
	reward = CARGO_CRATE_VALUE * 20
	wanted_types = list(
		/obj/item/firing_pin/clown = TRUE,
	)

/datum/bounty/item/ds2/clandestine
	name = "Clandestine Operations"
	description = "MI13 wants a couple of suppressors for our more clandestine frontline agents. Send em and they'll pay nicely."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/suppressor = TRUE,
	)

/datum/bounty/item/ds2/mindcrack
	name = "Project Mindcrack"
	description = "Gorlex wants a few mindshield firing pins for modification, they wont take any other pin. Mainly because they think they can rewire them to work for us."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/firing_pin/implant/mindshield = TRUE,
	)

/datum/bounty/item/ds2/battleship
	name = "Battleship Blitz"
	description = "A recent 'project' perse has taken a fair chunk of our attention, send us a few communications boards so we may wire them into our vessels"
	required_count = 3
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/circuitboard/computer/communications = TRUE,
	)

/datum/bounty/item/ds2/coffee
	name = "Coffee meltdown"
	description = "A recent incident left all the coffee makers broken back on DS-5, D-6 and, DS-7... We're not sure how, but just send them a few boards and they'll get it done."
	required_count = 3
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/circuitboard/machine/coffeemaker = TRUE,
	)
