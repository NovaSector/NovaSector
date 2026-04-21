/// Fired on a mob at the end of a successful climax into a partner orifice.
/// args: (mob/living/partner, climax_into_choice)
/// climax_into_choice is the slot string as built by climax.dm — one of
/// ORGAN_SLOT_VAGINA, "asshole", "mouth" (plus the non-penetrative variants penis/sheath/"On them").
/// Receivers: pregnancy trigger, knotting trigger, future inflation hooks.
#define COMSIG_MOB_POST_CLIMAX "mob_post_climax"

/// Default duration a knot stays tied before it loosens automatically.
#define KNOT_DEFAULT_DURATION (30 SECONDS)
/// Minimum knot duration.
#define KNOT_MIN_DURATION (10 SECONDS)
/// Maximum knot duration
#define KNOT_MAX_DURATION (2 MINUTES)
