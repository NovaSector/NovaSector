/obj/item/grenade/syndieminibomb/concussion/impact
	name = "Offensive Impact Grenade"
	desc = "An impact-fuzed grenade with no shrapnel and a relatively small explosive mass for offensive action."
	icon = 'modular_np_lethal/lethalguns/icons/grenades.dmi'
	icon_state = "impact_offense"
	ex_heavy = 0
	ex_light = 2
	ex_flame = 2

/obj/item/grenade/syndieminibomb/concussion/impact/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!active)
		return
	detonate()

/obj/item/grenade/frag/impact
	name = "Defensive Impact Grenade"
	desc = "An impact-fuzed grenade with large amounts of shrapnel and high explosive mass for defensive action."
	icon = 'modular_np_lethal/lethalguns/icons/grenades.dmi'
	icon_state = "impact_defense"
	shrapnel_type = /obj/projectile/bullet/shrapnel
	shrapnel_radius = 3
	ex_heavy = 0
	ex_light = 3
	ex_flame = 4

/obj/item/grenade/frag/impact/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!active)
		return
	detonate()
