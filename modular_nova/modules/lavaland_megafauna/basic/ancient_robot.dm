#define BODY_SHIELD_COOLDOWN_TIME 3 SECONDS
#define EXTRA_PLAYER_ANGER_NORMAL_CAP 6
#define EXTRA_PLAYER_ANGER_STATION_CAP 3
#define BLUESPACE 1
#define GRAV 2
#define PYRO 3
#define FLUX 4
#define VORTEX 5
#define CRYO 6
#define TOP_RIGHT 1
#define TOP_LEFT 2
#define BOTTOM_RIGHT 3
#define BOTTOM_LEFT 4

#define ROBOT_ENRAGED (health < maxHealth*0.5)

/mob/living/basic/megafauna/ancient_robot
	name = "\improper Vetus Speculator"
	health = 3000
	maxHealth = 3000
	ai_controller = /datum/ai_controller/basic_controller/ancient_robot
	icon = 'modular_nova/modules/lavaland_megafauna/icons/64x64megafauna.dmi'
	icon_state = "ancient_robot"

	var/charging = FALSE
	var/exploding = FALSE
	var/body_shield_enabled = FALSE
	var/mode = 0

	// Legs (Now Basic Mobs)
	var/mob/living/basic/ancient_robot_leg/TR
	var/mob/living/basic/ancient_robot_leg/TL
	var/mob/living/basic/ancient_robot_leg/BR
	var/mob/living/basic/ancient_robot_leg/BL

/mob/living/basic/megafauna/ancient_robot/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE, TRAIT_BOMBIMMUNE), INNATE_TRAIT)

	TR = new(loc, src, TOP_RIGHT)
	TL = new(loc, src, TOP_LEFT)
	BR = new(loc, src, BOTTOM_RIGHT)
	BL = new(loc, src, BOTTOM_LEFT)

	mode = pick(BLUESPACE, GRAV, PYRO, FLUX, VORTEX, CRYO)
	body_shield()
	return INITIALIZE_HINT_LATELOAD

/mob/living/basic/megafauna/ancient_robot/death(gibbed, allowed = FALSE)
	if(allowed)
		return ..()
	if(exploding)
		return
	self_destruct()
	exploding = TRUE

/mob/living/basic/megafauna/ancient_robot/proc/body_shield()
	body_shield_enabled = TRUE
	add_overlay("shield")

/mob/living/basic/megafauna/ancient_robot/bullet_act(obj/projectile/P)
	if(!body_shield_enabled)
		return ..()
	if(P.damage)
		disable_shield()
	return ..()

/mob/living/basic/megafauna/ancient_robot/proc/disable_shield()
	cut_overlay("shield")
	body_shield_enabled = FALSE
	addtimer(CALLBACK(src, PROC_REF(body_shield)), 3 SECONDS)

/mob/living/basic/megafauna/ancient_robot/proc/self_destruct()
	say("-ROQK ZKGXY OT XGOT-")
	addtimer(CALLBACK(src, PROC_REF(kaboom)), 10 SECONDS)

/mob/living/basic/megafauna/ancient_robot/proc/kaboom()
	explosion(get_turf(src), -1, 7, 15, 20)
	death(allowed = TRUE)

/mob/living/basic/ancient_robot_leg
	name = "leg"
	icon = 'modular_nova/modules/lavaland_megafauna/icons/lavaland_monsters.dmi'
	icon_state = "leg"
	health = INFINITY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT // Prevent clicking legs over the core
	var/mob/living/basic/megafauna/ancient_robot/core

/mob/living/basic/ancient_robot_leg/Initialize(mapload, mob/living/basic/megafauna/ancient_robot/owner, who)
	. = ..()
	core = owner
	if(!core)
		return INITIALIZE_HINT_QDEL
	add_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE, TRAIT_BOMBIMMUNE), INNATE_TRAIT)

/mob/living/basic/ancient_robot_leg/adjust_health(amount, updating_health = TRUE)
	var/damage = amount * 0.75
	core.adjustBruteLoss(damage)
	return ..()

#undef BODY_SHIELD_COOLDOWN_TIME
#undef EXTRA_PLAYER_ANGER_NORMAL_CAP
#undef EXTRA_PLAYER_ANGER_STATION_CAP
#undef BLUESPACE
#undef GRAV
#undef PYRO
#undef FLUX
#undef CRYO
#undef VORTEX

#undef TOP_RIGHT
#undef TOP_LEFT
#undef BOTTOM_RIGHT
#undef BOTTOM_LEFT
