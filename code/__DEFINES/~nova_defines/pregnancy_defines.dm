/// The divider for pregnancy duration, to allow for more or less precision
#define PREGNANCY_DURATION_MULTIPLIER (1 MINUTES)

/// Default duration of pregnancy, can be changed in preferences
#define PREGNANCY_DURATION_DEFAULT ((10 MINUTES) / PREGNANCY_DURATION_MULTIPLIER)
/// Minimum duration of pregnancy
#define PREGNANCY_DURATION_MINIMUM ((1 MINUTES) / PREGNANCY_DURATION_MULTIPLIER)
/// Maximum duration of pregnancy
#define PREGNANCY_DURATION_MAXIMUM ((4 HOURS) / PREGNANCY_DURATION_MULTIPLIER)

/// Default chance to get pregnant when someone cums inside you
#define PREGNANCY_CHANCE_DEFAULT 1
/// Minimum chance to get pregnant
#define PREGNANCY_CHANCE_MINIMUM 0
/// Maximum chance to get pregnant
#define PREGNANCY_CHANCE_MAXIMUM 100

/// Default genetic distribution of pregnancies (lower = favors mother, higher = favors father)
#define PREGNANCY_GENETIC_DISTRIBUTION_DEFAULT 10
/// Minimum genetic distribution
#define PREGNANCY_GENETIC_DISTRIBUTION_MINIMUM 0
/// Maximum genetic distribution
#define PREGNANCY_GENETIC_DISTRIBUTION_MAXIMUM 100

/// Cryptic pregnancies are not detected by health analyzers
#define PREGNANCY_FLAG_CRYPTIC (1 << 0)
/// Pregnancy will inflate your belly (currently cosmetic: emits flavor text only, Nova lacks belly organ)
#define PREGNANCY_FLAG_BELLY_INFLATION (1 << 1)
/// Pregnancy will not create live offspring, only inert eggs
#define PREGNANCY_FLAG_INERT (1 << 2)
/// Pregnancy will cause nausea effects
#define PREGNANCY_FLAG_NAUSEA (1 << 3)

#define PREGNANCY_FLAGS_DEFAULT (PREGNANCY_FLAG_BELLY_INFLATION)
