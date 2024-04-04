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

	var/synthetic = issynthetic(src)
	var/is_kick = body_position == LYING_DOWN
	
	if(synthetic) // hitting metal hurts
		attacker.apply_damage(
			damage = 10,
			def_zone = is_kick ? pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) : pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
		)

	if(HAS_TRAIT(src, TRAIT_ANALGESIA))
		visible_message(
			span_info("[attacker] [is_kick ? "kicks" : "punches"] [src] right in the nuts... but they don't react at all! What the hell?"),
			span_danger("You [is_kick ? "kick" : "punch"] [src] in the nuts with all your might... but your efforts are for naught as they remain impassive! Inhuman!")
			)
		return FALSE
	
	// General applied effects
	Knockdown(1 SECONDS)
	var/nauseating = prob(NUTSHOT_VOMIT_CHANCE)
	if(nauseating)
		vomit(VOMIT_CATEGORY_DEFAULT)

	visible_message(
		span_danger("[attacker] [is_kick ? "kicks" : "punches"] [src] right in the nuts, causing them to \
			[nauseating ? "throw up" : "double over"] in pain! \
			[synthetic ? "Who the fuck programmed them to do that?!" : "Fuck!"]"\
			),
		span_danger("You [is_kick ? "kick" : "punch"] [src] right in the nuts, causing them to \
			[nauseating ? "throw up" : "double over"] in pain\
			[synthetic ? "... But holy shit it hurts your [is_kick ? "leg" : "hand"]" : "! Fuck"]!"\
			),
		)

#undef NUTSHOT_VOMIT_CHANCE
