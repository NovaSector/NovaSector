// the recipes in question
/datum/crafting_recipe/hybrid_drill
	result = /obj/item/screwdriver/power/alien
	reqs = list(
		/obj/item/screwdriver/power = 1,
		/obj/item/screwdriver/abductor = 1,
		/obj/item/wrench/abductor = 1,
		/obj/item/alien_tool_upgrade = 1,
	)
	time = 10 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/hybrid_jaws
	result = /obj/item/crowbar/power/alien
	reqs = list(
		/obj/item/crowbar/power = 1,
		/obj/item/crowbar/abductor = 1,
		/obj/item/wirecutters/abductor = 1,
		/obj/item/alien_tool_upgrade = 1,
	)
	time = 10 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/hybrid_scalpel
	result = /obj/item/scalpel/advanced/alien
	reqs = list(
		/obj/item/scalpel/advanced = 1,
		/obj/item/scalpel/alien = 1,
		/obj/item/circular_saw/alien = 1,
		/obj/item/alien_tool_upgrade = 1,
	)
	time = 10 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/hybrid_retractor
	result = /obj/item/retractor/advanced/alien
	reqs = list(
		/obj/item/retractor/advanced = 1,
		/obj/item/retractor/alien = 1,
		/obj/item/hemostat/alien = 1,
		/obj/item/alien_tool_upgrade = 1,
	)
	time = 10 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/hybrid_cautery
	result = /obj/item/cautery/advanced/alien
	reqs = list(
		/obj/item/cautery/advanced = 1,
		/obj/item/cautery/alien = 1,
		/obj/item/surgicaldrill/alien = 1,
		/obj/item/alien_tool_upgrade = 1,
	)
	time = 10 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/hybrid_med_combi
	result = /obj/item/blood_filter/advanced/alien
	reqs = list(
		/obj/item/blood_filter/advanced = 1,
		/obj/item/blood_filter/alien = 1,
		/obj/item/bonesetter/alien = 1,
		/obj/item/alien_tool_upgrade = 1,
	)
	time = 10 SECONDS
	category = CAT_TOOLS
