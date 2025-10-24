/obj/item/graft
	/// Reagent list of the grafted seed, associative list of reagent types to reagent rate (see /datum/plant_gene/reagent)
	var/list/reagents_add

/obj/structure/flora/ash/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(src, /obj/structure/flora/ash/cacti))
		return ..()

	if(harvested && tool.get_sharpness())
		to_chat(user, span_notice("You begin to scrape away at the thick layers of ash underneath [src]..."))
		var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
		if(!do_after(user, 10 SECONDS * skill_modifier, target = src))
			to_chat(user, span_warning("You decide against scraping away at the thick layers of ash underneath [src]!"))
			return ITEM_INTERACT_BLOCKING

		if(prob(10))
			new /obj/item/food/tree_fruit(get_turf(src))
			to_chat(user, span_notice("You succesfully cut away a mass underneath [src], revealing an old preserved fruit from some kind of tree..."))
			user.mind?.adjust_experience(/datum/skill/primitive, 5)

		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		if(prob(20))
			qdel(src)

		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/item/food/tree_fruit
	name = "tree fruit"
	desc = "A very nondescript fruit from a tree-- you have to wonder where it came from."
	icon = 'modular_nova/modules/ashwalkers/icons/plant.dmi'
	icon_state = "treefruit"
	bite_consumption = 10
	max_volume = 100
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("sugary" = 1, "tart" = 1, "bitter" = 1)
	foodtypes = FRUIT

/// tree stage 1: small seedling
#define TREE_STAGE_ONE 1
/// tree stage 2: medium sapling
#define TREE_STAGE_TWO 2
/// tree stage 3: adult tree
#define TREE_STAGE_THREE 3

/obj/structure/simple_tree
	name = "tree"
	desc = "Whether by sheer luck or by determination, this tree has survived in this hellish environment-- for now. This tree will need assistance if it wants to survive!"
	icon = 'modular_nova/modules/ashwalkers/icons/tree.dmi'
	icon_state = "seedling"

	pixel_x = -32
	anchored = TRUE
	density = TRUE
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE

	/// whether the tree will process
	var/processing_tree = TRUE

	///the atom the farm is attached to
	var/atom/attached_atom

	/// the stage of the tree; at stage three, all functions are available depending on other variables
	var/tree_stage = TREE_STAGE_ONE
	/// the amount of fertilizer that has been applied to the tree, each increasing the chance to upgrade to the next
	var/fertilizer_amount = 0
	/// the cooldown between each processing
	COOLDOWN_DECLARE(process_cooldown)

	/// whether the tree has been tapped
	var/tapped_tree = FALSE
	/// the cooldown for collecting sap from the tree
	COOLDOWN_DECLARE(sap_cooldown)
	/// what the tree will produce from the tap
	var/tapped_reagent = /datum/reagent/consumable/sap

	/// the cooldown for being able to safely remove some branches from the tree for wood
	COOLDOWN_DECLARE(wood_cooldown)

	/// the list of grafts on the tree
	var/list/graft_list = list()
	/// the list of reagents from the grafted plants
	var/list/grafted_reagents = list()
	/// the cooldown for being able to harvest some fruits
	COOLDOWN_DECLARE(harvest_cooldown)

	/// the queen bee (if it exists) that is using this tree as a home
	var/obj/item/queen_bee/tree_bee
	/// the cooldown to collect a honeycomb from the tree/bee
	COOLDOWN_DECLARE(honeycomb_cooldown)

	/// how much maximum health the tree can have
	var/tree_max_health = 100
	/// how much current health the tree has
	var/tree_current_health = 100

/obj/structure/simple_tree/Initialize(mapload, atom/attaching_atom)
	. = ..()
	if(processing_tree)
		START_PROCESSING(SSobj, src)

	if(attaching_atom)
		attached_atom = attaching_atom
		if(!ismovable(attached_atom))
			return

		var/atom/movable/moving_atom = attached_atom
		src.glide_size = moving_atom.glide_size
		RegisterSignal(attached_atom, COMSIG_MOVABLE_MOVED, PROC_REF(move_tree))

/// used when the attached atom somehow moves
/obj/structure/simple_tree/proc/move_tree()
	SIGNAL_HANDLER

	if(QDELETED(attached_atom))
		return

	forceMove(get_turf(attached_atom))

/obj/structure/simple_tree/Destroy(force)
	QDEL_NULL(tree_bee)
	graft_list.Cut()
	attached_atom = null
	if(processing_tree)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/simple_tree/update_overlays()
	. = ..()
	cut_overlays()
	if(tree_stage < TREE_STAGE_THREE)
		return

	if(COOLDOWN_FINISHED(src, wood_cooldown))
		add_overlay("branch")

	if(COOLDOWN_FINISHED(src, harvest_cooldown))
		add_overlay("fruit")

	if(tapped_tree)
		add_overlay("sap")

		if(COOLDOWN_FINISHED(src, sap_cooldown))
			add_overlay("sapready")

	if(tree_bee)
		add_overlay("honey")

		if(COOLDOWN_FINISHED(src, honeycomb_cooldown))
			add_overlay("honeyready")

	for(var/graft_iterate in 1 to length(graft_list))
		add_overlay("grafted[graft_iterate]")

