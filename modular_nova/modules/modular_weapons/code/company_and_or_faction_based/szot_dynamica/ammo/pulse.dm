/obj/item/ammo_casing/pulse
	name = "pulse energy cell"
	desc = "A reusable energy cell for pulse weapons."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "zaibas_bullet"
	caliber = "pulse"
	projectile_type = /obj/projectile/beam/laser/plasma_glob/pulse
	var/max_uses = 15
	var/remaining_uses = 15
	harmful = FALSE

/obj/item/ammo_casing/pulse/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/item_scaling, 0.45, 1)
	remaining_uses = max_uses
	if(projectile_type)
		loaded_projectile = new projectile_type(src)

/obj/item/ammo_casing/pulse/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	if(remaining_uses <= 0)
		if(!quiet)
			to_chat(user, span_warning("[src] is depleted!"))
		return FALSE
	return ..()

/obj/item/ammo_casing/pulse/add_notes_ammo()
	var/list/readout = list()
	var/initial_brute = 20
	var/initial_burn = 10

	// Get damage multiplier if in a gun
	var/proj_damage_mult = 1
	if(isammobox(loc))
		var/obj/item/ammo_box/our_box = loc
		if(isgun(our_box.loc))
			var/obj/item/gun/our_gun = our_box.loc
			proj_damage_mult = our_gun.projectile_damage_multiplier
	else if(isgun(loc))
		var/obj/item/gun/our_gun = loc
		proj_damage_mult = our_gun.projectile_damage_multiplier

	// Calculate total damage per shot (brute + burn)
	var/total_damage = (initial_brute + initial_burn) * proj_damage_mult

	if(total_damage <= 0)
		return "Our legal team has determined these [span_warning(caliber)] plasma pulses to be non-lethal."

	readout += "These [span_warning(caliber)] plasma pulses deliver a combined [span_warning("[total_damage] damage")] per shot ([span_warning("[initial_brute * proj_damage_mult] brute")] + [span_warning("[initial_burn * proj_damage_mult] burn")])."
	readout += "Most test subjects succumbed to their wounds after [span_warning("[HITS_TO_CRIT(total_damage)] pulse\s")] at point-blank range."

	return readout.Join("\n")

/obj/item/ammo_casing/pulse/newshot()
	if(remaining_uses <= 0)
		return FALSE
	if(!loaded_projectile)
		loaded_projectile = new projectile_type(src)
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)
		remaining_uses--
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	return TRUE

/obj/item/ammo_casing/pulse/update_overlays()
	. = ..()
	var/use_percent = remaining_uses / max_uses
	switch(use_percent)
		if(0.7 to 1)
			. += "zaibas_bullet_3"
		if(0.3 to 0.7)
			. += "zaibas_bullet_2"
		if(0.1 to 0.3)
			. += "zaibas_bullet_1"
		if(0)
			. += "zaibas_bullet_0"

/obj/projectile/beam/laser/plasma_glob/pulse
	name = "pulse energy"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "plasma_pulse"
	damage = 20
	armour_penetration = 30
	wound_bonus = 5
	exposed_wound_bonus = 10
	light_range = 1
	light_color = LIGHT_COLOR_PURPLE
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser

/obj/projectile/beam/laser/plasma_glob/pulse/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/hit_limb_zone
	if(isliving(target))
		var/mob/living/victim = target
		hit_limb_zone = victim.check_hit_limb_zone_name(def_zone)
		var/armour_block = victim.run_armor_check(hit_limb_zone, BULLET, armour_penetration = 20)
		victim.apply_damage(10, BRUTE, hit_limb_zone, blocked = armour_block, wound_bonus = 5, exposed_wound_bonus = 10, sharpness = SHARP_POINTY)
