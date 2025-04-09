
/datum/crafting_recipe/tempgun
	name = "Temperature Gun"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/temperature
	reqs = list(/obj/item/gun/energy/laser = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/temperature = 1)
	time = 20 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/tempgun/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser)

/datum/crafting_recipe/armband/cargo
	name = "Brown Armband"
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	result = /obj/item/clothing/accessory/armband/cargo/nonsec
	tool_paths = list(/obj/item/toy/crayon/spraycan)
	time = 3 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/armband/purple
	name = "Purple Armband"
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	result = /obj/item/clothing/accessory/armband/science/nonsec
	tool_paths = list(/obj/item/toy/crayon/spraycan)
	time = 3 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/armband/orange
	name = "Orange Armband"
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	result = /obj/item/clothing/accessory/armband/engine/nonsec
	tool_paths = list(/obj/item/toy/crayon/spraycan)
	time = 3 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/armband/green
	name = "Green-Blue Armband"
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	result = /obj/item/clothing/accessory/armband/hydro/nonsec
	tool_paths = list(/obj/item/toy/crayon/spraycan)
	time = 3 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/armband/white
	name = "White Armband"
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	result = /obj/item/clothing/accessory/armband/med/nonsec
	tool_paths = list(/obj/item/toy/crayon/spraycan)
	time = 3 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/armband/white_blue
	name = "White-Blue Armband"
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	result = /obj/item/clothing/accessory/armband/medblue/nonsec
	tool_paths = list(/obj/item/toy/crayon/spraycan)
	time = 3 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/armband/red
	name = "Red Armband"
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	result = /obj/item/clothing/accessory/armband/nonsec
	tool_paths = list(/obj/item/toy/crayon/spraycan)
	time = 3 SECONDS
	category = CAT_CLOTHING
