//сама рука

/obj/item/borg/apparatus/universe_arm
    name = "manipulation apparatus"
    desc = "A specialized robotic gripper designed to hold and interact with a vast array of objects."
    icon_state = "connector"
    storable = list(/obj/item) // надеюсь оно работает так

/obj/item/borg/apparatus/universe_arm/Initialize(mapload)
    . = ..()
    if(stored)
        QDEL_NULL(stored)
    update_appearance()

/obj/item/borg/apparatus/universe_arm/attack_self(mob/living/silicon/robot/user)
    if(stored)
        return stored.attack_self(user)
    return ..()

/obj/item/borg/apparatus/universe_arm/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
    if(!stored || !proximity_flag)
        return ..()

    stored.melee_attack_chain(target, user, click_parameters)
    return TRUE

/obj/item/borg/apparatus/universe_arm/update_overlays()
    . = ..()
    if(!stored)
        return

    var/mutable_appearance/stored_view = new(stored)

    stored_view.pixel_x = 0
    stored_view.pixel_y = 0

    stored_view.layer = FLOAT_LAYER
    stored_view.plane = FLOAT_PLANE

    . += stored_view

/obj/item/borg/apparatus/universe_arm/attackby(obj/item/W, mob/user, params)
    if(stored)
        return stored.attackby(W, user, params)
    return ..()

/obj/item/borg/apparatus/universe_arm/pre_attack(atom/A, mob/living/user, list/modifiers)
    if(stored)
        return ..()

    if(istype(A, /obj/item/storage))
        var/obj/item/storage/S = A

        if(S.item_flags & ABSTRACT || HAS_TRAIT(S, TRAIT_NODROP))
            return ..()

        if(S.forceMove(src))
            stored = S
            RegisterSignal(stored, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_stored_updated_icon))
            update_appearance()
            to_chat(user, span_notice("You grab [S] with your [src]."))
            return TRUE

    return ..()

/obj/item/borg/apparatus/universe_arm/proc/handle_dropdown(mob/user)
	if(stored)
		to_chat(user, span_notice("You release [stored] from your [src]."))
		drop_stored_item()
		return TRUE
	return FALSE

//улучшение

/obj/item/borg/upgrade/universe_arm
	name = "universal manipulator upgrade"
	desc = "A specialized upgrade kit that grants a cyborg the ability to hold and operate standard handheld items."
	icon_state = "module_general"
	items_to_add = list(/obj/item/borg/apparatus/universe_arm)

/obj/item/borg/upgrade/universe_arm/Initialize(mapload)
	. = ..()
