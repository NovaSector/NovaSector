#define MAX_OXYGEN_PRODUCED MOLES_CELLSTANDARD // Kind of a large amount, but realism vs fun tradeoff?
/obj/structure/plant_tank
	name = "plant tank"
	desc = "A small little glass tank that is used to grow plants; this tank promotes the nitrogen and oxygen cycle."
	icon = 'modular_nova/modules/ashwalkers/icons/structures.dmi'
	icon_state = "plant_tank_e"
	anchored = FALSE
	density = TRUE
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	///the amount of times the tank can produce-- can be increased through feeding the tank
	var/operation_number = 0
	/// the farm component (if it was added)
	var/datum/component/simple_farm/connected_farm

/obj/structure/plant_tank/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/plant_tank/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/plant_tank/examine(mob/user)
	. = ..()
	. += span_notice("<br>Use food or worm fertilizer to allow nitrogen production and carbon dioxide processing!")
	. += span_notice("There are [operation_number] cycles left!")
	var/datum/component/simple_farm/find_farm = GetComponent(/datum/component/simple_farm)
	if(!find_farm)
		. += span_notice("<br>Use five sand to allow planting!")

/obj/structure/plant_tank/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/food) || istype(tool, /obj/item/stack/worm_fertilizer))
		if(istype(tool, /obj/item/food/tree_fruit))
			return ..()

		if(isstack(tool))
			if(!tool.use(1))
				return ITEM_INTERACT_BLOCKING

		else
			qdel(tool)

		balloon_alert(user, "[tool] placed inside")
		user.mind?.adjust_experience(/datum/skill/primitive, 2)
		operation_number += 2
		if(prob(user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
			operation_number += 2

		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/storage/bag/plants))
		var/list/foods = list()
		for(var/obj/item/food/food_item in tool)
			foods += food_item

		if(!length(foods))
			balloon_alert(user, "no food to dump inside")
			return ITEM_INTERACT_BLOCKING

		balloon_alert(user, "dumped food inside!")

		for(var/obj/item/food/food_item in foods)
			qdel(food_item)
			operation_number += 2
			if(prob(user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_PROBS_MODIFIER)))
				operation_number += 2
			user.mind?.adjust_experience(/datum/skill/primitive, 2)

		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/ore/glass))
		if(connected_farm)
			balloon_alert(user, "no more [tool] required")
			return ITEM_INTERACT_BLOCKING

		if(!tool.use(5))
			balloon_alert(user, "farms require five sand")
			return ITEM_INTERACT_BLOCKING

		connected_farm = AddComponent(/datum/component/simple_farm, TRUE, TRUE, list(0, 12))
		icon_state = "plant_tank_f"
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/structure/plant_tank/process(seconds_per_tick)
	if(operation_number <= 0) //we require "fuel" to actually produce stuff
		return

	var/turf/open/src_turf  = get_turf(src)
	if(isnull(src_turf))
		return

	if(!isopenturf(src_turf) || isspaceturf(src_turf) || src_turf.planetary_atmos) //must be open turf, can't be space turf, and can't be a turf that regenerates its atmos
		return

	var/has_plant = FALSE
	for(var/obj/structure/structure in src_turf.contents)
		if(istype(structure, /obj/structure/simple_farm) || istype(structure, /obj/structure/simple_tree))  //we require a plant to process the "fuel"
			has_plant = TRUE
			break

	if(!has_plant)
		return

	//if there is carbon dioxide in the air, lets turn it into oxygen
	var/datum/gas_mixture/env = src_turf.return_air()
	var/co2 = env.gases[/datum/gas/carbon_dioxide]
	if(!co2)
		return

	env.assert_gases(/datum/gas/carbon_dioxide, /datum/gas/oxygen, /datum/gas/nitrogen)

	// how much CO2 is available
	var/co2_amt = env.gases[/datum/gas/carbon_dioxide][MOLES]
	if(co2_amt <= 0)
		return

	var/gas_amt = min(co2_amt * seconds_per_tick, (MAX_OXYGEN_PRODUCED /2) * seconds_per_tick)
	env.gases[/datum/gas/carbon_dioxide][MOLES] -= min(co2_amt, gas_amt)
	src_turf.atmos_spawn_air("[GAS_O2]=[gas_amt]")
	var/add_n = gas_amt * 0.7 // 70% of CO2 becomes nitrogen
	src_turf.atmos_spawn_air("[GAS_N2]=[add_n]") // the nitrogen cycle-- plants (and bacteria) participate in the nitrogen cycle

	operation_number--

/obj/structure/plant_tank/wrench_act(mob/living/user, obj/item/tool)
	balloon_alert(user, "[anchored ? "un" : ""]bolting")
	tool.play_tool_sound(src, 50)
	if(!tool.use_tool(src, user, 2 SECONDS))
		return TRUE

	anchored = !anchored
	balloon_alert(user, "[anchored ? "" : "un"]bolted")
	return TRUE

/obj/structure/plant_tank/screwdriver_act(mob/living/user, obj/item/tool)
	balloon_alert(user, "deconstructing")
	tool.play_tool_sound(src, 50)
	if(!tool.use_tool(src, user, 2 SECONDS))
		return TRUE

	deconstruct()
	return TRUE

/obj/structure/plant_tank/atom_deconstruct(disassembled)
	var/target_turf = get_turf(src)
	for(var/loop in 1 to 4)
		new /obj/item/stack/sheet/glass(target_turf)
		new /obj/item/stack/rods(target_turf)
	new /obj/item/forging/complete/plate(target_turf)
	return ..()

/datum/crafting_recipe/plant_tank
	name = "Plant Tank"
	result = /obj/structure/plant_tank
	reqs = list(
		/obj/item/forging/complete/plate = 1,
		/obj/item/stack/sheet/glass = 4,
		/obj/item/stack/rods = 4,
	)
	category = CAT_STRUCTURE

	#undef MAX_OXYGEN_PRODUCED
