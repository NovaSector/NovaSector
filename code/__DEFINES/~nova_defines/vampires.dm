// Vampire defines that need to be available to upstream code edits
// The bulk of vampire defines remain in modular_nova/modules/bloodsucker/code/_defines.dm

/// Checks if the given mob is a vampire
#define IS_VAMPIRE(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vampire))
/// Checks if the given mob is a vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))

// Role preferences
#define ROLE_VAMPIRE "Vampire"
#define ROLE_VAMPIRIC_ACCIDENT "Vampiric Accident"
#define ROLE_VAMPIRE_BREAKOUT "Vampire Breakout"
#define ROLE_VASSAL "Vassal"

// Traits used in upstream edits
/// Hides TRAIT_GENELESS from sequence scanner
#define TRAIT_FAKEGENES "fakegenes"
/// The user is "vampire aligned" - i.e a vampire or vassal.
#define TRAIT_VAMPIRE_ALIGNED "vampire_aligned"
/// Slimepeople with this trait will not lose limbs from low blood/nutrition.
#define TRAIT_SLIME_NO_CANNIBALIZE "slime_no_cannibalize"

// Signals used in upstream edits
/// From base of /mob/living/simple_animal/attack_hand() and /mob/living/basic/attack_hand() when petting (non-combat): (mob/living/pet)
#define COMSIG_LIVING_PET_ANIMAL "living_pet_animal"
/// From base of carbon_defense.dm when hugging: (mob/living/carbon/hugged)
#define COMSIG_LIVING_HUG_CARBON "living_hug_carbon"
/// From base of /datum/element/art when appraising art: (atom/art_piece)
#define COMSIG_LIVING_APPRAISE_ART "living_appraise_art"
/// Sent to the mind when a slime has their core ejected: (obj/item/organ/brain/slime)
#define COMSIG_SLIME_CORE_EJECTED "slime_core_ejected"
/// Sent to the mind when a slime is revived: (mob/living/carbon/human, obj/item/organ/brain/slime)
#define COMSIG_SLIME_REVIVED "slime_revived"
