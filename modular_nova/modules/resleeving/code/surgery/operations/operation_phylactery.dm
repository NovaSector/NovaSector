/datum/surgery_operation/organ/implant_phylactery
	name = "implant_phylactery"
	desc = "Implant an RSD phylactery into the patient's brain, making it possible to attach a foreign resonance signature to the body."
	rnd_name = "Implant RSD Phylactery"
	rnd_desc = "A surgical procedure which directly implants an RSD phylactery into the patient's brain, \
		making it possible to attach a foreign resonance signature to the body."
	implements = list(
		/obj/item/rsd_interface = 1,
	)
	time = 5 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	operation_flags = OPERATION_LOCKED
	target_type = /obj/item/organ/brain
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED

/datum/surgery_operation/organ/implant_phylactery/get_default_radial_image()
	return image(/obj/item/rsd_interface)

/datum/surgery_operation/organ/implant_phylactery/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You begin to insert a phylactery into [organ.owner]'s brain..."),
		span_notice("[surgeon] begins to insert a phylactery into [organ.owner]'s brain."),
		span_notice("[surgeon] begins to perform surgery on [organ.owner]'s brain."),
	)
	display_pain(organ.owner, "Your head pounds with unimaginable pain!")

/datum/surgery_operation/organ/implant_phylactery/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/rsd_interface/phylactery = tool
	if(!phylactery.interact_with_atom(organ, surgeon))
		return ..()

	display_results(
		surgeon,
		organ.owner,
		span_notice("You successfully insert the phylactery into [organ.owner]'s brain!"),
		span_notice("[surgeon] successfully inserts the phylactery into [organ.owner]'s brain!"),
		span_notice("[surgeon] finishes performing surgery on [organ.owner]'s brain."),
	)

/datum/surgery_operation/organ/implant_phylactery/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You screw up, bruising the brain's tissue!"),
		span_notice("[surgeon] screws up, causing brain damage!"),
		span_notice("[surgeon] completes the surgery on [organ.owner]'s brain."),
	)
	display_pain(organ.owner, "Your head throbs with horrible pain!")
	organ.apply_organ_damage(40)

/datum/surgery_operation/organ/implant_phylactery/mechanic
	name = "implant_phylactery_mechanic"
	desc = "Implant an RSD phylactery into the patient's positronic, making it possible to attach a foreign resonance signature to the body."
	rnd_name = "Implant RSD Phylactery (Positronic)"
	rnd_desc = "A surgical procedure which directly implants an RSD phylactery into the patient's positronic, \
		making it possible to attach a foreign resonance signature to the body."
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	failure_sound = 'sound/items/taperecorder/taperecorder_stop.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
