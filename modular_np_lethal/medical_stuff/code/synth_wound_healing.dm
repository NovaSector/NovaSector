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
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam
	treatment_sound = 'sound/effects/spray.ogg'

/obj/item/stack/medical/wound_recovery/robofoam/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry/super, 10)
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
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam_super
	treatment_sound = 'sound/effects/spray.ogg'

/obj/item/stack/medical/wound_recovery/robofoam_super/examine(mob/user)
	. = ..()
	. += span_engradio("This can be used to <b>repair</b> damaged <b>armor</b>.")

/obj/item/stack/medical/wound_recovery/robofoam_super/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 10)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry/super, 10)
	healed_mob.reagents.add_reagent(/datum/reagent/dinitrogen_plasmide, 10)

/obj/item/stack/medical/wound_recovery/robofoam_super/afterattack(obj/item/clothing/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag || !istype(target))
		return FALSE
	if(!use(1, check = TRUE))
		return FALSE
	target.balloon_alert(user, "repairing...")
	if(!do_after(user, 10 SECONDS, target))
		return FALSE
	if(!use(1, check = TRUE))
		return FALSE
	target.repair(user)
	playsound(target, treatment_sound, 100, TRUE)
	use(1)

// Synth repair patch, gives the synth a small amount of healing chems
/obj/item/reagent_containers/pill/patch/lethal_synth_repair
	name = "robotic repair patch"
	desc = "A sealed patch with a small nanite swarm along with electrical coagulant reagents to repair small amounts of synthetic damage."
	icon = 'modular_np_lethal/medical_stuff/icons/stack_items.dmi'
	icon_state = "synth_patch"
	list_reagents = list(
		/datum/reagent/medicine/nanite_slurry/super = 10,
		/datum/reagent/dinitrogen_plasmide = 5,
		/datum/reagent/medicine/coagulant/fabricated = 10,
	)

// Nanite slurry but its not ass
/datum/reagent/medicine/nanite_slurry/super
	name = "Super Nanite Slurry"
	healing = 4
	temperature_change = 20
