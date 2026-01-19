/obj/item/ammo_box/pulse_cargo_box
	name = "ammo canister (pulse energy cell)"
	desc = "A stabilizing canister of plasma pulse energy cells, holds eight cells."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "plasma_pulse_box"

	multiple_sprites = AMMO_BOX_PER_BULLET

	w_class = WEIGHT_CLASS_NORMAL

	caliber = "pulse"
	casing_phrasing = "plug"
	ammo_type = /obj/item/ammo_casing/pulse
	max_ammo = 8

/obj/item/ammo_box/pulse_cargo_box/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/ammo_box/pulse_cargo_box/top_off(load_type, starting=FALSE)
// Always create new instances rather than storing paths. Due to the nature of the pulse cartridges, this is important to properly track remaining ammo.
	. = ..(load_type, starting = FALSE)

/obj/item/ammo_casing/pulse
	name = "pulse energy cell"
	desc = "A reusable energy cell for pulse weapons."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "zaibas_bullet"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.25, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 1, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75)
	caliber = "pulse"
	projectile_type = /obj/projectile/beam/laser/plasma_glob/pulse
	///Maximum amount of times this casing can be used.
	var/max_uses = 15
	///Current amount of times this casing can be used.
	var/remaining_uses = 15
	///If TRUE, this casing will not consume uses when fired; relying on the gun to do that instead.
	var/suppress_use_consumption = FALSE
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
	// Reset suppress_use_consumption flag when used in a different weapon
	if(fired_from && istype(fired_from, /obj/item/gun))
		var/obj/item/gun/weapon = fired_from
		if(!istype(weapon, /obj/item/gun/ballistic/rifle/pulse_sniper))
			suppress_use_consumption = FALSE
	return ..()

/obj/item/ammo_casing/pulse/add_notes_ammo()
	var/list/readout = list()
	var/initial_burn = /obj/projectile/beam/laser/plasma_glob/pulse::damage
	var/initial_brute = /obj/projectile/beam/laser/plasma_glob/pulse::secondary_damage

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
	else if(istype(loc, /obj/item/ammo_box/magazine/internal))
		// Handle internal magazines like in the pulse sniper
		var/obj/item/ammo_box/magazine/internal/internal_mag = loc
		if(isgun(internal_mag.loc))
			var/obj/item/gun/our_gun = internal_mag.loc
			proj_damage_mult = our_gun.projectile_damage_multiplier

	// Calculate total damage per shot (brute + burn)
	var/total_damage = (initial_brute + initial_burn) * proj_damage_mult

	if(total_damage <= 0)
		return "Our legal team has determined these [span_warning(caliber)] plasma pulses to be non-lethal."

	readout += "These [span_warning(caliber)] pulses deliver a combined [span_warning("[total_damage] damage")] per shot ([span_warning("[initial_brute * proj_damage_mult] brute")] + [span_warning("[initial_burn * proj_damage_mult] burn")])."
	readout += "Most test subjects succumbed to their wounds after [span_warning("[HITS_TO_CRIT(total_damage)] pulse\s")] at point-blank range."

	return readout.Join("\n")

/obj/item/ammo_casing/pulse/newshot()
	if(remaining_uses <= 0)
		QDEL_NULL(loaded_projectile)
		return FALSE
	if(!loaded_projectile)
		loaded_projectile = new projectile_type(src, src)
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)
		// Only decrement uses if not suppressed (for special weapons like pulse sniper)
		if(!suppress_use_consumption)
			remaining_uses--
	return TRUE

/obj/item/ammo_casing/pulse/update_overlays()
	. = ..()
	if(remaining_uses <= 0)
		. += "zaibas_bullet_0"
		return
	var/use_percent = remaining_uses / max_uses
	switch(use_percent)
		if(0.7 to 1)
			. += "zaibas_bullet_3"
		if(0.3 to 0.7)
			. += "zaibas_bullet_2"
		if(0.1 to 0.3)
			. += "zaibas_bullet_1"

/obj/projectile/beam/laser/plasma_glob/pulse
	name = "pulse energy"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "plasma_pulse"
	damage = 15
	speed = /obj/projectile::speed
	wound_bonus = 5
	exposed_wound_bonus = 10
	light_range = 1
	light_color = LIGHT_COLOR_PURPLE
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	///Which damage type do we deal as a secondary effect?
	var/secondary_damage_type = BRUTE
	///How much secondary damage do we deal?
	var/secondary_damage = 10
	///How much chance does it have to proc wounds?
	var/secondary_wound_bonus = 5
	///How much chance does it have to proc wounds on exposed targets?
	var/secondary_exposed_wound_bonus = 10
	///How much penetration does it have?
	var/secondary_armour_penetration = 0
	///Which armor protects against it?
	var/secondary_armor_flag = BULLET

/obj/projectile/beam/laser/plasma_glob/pulse/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/hit_limb_zone
	if(isliving(target))
		var/mob/living/victim = target
		hit_limb_zone = victim.check_hit_limb_zone_name(def_zone)
		var/armour_block = victim.run_armor_check(hit_limb_zone, secondary_armor_flag, armour_penetration = secondary_armour_penetration)

		// Get the projectile damage multiplier from the gun that fired this projectile
		var/proj_damage_mult = 1
		if(fired_from && istype(fired_from, /obj/item/gun))
			var/obj/item/gun/gun = fired_from
			proj_damage_mult = gun.projectile_damage_multiplier

		// Modify brute damage with the multiplier
		var/brute_damage = secondary_damage * proj_damage_mult

		// Apply brute damage
		victim.apply_damage(brute_damage, secondary_damage_type, hit_limb_zone, blocked = armour_block, wound_bonus = secondary_wound_bonus, exposed_wound_bonus = secondary_exposed_wound_bonus, sharpness = SHARP_POINTY)
