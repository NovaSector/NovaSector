#define DEATH_CONSEQUENCES_QUIRK_NAME "Death Degradation Disorder"
#define DEATH_CONSEQUENCES_QUIRK_DESC "Patient is unusually susceptable to mortality."
#define DEATH_CONSEQUENCES_BASE_DEGRADATION_ON_DEATH 50

/// The victim's crit threshold cannot go below this.
#define DEATH_CONSEQUENCES_MINIMUM_VICTIM_CRIT_THRESHOLD (MAX_LIVING_HEALTH) - 1

#define DEATH_CONSEQUENCES_REAGENT_FLAT_AMOUNT "dc_flat_reagent_amount"
#define DEATH_CONSEQUENCES_REAGENT_MULT_AMOUNT "dc_mult_reagent_amount"
#define DEATH_CONSEQUENCES_REAGENT_METABOLIZE "dc_reagent_should_be_metabolizing"
/// If true, we will check to see if this can process. Ex. things like synths wont process formaldehyde
#define DEATH_CONSEQUENCES_REAGENT_CHECK_PROCESSING_FLAGS "dc_check_reagent_processing_flags"

/// Absolute maximum for preferences.
#define DEATH_CONSEQUENCES_MAXIMUM_THEORETICAL_DEGRADATION 10000
#define DEATH_CONSEQUENCES_DEFAULT_MAX_DEGRADATION 500 // arbitrary
#define DEATH_CONSEQUENCES_DEFAULT_LIVING_DEGRADATION_RECOVERY 0.01
#define DEATH_CONSEQUENCES_DEFAULT_DEGRADATION_ON_DEATH 50

#define DEATH_CONSEQUENCES_DEFAULT_REZADONE_DEGRADATION_REDUCTION 0.4
#define DEATH_CONSEQUENCES_DEFAULT_STRANGE_REAGENT_DEGRADATION_REDUCTION 0.25
#define DEATH_CONSEQUENCES_DEFAULT_EIGENSTASIUM_DEGRADATION_REDUCTION 5 // for such a rare chem, you fucking bet
#define DEATH_CONSEQUENCES_DEFAULT_SANSUFENTANYL_DEGRADATION_REDUCTION 1

#define DEATH_CONSEQUENCES_SHOW_HEALTH_ANALYZER_DATA "dc_show_health_analyzer_data"

#define DEATH_CONSEQUENCES_TIME_BETWEEN_REMINDERS 5 MINUTES

/// the minimum percentage of RGB darkness reduction that Nova's NV will always give. for base reference, the old NV quirk was equal to 4.5. note: some wide variance in min/max is needed to ensure hue has some chance to linear convert across
#define NOVA_NIGHT_VISION_POWER_MIN 4.5
/// the maximum percentage. for reference, low-light adapted eyes (icecats and ashwalkers) have 30.
#define NOVA_NIGHT_VISION_POWER_MAX 9
/// percentage of the NIGHT_VISION_POWER_MAX increase that is applied for eyes with low innate flash protection (photophobia quirk/moth eyes). At 0.75, this raises NV to 22.5 at hypersensitive flash_protect.
#define NOVA_NIGHT_VISION_SENSITIVITY_MULT 0.75
