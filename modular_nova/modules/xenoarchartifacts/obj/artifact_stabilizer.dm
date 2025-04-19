/obj/item/xenoarch/anomaly_stabilizer
	name = "handheld anomaly stabilizer"
	desc = "An old model of handheld forcefield projector, able to stabilize crushing boulders from turning into dust completely. Nobody bothers to update it's software. \
	Comes with no warranty and outdated terminology."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/tools.dmi'
	icon_state = "anoscanner_borg"
	/// Currently selected field
	var/selected = NONE

	/// List of possible fields
	var/fields = list(
		"Diffracted carbon dioxide laser",
		"Nitrogen tracer field",
		"Potassium refrigerant cloud",
		"Mercury dispersion wave",
		"Iron wafer conduction field",
		"Calcium binary deoxidizer",
		"Chlorine diffusion emissions",
		"Phoron saturated field", // Phoron is left intentionally.
	)

	/// Speed of the stabilizer
	var/stabilizing_speed = 5 SECONDS

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
		var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/research, SKILL_SPEED_MODIFIER)
		if(!selected)
			return

		user.visible_message(
			span_notice("[user] begins to stabilize [current] using [src]."),
			span_notice("You begin to stabilize [current] using [src]."),
			blind_message = span_hear("You hear buzzing nearby."),
		)
		if(!do_after(user, stabilizing_speed * skill_modifier, target = current))
			user.visible_message(
				span_notice("[user] messes up and damages [current]!"),
				span_notice("You interrupt your stabilizing, damaging the boulder in the process!"),
				blind_message = span_hear("You hear rock crumbling nearby."),
			)
			current.excavation_level += rand(10,50)
			return

		if(boulder_type == selected)
			current.stabilised = TRUE

		else
			current.stabilised = FALSE // Yep, you can change the perfectly stabilized boulder wrong

		user.visible_message(
			span_notice("[user] finish applying the stabilizing field to the [current]."),
			span_notice("You finish applying the stabilizing field to the [current]."),
		)
		user.mind?.adjust_experience(/datum/skill/research, 10)
		return
