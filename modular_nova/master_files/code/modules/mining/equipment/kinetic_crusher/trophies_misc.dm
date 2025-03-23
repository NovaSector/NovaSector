/obj/item/crusher_trophy/retool_kit
	/// icon file where this retool kit's projectile is stored
	var/retool_projectile_icon_file = 'icons/obj/weapons/guns/projectiles.dmi'

/obj/item/crusher_trophy/retool_kit/add_to(obj/item/kinetic_crusher/pkc, mob/user)
	. = ..()
	pkc.projectile_icon_file = retool_projectile_icon_file

/obj/item/crusher_trophy/retool_kit/remove_from(obj/item/kinetic_crusher/pkc)
	. = ..()
	pkc.projectile_icon_file = initial(pkc.projectile_icon_file)
