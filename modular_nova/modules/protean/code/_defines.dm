// -- Protean Species Defines --

#define SPECIES_PROTEAN "protean"

/// Helper macro
#define isprotean(A) (is_species(A, /datum/species/protean))

/// Organ flag for nanomachine organs - next free bit after ORGAN_TUMOR_CORRUPTED (1<<18)
#define ORGAN_NANOMACHINE (1<<19)

/// Trait sources
#define PROTEAN_TRAIT "protean"
#define PROTEAN_SERVO_TRAIT "protean_servo"

/// Blood type
#define BLOOD_TYPE_IRON "FE"
#define BLOOD_COLOR_IRON "#CCCCCC"

/// Sprite file location
#define PROTEAN_ORGAN_SPRITE 'modular_nova/modules/protean/icons/mob/species/protean/protean.dmi'

/// Stomach constants
#define PROTEAN_STOMACH_FULL 10
#define PROTEAN_STOMACH_FALTERING 0.5
#define PROTEAN_METABOLISM_RATE 2000

/// Limb auto-delete timer
#define PROTEAN_LIMB_TIME (30 SECONDS)

/// Brute damage messages
#define LIGHT_NANO_BRUTE "scratched"
#define MEDIUM_NANO_BRUTE "festering"
#define HEAVY_NANO_BRUTE "falling apart"

/// Burn damage messages
#define LIGHT_NANO_BURN "scorched"
#define MEDIUM_NANO_BURN "melted"
#define HEAVY_NANO_BURN "boiling"

#define BRUTE_EXAMINE_NANO "deformation"
#define BURN_EXAMINE_NANO "scorching"
