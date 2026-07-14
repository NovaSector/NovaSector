/datum/design/borg_upgrade_shrink
	name = "Shrink Module"
	id = "borg_upgrade_shrink"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/shrink
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL,
	)

/datum/design/borg_upgrade_surgicaltools
	name = "Advanced Surgical Tools Module"
	id = "borg_upgrade_surgicaltools"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/surgerytools
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL,
	)

/datum/design/borg_upgrade_autopsyscanner
	name = "Autopsy Scanner Module"
	id = "borg_upgrade_autopsyscanner"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/autopsy_scanner
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL,
	)

/datum/design/borg_upgrade_chemistrygripper
	name = "Chemistry Gripper Module"
	id = "borg_upgrade_chemistrygripper"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/chemistrygripper
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL,
	)

/datum/design/affection_module
	name = "Affection Module"
	id = "affection_module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/affectionmodule
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL,
	)

/datum/design/advanced_materials
	name = "Advanced Materials Module"
	id = "advanced_materials"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/advanced_materials
	materials = list(
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT * 3,
	)
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING,
	)

/datum/design/borg_shapeshifter_module
	name = "Shapeshifting Module"
	id = "borg_shapeshifter_module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/borg_shapeshifter
	materials = list(
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL,
	)

/datum/design/borg_upgrade_welding
	name = "Welding Module"
	id = "borg_upgrade_welding"
	construction_time = 6 SECONDS
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/welder
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT * 1,
	)
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MINING,
	)

//Cyborg Nova overrides
/datum/design/borg_suit
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
	)
	construction_time = 8 SECONDS

/obj/item/robot_suit
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)

/datum/design/borg_chest
	name = "Cyborg Torso"
	id = "borg_chest"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/chest/robot
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_CHASSIS,
	)

/obj/item/bodypart/chest/robot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8)

/datum/design/borg_head
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 4 SECONDS

/obj/item/bodypart/head/robot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/datum/design/borg_l_arm
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 8 SECONDS

/obj/item/bodypart/arm/left/robot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/datum/design/borg_r_arm
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 8 SECONDS

/obj/item/bodypart/arm/right/robot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/// All of these contain robot arms... this sucks, do we really need to have cheaper robot parts?

/mob/living/basic/bot/cleanbot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/mob/living/basic/bot/repairbot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4.8, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/mob/living/basic/bot/medbot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.3, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2.5)

/mob/living/basic/bot/secbot/honkbot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.8, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/mob/living/basic/bot/firebot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/mob/living/basic/bot/vibebot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.8, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)

/obj/vehicle/sealed/mecha/vim
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4.55, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.7)

/mob/living/basic/bot/secbot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3.2)

/mob/living/basic/bot/secbot/ed209
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 9.8, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2.1)

/obj/item/extendohand
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/datum/design/borg_l_leg
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 8 SECONDS

/obj/item/bodypart/leg/left/robot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/datum/design/borg_r_leg
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	construction_time = 8 SECONDS

/obj/item/bodypart/leg/right/robot
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/datum/design/borg_upgrade_cargo_apparatus
	name = "Cargo Apparatus"
	id = "borg_upgrade_cargo_apparatus"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/cargo_papermanipulator
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2.5)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/cargo_papermanipulator
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5)

/datum/design/rld
	name = "Cyborg Rapid Lighting Device"
	id = "rld_cyborg"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/rld
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/obj/item/borg/upgrade/rld
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.25)

/datum/design/borg_upgrade_brped
	name = "Bluespace Rapid Part Exchange Device"
	id = "borg_upgrade_brped"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/brped
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING
	)

/obj/item/borg/upgrade/brped
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5)

/datum/design/borgteleporter
	name = "Cyborg Cargo Teleporter"
	id = "borg_upgrade_cargo_teleporter"
	build_type = MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/borg/upgrade/cargo_teleporter
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/cargo_teleporter
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.25)
