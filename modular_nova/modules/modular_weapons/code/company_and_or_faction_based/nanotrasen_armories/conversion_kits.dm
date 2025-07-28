/obj/item/crafting_conversion_kit/reclaimer_reverse
	name = "\improper Nanotrasen NT20 conversion kit"
	desc = "All the parts you need to convert the 'Reclaimer' rC-20 back to a stock Nanotrasen NT20, outside of the parts that make the gun actually a gun. \
		Considering the limited quantity of NT20s in existence, having to deconstruct an rC-20 to rebuild your NT20 means that something went wrong."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/ballistic.dmi'
	icon_state = "nt20_kit"

	lore_blurb = "After learning that Scarborough Arms was starting to manufacture and distribute parts kits that required \
		cannibalizing their own NT20s for completion, Nanotrasen figured that it would be an inevitability that a Shield would \
		fall in the line of duty and have their service weapon pilfered and cannibalized to complete the parts kit. \
		The problem, then, became what to do after, ideally, the threat is dealt with and the cannibalized weapon returned to \
		the Shield who had lost their firearm.<br><br>\
		Instead of allowing their Shields to reuse the cannibalized weapon (and open themselves to criticism), \
		it was decided to manufacture replacement parts kits to refurbish converted weapons back to the NT20 standard, \
		for better or for worse."

/obj/item/crafting_conversion_kit/reclaimer_reverse/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/datum/crafting_recipe/reclaimer_reverse
	name = "rC-20 'Reclaimer' to NT20 Conversion"
	desc = "Do you care about honor, or do you use honor as an excuse? An excuse to exist in a violent world."
	result = /obj/item/gun/ballistic/automatic/nt20/empty
	reqs = list(
		/obj/item/gun/ballistic/automatic/c20r/reclaimed = 1,
		/obj/item/crafting_conversion_kit/reclaimer_reverse = 1
	)
	steps = list(
		"Remove the rC-20's magazine",
		"Clear the rC-20's chamber"
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/reclaimer_reverse/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/ballistic/automatic/c20r/reclaimed/the_piece = collected_requirements[/obj/item/gun/ballistic/automatic/c20r/reclaimed][1]
	if(the_piece.chambered)
		return FALSE
	if(the_piece.magazine)
		return FALSE
	return ..()
