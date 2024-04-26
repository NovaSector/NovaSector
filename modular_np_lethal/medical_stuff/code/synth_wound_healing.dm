// Used to stop synth structural damage
/obj/item/stack/medical/wound_recovery/robofoam
	name = "robotic repair spray"
	singular_name = "robotic repair spray"
	desc = "A needle-tip foam gun filled with an advanced synthetic foam that rapidly \
		fills and stabilizes structural damage in synthetics. The damage area will be \
		vulnerable to further damage while the foam hardens"
	icon = 'modular_np_lethal/medical_stuff/icons/stack_items.dmi'
	icon_state = "robofoam"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic
	)
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam
	treatment_sound = 'sound/effects/spray.ogg'

/obj/item/stack/medical/wound_recovery/robofoam/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 10)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 10)

// Used to cure practically any synthetic wound, and also repair armor if you're fucked up
/obj/item/stack/medical/wound_recovery/robofoam_super
	name = "premium robotic repair spray"
	singular_name = "premium robotic repair spray"
	desc = "A needle-tip foam gun filled with an advanced synthetic foam that rapidly \
		fills and stabilizes structural damage in synthetics. The damage area will be \
		vulnerable to further damage while the foam hardens. \
		This special premium type can also be used to repair almost any possible type \
		of synthetic damage."
	icon = 'modular_np_lethal/medical_stuff/icons/stack_items.dmi'
	icon_state = "robofoam_super"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic,
		/datum/wound/muscle/robotic,
		/datum/wound/electrical_damage,
		/datum/wound/burn/robotic,
	)
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam_super
	treatment_sound = 'sound/effects/spray.ogg'

/obj/item/stack/medical/wound_recovery/robofoam_super/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 10)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 10)
	healed_mob.reagents.add_reagent(/datum/reagent/dinitrogen_plasmide, 10)
