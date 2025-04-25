// Adds gender to the newly spawned AI mob
/obj/structure/ai_core/ai_structure_to_mob()
	var/mob/living/silicon/ai/ai_mob = ..()
	if(!ai_mob)
		return ai_mob
	if(!isnull(core_mmi.brainmob.client))
		ai_mob.set_gender(core_mmi.brainmob.client)
	return ai_mob

