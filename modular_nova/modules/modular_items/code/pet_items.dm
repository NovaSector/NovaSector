/obj/item/pet_food
	name = "\improper Generic pet treat"
	desc = "Far too bland for your pet OR reality. You shouldn't be seeing this."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "skeletonmeat"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/pet_food/interact_with_atom(mob/living/basic/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with) || user.combat_mode)
		return NONE
	if(interacting_with.stat)
		to_chat(user, span_warning("The pet is dead!"))
		return ITEM_INTERACT_BLOCKING
	if(!is_path_in_list(interacting_with.type, flatten_list(GLOB.possible_player_pet)))
		to_chat(user, span_warning("This treat doesn't work on [interacting_with]!"))
		return ITEM_INTERACT_BLOCKING
	return ITEM_INTERACT_SUCCESS

/obj/item/pet_food/pet_space_treat
	name = "\improper Treat Breather"
	desc = "A tasty snack for any loving companion that'll make them resistant to the nasty void of space! (Warranty void if pet cannot, in fact, handle the void of space, process not reversible)"
	icon = 'modular_nova/modules/modular_items/icons/pet_items.dmi'
	icon_state = "pet_space_treat"

/obj/item/pet_food/pet_space_treat/interact_with_atom(mob/living/basic/target_pet, mob/living/user, list/modifiers)
	. = ..()
	if(. != ITEM_INTERACT_SUCCESS)
		return
	if(HAS_TRAIT(target_pet, TRAIT_PET_SPACE_TREAT))
		to_chat(user, span_warning("This pet has already eaten a space treat!"))
		return ITEM_INTERACT_BLOCKING
	if(!target_pet.unsuitable_atmos_damage || !target_pet.minimum_survivable_temperature || !target_pet.maximum_survivable_temperature)
		to_chat(user, span_warning("This treat is unsuitable for this pet!"))
		return ITEM_INTERACT_BLOCKING
	ADD_TRAIT(target_pet, TRAIT_PET_SPACE_TREAT, user)
	target_pet.RemoveElement(/datum/element/atmos_requirements, target_pet.habitable_atmos, target_pet.unsuitable_atmos_damage)
	target_pet.RemoveElement(/datum/element/body_temp_sensitive, target_pet.minimum_survivable_temperature, target_pet.maximum_survivable_temperature, target_pet.unsuitable_cold_damage, target_pet.unsuitable_heat_damage)
	target_pet.unsuitable_atmos_damage = 0
	target_pet.minimum_survivable_temperature = TCMB
	target_pet.maximum_survivable_temperature = NPC_DEFAULT_MAX_TEMP
	target_pet.apply_atmos_requirements()
	target_pet.apply_temperature_requirements()
	target_pet.desc += span_notice("\n[target_pet.p_They()] seem[target_pet.p_s()] hardier against the void of space.")
	to_chat(user, span_notice("You feed the treat to the [target_pet], which they quickly gobble up."))
	qdel(src)
