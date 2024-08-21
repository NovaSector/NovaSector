/obj/item/xenoarch/anomaly_stabilizer
	name = "handheld anomaly stabilizer"
	desc = "An old model of handheld forcefield projector, able to stabilize crushing boulders from turning into dust completely. Nobody bothers to update it's software. \
	Comes with no warranty and outdated terminology."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/tools.dmi'
	icon_state = "anoscanner_borg"
	var/selected = NONE
	var/fields = list(
		"Diffracted carbon dioxide laser",
		"Nitrogen tracer field",
		"Potassium refrigerant cloud",
		"Mercury dispersion wave",
		"Iron wafer conduction field",
		"Calcium binary deoxidiser",
		"Chlorine diffusion emissions",
		"Phoron saturated field", // Phoron is left intentionally.
	)

/obj/item/xenoarch/anomaly_stabilizer/attack_self(mob/user)
	var/target_path = input(user, "Choose a field") as null|anything in fields
	if (!target_path)
		return
	else
		selected = target_path

/obj/item/xenoarch/anomaly_stabilizer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ITEM_INTERACT_SUCCESS
	if(istype(interacting_with, /obj/structure/boulder))
		var/obj/structure/boulder/current = interacting_with
		var/boulder_type = current.artifact_stabilizing_field
		// if(boulder_type == selected)
		if(!selected)
			return
		to_chat(user, span_notice("You begin to stabilize [current] using [src]."))
		if(!do_after(user, 5 SECONDS, target = current))
			to_chat(user, span_warning("You interrupt your stabilizing, damaging the boulder in the process!"))
			current.excavation_level += rand(10,50)
			return
		if(boulder_type == selected)
			current.stabilised = TRUE
		else
			current.stabilised = FALSE // Yep, you can change the perfectly stabilized boulder wrong
		to_chat(user, span_notice("You finish applying the stabilizing field to the [current]."))
		return
