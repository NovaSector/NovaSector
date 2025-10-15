// Deathgasp datum system for synthetic species
// Following the same pattern as scream_datums.dm
// Global list is populated by init_prefs_emotes() in modular_nova/modules/customization/__HELPERS/global_lists.dm

GLOBAL_LIST_EMPTY(synth_deathgasp_types)

/datum/deathgasp_type
	var/name
	var/sound_path

/datum/deathgasp_type/hacked
	name = "Hacked"
	sound_path = 'modular_nova/master_files/sound/effects/hacked.ogg'

/datum/deathgasp_type/error
	name = "Error"
	sound_path = 'modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_error.ogg'

/datum/deathgasp_type/scary
	name = "Scary"
	sound_path = 'modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_scary.ogg'

/datum/deathgasp_type/shutdown
	name = "Shutdown"
	sound_path = 'modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_shutdown.ogg'

/datum/deathgasp_type/none
	name = "None"
	sound_path = null

