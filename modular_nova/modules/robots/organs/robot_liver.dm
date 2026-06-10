/obj/item/organ/liver/cleaning_filter
	name = "intake filter"
	desc = "A fitted filter meant for use in cybernetic organisms. It struggles with most substances toxic to organics."
	organ_flags = ORGAN_ROBOTIC
	icon_state = "cleaning_filter"
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'

/obj/item/organ/liver/cleaning_filter/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/stomach/fuel_generator/fuel_generator = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(fuel_generator))
		if(istype(chem, fuel_generator.favorite_reagent) || is_type_in_list(chem, fuel_generator.flammable_reagents))
			organ_owner.reagents.trans_to(fuel_generator, chem.metabolization_rate * seconds_per_tick, null, chem.type)
			return COMSIG_MOB_STOP_REAGENT_TICK
	if(organ_flags & ORGAN_FAILING || organ_flags & ORGAN_DEPOWERED)
		var/obj/item/organ/brain/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(!robot_brain || !istype(robot_brain))
			apply_organ_damage(2)
			organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
			return COMSIG_MOB_STOP_REAGENT_TICK
		robot_brain.apply_organ_damage(2)
		organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
		return COMSIG_MOB_STOP_REAGENT_TICK
	var/obj/item/organ/lungs/fans = owner.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!fans || !istype(fans))
		var/obj/item/organ/brain/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(!robot_brain || !istype(robot_brain))
			apply_organ_damage(2)
			organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
			return COMSIG_MOB_STOP_REAGENT_TICK
		robot_brain.apply_organ_damage(2)
		organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
		return COMSIG_MOB_STOP_REAGENT_TICK
	if(istype(chem, /datum/reagent/toxin))
		fans.apply_organ_damage(1 + (1 * (damage / maxHealth)))
	organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate * seconds_per_tick)
	return COMSIG_MOB_STOP_REAGENT_TICK

/obj/item/organ/liver/cleaning_filter/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/brain/robot_nova/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: No cybernetic brain to draw power from!")
			organ_flags |= ORGAN_DEPOWERED
		return
	if(robot_brain.power <= 25)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering [name] to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (ROBOT_POWER_DRAIN * seconds_per_tick) * robot_brain.temperature_disparity
	robot_brain.run_updates()
