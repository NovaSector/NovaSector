/// The divider for pregnancy duration, to allow for more or less precision.
#define PREGNANCY_DURATION_MULTIPLIER (1 MINUTES)

/// Default duration of pregnancy, can be changed in preferences.
#define PREGNANCY_DURATION_DEFAULT ((10 MINUTES) / PREGNANCY_DURATION_MULTIPLIER)
/// Minimum duration of pregnancy.
#define PREGNANCY_DURATION_MINIMUM ((1 MINUTES) / PREGNANCY_DURATION_MULTIPLIER)
/// Maximum duration of pregnancy.
#define PREGNANCY_DURATION_MAXIMUM ((4 HOURS) / PREGNANCY_DURATION_MULTIPLIER)

/// Default chance to get pregnant when someone climaxes inside you.
#define PREGNANCY_CHANCE_DEFAULT 1
/// Minimum chance to get pregnant.
#define PREGNANCY_CHANCE_MINIMUM 0
/// Maximum chance to get pregnant.
#define PREGNANCY_CHANCE_MAXIMUM 100

/// Cryptic pregnancies are not detected by health analyzers.
#define PREGNANCY_FLAG_CRYPTIC (1 << 0)
/// Pregnancy will inflate your belly (currently cosmetic: emits flavor text only, Nova lacks belly organ).
#define PREGNANCY_FLAG_BELLY_INFLATION (1 << 1)
/// Pregnancy will not create live offspring, only inert eggs.
#define PREGNANCY_FLAG_INERT (1 << 2)
/// Pregnancy will cause nausea effects.
#define PREGNANCY_FLAG_NAUSEA (1 << 3)

#define PREGNANCY_FLAGS_DEFAULT (PREGNANCY_FLAG_BELLY_INFLATION)

// Stages of pregnancy used by /datum/status_effect/pregnancy.
// Progress = round((elapsed / duration) * PREGNANCY_STAGE_MAX).
#define PREGNANCY_STAGE_PRESSURE 2
#define PREGNANCY_STAGE_SWELL 3
#define PREGNANCY_STAGE_LABOR 5
#define PREGNANCY_STAGE_MAX 5

/// Disgust applied on nausea proc per tick during gestation.
#define PREGNANCY_NAUSEA_DISGUST 30
/// Disgust per second during labor.
#define PREGNANCY_LABOR_DISGUST_PER_SECOND 3
/// Stamina loss rate (per second) during swell stage.
#define PREGNANCY_SWELL_STAMINA_PER_SECOND 2.5
/// Stamina-loss cap past which passive drain stops.
#define PREGNANCY_STAMINA_SOFT_CAP 50
/// Stamina-loss cap past which labor screaming stops.
#define PREGNANCY_STAMINA_HARD_CAP 100

/// Probability per tick (in percent) of a random fetal motion message during swell.
#define PREGNANCY_KICK_CHANCE 1.5
/// Probability per tick (in percent) of delivering the egg while lying down in labor.
#define PREGNANCY_DELIVERY_CHANCE 5
