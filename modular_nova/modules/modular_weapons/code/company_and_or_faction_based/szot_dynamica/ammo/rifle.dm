// Various ammo boxes for .310

/obj/item/ammo_box/c310_cargo_box
	name = "ammo box (.310 Strilka lethal)"
	desc = "A box of .310 Strilka lethal rifle rounds, holds ten cartridges."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "310_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_STRILKA310
	ammo_type = /obj/item/ammo_casing/strilka310
	max_ammo = 10

// Rubber

/obj/item/ammo_box/c310_cargo_box/rubber
	name = "ammo box (.310 Strilka rubber)"
	desc = "A box of .310 Strilka rubber rifle rounds, holds ten cartridges."

	icon_state = "310_box_rubber"

	ammo_type = /obj/item/ammo_casing/strilka310/rubber

// AP

/obj/item/ammo_box/c310_cargo_box/piercing
	name = "ammo box (.310 Strilka piercing)"
	desc = "A box of .310 Strilka piercing rifle rounds, holds ten cartridges."

	icon_state = "310_box_ap"

	ammo_type = /obj/item/ammo_casing/strilka310/ap

// AMR bullet

/obj/item/ammo_casing/p60strela
	name = ".60 Strela caseless cartridge"
	desc = "A massive block of plasma-purple propellant with an equally massive round sticking out the top of it. \
		While good at killing a man, you'll find most effective use out of destroying things with it."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "amr_bullet"
	caliber = CALIBER_60STRELA
	projectile_type = /obj/projectile/bullet/p60strela

/obj/item/ammo_casing/p60strela/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/projectile/bullet/p60strela // The funny thing is, these are wild but you only get three of them a magazine
	name =".60 Strela bullet"
	icon_state = "gaussphase"
	speed = 2.5
	damage = 70
	armour_penetration = 50
	wound_bonus = 15 // Toned back down, as it's getting alot more damage.
	bare_wound_bonus = 15
	demolition_mod = 1.8
	/// How much damage we add to things that are weak to this bullet
	var/anti_materiel_damage_addition = 30
	/// What biotype we look for
	var/biotype_we_look_for = MOB_ROBOTIC

/obj/projectile/bullet/p60strela/on_hit(atom/target, blocked, pierce_hit)
	if(!isliving(target) || (damage > initial(damage)))
		return ..()
	var/mob/living/target_mob = target
	if(target_mob.mob_biotypes & biotype_we_look_for)
		damage += anti_materiel_damage_addition
	return ..()
