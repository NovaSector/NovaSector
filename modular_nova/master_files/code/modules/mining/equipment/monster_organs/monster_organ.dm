/obj/item/organ/monster_core/try_apply(atom/target, mob/user)
	if (istype(target, /obj/structure/lavaland/ash_walker))
		target.attackby(src, user)
		return
	return ..()
