
/obj/item/clothing/glasses/eyepatch/hud
	name = "HUD eyepatch"
	desc = "A simple HUD designed to interface with optical nerves of a lost eye. This one seems busted."
	icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	inhand_icon_state = "sunhudmed"
	//Set here because all the HUD eyepatches have an alternate skin.
	//Thankfully, this alt skin ALSO is toggleable.
	uses_advanced_reskins = TRUE

	//Just re-doing the HUD toggleable code on eyepatches.
	actions_types = list(/datum/action/item_action/toggle_wearable_hud)
	/// Whether the HUD info is on or off
	var/display_active = TRUE

/obj/item/clothing/glasses/eyepatch/hud/sec
	name = "security HUD eyepatch"
	desc = "Lost your eye beating an innocent clown? Thankfully your corporate overlords have made something to make up for this. May not do well against flashes."
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red

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

/obj/item/clothing/glasses/eyepatch/hud/med
	name = "medical HUD eyepatch"
	desc = "Do no harm, maybe harm has befell to you, or your poor eyeball, thankfully there's a way to continue your oath, thankfully it didn't mention sleepdarts or monkey men."
	icon_state = "medpatch"
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


/obj/item/clothing/glasses/eyepatch/hud/meson
	name = "mesons HUD eyepatch"
	desc = "For those that only want to go half insane when staring at the supermatter."
	icon_state = "mesonpatch"
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

/obj/item/clothing/glasses/eyepatch/hud/diagnostic
	name = "diagnostic HUD eyepatch"
	desc = "Lost your eyeball to a rogue borg? Dare to tell a Dogborg to do its job? Got bored? Whatever the reason, this bit of tech will help you still repair borgs, they'll never need it since they usually do it themselves, but it's the thought that counts."
	icon_state = "robopatch"
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

/obj/item/clothing/glasses/eyepatch/hud/sci
	name = "science HUD eyepatch"
	desc = "Every few years, the aspiring mad scientist says to themselves 'I've got the castle, the evil laugh and equipment, but what I need is a look'. Thankfully, Dr. Galox has already covered that for you dear friend - while it doesn't do much beyond scan chemicals, what it lacks in use it makes up for in style."
	icon_state = "scipatch"
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
