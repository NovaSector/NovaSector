/obj/item/synth_chest
	name = "synth assembly"
	desc = "Prints out a fully prepared synthetic chest, ready for further construction."
	icon = 'modular_nova/modules/bodyparts/icons/ipc_parts.dmi'
	icon_state = "bshipc_chest"

/obj/item/synth_chest/Initialize(mapload)
	. = ..()
	var/mob/living/carbon/human/species/synth/synth_body = new /mob/living/carbon/human/species/synth(get_turf(src))
	/// Remove those bodyparts
	for(var/synth_body_parts in synth_body.bodyparts)
		var/obj/item/bodypart/bodypart = synth_body_parts
		if(bodypart.body_part != CHEST)
			QDEL_NULL(bodypart)
	/// Remove those organs
	for (var/synth_organ in synth_body.organs)
		qdel(synth_organ)

	/// Update current body to be limbless
	synth_body.update_icon()
	ADD_TRAIT(synth_body, TRAIT_EMOTEMUTE, type)
	synth_body.death()
	REMOVE_TRAIT(synth_body, TRAIT_EMOTEMUTE, type)
	/// Remove placeholder synth_chest
	qdel(src)

/datum/design/synth_construction
	name = "Android Construction"
	id = "synth_construction"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 10 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/synth_chest
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/mmi/posibrain/ipc
	name = "compact positronic brain"
	desc = "A cube of shining metal, it has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers. This one appears to be inactive."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "posibrain"
	base_icon_state = "posibrain"

	begin_activation_message = "<span class='notice'>You carefully locate the manual activation switch and start the compact positronic brain's boot process.</span>"
	success_message = "<span class='notice'>The compact positronic brain pings, and its lights start flashing. Success!</span>"
	fail_message = "<span class='notice'>The compact positronic brain buzzes quietly, and the golden lights fade away. Perhaps you could try again?</span>"
	new_mob_message = "<span class='notice'>The compact positronic brain chimes quietly.</span>"
	recharge_message = "<span class='warning'>The compact positronic brain isn't ready to activate again yet! Give it some time to recharge.</span>"

/obj/item/mmi/posibrain/ipc/transfer_personality(mob/dead/observer/candidate)
	if(candidate)
		var/obj/item/organ/brain/synth/ipc_brain = new /obj/item/organ/brain/synth(get_turf(src))
		ipc_brain.brainmob = new /mob/living/brain(ipc_brain)
		if(candidate.mind)
			candidate.mind.transfer_to(ipc_brain.brainmob)
		else
			ipc_brain.brainmob.key = candidate.key
		candidate.reenter_corpse()
		visible_message(success_message)
		playsound(src, 'sound/machines/ping.ogg', 15, TRUE)
		qdel(src)

/obj/item/mmi/posibrain/ipc/update_icon_state()
	. = ..()
	if(searching)
		icon = 'icons/obj/devices/assemblies.dmi'
		icon_state = "[base_icon_state]-searching"
		return
	if(brainmob?.key)
		icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
		icon_state = "posibrain-ipc"
		return
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "[base_icon_state]"
	return

/datum/design/synth_positronic
	name = "Android Positronic Brain"
	id = "synth_positronic"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 10 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mmi/posibrain/ipc
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/power_cord
	name = "Charging Implant"
	id = "power_cord"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 3 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/organ/cyberimp/arm/toolkit/power_cord/left_arm
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
