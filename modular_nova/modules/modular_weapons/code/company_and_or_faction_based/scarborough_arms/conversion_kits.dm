/obj/item/crafting_conversion_kit/reclaimer_c20r
	name = "\improper Scarborough Arms 'DURANDAL 23-E' conversion kit"
	desc = "All the parts you need to convert the Nanotrasen NT20 into a 'Reclaimer' rC-20, outside of the parts that make the gun actually a gun. \
		Considering the limited quantity of NT20s in existence, surely you have a good reason to steal one and break it down...?"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/scarborough_arms/submachinegun.dmi'
	icon_state = "rc20_kit"

	lore_blurb = "The Scarborough Arms \"DURANDAL 23-E\" parts kit is, in essence, a disassembled C-20r missing just enough parts to \
	legally classify it as \"not really a firearm\", allowing for looser regulations to apply to its transport. However, the parts that are included \
	are very much of Scarborough Arms quality, which make the resulting firearm much more performant compared to its main in-sector \
	competitor, the NT20. Unfortunately, utilizing this parts kit requires cannibalizing an NT20, which no regulation-abiding crew member \
	should have gotten their hands on barring extenuating circumstances, nor should consider breaking down, again barring extenuating circumstances.<br><br>\
	\"When the count sees it never will be broke, <br>\
	Then to himself right softly he makes moan; <br>\
	'Ah, Durandal, fair, hallowed, and devote, <br>\
	What store of relics lies in thy hilt of gold!\"<br>\
	- The Song of Roland, translated by Dorothy Sayers"

/datum/crafting_recipe/reclaimer_c20r
	name = "NT20 to rC-20 'Reclaimer' Conversion"
	desc = "Unlike you, I have no physical or social restraints. The candles burn out for you; I am free."
	result = /obj/item/gun/ballistic/automatic/c20r/reclaimed/empty
	reqs = list(
		/obj/item/gun/ballistic/automatic/nt20 = 1,
		/obj/item/crafting_conversion_kit/reclaimer_c20r = 1
	)
	steps = list(
		"Unload the NT20",
		"Leave the bolt open"
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/reclaimer_c20r/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/ballistic/automatic/nt20/the_piece = collected_requirements[/obj/item/gun/ballistic/automatic/nt20][1]
	if(the_piece.chambered)
		return FALSE
	if(the_piece.magazine)
		return FALSE
	return ..()
