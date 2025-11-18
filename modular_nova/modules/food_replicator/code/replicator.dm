#define RND_CATEGORY_HC_FOOD "Provision"
#define RND_CATEGORY_HC_MEDICAL "Medicine"
#define RND_CATEGORY_HC_CLOTHING "Apparel"

/obj/machinery/biogenerator/food_replicator
	name = "\improper Pioneer-Class Matter Resequencer"
	desc = "A modern Heliostatic Coalition resequencer unit, producing civilian necessities through controlled organic transmutation. Its streamlined \
	casing bears little resemblance to the original colonization era designs."
	icon = 'modular_nova/modules/food_replicator/icons/biogenerator.dmi'
	circuit = /obj/item/circuitboard/machine/biogenerator/food_replicator
	show_categories = list(
		RND_CATEGORY_HC_FOOD,
		RND_CATEGORY_HC_MEDICAL,
		RND_CATEGORY_HC_CLOTHING,
	)

/obj/machinery/biogenerator/food_replicator/examine_more(mob/user)
	. = ..()

	. += "This machine's lineage traces back to the first wave of Sol colonization - the original Pioneer-Class units were brutally overbuilt survival tools \
	issued to settler groups expecting imminent resupply that never came. Through generations of hardship, these resequencers became the bedrock of colonial survival, \
	producing everything from emergency rations to medical supplies and durable textiles from whatever organic matter was available."

	. += "As the scattered colonies evolved into the Heliostatic Coalition, the Pioneer underwent continuous refinement. Coalition engineers rebuilt, \
	overbuilt, and streamlined the design so thoroughly that the current model barely resembles its Sol-era ancestor externally. Yet internally, \
	the core matter-transmutation principles remain unchanged, producing practically the same selection of utilitarian goods that once kept entire \
	colonies alive during their most desperate years."

	return .

/obj/machinery/biogenerator/food_replicator/RefreshParts()
	. = ..()
	efficiency *= 0.75
	productivity *= 0.75

/obj/item/circuitboard/machine/biogenerator/food_replicator
	name = "Pioneer-Class Matter Resequencer"
	build_path = /obj/machinery/biogenerator/food_replicator

/obj/item/flatpack/food_replicator
	name = "pioneer matter resequencer"
	board = /obj/item/circuitboard/machine/biogenerator/food_replicator
