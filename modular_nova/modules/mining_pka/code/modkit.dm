/obj/item/borg/upgrade/modkit
	/// Variable to keep in check the max number of cooldown modkits.
	var/max_same = 99

/obj/item/borg/upgrade/modkit/cooldown
	max_same = 4

/obj/item/borg/upgrade/modkit/install(obj/item/gun/energy/recharge/kinetic_accelerator/KA, mob/user, transfer_to_loc = TRUE)
	/// Override so we limit the number of cooldown modkits to our value.
	var/mk_count = 0
	for (var/obj/item/borg/upgrade/modkit/modkit_aux as anything in KA.modkits)
		if (modkit_aux.type == type)
			mk_count++
	if (mk_count >= max_same)
		to_chat(user, span_notice("You cannot install more than [max_same] of [name] at the same time!"))
		return FALSE
	. = ..()

/obj/item/borg/upgrade/modkit/damage/modify_projectile(obj/projectile/kinetic/kinetic_projectile)
	kinetic_projectile.damage += modifier*kinetic_projectile.mod_mult
