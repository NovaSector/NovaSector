/obj/item/ammo_casing/pulse
	name = "pulse energy cell"
	desc = "A reusable energy cell for pulse weapons."
	icon_state = "pulse-casing"
	caliber = "pulse"
	projectile_type = /obj/projectile/bullet/pulse
	var/max_uses = 15
	var/remaining_uses = 15
	harmful = FALSE

/obj/item/ammo_casing/pulse/Initialize(mapload)
	. = ..()
	remaining_uses = max_uses
	if(projectile_type)
		loaded_projectile = new projectile_type(src)

/obj/item/ammo_casing/pulse/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	if(remaining_uses <= 0)
		if(!quiet)
			to_chat(user, span_warning("[src] is depleted!"))
		return FALSE
	return ..()

/obj/item/ammo_casing/pulse/newshot()
	if(remaining_uses <= 0)
		return FALSE
	if(!loaded_projectile)
		loaded_projectile = new projectile_type(src)
		name = initial(name)
		desc = initial(desc)
		remaining_uses--
	return TRUE

/obj/item/ammo_casing/pulse/update_icon_state()
	. = ..()
	var/use_percent = remaining_uses / max_uses
	if(use_percent > 0.66)
		icon_state = "pulse-casing"
	else if(use_percent > 0.33)
		icon_state = "pulse-casing_medium"
	else if(remaining_uses > 0)
		icon_state = "pulse-casing_low"
	else
		icon_state = "pulse-casing_empty"

/obj/projectile/bullet/pulse
	name = "pulse energy"
	icon_state = "pulse"
	damage = 20
	damage_type = BURN
	armor_flag = ENERGY
	light_range = 2
	light_color = LIGHT_COLOR_ELECTRIC_CYAN
	impact_effect_type = /obj/effect/temp_visual/impact_effect/pulse

/obj/effect/temp_visual/impact_effect/pulse
	icon_state = "pulse_impact"
	duration = 5
