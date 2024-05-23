///Mermaid organ
/obj/item/organ/external/taur_body/mermaid/on_mob_insert(mob/living/carbon/mermaid, special, movement_flags)
	. = ..()
	//delete the user's legs with a safe proc
	for(var/obj/item/bodypart/leg/legs in mermaid.bodyparts)
		legs.drop_limb()
		qdel(legs) //get your sea legs
