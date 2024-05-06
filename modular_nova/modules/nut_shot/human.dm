/// How long someone is knocked down for when hit in the balls
#define NUTSHOT_KNOCKDOWN_TIME 1 SECONDS
/// The chance to make someone throw up when you punch them in the balls
#define NUTSHOT_VOMIT_CHANCE 20 // Also requires a knockdown punch, so the impact is a bit lower than it might appear.
/// The amount of damage you take when striking metallic balls
#define NUTSHOT_SELF_DAMAGE 10

// For when you want to hurt a motherfucker
/// Checks to see if it is possible to reach the mob's testicles and influence them through that - i.e. not medicated or unconscious. Knocks down when successful, with a small chance to vomit.
/mob/living/carbon/human/proc/try_nut_shot(mob/living/attacker)
	if(stat >= UNCONSCIOUS)
		return FALSE
	if(!(attacker.zone_selected == BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!has_balls(REQUIRE_GENITAL_EXPOSED))
		return FALSE

	var/balls_of_steel = issynthetic(src) // Update when we have cybernetic testes. When.
	var/is_kick = body_position == LYING_DOWN
	
	if(balls_of_steel) // hitting metal hurts
		attacker.apply_damage(
			damage = NUTSHOT_SELF_DAMAGE,
			def_zone = is_kick ? pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) : pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
		)

	if(HAS_TRAIT(src, TRAIT_ANALGESIA))
		visible_message(
			span_info("[attacker] [is_kick ? "kicks" : "punches"] [src] right in the nuts... but they don't react at all! What the hell?"),
			span_danger("You [is_kick ? "kick" : "punch"] [src] in the nuts with all your might... but your efforts are for naught as they remain impassive! Inhuman!")
			)
		return FALSE
	
	// General applied effects
	Knockdown(NUTSHOT_KNOCKDOWN_TIME)
	var/nauseating = prob(NUTSHOT_VOMIT_CHANCE)
	if(nauseating)
		vomit(VOMIT_CATEGORY_DEFAULT)

	visible_message(
		span_danger("[attacker] [is_kick ? "kicks" : "punches"] [src] right in the nuts, causing them to \
			[nauseating ? "throw up" : "double over"] in pain! \
			[balls_of_steel ? "Who the fuck programmed them to do that?!" : "Fuck!"]"\
			),
		span_danger("You [is_kick ? "kick" : "punch"] [src] right in the nuts, causing them to \
			[nauseating ? "throw up" : "double over"] in pain\
			[balls_of_steel ? "... But holy shit it hurts your [is_kick ? "leg" : "hand"]" : "! Fuck"]!"\
			),
		)

#undef NUTSHOT_VOMIT_CHANCE
#undef NUTSHOT_SELF_DAMAGE
#undef NUTSHOT_KNOCKDOWN_TIME
