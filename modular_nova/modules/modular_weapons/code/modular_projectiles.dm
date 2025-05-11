/obj/item/ammo_casing
	/// Can this bullet casing be printed at an ammunition workbench?
	var/can_be_printed = TRUE
	/// If it can be printed, does this casing require an advanced ammunition datadisk? Mainly for specialized ammo.
	/// Rubbers aren't advanced. Standard ammo (or FMJ if you're particularly pedantic) isn't advanced.
	/// Think more specialized or weird, niche ammo, like armor-piercing, incendiary, hollowpoint, or God forbid, phasic.
	var/advanced_print_req = FALSE

// whatever goblin decided to spread out bullets over like 3 files and god knows however many overrides i wish you a very stubbed toe

/*
*	.38 Special
*/
#define COLOR_AMMO_EMP "#5f959c" // not undefining because it might be applicable for other EMP bullets in the future. no modular color defines file exists

/obj/item/ammo_casing/c38/haywire
	name = ".38 Haywire bullet casing"
	desc = "A .38 Haywire bullet casing, with an electromagnetic generator in the tip.\
		<br><br>\
		<i>HAYWIRE: Electromagnetic pulse ammo. Deals little damage, but causes a small electromagnetic pulse.</i>"
	projectile_type = /obj/projectile/bullet/c38/haywire
	custom_materials = AMMO_MATS_EMP
	advanced_print_req = TRUE

/obj/item/ammo_box/c38/haywire
	name = "speed loader (.38 Haywire)"
	desc = "Designed to quickly reload revolvers. These rounds create small electromagnetic pulses upon impact."
	ammo_type = /obj/item/ammo_casing/c38/haywire
	ammo_band_color = COLOR_AMMO_EMP

/obj/item/ammo_box/magazine/m38/haywire
	name = "battle rifle magazine (.38 Haywire)"
	desc = parent_type::desc + " These bullets create small electromagnetic pulses on impact; devastating against electronics."
	ammo_type = /obj/item/ammo_casing/c38/haywire
	ammo_band_color = COLOR_AMMO_EMP

/obj/projectile/bullet/c38/haywire
	name = ".38 haywire bullet"
	damage = 10
	ricochets_max = 0
	embed_type = null
	/// EMP radius when this bullet hits a target.
	var/emp_radius = 0

/obj/projectile/bullet/c38/haywire/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	empulse(target, 0, emp_radius)

/*
*	.357 Magnum
*/

/obj/item/ammo_casing/c357/haywire
	name = ".357 Haywire+ bullet casing"
	desc = "A .357 Haywire+ bullet casing, with a high-efficiency electromagnetic generator in the tip.\
		<br><br>\
		<i>HAYWIRE+: Electromagnetic pulse ammo. Deals moderate damage, and cause a small, but powerful, electromagnetic pulse.</i>"
	projectile_type = /obj/projectile/bullet/c357/haywire
	custom_materials = AMMO_MATS_EMP
	advanced_print_req = TRUE

/obj/item/ammo_box/a357/haywire
	name = "speed loader (.357 Haywire+)"
	desc = "Designed to quickly reload revolvers. These rounds create small, but powerful electromagnetic pulses upon impact."
	ammo_type = /obj/item/ammo_casing/c357/haywire
	ammo_band_color = COLOR_AMMO_EMP

/obj/projectile/bullet/c357/haywire
	name = ".357 Haywire+ bullet"
	damage = 40
	ricochets_max = 0
	embed_type = null
	/// EMP radius when this bullet hits a target.
	var/emp_radius = 1

/obj/projectile/bullet/c357/haywire/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	empulse(target, emp_radius, emp_radius)

/*
*	.460 Ceres (renamed tgcode .45)
*/

/obj/item/ammo_casing/c45/rubber
	name = ".460 Ceres rubber bullet casing"
	desc = "A .460 bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c45/rubber
	harmful = FALSE

/obj/projectile/bullet/c45/rubber
	name = ".460 Ceres rubber bullet"
	damage = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	wound_bonus = -50

/obj/item/ammo_casing/c45/hp
	name = ".460 Ceres hollow-point bullet casing"
	desc = "A .460 hollow-point bullet casing. Very lethal against unarmored opponents. Suffers against armor."
	projectile_type = /obj/projectile/bullet/c45/hp
	advanced_print_req = TRUE

/obj/projectile/bullet/c45/hp
	name = ".460 Ceres hollow-point bullet"
	damage = 40
	weak_against_armour = TRUE

/*
*	8mm Usurpator (renamed tg c46x30mm, used in the WT550)
*/

/obj/projectile/bullet/c46x30mm_rubber
	name = "8mm Usurpator rubber bullet"
	damage = 3
	stamina = 17
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	wound_bonus = -50

/obj/item/ammo_casing/c46x30mm/rubber
	name = "8mm Usurpator rubber bullet casing"
	desc = "An 8mm Usurpator rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c46x30mm_rubber
	harmful = FALSE

/*
*	.277 Aestus (renamed tgcode .223, used in the M-90gl)
*/

/obj/item/ammo_casing/a223/rubber
	name = ".277 Aestus rubber bullet casing"
	desc = "A .277 rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/a223/rubber
	harmful = FALSE

/obj/projectile/bullet/a223/rubber
	name = ".277 rubber bullet"
	damage = 10
	armour_penetration = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	wound_bonus = -50

/obj/item/ammo_casing/a223/ap
	name = ".277 Aestus armor-piercing bullet casing"
	desc = "A .277 armor-piercing bullet casing.\
	<br><br>\
	<i>ARMOR PIERCING: Increased armor piercing capabilities. What did you expect?"
	projectile_type = /obj/projectile/bullet/a223/ap
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_AP

/obj/projectile/bullet/a223/ap
	name = ".277 armor-piercing bullet"
	armour_penetration = 60
