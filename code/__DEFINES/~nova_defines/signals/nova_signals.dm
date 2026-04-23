///from base of /mob/living/carbon/update_stat(): (stat_mob) allows you to block normal stat processing
#define COMSIG_CARBON_UPDATE_STAT "carbon_update_stat"
	#define COMSIG_CARBON_UPDATE_STAT_NO_UPDATE (1<<0)

/// from base of mob/living/carbon/human/updatehealth()
#define COMSIG_HUMAN_HEALTH_PRE_UPDATE "human_health_update"
	#define COMSIG_HUMAN_HEALTH_PRE_UPDATE_DONT_UPDATE_MOVESPEED (1<<0)

/// from base of mob/living/med_hud_set_status()
#define COMSIG_LIVING_MED_HUD_SET_STATUS "living_med_hud_set_status"
	#define COMSIG_LIVING_MED_HUD_SET_STATUS_OVERRIDE (1<<0)
/// from base of mob/living/med_hud_set_health()
#define COMSIG_LIVING_MED_HUD_SET_HEALTH "living_med_hud_set_health"
	#define COMSIG_LIVING_MED_HUD_SET_HEALTH_OVERRIDE (1<<0)
/// from base of mob/living/revive()
#define COMSIG_LIVING_CAN_REVIVE "living_can_revive"
	#define COMSIG_LIVING_CAN_REVIVE_OVERRIDE (1<<0)

///from datum/species/handle_body_temperature(): (mob/living/carbon/human/affected, seconds_per_tick, times_fired)
#define COMSIG_SPECIES_HANDLE_TEMPERATURE "species_handle_temperature"
	#define COMSIG_SPECIES_OVERRIDE_TEMPERATURE (1<<0)

///from base of mob/adjust_bodytemperature(): (new_temp, old_temp)
#define COMSIG_MOB_TEMPERATURE_CHANGE "mob_temperature_change"
