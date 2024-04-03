/// The chance to make someone throw up when you punch them in the balls
#define NUTSHOT_VOMIT_CHANCE 20 // Also requires a knockdown punch, so the impact is a bit lower than it might appear.

// For when you want to hurt a motherfucker
/mob/living/carbon/human/proc/try_nut_shot(mob/living/attacker)
	if(stat >= UNCONSCIOUS)
		return FALSE
	if(!(attacker.zone_selected == BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!has_balls(REQUIRE_GENITAL_EXPOSED))
		return FALSE
	Knockdown(1 SECONDS)

	var/nauseating = prob(NUTSHOT_VOMIT_CHANCE)
	if(nauseating)
		vomit(VOMIT_CATEGORY_DEFAULT)

	visible_message(span_danger("[attacker] punches [src] right in the nuts, causing them to [nauseating ? "throw up" : "double over"] in pain! Fuck!"))

#undef NUTSHOT_VOMIT_CHANCE
