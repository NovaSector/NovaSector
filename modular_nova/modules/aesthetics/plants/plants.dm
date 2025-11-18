/obj/item/kirbyplants
	///List of modular icon states, added to the end of the randomization list
	/// and used to change to our icon file
	var/list/modular_states = list(
		"modular-1",
		"modular-2",
		"modular-3",
		"modular-4",
		"modular-5",
		"modular-6",
		"modular-7",
		"modular-8",
	)

/obj/item/kirbyplants/monkey
	name = "monkey plant"
	desc = "Something that seems to have been made by the Nanotrasen science division, one might call it an abomination. Its heads seem... alive."
	icon_state = "monkeyplant"
	icon = 'modular_nova/modules/aesthetics/plants/icons/plants.dmi'
	trimmable = FALSE
