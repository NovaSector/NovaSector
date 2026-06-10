/datum/design/robot_oil_pump
	name = "oil heart"
	desc = "An Android heart, used to distribute oil throughout the chassis."
	id = "robot_oil_pump"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/heart/oil_pump
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/robot_fuel_generator
	name = "Android engine"
	desc = "An incredibly small, versatile modern combustion engine produced by Conarex Aeronautics, meant to power cybernetic organisms."
	id = "robot_fuel_generator"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/stomach/fuel_generator
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/robot_cooling_fans
	name = "cooling fans"
	desc = "A set of dense fans that channel air over steel heat sinks and force it out through a tube."
	id = "robot_cooling_fans"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/lungs/cooling_fans
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/robot_microphone
	name = "auditory sensor suite"
	desc = "A pair of ruggedized microphones. Used to translate noise to sound for cybernetic organisms."
	id = "robot_microphone"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/ears/microphone
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/robot_speaker
	name = "robotic voice box"
	desc = "A high-fidelity speaker used to produce a clear synthetic voice. It is incapable of the exact intonation and subvocal queues of humans in accordance with TerraGov law."
	id = "robot_speaker"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/tongue/speaker
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/robot_cleaning_filter
	name = "intake filter"
	desc = "A fitted filter meant for use in cybernetic organisms. It struggles with most substances toxic to organics."
	id = "robot_cleaning_filter"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/liver/cleaning_filter
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/robot_random_number_database
	name = "cyborg GPU"
	desc = "A beefy GPU built for installation inside of cybernetic organisms, used for various computing tasks. This particular one is well-worn."
	id = "robot_random_number_database"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/appendix/random_number_database
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/robot_camera
	name = "optical sensory suite"
	desc = "An expensive pair of cameras with thick, internal data cables. Used to give cybernetic organisms sight."
	id = "robot_camera"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/eyes/camera
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE


/datum/techweb_node/robot_organs
	id = TECHWEB_NODE_ROBOT_ORGANS
	display_name = "Robotic Organs"
	description = "Organs and machinery for interfacing with robotic crewmembers."
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"robotifier",
		"robotcrewconsole",
		"organ_fixer",
		"robot_oil_pump",
		"robot_fuel_generator",
		"robot_cooling_fans",
		"robot_microphone",
		"robot_speaker",
		"robot_cleaning_filter",
		"robot_random_number_database",
		"robot_camera",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)
