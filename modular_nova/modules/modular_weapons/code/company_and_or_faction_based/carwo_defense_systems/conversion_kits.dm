/obj/item/crafting_conversion_kit/riot_sol_super
	name = "\improper KOLBEN/NACHTREIHER overhaul suite"
	desc = "All the parts you need to convert the venerable M64 shotgun into the barrel-charging-capable Nachtreiher combat shotgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	icon_state = "renoster_super_kit"

	lore_blurb = "The KOLBEN/NACHTREIHER parts kit is the civilian version of the KOLBEN overhaul suite for Carwo's venerable M64 combat shotgun.<br><br>\
		One of the earliest examples of the current wave of barrel-charger-based overhauls to pre-existing firearms, the NACHTREIHER parts kit features \
		a ten-shell extended magazine tube, the components to convert the M64 into a semi-automatic shotgun, \
		an extended barrel with integrated installation space for a barrel charger, a magnetic barrel charger, \
		and a paired smart optical sight and a handguard with integrated aiming module. \
		While all this adds some weight to the already heavy shotgun, many appreciate having a few extra shells, semi-auto fire, \
		and the ability to engage the barrel charger for those demanding shots that value precision over volume."

/obj/item/crafting_conversion_kit/riot_sol_super/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ARCHON)

/datum/crafting_recipe/riot_sol_super
	name = "M64 to KOLBEN/NACHTREIHER Shotgun Conversion"
	desc = "Bring order to chaos."
	result = /obj/item/gun/ballistic/shotgun/riot/sol/super/empty
	reqs = list(
		/obj/item/gun/ballistic/shotgun/riot/sol = 1,
		/obj/item/crafting_conversion_kit/riot_sol_super = 1
	)
	steps = list(
		"Empty the magazine",
		"Empty the chamber"
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/riot_sol_super/New()
	..()
	LAZYOR(blacklist, typesof(/obj/item/gun/ballistic/shotgun/riot/sol/super)) // let's not try to super-ize our already super shotgun i think

/datum/crafting_recipe/riot_sol_super/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/ballistic/shotgun/riot/sol/the_piece = collected_requirements[/obj/item/gun/ballistic/shotgun/riot/sol][1]
	if(the_piece.get_ammo())
		return FALSE
	return ..()
