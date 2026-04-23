// oh yeeeee BEER implant on hand

/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol/hand
	name = "hand alcohol shaker"
	charge_cost = null
	default_reagent_types = list(\
		/datum/reagent/consumable/ethanol/beer\
	)

/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol/hand/process(seconds_per_tick)
	charge_timer += seconds_per_tick
	if(charge_timer >= recharge_time)
		regenerate_reagents_h(default_reagent_types)
		if(upgraded)
			regenerate_reagents_h(expanded_reagent_types)
		charge_timer = 0
	return 1

/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol/hand/proc/regenerate_reagents_h(list/reagents_to_regen)
	for(var/reagent in reagents_to_regen)
		var/datum/reagent/reagent_to_regen = reagent
		if(!stored_reagents.has_reagent(reagent_to_regen, max_volume_per_reagent))
			stored_reagents.add_reagent(reagent_to_regen, 5, reagtemp = dispensed_temperature, no_react = TRUE)

/obj/item/organ/cyberimp/arm/toolkit/beer
	name = "integrated beer syntizer implant"
	desc = "implant for real dwarf"
	actions_types = list(/datum/action/item_action/organ_action/toggle/toolkit)
	items_to_create = list(
		/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol/hand,
	)
