#define RND_SUBCATEGORY_MACHINE_XENOARCH "/Xenoarchaeology Machinery"
#define RND_SUBCATEGORY_EQUIPMENT_XENOARCH "/Xenoarchaeology Equipment"
#define RND_SUBCATEGORY_TOOLS_XENOARCH "/Xenoarchaeology Tools"
#define RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED "/Xenoarchaeology Tools (Advanced)"

/datum/design/xenoarch
	abstract_type = /datum/design/xenoarch
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT,
	)

/datum/design/xenoarch/tool
	abstract_type = /datum/design/xenoarch/tool
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_XENOARCH,
	)

/datum/design/xenoarch/tool/hammer
	name = "Hammer (cm 1)"
	desc = "A hammer that can slowly remove debris on strange rocks."
	build_path = /obj/item/xenoarch/hammer

/datum/design/xenoarch/tool/hammer/cm2
	name = "Hammer (cm 2)"
	build_path = /obj/item/xenoarch/hammer/cm2

/datum/design/xenoarch/tool/hammer/cm3
	name = "Hammer (cm 3)"
	build_path = /obj/item/xenoarch/hammer/cm3

/datum/design/xenoarch/tool/hammer/cm4
	name = "Hammer (cm 4)"
	build_path = /obj/item/xenoarch/hammer/cm4

/datum/design/xenoarch/tool/hammer/cm5
	name = "Hammer (cm 5)"
	build_path = /obj/item/xenoarch/hammer/cm5

/datum/design/xenoarch/tool/hammer/cm6
	name = "Hammer (cm 6)"
	build_path = /obj/item/xenoarch/hammer/cm6

/datum/design/xenoarch/tool/hammer/cm10
	name = "Hammer (cm 10)"
	build_path = /obj/item/xenoarch/hammer/cm10

/datum/design/xenoarch/tool/brush
	name = "Brush"
	desc = "A brush that can slowly remove debris on a strange rock."
	build_path = /obj/item/xenoarch/brush

/datum/design/xenoarch/tool/xeno_tape
	name = "Xenoarch Tape Measure"
	desc = "A tape measure used to measure the dug depth of strange rocks."
	build_path = /obj/item/xenoarch

/datum/design/xenoarch/tool/scanner
	name = "Xenoarch Handheld Scanner"
	desc = "A handheld scanner for strange rocks, capable of tagging a \"safe\" depth and maximum depth."
	build_path = /obj/item/xenoarch/handheld_scanner

/datum/design/xenoarch/tool/stabilizer
	name = "Xenoarch Artifact Stabilizer"
	desc = "An outdated tech to stabilize boulders."
	build_path = /obj/item/xenoarch/anomaly_stabilizer
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/xenoarch/tool/core_sampler
	name = "Core Sampler"
	desc = "An outdated way to take a sample of rocks and dirt."
	build_path = /obj/item/xenoarch/core_sampler
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/xenoarch/tool/particles_battery
	name = "Exotic particles power battery"
	desc = "A battery, that can collect exotic particles and release them later, if used properly."
	build_path = /obj/item/xenoarch/particles_battery
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/xenoarch/tool/xenoarch_utilizer
	name = "Exotic particles power utilizer"
	desc = "A device used to discharge exotic particle batteries."
	build_path = /obj/item/xenoarch/xenoarch_utilizer
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/xenoarch/tool/wave_scanner_backpack
	name = "Wave scanner backpack"
	desc = "An outdated way to find exotic particles."
	build_path = /obj/item/xenoarch/wave_scanner_backpack
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/xenoarch/tool/advanced
	abstract_type = /datum/design/xenoarch/tool/advanced
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2 ,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 4,
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED,
	)

/datum/design/xenoarch/tool/advanced/scanner
	name = "Xenoarch Advanced Handheld Scanner"
	build_path = /obj/item/xenoarch/handheld_scanner/advanced

/datum/design/xenoarch/tool/radar
	name = "Xenoarch Handheld Radar"
	desc = "A device with the capabilities to recover items lost due to time."
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/xenoarch/handheld_radar

/datum/design/xenoarch/tool/advanced/adv_hammer
	name = "Advanced Hammer"
	desc = "A hammer that can quickly remove debris on a strange rock and change digging depths."
	build_path = /obj/item/xenoarch/hammer/adv

/datum/design/xenoarch/tool/advanced/adv_brush
	name = "Advanced Brush"
	desc = "A brush that can quickly remove debris on a strange rock."
	build_path = /obj/item/xenoarch/brush/adv

/datum/design/xenoarch/equipment
	abstract_type = /datum/design/xenoarch/equipment
	// everything under this except the adv bag feels redundant because cloth/leather are there too
	// but i guess we'll burn that bridge another time
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_XENOARCH,
	)

/datum/design/xenoarch/equipment/bag
	name = "Xenoarchaeology Bag"
	desc = "A bag that can hold about twenty-five strange rocks."
	build_path = /obj/item/storage/bag/xenoarch

