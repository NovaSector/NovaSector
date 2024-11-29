///from base of living/set_pull_offset(): (mob/living/pull_target, grab_state)
#define COMSIG_LIVING_SET_PULL_OFFSET "living_set_pull_offset"
///from base of living/reset_pull_offsets(): (mob/living/pull_target, override)
#define COMSIG_LIVING_RESET_PULL_OFFSETS "living_reset_pull_offsets"
///from base of living/CanAllowThrough(): (atom/movable/mover, border_dir)
#define COMSIG_LIVING_CAN_ALLOW_THROUGH "living_can_allow_through"
	/// Allow to movable atoms to pass through this living mob
	#define COMPONENT_LIVING_PASSABLE (1<<0)
///from base of living/received_stamina_damage(): (current_level, amount_actual, amount)
#define COMSIG_LIVING_RECEIVED_STAMINA_DAMAGE "living_received_stam_damage"
	/// Block the timer for stam regen from being started (or refreshed)
	#define COMPONENT_LIVING_BLOCK_STAMINA_REGEN_TIMER (1<<0)
