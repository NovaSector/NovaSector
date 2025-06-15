
//custom arrival announcement
//proc/announce_arrival()
//announcement system loads too early in new_player.dm - pending upstream change

//no employee contract
/mob/dead/new_player/AddEmploymentContract(mob/living/carbon/human/character)
	if(!SSticker.IsRoundInProgress() || QDELETED(character))
		return
	if(character.has_quirk(/datum/quirk/visitor) && istype(character.mind?.assigned_role, SSjob.get_job_type(/datum/job/assistant)))
		return
	return ..()
