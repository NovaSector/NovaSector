/datum/reagent/consumable/sap
	name = "Sap"
	description = "The lifeblood of trees. Full of sugar that was meant for the tree, you monster."
	color = "#c9a030b6"
	taste_description = "sugary"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	evaporates = TRUE

/datum/reagent/consumable/syrup
	name = "Syrup"
	description = "A starchy, thick, and sugary liquid that was extracted and processed from a tree."
	color = "#3a1d05b6"
	taste_description = "sugary"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	evaporates = TRUE

/datum/crafting_recipe/food/bacon_syrup
	name = "Syrup Bacon"
	reqs = list(
		/obj/item/food/meat/bacon = 1,
		/datum/reagent/consumable/syrup = 2,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/sugar = 1
	)
	result = /obj/item/food/meat/bacon/syrup
	category = CAT_MEAT

/obj/item/food/meat/bacon/syrup
	name = "piece of syrup bacon"
	desc = "A delicious piece of bacon that has been coated with some syrup, sugar, and salt."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/syrup = 1,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/fat = 2,
	)

/datum/chemical_reaction/food/sap_syrup
	results = list(/datum/reagent/consumable/syrup = 1)
	required_reagents = list(/datum/reagent/consumable/sap = 2)
	required_temp = 390.15
	optimal_temp = 600
	mob_react = FALSE

/datum/chemical_reaction/food/syrup_sugar
	results = list(/datum/reagent/consumable/sugar = 1)
	required_reagents = list(/datum/reagent/consumable/syrup = 1)
	required_temp = 400.15
	optimal_temp = 600
	mob_react = FALSE
