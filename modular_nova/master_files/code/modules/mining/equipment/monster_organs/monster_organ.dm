/obj/item/organ/monster_core/try_apply(atom/target, mob/user)
	if (istype(target, /obj/structure/lavaland/ash_walker))
		target.base_item_interaction(user, src)
		return
	return ..()
