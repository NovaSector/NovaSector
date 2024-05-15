///Mermaid organ
//Adds a signal allowing the use of their tail for navigation in pressurized zero g
/obj/item/organ/external/taur_body/mermaid/on_mob_insert(mob/living/carbon/mermaid, special, movement_flags)
	. = ..()
	RegisterSignal(mermaid, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(update_float_move))
	//delete the user's legs with a safe proc
	for(var/obj/item/bodypart/leg/legs in mermaid.bodyparts)
		legs.drop_limb()
		qdel(legs) //get your sea legs

//proc called before a move happens to see if we are given control
/obj/item/organ/external/taur_body/mermaid/proc/update_float_move()
	SIGNAL_HANDLER
	//check if the current tile atmosphere suits ideal conditions to swim around mid-air
	if(!isspaceturf(owner.loc))
		var/datum/gas_mixture/current = owner.loc.return_air()
		if(current && (current.return_pressure() >= ONE_ATMOSPHERE*0.85))
			ADD_TRAIT(owner, TRAIT_FREE_FLOAT_MOVEMENT, REF(src))
			return

	REMOVE_TRAIT(owner, TRAIT_FREE_FLOAT_MOVEMENT, REF(src))

//remove lingering traits
/obj/item/organ/external/taur_body/mermaid/on_mob_remove(mob/living/carbon/mermaid)
	. = ..()
	UnregisterSignal(mermaid, COMSIG_MOVABLE_PRE_MOVE)
	REMOVE_TRAIT(mermaid, TRAIT_FREE_FLOAT_MOVEMENT, REF(src))