/obj/structure/simple_tree/update_icon_state()
	switch(tree_stage)
		if(TREE_STAGE_ONE)
			icon_state = "seedling"

		if(TREE_STAGE_TWO)
			icon_state = "sapling"

		if(TREE_STAGE_THREE)
			icon_state = "tree"

	return ..()

/obj/structure/simple_tree/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, process_cooldown))
		return

	COOLDOWN_START(src, process_cooldown, 30 SECONDS)
	if(tree_stage < TREE_STAGE_THREE)
		attempt_upgrade()
		adjust_health(-5)
		return

	if(prob(10) && !tree_bee)
		tree_bee = new /obj/item/queen_bee/bought(src)

	update_appearance(UPDATE_OVERLAYS)

/obj/structure/simple_tree/examine(mob/user)
	. = ..()
	switch(tree_stage)
		if(TREE_STAGE_ONE)
			. += span_notice("Very tiny! The tree is still very much a seedling.")

		if(TREE_STAGE_TWO)
			. += span_notice("Getting bigger! The tree is truly a sapling now.")

		if(TREE_STAGE_THREE)
			. += span_notice("Hooray! The tree has survived the ordeal, and has become fully grown.")
			if(COOLDOWN_FINISHED(src, harvest_cooldown))
				. += span_notice("There are fruits that look ready to pick.")

			if(COOLDOWN_FINISHED(src, wood_cooldown))
				. += span_notice("There are some branches that look ready to cut down with something sharp.")

			if(length(graft_list) < 3)
				. += span_notice("You are able to graft samples of other plants to this tree.")

			for(var/obj/item/graft/grafted_item in graft_list)
				. += span_notice("A sample of [grafted_item.plant_dna.plantname] is grafted on.")

			if(tree_bee)
				. += span_notice("A big queen bee can be seen flying around the tree.")
				if(COOLDOWN_FINISHED(src, honeycomb_cooldown))
					. += span_notice("The hive looks ready to harvest. Use some cutters or knives.")

			if(tapped_tree)
				. += span_notice("There is a tap poking out the side of the tree.")
				if(COOLDOWN_FINISHED(src, sap_cooldown))
					. += span_notice("Some sap is leaking out the tap-- collect it!")

			else
				. += span_notice("You can use a screwdriver to tap this tree.")

