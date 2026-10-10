// Adds a block signal that can be utilized to prevent the stamina regen timer from being re-added (and thus reset)
// Currently used by death degradation to give a chance for stamina to regen.
/mob/living/timed_stamina_reset()
	if(SEND_SIGNAL(src, COMSIG_LIVING_RECEIVED_STAMINA_DAMAGE, get_stamina_loss()) & COMPONENT_LIVING_BLOCK_STAMINA_REGEN_TIMER)
		return
	return ..()
