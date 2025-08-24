/*
*	4.6x30mm
*/

/obj/item/ammo_casing/c46x30mm/ap
	desc = "A 4.6x30mm armor-piercing bullet casing.\
		<br><br>\
		<i>ARMOR PIERCING: Increased armor piercing capabilities. Reduced stopping power.</i>"
	ammo_categories = AMMO_CLASS_PLUS
	custom_materials = AMMO_MATS_AP

/obj/item/ammo_casing/c46x30mm/inc
	desc = "A 4.6x30mm incendiary bullet casing.\
		<br><br>\
		<i>INCENDIARY: Leaves a trail of fire when shot, sets targets aflame.</i>"
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_TEMP

/obj/item/ammo_casing/c46x30mm/rubber
	name = "4.6x30mm rubber bullet casing"
	desc = "A 4.6x30mm rubber bullet casing.\
		<br><br>\
		<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	ammo_categories = AMMO_CLASS_NONE
	projectile_type = /obj/projectile/bullet/c46x30mm/rubber
	harmful = FALSE

/*
*	.223
*/

/obj/item/ammo_casing/a223/weak
	can_be_printed = FALSE

/obj/item/ammo_casing/a223/phasic
	desc = "A .223 phasic bullet casing.\
		<br><br>\
		<i>PHASIC: Ignores all surfaces except organic matter.</i>"
	ammo_categories = AMMO_CLASS_ESOTERIC
	custom_materials = AMMO_MATS_PHASIC

/obj/item/ammo_casing/a223/rubber
	name = ".223 rubber bullet casing"
	desc = "A .223 rubber bullet casing.\
		<br><br>\
		<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	ammo_categories = AMMO_CLASS_NONE
	projectile_type = /obj/projectile/bullet/a223/rubber
	harmful = FALSE

/obj/item/ammo_casing/a223/ap
	name = ".223 armor-piercing bullet casing"
	desc = "A .223 armor-piercing bullet casing.\
		<br><br>\
		<i>ARMOR PIERCING: Increased armor piercing capabilities.</i>"
	projectile_type = /obj/projectile/bullet/a223/ap
	ammo_categories = AMMO_CLASS_PLUS
	custom_materials = AMMO_MATS_AP

/obj/projectile/bullet/a223/ap
	name = ".223 armor-piercing bullet"
	damage = 30
	armour_penetration = 60

/*
*	7mm (L6 SAW)
*/

/obj/item/ammo_casing/m7mm/ap
	ammo_categories = AMMO_CLASS_PLUS
	custom_materials = AMMO_MATS_AP

/obj/item/ammo_casing/m7mm/hollow
	ammo_categories = AMMO_CLASS_PLUS

/obj/item/ammo_casing/m7mm/incen
	ammo_categories = AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_TEMP

/obj/item/ammo_casing/m7mm/match
	ammo_categories = AMMO_CLASS_NICHE

/obj/item/ammo_casing/m7mm/bouncy
	ammo_categories = AMMO_CLASS_NICHE

/*
*	.50 BMG
*/

/obj/item/ammo_casing/p50
	ammo_categories = AMMO_CLASS_SUPER
	custom_materials = AMMO_MATS_HEAVY

/obj/item/ammo_casing/p50/surplus
	desc = "A .50 BMG surplus bullet casing.\
		<br><br>\
		<i>SURPLUS: Lacks innate armor penetration, contact-stun, or innate dismemberment ability. Still incredibly painful to be hit by.</i>"
	ammo_categories = AMMO_CLASS_LETHAL

/obj/item/ammo_casing/p50/disruptor
	desc = "A .50 BMG disruptor bullet casing.\
		<br><br>\
		<i>DISRUPTOR: Forces humanoid targets to sleep, does heavy damage against cyborgs, EMPs struck targets.</i>"
	ammo_categories = AMMO_CLASS_SUPER | AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_HEAVY

/obj/item/ammo_casing/p50/incendiary
	desc = "A .50 BMG incendiary bullet casing.\
		<br><br>\
		<i>INCENDIARY: Lacks innate dismemberment ability and contact-stun. Creates hotspots on impact. Sets people very on fire.</i>"
	projectile_type = /obj/projectile/bullet/p50/incendiary
	ammo_categories = AMMO_CLASS_SUPER | AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_HEAVY

/obj/item/ammo_casing/p50/penetrator
	desc = "A .50 BMG penetrator bullet casing.\
		<br><br>\
		<i>PENETRATOR: Goes through basically everything. Lacks innate dismemberment ability and contact-stun.</i>"
	ammo_categories = AMMO_CLASS_SUPER | AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_HEAVY

/obj/item/ammo_casing/p50/marksman
	desc = "A .50 BMG marksman bullet casing.\
		<br><br>\
		<i>MARKSMAN: Bullets have <b>no</b> travel time, and can ricochet once. Does slightly less damage, lacks innate dismemberment and contact-stun.</i>"
	ammo_categories = AMMO_CLASS_SUPER | AMMO_CLASS_NICHE
	custom_materials = AMMO_MATS_HEAVY_FAST

/*
*	.310 Strilka
*/
/obj/item/ammo_casing/strilka310/surplus
	can_be_printed = FALSE

/obj/item/ammo_casing/strilka310/lionhunter
	name = "hunter's rifle round"
	can_be_printed = FALSE // trust me bro you dont wanna give security homing wallhack Better Rubbers

/obj/item/ammo_casing/strilka310/enchanted
	name = "enchanted rifle round"
	can_be_printed = FALSE // these are Really Really Better Rubbers

/obj/item/ammo_casing/strilka310/phasic
	ammo_categories = AMMO_CLASS_SUPER | AMMO_CLASS_ESOTERIC
	custom_materials = AMMO_MATS_PHASIC

/obj/item/ammo_casing/strilka310/rubber
	name = ".310 Strilka rubber bullet casing"
	desc = "A .310 rubber bullet casing. Casing is a bit of a fib, there isn't one.\
		<br><br>\
		<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/ammo.dmi'
	icon_state = "310-casing-rubber"

	projectile_type = /obj/projectile/bullet/strilka310/rubber
	ammo_categories = AMMO_CLASS_NONE
	harmful = FALSE

/obj/projectile/bullet/strilka310/rubber
	name = ".310 rubber bullet"
	damage = 15
	stamina = 55
	ricochets_max = 5
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null

/obj/item/ammo_casing/strilka310/ap
	name = ".310 Strilka armor-piercing bullet casing"
	desc = "A .310 armor-piercing bullet casing. Casing is a bit of a fib, there isn't one.\
		<br><br>\
		<i>ARMOR-PIERCING: Improved armor-piercing capabilities, in return for less outright damage.</i>"

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/ammo.dmi'
	icon_state = "310-casing-ap"

	projectile_type = /obj/projectile/bullet/strilka310/ap
	ammo_categories = AMMO_CLASS_PLUS
	custom_materials = AMMO_MATS_AP

/obj/projectile/bullet/strilka310/ap
	name = ".310 armor-piercing bullet"
	damage = 50
	armour_penetration = 60

/*
*	40mm (yes, the grenade)
*/
/obj/item/ammo_casing/a40mm
	ammo_categories = AMMO_CLASS_SUPER
	custom_materials = AMMO_MATS_HEAVY

/obj/item/ammo_casing/a40mm/rubber
	ammo_categories = AMMO_CLASS_NICHE_LTL
