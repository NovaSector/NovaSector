#define SPECIES_HIVELESS "hiveless"

#define HIVELESS_PROTEIN_MAX 100
#define HIVELESS_PROTEIN_STARVE_BRUTE 0.5
#define HIVELESS_PROTEIN_STARVE_TOX 0.5
#define HIVELESS_PROTEIN_PER_REAGENT_UNIT 4
/// Protein lost per life tick just from being alive.
#define HIVELESS_PROTEIN_DECAY 0.1
/// Extra protein lost per life tick while chitinous armor is worn.
#define HIVELESS_ARMOR_UPKEEP 0.4

/// Sent on the owner mob from /obj/item/organ/stomach/hiveless when protein reserves change.
#define COMSIG_HIVELESS_PROTEIN_CHANGED "hiveless_protein_changed"
/// HUD key for the protein reserves display screen element.
#define HUD_HIVELESS_PROTEIN "hud_hiveless_protein"

#define HIVELESS_COST_BLADE       15
#define HIVELESS_COST_ARMOR       20
#define HIVELESS_COST_SPIT        8
#define HIVELESS_COST_REGEN       25
#define HIVELESS_COST_SHRIEK      15
#define HIVELESS_COST_FLESHMEND   20
#define HIVELESS_COST_SHAPESHIFT  25
