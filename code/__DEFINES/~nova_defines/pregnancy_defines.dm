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
/// Pregnancy will cause nausea effects.
#define PREGNANCY_FLAG_NAUSEA (1 << 2)

#define PREGNANCY_FLAGS_DEFAULT (PREGNANCY_FLAG_BELLY_INFLATION)

// Stages of pregnancy used by /datum/status_effect/pregnancy.
// Pregnancy is a persistent status; stages advance to stable late pregnancy and stay there until removed.
#define PREGNANCY_STAGE_PRESSURE 1
#define PREGNANCY_STAGE_SWELL 2
#define PREGNANCY_STAGE_STABLE 3
#define PREGNANCY_STAGE_PRESSURE_TIME (2 MINUTES)
#define PREGNANCY_STAGE_SWELL_TIME (5 MINUTES)
#define PREGNANCY_STAGE_STABLE_TIME (10 MINUTES)

/// Disgust applied on nausea proc per tick during gestation.
#define PREGNANCY_NAUSEA_DISGUST 30
/// Stamina loss rate (per second) during swell stage.
#define PREGNANCY_SWELL_STAMINA_PER_SECOND 2.5
/// Stamina-loss cap past which passive drain stops.
#define PREGNANCY_STAMINA_SOFT_CAP 50

/// Probability per tick (in percent) of a random fetal motion message during swell.
#define PREGNANCY_KICK_CHANCE 1.5