/datum/design/xenoarch/equipment/belt
	name = "Xenoarchaeology Belt"
	desc = "A belt that can hold all of the essential tools for xenoarchaeology."
	build_path = /obj/item/storage/belt/utility/xenoarch

/datum/design/xenoarch/equipment/bag_adv
	name = "Advanced Xenoarch Bag"
	desc = "A bag that can hold about fifty strange rocks."
	materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT * 2.5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5) // same materials as the mining bag of holding.
	build_path = /obj/item/storage/bag/xenoarch/adv

/datum/design/board/xenoarch
	abstract_type = /datum/design/board/xenoarch
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_XENOARCH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xenoarch/researcher
	name = "Xenoarch Researcher Board"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch researcher."
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/xenoarch/scanner
	name = "Xenoarch Scanner Board"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch scanner."
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/xenoarch/artifact_analyzer
	name = "Artifact Analyzer Board"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch artifact analyzer."
	build_path = /obj/item/circuitboard/machine/artifact_analyser

/datum/design/board/xenoarch/radiocarbon_spectrometer
	name = "Radiocarbon spectrometer Board"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch radiocarbon spectrometer."
	build_path = /obj/item/circuitboard/machine/radiocarbon_spectrometer

/datum/design/board/xenoarch/artifact_harvester
	name = "Exotic Particle Harvester Board"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch exotic particle harvester."
	build_path = /obj/item/circuitboard/machine/artifact_harvester

/datum/design/board/xenoarch/artifact_scanpad
	name = "Artifact Scanpad Board"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch artifact scanpad."
	build_path = /obj/item/circuitboard/machine/artifact_scanpad

/datum/design/board/xenoarch/digger
	name = "Xenoarch Digger Board"
	desc = "Allows for the construction of circuit boards used to build a new xenoarch digger."
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE

/datum/techweb_node/basic_xenoarch
	node_flags = TECHWEB_NODE_STARTER | TECHWEB_NODE_WIKI
	display_name = "Basic Xenoarchaeology"
	description = "The basic designs of xenoarchaeology."
	unlocked_designs = list(
		/datum/design/xenoarch/tool/hammer,
		/datum/design/xenoarch/tool/hammer/cm2,
		/datum/design/xenoarch/tool/hammer/cm3,
		/datum/design/xenoarch/tool/hammer/cm4,
		/datum/design/xenoarch/tool/hammer/cm5,
		/datum/design/xenoarch/tool/hammer/cm6,
		/datum/design/xenoarch/tool/hammer/cm10,
		/datum/design/xenoarch/tool/brush,
		/datum/design/xenoarch/tool/xenoarch_utilizer,
		/datum/design/xenoarch/tool/xeno_tape,
		/datum/design/xenoarch/tool/scanner,
		/datum/design/xenoarch/tool/wave_scanner_backpack,
		/datum/design/xenoarch/tool/core_sampler,
		/datum/design/xenoarch/tool/particles_battery,
		/datum/design/xenoarch/tool/stabilizer,
		/datum/design/xenoarch/equipment/belt,
		/datum/design/xenoarch/equipment/bag,
		/datum/design/xenoarch/tool/radar,
		/datum/design/board/xenoarch/researcher,
		/datum/design/board/xenoarch/scanner,
	)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SERVICE, RADIO_CHANNEL_SUPPLY)

/datum/techweb_node/xenoarch_machines
	display_name = "Xenoarchaeology Machines"
	description = "Sometimes, xenoarchaeology can be time consuming, perhaps machines can help?"
	prerequisite_nodes = list(/datum/techweb_node/basic_xenoarch)
	unlocked_designs = list(
		/datum/design/board/xenoarch/artifact_analyzer,
		/datum/design/board/xenoarch/artifact_scanpad,
		/datum/design/board/xenoarch/artifact_harvester,
		/datum/design/board/xenoarch/radiocarbon_spectrometer,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/adv_xenoarch
	display_name = "Advanced Archeology"
	description = "After some time, those tools we used have become antiquated-- we need an upgrade."
	prerequisite_nodes = list(/datum/techweb_node/basic_xenoarch)
	unlocked_designs = list(
		/datum/design/xenoarch/tool/advanced/adv_hammer,
		/datum/design/xenoarch/tool/advanced/adv_brush,
		/datum/design/xenoarch/equipment/bag_adv,
		/datum/design/xenoarch/tool/advanced/scanner,
		/datum/design/board/xenoarch/digger,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_SERVICE, RADIO_CHANNEL_SUPPLY)

#undef RND_SUBCATEGORY_MACHINE_XENOARCH
#undef RND_SUBCATEGORY_EQUIPMENT_XENOARCH
#undef RND_SUBCATEGORY_TOOLS_XENOARCH
#undef RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED
