/obj/item/clothing/glasses/hud/eyepatch
	name = "HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one is broken."
	icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"
	inhand_icon_state = null

	actions_types = list(/datum/action/item_action/toggle_wearable_hud,
	/datum/action/item_action/flip)
	var/flipped = FALSE

/*
All this is copied  eyepatch toggle/tint code from
code\modules\clothing\glasses\_glasses.dm so HUD eyepatches function with
scarred eye.
*/
/obj/item/clothing/glasses/hud/eyepatch/attack_self(mob/user)
	. = ..()
	flip_eyepatch()

/obj/item/clothing/glasses/hud/eyepatch/proc/flip_eyepatch()
	flipped = !flipped
	icon_state = flipped ? "[base_icon_state]_flipped" : base_icon_state
	if (!ismob(loc))
		return
	var/mob/user = loc
	user.update_worn_glasses()
	if (!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if (human_user.get_eye_scars() & (flipped ? RIGHT_EYE_SCAR : LEFT_EYE_SCAR))
		tint = INFINITY
	else
		tint = initial(tint)
	human_user.update_tint()

/obj/item/clothing/glasses/hud/eyepatch/equipped(mob/living/user, slot)
	if (!ishuman(user))
		return ..()
	var/mob/living/carbon/human/human_user = user
	// lol lmao
	if (human_user.get_eye_scars() & (flipped ? RIGHT_EYE_SCAR : LEFT_EYE_SCAR))
		tint = INFINITY
	else
		tint = initial(tint)
	return ..()

/obj/item/clothing/glasses/hud/eyepatch/dropped(mob/living/user)
	. = ..()
	tint = initial(tint)

/*
End of the copy-paste.
*/

/obj/item/clothing/glasses/hud/eyepatch/sec
	name = "security HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one scans humanoids in view and provides accurate data about their ID status and security records."
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red
	icon_state = "security_eyepatch"

/obj/item/clothing/glasses/hud/eyepatch/med
	name = "medical HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one scans humanoids in view and provides accurate data about their health status."
	icon_state = "medpatch"
	base_icon_state = "medpatch"
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/eyepatch/meson
	name = "mesons HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one displays basic structural and terrain layouts through walls, regardless of lighting conditions."
	icon_state = "mesonpatch"
	base_icon_state = "mesonpatch"
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	vision_flags = SEE_TURFS
	color_cutoffs = list(5, 15, 5)
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	actions_types = list(/datum/action/item_action/flip)

/obj/item/clothing/glasses/hud/eyepatch/diagnostic
	name = "diagnostic HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one analyzes the integrity and status of robotics and exosuits."
	icon_state = "robopatch"
	base_icon_state = "robopatch"
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/eyepatch/sci
	name = "science HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one is fitted with an analyzer for scanning items and reagents."
	icon_state = "scipatch"
	base_icon_state = "scipatch"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)
	actions_types = list(/datum/action/item_action/flip)

/// BLINDFOLD HUD (Used with NIF upgrade)///
/obj/item/clothing/glasses/trickblindfold/obsolete
	name = "obsolete fake blindfold"
	desc = "An ornate fake blindfold, devoid of any electronics. It's belived to be originally worn by members of bygone military force that sought to protect humanity."
	icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "obsoletefold"
	base_icon_state = "obsoletefold"
