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
		"Remove the magazine",
		"Clear the chamber"
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

/obj/item/crafting_conversion_kit/c38_super
	name = "\improper Nanotrasen NT/E Laevateinn conversion kit"
	desc = "All the parts you need to convert a .38 revolver (including the Colt Detective Special) into a magnetically-accelerated beast of a revolver. \
		This comes at the cost of concealability, but frankly, if you needed this, whatever situation you were getting into wasn't staying quiet anyway."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/ballistic.dmi'
	icon_state = "c38rail_kit"

	lore_blurb = "The NT/E Laevateinn is Nanotrasen's take on a charged-shot revolver, designed shortly after the BR-38. While much less \"gun\" than the BR-38, \
		you still get comparable stopping power and a faster projectile - but you pay for it with a larger overall size, \
		lacking followup potential, and more than a little felt recoil. \
		This parts kit features a replacement bottom-cylinder action, a dual-sided, hybrid barrel charger stabilizer assembly, \
		a magnetic barrel charger insert, a Nanotrasen-blue ergonomic grip, and the end-user's choice of \
		illuminated sights, front-mounted reflex sight, or rear-mounted scope."

/obj/item/crafting_conversion_kit/c38_super/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/datum/crafting_recipe/c38_super
	name = ".38 Revolver to NT/E Laevateinn Conversion"
	desc = "Under what circumstances would you need to carry around a .38 revolver converted into a railgun? Whatever circumstances you're in, apparently."
	result = /obj/item/gun/ballistic/revolver/c38/super/empty
	reqs = list(
		/obj/item/gun/ballistic/revolver/c38 = 1,
		/obj/item/crafting_conversion_kit/c38_super = 1
	)
	steps = list(
		"Clear the cylinder",
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/c38_super/New()
	..()
	LAZYOR(blacklist, typesof(/obj/item/gun/ballistic/revolver/c38/super)) // let's not try to super-ize our already super revolver i think

/datum/crafting_recipe/c38_super/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/ballistic/revolver/c38/the_piece = collected_requirements[/obj/item/gun/ballistic/revolver/c38][1]
	if(the_piece.get_ammo())
		return FALSE
	return ..()
