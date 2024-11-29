// Adds a block signal that can be utilized to prevent the stamina regen timer from being re-added (and thus reset)
// Currently used by death degradation to give a chance for stamina to regen.
/mob/living/received_stamina_damage(current_level, amount_actual, amount)
	if(SEND_SIGNAL(src, COMSIG_LIVING_RECEIVED_STAMINA_DAMAGE, current_level, amount_actual, amount) & COMPONENT_LIVING_BLOCK_STAMINA_REGEN_TIMER)
		return
	return ..()
