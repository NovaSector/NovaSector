/// Projectile fired by Spine Spit. Drops a landed spine on hit or at max range.
/obj/projectile/hiveless_spine
	name = "chitinous spine"
	desc = "A barbed, bone-white spine torn straight from something's ribcage."
	icon = 'modular_nova/modules/hiveless/icons/hiveless_projectiles.dmi'
	icon_state = "spine"
	damage = 14
	damage_type = BRUTE
	armor_flag = BULLET
	armour_penetration = 40
	speed = 1.2
	range = 9
	sharpness = SHARP_POINTY
	wound_bonus = 5
	hitsound = 'sound/items/weapons/pierce.ogg'
	impact_effect_type = /obj/effect/temp_visual/dir_setting/bloodsplatter
	embed_type = /datum/embedding/hiveless_spine
	shrapnel_type = /obj/item/hiveless_spine
	embed_falloff_tile = -3
	/// Secondary burn damage applied on top of the brute damage on hit.
	var/bonus_burn = 6

/obj/projectile/hiveless_spine/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(. == BULLET_ACT_BLOCK)
		return
	if(bonus_burn && isliving(target))
		var/mob/living/victim = target
		victim.apply_damage(bonus_burn, BURN, def_zone, blocked)
	drop_landed_spine(get_turf(target))

/obj/projectile/hiveless_spine/on_range()
	drop_landed_spine(get_turf(src))
	return ..()

/// Spawns a landed spine on `where` if it's a valid turf.
/obj/projectile/hiveless_spine/proc/drop_landed_spine(turf/where)
	if(!where || !isturf(where))
		return
	new /obj/item/hiveless_spine(where)

/// Pickupable spine left on the ground after a projectile lands.
/obj/item/hiveless_spine
	name = "chitinous spine"
	desc = "A barbed bone spine, still slick with ichor. Sharp enough to draw blood if you grab it wrong."
	icon = 'modular_nova/modules/hiveless/icons/hiveless_projectiles.dmi'
	icon_state = "spine_landed"
	w_class = WEIGHT_CLASS_TINY
	force = 6
	throwforce = 8
	throw_speed = 4
	throw_range = 5
	sharpness = SHARP_POINTY
	attack_verb_continuous = list("jabs", "stabs", "pokes")
	attack_verb_simple = list("jab", "stab", "poke")
	hitsound = 'sound/items/weapons/pierce.ogg'

/// Embedding profile for a spine that sticks into a target on impact.
/datum/embedding/hiveless_spine
	embed_chance = 35
	fall_chance = 3
	pain_chance = 20
	pain_mult = 3
	impact_pain_mult = 5
	remove_pain_mult = 8
	rip_time = 2 SECONDS
	jostle_chance = 8
	jostle_pain_mult = 2
	ignore_throwspeed_threshold = TRUE
