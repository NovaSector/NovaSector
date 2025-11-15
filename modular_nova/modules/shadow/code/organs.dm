/obj/item/organ/eyes/shadow
	is_emissive = TRUE

/obj/item/organ/brain/shadow/nightmare/on_mob_insert(mob/living/carbon/brain_owner)
	. = ..()
	/* grant this spell regardless of nightmare traitor datum because
	this brain is exclusive to the nightmare - who is traitor only */
	if(isnull(terrorize_spell))
		terrorize_spell = new(src)
		terrorize_spell.Grant(brain_owner)
