///Mermaid organ
/obj/item/organ/external/taur_body/mermaid/on_mob_insert(mob/living/carbon/mermaid, special, movement_flags)
	. = ..()
	RegisterSignal(mermaid, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(update_float_move))

	for(var/obj/item/bodypart/leg/legs in mermaid.bodyparts)
		legs.drop_limb()
		qdel(legs) //get your sea legs


/obj/item/organ/external/taur_body/mermaid/on_mob_remove(mob/living/carbon/mermaid)
	. = ..()
	UnregisterSignal(mermaid, COMSIG_MOVABLE_PRE_MOVE)
	REMOVE_TRAIT(mermaid, TRAIT_FREE_FLOAT_MOVEMENT, REF(src))


/obj/item/organ/external/taur_body/mermaid/proc/update_float_move()
	SIGNAL_HANDLER

	if(!isspaceturf(owner.loc))
		var/datum/gas_mixture/current = owner.loc.return_air()
		if(current && (current.return_pressure() >= ONE_ATMOSPHERE*0.85)) //as long as there's pressure and no gravity, navigation while floating is possible
			ADD_TRAIT(owner, TRAIT_FREE_FLOAT_MOVEMENT, REF(src))
			return

	REMOVE_TRAIT(owner, TRAIT_FREE_FLOAT_MOVEMENT, REF(src))


///Prevent organic legs from being granted
/obj/item/bodypart/leg/can_attach_limb(mob/living/carbon/new_limb_owner, special)
	for(var/obj/item/organ/external/taur_body/taur_body in new_limb_owner.organs)
		if(taur_body.prevent_leg_insertion)
			return FALSE
	return ..()

///Prevent legs from being surgically attached (can_attach_limb proc edit still allows synthetic limbs to pass)
/datum/surgery/prosthetic_replacement/can_start(mob/user, mob/living/carbon/target)
	if(!(user.zone_selected == BODY_ZONE_L_LEG || user.zone_selected == BODY_ZONE_R_LEG))
		return ..()

	for(var/obj/item/organ/external/taur_body/taur_body in target.organs)
		if(taur_body.prevent_leg_insertion)
			return FALSE
	return ..()
