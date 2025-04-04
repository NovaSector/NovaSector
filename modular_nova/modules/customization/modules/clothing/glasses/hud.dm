/obj/item/clothing/glasses/hud/eyepatch
	name = "HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one is broken."
	icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"
	inhand_icon_state = "sunhudmed"
	uses_advanced_reskins = TRUE
	can_switch_eye = TRUE	//See modular_nova\modules\customization\modules\clothing\glasses\glasses.dm
	actions_types = list(/datum/action/item_action/flip)


/obj/item/clothing/glasses/hud/eyepatch/attack_self(mob/user, modifiers)
	. = ..()
	icon_state = (icon_state == base_icon_state) ? "[base_icon_state]_flipped" : base_icon_state
	user.update_worn_glasses()


/obj/item/clothing/glasses/hud/eyepatch/sec
	name = "security HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one scans humanoids in view and provides accurate data about their ID status and security records."
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/blue

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "secfold",
			RESKIN_WORN_ICON_STATE = "secfold"
		)
	)
/obj/item/clothing/glasses/hud/eyepatch/med
	name = "medical HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one scans humanoids in view and provides accurate data about their health status."
	icon_state = "medpatch"
	base_icon_state = "medpatch"
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "medpatch",
			RESKIN_WORN_ICON_STATE = "medpatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "medfold",
			RESKIN_WORN_ICON_STATE = "medfold"
		)
	)

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

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "mesonpatch",
			RESKIN_WORN_ICON_STATE = "mesonpatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "mesonfold",
			RESKIN_WORN_ICON_STATE = "mesonfold"
		)
	)

/obj/item/clothing/glasses/hud/eyepatch/diagnostic
	name = "diagnostic HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one analyzes the integrity and status of robotics and exosuits.
	icon_state = "robopatch"
	base_icon_state = "robopatch"
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "robopatch",
			RESKIN_WORN_ICON_STATE = "robopatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "robofold",
			RESKIN_WORN_ICON_STATE = "robofold"
		)
	)

/obj/item/clothing/glasses/hud/eyepatch/sci
	name = "science HUD eyepatch"
	desc = "A HUD designed to interface directly with optical nerves. This one is fitted with an analyzer for scanning items and reagents.
	icon_state = "scipatch"
	base_icon_state = "scipatch"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "scipatch",
			RESKIN_WORN_ICON_STATE = "scipatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "scifold",
			RESKIN_WORN_ICON_STATE = "scifold"
		)
	)


/// BLINDFOLD HUDS ///
/obj/item/clothing/glasses/trickblindfold/obsolete
	name = "obsolete fake blindfold"
	desc = "An ornate fake blindfold, devoid of any electronics. It's belived to be originally worn by members of bygone military force that sought to protect humanity."
	icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "obsoletefold"
	base_icon_state = "obsoletefold"
	can_switch_eye = TRUE

/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold
	name = "sec blindfold HUD"
	desc = "a fake blindfold with a security HUD inside, helps you look like blind justice. This won't provide the same protection that you'd get from sunglasses."
	icon_state =  "secfold"
	base_icon_state =  "secfold"

/obj/item/clothing/glasses/hud/eyepatch/med/blindfold
	name = "medical blindfold HUD"
	desc = "a fake blindfold with a medical HUD inside, great for helping keep a poker face when dealing with patients."
	icon_state =  "medfold"
	base_icon_state =  "medfold"

/obj/item/clothing/glasses/hud/eyepatch/meson/blindfold
	name = "meson blindfold HUD"
	desc = "a fake blindfold with meson lenses inside. Doesn't shield against welding."
	icon_state =  "mesonfold"
	base_icon_state =  "mesonfold"

/obj/item/clothing/glasses/hud/eyepatch/diagnostic/blindfold
	name = "diagnostic blindfold HUD"
	desc = "a fake blindfold with a diagnostic HUD inside, excellent for working on androids."
	icon_state =  "robofold"
	base_icon_state =  "robofold"

/obj/item/clothing/glasses/hud/eyepatch/sci/blindfold
	name = "science blindfold HUD"
	desc = "a fake blindfold with a science HUD inside, provides a way to get used to blindfolds before you eventually end up needing the real thing."
	icon_state =  "scifold"
	base_icon_state =  "scifold"
