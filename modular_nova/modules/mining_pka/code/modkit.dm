/obj/item/borg/upgrade/modkit/cooldown
	denied_type = /obj/item/borg/upgrade/modkit/cooldown
	maximum_of_type = 3

/obj/item/borg/upgrade/modkit/aoe/mobs
	denied_type = /obj/item/borg/upgrade/modkit/aoe/mobs
	maximum_of_type = 1

/obj/item/borg/upgrade/modkit/damage/modify_projectile(obj/projectile/kinetic/kinetic_projectile)
	kinetic_projectile.damage += modifier*kinetic_projectile.mod_mult
