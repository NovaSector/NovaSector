// This is just to remove the TG paralyze on the gorilla, if this is still here after that's gone, uh-oh.
/mob/living/basic/gorilla
  var/paralyze_chance = 20

  
/mob/living/basic/gorilla/melee_attack(mob/living/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	ooga_ooga()
	if (prob(paralyze_chance))
		target.Knockdown(1 SECONDS)
		visible_message(span_danger("[src] knocks [target] down!"))
	else
		target.throw_at(get_edge_target_turf(target, dir), range = rand(1, 2), speed = 7, thrower = src)
