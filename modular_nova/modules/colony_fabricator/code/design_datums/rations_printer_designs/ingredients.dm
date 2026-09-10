/datum/design/biogen/frontier_ration/ingredients
	abstract_type = /datum/design/biogen/frontier_ration/ingredients
	name = "Frontier Ingredients Basetype"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_FOODRICATOR_INGREDIENTS,
	)

/datum/design/biogen/frontier_ration/ingredients/egg
	name = "Egg"
	build_path = /obj/item/food/egg

/datum/design/biogen/frontier_ration/ingredients/chicken
	name = "Chicken"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/chicken

/datum/design/biogen/frontier_ration/ingredients/mystery_meat
	name = "Meat Product"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/meatproduct

/datum/design/biogen/frontier_ration/ingredients/butter
	name = "Butter"
	build_path = /obj/item/food/butter

/datum/design/biogen/frontier_ration/ingredients/cheese
	name = "Cheese"
	build_path = /obj/item/food/cheese/wedge

/datum/design/biogen/frontier_ration/ingredients/cheese_firm
	name = "Firm Cheese"
	build_path = /obj/item/food/cheese/firm_cheese_slice
