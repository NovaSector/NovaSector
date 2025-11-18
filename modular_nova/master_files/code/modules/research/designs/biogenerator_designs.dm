/datum/design/biomeat
	name = "Meat Product"
	id = "meatp"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25) // Monkey Cube is more efficient, but this is easier on the chef.
	build_path = /obj/item/food/meat/slab/meatproduct
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)

// Kobors
/datum/design/kobold_cube
	name = "Kobold Kube"
	id = "kcube"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/monkeycube/kobold
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_FOOD)
