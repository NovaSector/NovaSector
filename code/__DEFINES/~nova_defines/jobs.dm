// Just keeping this easy to maintain in the future.
#define JOB_NOT_NOVA_STAR (JOB_UNAVAILABLE_AGE + 1)
#define JOB_UNAVAILABLE_QUIRK (JOB_NOT_NOVA_STAR + 1)
#define JOB_UNAVAILABLE_SPECIES (JOB_UNAVAILABLE_QUIRK + 1)
#define JOB_UNAVAILABLE_LANGUAGE (JOB_UNAVAILABLE_SPECIES + 1)
#define JOB_UNAVAILABLE_FLAVOUR (JOB_UNAVAILABLE_LANGUAGE + 1)
#define JOB_UNAVAILABLE_AUGMENT (JOB_UNAVAILABLE_FLAVOUR + 1)

#define SEC_RESTRICTED_QUIRKS "Blind" = TRUE, "Brain Tumor" = TRUE, "Deaf" = TRUE, "Paraplegic" = TRUE, "Hemiplegic" = TRUE, "Mute" = TRUE, "Foreigner" = TRUE, "Pacifist" = TRUE, "No Guns" = TRUE, "Illiterate" = TRUE, "Nerve Stapled" = TRUE, "Underworld Connections" = TRUE
#define HEAD_RESTRICTED_QUIRKS "Blind" = TRUE, "Deaf" = TRUE, "Mute" = TRUE, "Foreigner" = TRUE, "Brain Tumor" = TRUE, "Illiterate" = TRUE, "Underworld Connections" = TRUE
#define HEAD_RESTRICTED_QUIRKS_QM "Blind" = TRUE, "Deaf" = TRUE, "Mute" = TRUE, "Foreigner" = TRUE, "Brain Tumor" = TRUE, "Illiterate" = TRUE
#define GUARD_RESTRICTED_QUIRKS "Blind" = TRUE, "Deaf" = TRUE, "Foreigner" = TRUE, "Pacifist" = TRUE, "Nerve Stapled" = TRUE
#define PRISONER_RESTRICTED_QUIRKS "Underworld Connections" = TRUE

#define RESTRICTED_QUIRKS_EXCEPTIONS list("Mute" = "Signer")

#define HEAD_RESTRICTED_AUGMENTS /obj/item/bodypart/arm/left/self_destruct, /obj/item/bodypart/arm/right/self_destruct, /obj/item/bodypart/leg/left/self_destruct, /obj/item/bodypart/leg/right/self_destruct
#define SEC_RESTRICTED_AUGMENTS /obj/item/bodypart/arm/left/self_destruct, /obj/item/bodypart/arm/right/self_destruct, /obj/item/bodypart/leg/left/self_destruct, /obj/item/bodypart/leg/right/self_destruct

/// Time after clocking out before you can clock in again
#define TIMECLOCK_COOLDOWN 5 MINUTES

/// What items do we want to remove from the person clocking out?
#define SELF_SERVE_RETURN_ITEMS list( \
	/obj/item/melee/baton/telescopic, \
	/obj/item/melee/baton, \
	/obj/item/assembly/flash/handheld, \
	/obj/item/gun/energy/disabler, \
	/obj/item/megaphone/command, \
	/obj/item/door_remote/captain, \
	/obj/item/door_remote/chief_engineer, \
	/obj/item/door_remote/research_director, \
	/obj/item/door_remote/head_of_security, \
	/obj/item/door_remote/quartermaster, \
	/obj/item/door_remote/chief_medical_officer, \
	/obj/item/door_remote/head_of_personnel, \
	/obj/item/circuitboard/machine/techfab/department/engineering, \
	/obj/item/circuitboard/machine/techfab/department/service, \
	/obj/item/circuitboard/machine/techfab/department/security, \
	/obj/item/circuitboard/machine/techfab/department/medical, \
	/obj/item/circuitboard/machine/techfab/department/cargo, \
	/obj/item/circuitboard/machine/techfab/department/science, \
	/obj/item/blueprints, \
	/obj/item/pipe_dispenser/bluespace, \
	/obj/item/mod/control/pre_equipped/advanced, \
	/obj/item/clothing/shoes/magboots/advance, \
	/obj/item/shield/riot/tele, \
	/obj/item/storage/belt/security/full, \
	/obj/item/gun/energy/e_gun/hos, \
	/obj/item/pinpointer/nuke, \
	/obj/item/storage/belt/sabre, \
	/obj/item/mod/control/pre_equipped/magnate, \
	/obj/item/mod/control/pre_equipped/blueshield, \
	/obj/item/clothing/suit/armor/vest/warden, \
	/obj/item/clothing/gloves/krav_maga/sec, \
	/obj/item/clothing/suit/armor/vest/alt/sec, \
	/obj/item/storage/belt/holster/detective/full, \
	/obj/item/detective_scanner, \
	/obj/item/mod/control/pre_equipped/security, \
	/obj/item/mod/control/pre_equipped/safeguard, \
	/obj/item/gun/energy/cell_loaded/medigun/cmo, \
	/obj/item/storage/hypospraykit/cmo/preloaded, \
	/obj/item/mod/control/pre_equipped/rescue, \
	/obj/item/card/id/departmental_budget/car, \
	/obj/item/clothing/suit/armor/reactive/teleport, \
	/obj/item/mod/control/pre_equipped/research, \
)
