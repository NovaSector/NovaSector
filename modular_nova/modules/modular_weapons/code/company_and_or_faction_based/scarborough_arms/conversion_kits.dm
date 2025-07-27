/obj/item/crafting_conversion_kit/reclaimer_c20r
	name = "\improper Scarborough 'Reclaimer' conversion kit"
	desc = "All the parts you need to convert the Nanotrasen NT20 into a 'Reclaimer' rC-20, outside of the parts that make the gun actually a gun. \
		Considering the limited quantity of NT20s in existence, surely you have a good reason to be considering stealing one and breaking it down."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/scarborough_arms/parts_kits.dmi'
	icon_state = "rc20_kit"

	lore_blurb = "The Scarborough Arms 'Reclaimer' parts kit, part of the 'DURANDAL 23-E' series of conversion kits, \
		is, in essence, a disassembled C-20r missing just enough parts to legally classify it as \"not really a firearm\", \
		allowing for looser regulations to apply to its transport. \
		However, the parts that are included are very much of Scarborough Arms quality, \
		which make the resulting firearm much more performant compared to its main in-sector \
		competitor, the NT20.<br><br>\
		Unfortunately, utilizing this parts kit requires cannibalizing an NT20, which no regulation-abiding crew member \
		should have gotten their hands on barring extenuating circumstances, \
		nor should consider breaking down, again barring extenuating circumstances."

/obj/item/crafting_conversion_kit/reclaimer_c20r/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/datum/crafting_recipe/reclaimer_c20r
	name = "NT20 to rC-20 'Reclaimer' Conversion"
	desc = "Unlike you, I have no physical or social restraints. The candles burn out for you; I am free."
	result = /obj/item/gun/ballistic/automatic/c20r/reclaimed/empty
	reqs = list(
		/obj/item/gun/ballistic/automatic/nt20 = 1,
		/obj/item/crafting_conversion_kit/reclaimer_c20r = 1
	)
	steps = list(
		"Remove the NT20's magazine",
		"Clear the NT20's chamber"
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

/obj/item/storage/toolbox/guncase/traitor/durandal_parts
	name = "\improper DURANDAL 23-E-series 'Reclaimer' parts case"
	desc = "A large case for weapon parts and magazines, with an odd, blood-red symbol stamped on the front. \
		There seems to be a strange switch along the side inside a plastic flap."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/scarborough_arms/parts_kits.dmi'
	base_icon_state = "reclaimer_case"
	icon_state = "reclaimer_case"
	weapon_to_spawn = /obj/item/crafting_conversion_kit/reclaimer_c20r
	extra_to_spawn = /obj/item/ammo_box/magazine/smgm45
	ammo_box_to_spawn = /obj/item/ammo_box/c45/large
	var/lore_blurb = "This case is designed to fit a parts kit for a 'Reclaimer' rC-20, with accompanying magazines and large ammunition box."

/obj/item/storage/toolbox/guncase/traitor/durandal_parts/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/storage/toolbox/guncase/traitor/durandal_parts/examine_more(mob/user)
	. = ..()
	. += "<i>Scarborough Arms's 'DURANDAL' line of parts kits are designed for the discerning customer who needs \
		every ounce of performance they can get out of their tools of rampant violence. The rumors that the kits are \
		designed with the assistance of an AI that's either missing ethical limiters or has independently subverted them \
		are probably unfounded.<br><br>\
		\"When the count sees it never will be broke, <br>\
		Then to himself right softly he makes moan; <br>\
		'Ah, Durandal, fair, hallowed, and devote, <br>\
		What store of relics lies in thy hilt of gold!\"<br>\
		- The Song of Roland, translated by Dorothy Sayers</i>"
	if(lore_blurb)
		. += "<br><i>[lore_blurb]</i>"