/obj/structure/simple_tree/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/worm_fertilizer))
		do_fertilizer(user, tool)
		return ITEM_INTERACT_SUCCESS

	if(tool.tool_behaviour == TOOL_KNIFE)
		attempt_honeycomb(user)
		return ITEM_INTERACT_SUCCESS

	if(tool.get_sharpness()) //doing this after the knife because assumedly, knives are sharp!
		attempt_woodmaking(user)
		return ITEM_INTERACT_SUCCESS

	if(tree_stage < TREE_STAGE_THREE)
		return ..()

	if(istype(tool, /obj/item/secateurs))
		var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
		if(!do_after(user, 10 SECONDS * skill_modifier, target = src))
			to_chat(user, span_warning("You decide against removing the grafts!"))
			return ITEM_INTERACT_BLOCKING

		for(var/obj/item/graft/target_grafts in graft_list)
			target_grafts.forceMove(get_turf(user))
			user.mind?.adjust_experience(/datum/skill/primitive, 5)
			graft_list -= target_grafts

		update_graft_reagents()
		update_appearance(UPDATE_OVERLAYS)
		to_chat(user, span_notice("You decide to remove the grafts from [src]."))
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/queen_bee))
		if(tree_bee)
			to_chat(user, span_warning("There is already a queen bee!"))
			return ITEM_INTERACT_BLOCKING

		tool.forceMove(src)
		tree_bee = tool
		to_chat(user, span_notice("You add [tool] to [src]."))
		update_appearance(UPDATE_OVERLAYS)
		return ITEM_INTERACT_SUCCESS

	if(is_reagent_container(tool))
		if(!COOLDOWN_FINISHED(src, sap_cooldown))
			to_chat(user, span_warning("[src] has recently been tapped!"))
			return ITEM_INTERACT_BLOCKING

		COOLDOWN_START(src, sap_cooldown, 1 MINUTES)
		playsound(get_turf(src), SFX_TREE_CHOP, 50, vary = FALSE)
		var/obj/item/reagent_containers/container_tool = tool
		if(container_tool.is_refillable())
			if(!container_tool.reagents.holder_full())
				container_tool.reagents.add_reagent(tapped_reagent, 10)
				return ITEM_INTERACT_SUCCESS

			to_chat(user, span_warning("[tool] is unable to be filled further!"))
			return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/graft))
		var/obj/item/graft/tool_graft = tool
		playsound(src, SFX_CRUNCHY_BUSH_WHACK, 50, vary = FALSE)
		to_chat(user, span_notice("You begin to graft the [tool_graft.plant_dna.plantname] graft onto [src]."))
		var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
		if(!do_after(user, 10 SECONDS * skill_modifier, target = src))
			to_chat(user, span_warning("You decide against the grafting!"))
			return ITEM_INTERACT_BLOCKING

		playsound(src, SFX_CRUNCHY_BUSH_WHACK, 50, vary = FALSE)

		if(length(graft_list) >= 3)
			to_chat(user, span_warning("[src] is already full of grafts!"))
			return ITEM_INTERACT_BLOCKING

		tool_graft.forceMove(src)
		graft_list += tool_graft
		to_chat(user, span_notice("You successfully graft the [tool_graft.plant_dna.plantname] graft onto [src]."))
		update_graft_reagents()
		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		update_appearance(UPDATE_OVERLAYS)
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/structure/simple_tree/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(tree_stage < TREE_STAGE_THREE)
		return ITEM_INTERACT_BLOCKING

	// if we are fruited, lets pick that first
	if(COOLDOWN_FINISHED(src, harvest_cooldown))
		COOLDOWN_START(src, harvest_cooldown, 30 SECONDS)
		update_appearance(UPDATE_OVERLAYS)
		playsound(src, SFX_CRUNCHY_BUSH_WHACK, 50, vary = FALSE)
		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		to_chat(user, span_notice("You harvest some fruit from [src]."))
		var/turf/user_turf = get_turf(user)
		for(var/iteration in 1 to rand(1, 2))
			var/obj/item/food/tree_fruit/spawned_fruit = new /obj/item/food/tree_fruit(user_turf)
			for(var/adding_reagents in grafted_reagents)
				spawned_fruit.reagents.add_reagent(adding_reagents, 5)

		return

	// if not fruited, lets get the bee out if its there
	if(tree_bee)
		tree_bee.forceMove(get_turf(user))
		to_chat(user, span_warning("You pull [tree_bee] from [src]!"))
		playsound(src, SFX_CRUNCHY_BUSH_WHACK, 50, vary = FALSE)
		tree_bee = null
		update_appearance(UPDATE_OVERLAYS)
		return

/obj/structure/simple_tree/wirecutter_act(mob/living/user, obj/item/tool)
	attempt_honeycomb(user)
	return ITEM_INTERACT_SUCCESS

/obj/structure/simple_tree/screwdriver_act(mob/living/user, obj/item/tool)
	if(tapped_tree)
		to_chat(user, span_warning("[src] has already been tapped!"))
		return ITEM_INTERACT_BLOCKING

	tap_tree(user, tool)
	return ITEM_INTERACT_SUCCESS

/// tapping the tree, to allow for drainage of sap; who, with what, tapping or untapping, how long, and if forced
/obj/structure/simple_tree/proc/tap_tree(mob/user, obj/item/tool, tapping_direction = TRUE, use_time = 4 SECONDS, forced_tool = FALSE)
	playsound(get_turf(src), SFX_TREE_CHOP, 50, vary = FALSE)
	if(!forced_tool)
		to_chat(user, span_notice("You begin to use [tool] on [src]..."))
		var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
		if(!do_after(user, use_time * tool.toolspeed * skill_modifier, target = src))
			to_chat(user, span_warning("You decide against using [tool] on [src]!"))
			return

		to_chat(user, span_notice("You finished using [tool] on [src]!"))
		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		tool.forceMove(src)

	playsound(get_turf(src), SFX_TREE_CHOP, 50, vary = FALSE)
	tapped_tree = tapping_direction
	update_appearance(UPDATE_OVERLAYS)

/// applying fertilizer to the tree; who did it, with what, how long, how much use, how much give, and whether you've forced it (bypasses the usage)
/obj/structure/simple_tree/proc/do_fertilizer(mob/user, obj/item/tool, use_time = 2 SECONDS, use_amount = 1, given_amount = 1, forced_fertilizer = FALSE)
	playsound(src, 'sound/effects/shovel_dig.ogg', 50, TRUE)
	if(!forced_fertilizer)
		if(!tool.use(use_amount))
			to_chat(user, span_warning("You decide against using [tool] on [src]!"))
			return

		to_chat(user, span_notice("You used [tool], which healed [src]!"))
		user.mind?.adjust_experience(/datum/skill/primitive, 5)

	adjust_health(5)
	playsound(src, 'sound/effects/shovel_dig.ogg', 50, TRUE)
	fertilizer_amount += given_amount

