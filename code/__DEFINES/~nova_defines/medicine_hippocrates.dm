// modular_nova/modules/MEDICINE_HIPPOCRATES

/*
 * Liver load categories.
 *
 * A medicine declares which kinds of damage it asks the liver to help it repair. Medicines that
 * share a category pile their load onto the same pool, and a pool over LIVER_LOAD_FREE_LOAD starts
 * dragging down how much good every medicine feeding that pool actually does.
 *
 * These are bitflags so that a panacea can load several pools at once without allocating a list per
 * reagent instance.
 */
#define LIVER_LOAD_BRUTE (1<<0)
#define LIVER_LOAD_BURN (1<<1)
#define LIVER_LOAD_TOXIN (1<<2)
#define LIVER_LOAD_OXYGEN (1<<3)

/// Every liver load category, for panaceas and for iterating the load pools.
#define LIVER_LOAD_ALL (LIVER_LOAD_BRUTE|LIVER_LOAD_BURN|LIVER_LOAD_TOXIN|LIVER_LOAD_OXYGEN)

/// Combined load a single pool can carry before medicines feeding it start losing effectiveness.
#define LIVER_LOAD_FREE_LOAD 1
/// The floor liver load can drag a medicine's effectiveness down to.
#define LIVER_LOAD_MIN_EFFICIENCY 0.35
/// Combined load at which the patient starts feeling the pain (nausea, drowsiness, dizziness).
#define LIVER_LOAD_STRAIN_LOAD 1.5
/// How long the overmedicated status effect sticks around after the last metabolism tick that refreshed it.
#define LIVER_LOAD_STRAIN_DURATION (12 SECONDS)
/// Liver quality multiplier used when the patient has no liver at all - unfiltered, everything hits twice as hard.
#define LIVER_LOAD_NO_LIVER_QUALITY 0.5
/// Worst liver quality multiplier a ruined-but-present liver can give.
#define LIVER_LOAD_MIN_LIVER_QUALITY 0.25
