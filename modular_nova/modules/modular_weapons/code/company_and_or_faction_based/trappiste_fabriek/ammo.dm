// .585 Trappiste
// High caliber round used in large pistols and revolvers

/obj/item/ammo_casing/c585trappiste
	name = ".585 Trappiste lethal bullet casing"
	desc = "A white polymer cased high caliber round commonly used in handguns."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/ammo.dmi'
	icon_state = "585trappiste"

	caliber = CALIBER_585TRAPPISTE
	projectile_type = /obj/projectile/bullet/c585trappiste

/obj/projectile/bullet/c585trappiste
	name = ".585 Trappiste bullet"
	damage = 45
	wound_bonus = 5 // Normal bullets are 20

/obj/item/ammo_box/c585trappiste
	name = "ammo box (.585 Trappiste lethal)"
	desc = "A box of .585 Trappiste pistol rounds, holds ten cartridges."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/ammo.dmi'
	icon_state = "585box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_585TRAPPISTE
	ammo_type = /obj/item/ammo_casing/c585trappiste
	max_ammo = 10

// .585 Trappiste equivalent to a rubber bullet

/obj/item/ammo_casing/c585trappiste/incapacitator
	name = ".585 Trappiste flathead bullet casing"
	desc = "A white polymer cased high caliber round with a relatively soft, flat tip. Designed to flatten against targets and usually not penetrate on impact."

	icon_state = "585trappiste_disabler"

	projectile_type = /obj/projectile/bullet/c585trappiste/incapacitator
	harmful = FALSE

/obj/projectile/bullet/c585trappiste/incapacitator
	name = ".585 Trappiste flathead bullet"
	damage = 20
	stamina = 40
	wound_bonus = 10

	weak_against_armour = TRUE

	shrapnel_type = null
	sharpness = NONE
	embed_data = null

/obj/item/ammo_box/c585trappiste/incapacitator
	name = "ammo box (.585 Trappiste flathead)"
	desc = "A box of .585 Trappiste pistol rounds, holds ten cartridges. The blue stripe indicates that it should hold less lethal rounds."

	icon_state = "585box_disabler"

	ammo_type = /obj/item/ammo_casing/c585trappiste/incapacitator

// .585 incendiary, less damage, sets people on fire

/obj/item/ammo_casing/c585trappiste/incendiary
	name = ".585 Trappiste incendiary bullet casing"
	desc = "A white polymer cased high caliber round with an equally white phosphorus tip. Designed to burst into flames on impact."

	icon_state = "585trappiste_hot"
	projectile_type = /obj/projectile/bullet/c585trappiste/incendiary

	advanced_print_req = TRUE

/obj/projectile/bullet/c585trappiste/incendiary
	name = ".585 Trappiste incendiary bullet"
	damage = 35


/// How many firestacks the bullet should impart upon a target when impacting
	var/firestacks_to_give = 1

/obj/projectile/bullet/c585trappiste/incendiary/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/gaslighter = target
		gaslighter.adjust_fire_stacks(firestacks_to_give)
		gaslighter.ignite_mob()

/obj/item/ammo_box/c585trappiste/incendiary
	name = "ammo box (.585 Trappiste Incendiary)"
	desc = "A box of .585 Trappiste pistol rounds, holds ten cartridges. The orange stripe indicates that it should hold incendiary rounds."

	icon_state = "585box_hot"

	ammo_type = /obj/item/ammo_casing/c585trappiste/incendiary
