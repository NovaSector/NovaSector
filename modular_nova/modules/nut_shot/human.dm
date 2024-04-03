#define NUTSHOT_VOMIT_CHANCE 10

// For when you want to hurt a motherfucker
/mob/living/carbon/human/proc/try_nut_shot(mob/living/attacker)
	if(stat >= UNCONSCIOUS)
		return
	if(!(attacker.zone_selected == BODY_ZONE_PRECISE_GROIN))
		return
	if(!has_balls(REQUIRE_GENITAL_EXPOSED))
		return
	Knockdown(1 SECONDS)

	var/nauseating = prob(NUTSHOT_VOMIT_CHANCE)
	if(nauseating)
		vomit(VOMIT_CATEGORY_DEFAULT)

	visible_message(span_danger("[attacker] punches [src] right in the nuts, causing them to [nauseating ? "throw up" : "double over"] in pain! Fuck!"))

#undef NUTSHOT_VOMIT_CHANCE