/// attempts to spawn a log, or damages it if it cannot
/obj/structure/simple_tree/proc/attempt_woodmaking(mob/user)
	if(!COOLDOWN_FINISHED(src, wood_cooldown) || tree_stage < TREE_STAGE_THREE)
		adjust_health(-50)
		to_chat(user, span_warning("You damage [src] trying to harvest something!"))
		return

	COOLDOWN_START(src, wood_cooldown, 1 MINUTES)
	update_appearance(UPDATE_OVERLAYS)
	var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 5 SECONDS * skill_modifier, target = src))
		to_chat(user, span_warning("You fumble with the wood, splintering it into uselessness!"))
		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		return

	playsound(get_turf(src), SFX_TREE_CHOP, 50, vary = FALSE)
	user.mind?.adjust_experience(/datum/skill/primitive, 10)
	new /obj/item/stack/sheet/mineral/wood(get_turf(user), 4)

/// attempts to spawn a honeycomb
/obj/structure/simple_tree/proc/attempt_honeycomb(mob/user)
	if(tree_stage < TREE_STAGE_THREE)
		adjust_health(-10)
		to_chat(user, span_warning("You damage [src] trying to harvest something!"))
		return

	playsound(src, SFX_CRUNCHY_BUSH_WHACK, 50, vary = FALSE)
	if(!tree_bee || !COOLDOWN_FINISHED(src, honeycomb_cooldown))
		to_chat(user, span_warning("There is nothing to harvest from [src]!"))
		return

	COOLDOWN_START(src, honeycomb_cooldown, 90 SECONDS)
	to_chat(user, span_notice("You begin harvesting honeycomb from [src]..."))
	update_appearance(UPDATE_OVERLAYS)
	var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 10 SECONDS * skill_modifier, target = src))
		to_chat(user, span_warning("You break the honeycomb accidentally!"))
		user.mind?.adjust_experience(/datum/skill/primitive, 5)
		return

	playsound(src, SFX_CRUNCHY_BUSH_WHACK, 50, vary = FALSE)
	for(var/iteration in 1 to rand(1, 2))
		var/obj/item/food/honeycomb/new_comb = new(get_turf(user))
		new_comb.set_reagent(tree_bee.queen.beegent.type)
	to_chat(user, span_notice("You successfully harvest honeycomb from [src]."))
	user.mind?.adjust_experience(/datum/skill/primitive, 10)
	return

/// attempts to stage up, which gets closer to having the full functions plus heals
/obj/structure/simple_tree/proc/attempt_upgrade()
	var/probability_chance = 10 + round(fertilizer_amount * 0.25)
	var/plant_present = FALSE
	for(var/obj/structure/simple_farm/found_farms in range(2, src))
		if(!istype(found_farms.planted_seed, /obj/item/seeds/lavaland/fireblossom) && !istype(found_farms.planted_seed, /obj/item/seeds/chili/ice))
			continue

		plant_present = TRUE

	if(locate(/obj/structure/flora/ash/fireblossom) in range(2, src) || locate(/obj/structure/flora/ash/chilly) in range(2, src))
		plant_present = TRUE

	if(plant_present)
		probability_chance += 10

	if(!prob(probability_chance))
		return

	for(var/obj/structure/simple_tree/surrounding_trees in range(2, src))
		if(surrounding_trees == src)
			continue

		if(prob(20))
			balloon_alert_to_viewers("feeling stiffed...")
			return

	fertilizer_amount = 0
	tree_stage = clamp(tree_stage + 1, TREE_STAGE_ONE, TREE_STAGE_THREE)
	update_appearance(UPDATE_ICON)
	tree_current_health = tree_max_health
	playsound(src, SFX_TREE_CHOP, 50, vary = FALSE)

/// updates the reagents that will be inserted into the product
/obj/structure/simple_tree/proc/update_graft_reagents()
	grafted_reagents.Cut() // have to reset it first of course
	for(var/obj/item/graft/grafted_item in graft_list)
		for(var/adding_reagent in grafted_item.reagents_add)
			grafted_reagents.Add(adding_reagent)

/// adjusts the trees health, clamped from 0 to the max health; if 0, will qdel the tree
/obj/structure/simple_tree/proc/adjust_health(damage_number)
	tree_current_health = clamp(tree_current_health + damage_number, 0, tree_max_health)
	playsound(get_turf(src), SFX_TREE_CHOP, 50, vary = FALSE)
	if(tree_current_health == 0)
		new /obj/item/stack/sheet/mineral/wood(get_turf(src), tree_stage * 3)
		qdel(src)

#undef TREE_STAGE_ONE
#undef TREE_STAGE_TWO
#undef TREE_STAGE_THREE
