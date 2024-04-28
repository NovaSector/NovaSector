// Impact grenades for offense, has no shrapnel and a pretty small kaboom

/obj/item/grenade/syndieminibomb/concussion/impact
	name = "Offensive Impact Grenade"
	desc = "An impact-fuzed grenade with no shrapnel and a relatively small explosive mass for offensive action. \
		The impact explosive will not be ready until <b>1/3 of the 5 second arming time has passed</b> and it will \
		behave like a <b>regular grenade</b> if thrown <b>before that time</b>."
	icon = 'modular_np_lethal/lethalguns/icons/grenades.dmi'
	icon_state = "impact_offense"
	ex_dev = 0
	ex_heavy = 0
	ex_light = 2
	ex_flame = 0
	/// Can this grenade explode on impact yet?
	var/impact_explosion_ready = FALSE

/obj/item/grenade/syndieminibomb/concussion/impact/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!impact_explosion_ready)
		return
	detonate()

/obj/item/grenade/syndieminibomb/concussion/impact/arm_grenade(mob/user, delayoverride, msg = TRUE, volume = 60)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(ready_impact)), det_time / 3)

/// Allows the grenade to explode on throw impact
/obj/item/grenade/syndieminibomb/concussion/impact/proc/ready_impact()
	impact_explosion_ready = TRUE

// Impact grenades for defense, has shrapnel and a bigger boom

/obj/item/grenade/frag/impact
	name = "Defensive Impact Grenade"
	desc = "An impact-fuzed grenade with large amounts of shrapnel and high explosive mass for defensive action. \
		The impact explosive will not be ready until <b>1/2 of the 5 second arming time has passed</b> and it will \
		behave like a <b>regular grenade</b> if thrown <b>before that time</b>."
	icon = 'modular_np_lethal/lethalguns/icons/grenades.dmi'
	icon_state = "impact_defense"
	shrapnel_type = /obj/projectile/bullet/shrapnel
	shrapnel_radius = 3
	ex_dev = 0
	ex_heavy = 0
	ex_light = 3
	ex_flame = 0
	/// Can this grenade explode on impact yet?
	var/impact_explosion_ready = FALSE

/obj/item/grenade/frag/impact/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!impact_explosion_ready)
		return
	detonate()

/obj/item/grenade/frag/impact/arm_grenade(mob/user, delayoverride, msg = TRUE, volume = 60)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(ready_impact)), det_time / 2)

/// Allows the grenade to explode on throw impact
/obj/item/grenade/frag/impact/proc/ready_impact()
	impact_explosion_ready = TRUE
