#define RND_CATEGORY_NRI_FOOD "Provision"
#define RND_CATEGORY_NRI_MEDICAL "Medicine"
#define RND_CATEGORY_NRI_CLOTHING "Apparel"

/obj/machinery/biogenerator/food_replicator
	name = "\improper Type 34 'Colonial Supply Core'"
	desc = "The Type 34 'Colonial Supply Core,' colloquially known as the 'Gencrate/CSC' is an ancient, boxy design first put in use by the pioneer colonists of what's now known \
		as the NRI. The Gencrate is at its core a matter resequencer, a highly specialized subtype of biogenerator which performs a sort of transmutation using organic \
		compounds; normally from large-scale crops or waste product. With sufficient supply, the machine is capable of making a wide variety of provisions, \
	from clothes to food to first-aid medical supplies."
	icon = 'modular_nova/modules/food_replicator/icons/biogenerator.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/food_replicator
	show_categories = list(
		RND_CATEGORY_NRI_FOOD,
		RND_CATEGORY_NRI_MEDICAL,
		RND_CATEGORY_NRI_CLOTHING,
	)

/obj/machinery/biogenerator/food_replicator/RefreshParts()
	. = ..()
	efficiency *= 0.75
	productivity *= 0.75

/obj/item/circuitboard/machine/biogenerator/food_replicator
	name = "Colonial Supply Core"
	build_path = /obj/machinery/biogenerator/food_replicator

/obj/item/flatpack/food_replicator
	name = "colonial supply core"
	board = /obj/item/circuitboard/machine/biogenerator/food_replicator
