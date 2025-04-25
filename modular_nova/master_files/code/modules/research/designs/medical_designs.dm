/datum/design/cybernetic_tongue
	name = "Cybernetic Tongue"
	desc = "A cybernetic tongue."
	id = "cybernetic_tongue"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/organ/tongue/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_tongue/lizard
	name = "Forked Cybernetic Tongue"
	desc = "A forked cybernetic tongue."
	id = "cybernetic_tongue_lizard"
	build_path = /obj/item/organ/tongue/lizard/cybernetic

/datum/design/cone_of_shame
	name = "Collar Cone"
	desc = "A protective guard used to prevent infections. Its advertisement claims it is: \"used to prevent unnecessary scratching, biting or licking of wounds to better facilitate healing. Works on people and pets alike!\" You question its efficacy, while also feeling a mild sense of shame while wearing it."
	id = "cone_of_shame"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/head/cone_of_shame
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
