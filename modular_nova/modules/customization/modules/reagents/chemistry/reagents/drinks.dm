/obj/item/reagent_containers/cup/soda_cans/nova/lubricola
	name = "LubriCola"
	desc = "The perfect lubricant for your weary gears."
	icon_state = "lubricola"
	list_reagents = list(/datum/reagent/fuel/oil = 30)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/nova/welding_fizz
	name = "Welding Fizz"
	desc = "More energy than in an IED! Now carbonated. WARNING: Contains toxic and flammable fuels."
	icon_state = "welding_fizz"
	list_reagents = list(/datum/reagent/fuel = 25, /datum/reagent/carbondioxide = 5)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/nova/synthanolcan
	name = "Silly Cone's Synthanol"
	desc = "A recompiling can of synthanol."
	icon_state = "synthanolcan"
	list_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 30)
	custom_price = PAYCHECK_CREW

/*
*	NOVA SECTOR SODA CANS
*/

/obj/item/reagent_containers/cup/soda_cans/nova
	icon = 'modular_nova/master_files/icons/obj/drinks.dmi'
	icon_state = null
	crushed_icon = 'modular_nova/master_files/icons/obj/janitor.dmi'
