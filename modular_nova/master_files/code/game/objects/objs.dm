/obj
	///the Nova Sector version of obj_flags, to prevent any potential future conflict
	var/obj_flags_nova = NONE

/obj/examine_tags(mob/user)
	. = ..()
	if(obj_flags & ADMIN_ITEM)
		.["administrative"] = "Created by an Admin, somehow."
