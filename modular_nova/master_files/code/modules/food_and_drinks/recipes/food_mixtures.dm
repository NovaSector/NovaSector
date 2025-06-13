/datum/crafting_recipe/food
	time = 0.5 SECONDS // Default crafting time is 30 deciseconds, food is crafted much more often and in large numbers.

/obj/item/food/pizza/arnold // Account for our low iron diet, 6x AMMO_MATS_BASIC
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 16, /datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/canned/chap
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/food/canned/tuna
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
