#define BSRPD_CAPACITY_MAX 500
#define BSRPD_CAPACITY_USE 10
#define BSRPD_CAPACITY_NEW 250

/obj/item/pipe_dispenser/bluespace
	name = "bluespace RPD"
	desc = "State of the art technology being tested by NT scientists; this is their only working prototype."
	icon = 'modular_nova/modules/bsrpd/icons/bsrpd.dmi'
	icon_state = "bsrpd"
	lefthand_file = 'modular_nova/modules/bsrpd/icons/bsrpd_left.dmi'
	righthand_file = 'modular_nova/modules/bsrpd/icons/bsrpd_right.dmi'
	inhand_icon_state = "bsrpd"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	custom_materials = null

	///how much charge the bsrpd can hold
	var/current_capacity = BSRPD_CAPACITY_MAX

	///the default amount of charge per range use
	var/ranged_use_cost = BSRPD_CAPACITY_USE

	///in_use to prevent spam clicking to cheat the costs
	var/in_use = FALSE

	/// Flag to check if we should use remote piping
	var/remote_piping_toggle = FALSE

/obj/item/pipe_dispenser/bluespace/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/sheet/bluespace_crystal))
		if(BSRPD_CAPACITY_NEW > (BSRPD_CAPACITY_MAX - current_capacity) || ranged_use_cost == 0)
			to_chat(user, span_warning("You cannot recharge [src] anymore!"))
			return ITEM_INTERACT_BLOCKING

		tool.use(1)
		to_chat(user, span_notice("You recharge the bluespace capacitor inside of [src]"))
		current_capacity += BSRPD_CAPACITY_NEW
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/assembly/signaler/anomaly/bluespace))
		if(ranged_use_cost)
			to_chat(user, span_notice("You slot [tool] into [src]; supercharging the bluespace capacitor!"))
			ranged_use_cost = 0
			qdel(tool)
			return ITEM_INTERACT_SUCCESS

		else
			to_chat(user, span_warning("You cannot improve the [src] further."))

		return ITEM_INTERACT_BLOCKING

	return NONE

/obj/item/pipe_dispenser/bluespace/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		. += "Currently has [ranged_use_cost == 0 ? "infinite" : current_capacity / ranged_use_cost] charges remaining."
		if(ranged_use_cost != 0)
			. += "The Bluespace Anomaly Core slot is empty."

	else
		. += "You cannot see the charge capacity."

	. += span_notice("<b>Alt-Click</b> to toggle remote piping.")

/obj/item/pipe_dispenser/bluespace/click_alt(mob/user)
	remote_piping_toggle = !remote_piping_toggle
	balloon_alert(user, "remote piping [remote_piping_toggle ? "on" : "off"]")
	playsound(get_turf(src), 'sound/machines/click.ogg', 50, TRUE)
	return CLICK_ACTION_SUCCESS

/obj/item/pipe_dispenser/bluespace/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!remote_piping_toggle) // If we are in proximity to the target or have our safety on, don't use charge and don't call this shitcode.
		return NONE

	if(current_capacity < ranged_use_cost)
		to_chat(user, span_warning("The [src] lacks the charge to do that."))
		return ITEM_INTERACT_BLOCKING

	if(!in_use)
		user.Beam(interacting_with, icon_state = "rped_upgrade", time = 1 SECONDS)
		in_use = TRUE // So people can't just spam click and get more uses
		addtimer(VARSET_CALLBACK(src, in_use, FALSE),  1 SECONDS, TIMER_UNIQUE)
		if(interact_with_atom(interacting_with, user, modifiers))
			current_capacity -= ranged_use_cost
			return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_BLOCKING

#undef BSRPD_CAPACITY_MAX
#undef BSRPD_CAPACITY_USE
#undef BSRPD_CAPACITY_NEW
