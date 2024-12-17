/obj/projectile/bullet/kineticball
	name = "kinetic orb"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/bolt_fabrications/riotrubberbullet.dmi'
	icon_state = "riotrubberbullet"
	// Used the hive shot stats, with 0 colateral damage, the advantage is that its not weak against armor, and its supposed to bounce a lot.
	damage = 0
	stamina = 30
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	ricochet_incidence_leeway = 0
	ricochets_max = 5
	ricochet_chance = 200
	ricochet_auto_aim_angle = 60
	ricochet_auto_aim_range = 8
	ricochet_decay_damage = 0.9
	ricochet_decay_chance = 1
	wound_bonus = -30
	bare_wound_bonus = -10

/obj/item/ammo_casing/kineticball
	name = "kinetic ball casing"
	desc = "A kinetic ball casing."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/bolt_fabrications/stingtop.dmi'
	icon_state = "stingstop"
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/kineticball
	caliber = CALIBER_KINETICBALL
	projectile_type = /obj/projectile/bullet/kineticball
	harmful = FALSE

/obj/item/ammo_box/magazine/ammo_stack/kineticball
	name = "kinetic ball casings"
	desc = "A stack of kinetic ball cartridges."
	caliber = CALIBER_KINETICBALL
	ammo_type = /obj/item/ammo_casing/kineticball
	max_ammo = 9
	casing_x_positions = list(
		-7,
		-5,
		-3,
		-1,
		0,
		1,
		3,
		5,
		7,
	)
	casing_y_padding = 6
