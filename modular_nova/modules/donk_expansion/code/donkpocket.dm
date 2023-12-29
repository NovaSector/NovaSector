/obj/item/storage/box/donkpockets/nova
	icon = 'modular_nova/modules/donk_expansion/icons/donkpocket.dmi'

/obj/item/food/donkpocket/nova
	icon = 'modular_nova/modules/donk_expansion/icons/donkpocket.dmi'

/obj/item/food/donkpocket/warm/nova
	icon = 'modular_nova/modules/donk_expansion/icons/donkpocket.dmi'

///Coffee pockets
//box
/obj/item/storage/box/donkpockets/nova/donkpocketcaffe
	name = "box of coffee donk-pockets"
	icon_state = "donkpocketboxcaffe"
	donktype = /obj/item/food/donkpocket/nova/caffe

//plain
/obj/item/food/donkpocket/nova/caffe
	name = "\improper Caffè-pocket"
	desc = ""
	icon_state = "donkpocketcaffe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/coffee = 4,
	)
	tastes = list("coffee" = 2, "dough" = 2, "caramel" = 1)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/nova/caffe
	crafting_complexity = FOOD_COMPLEXITY_3
	var/static/list/caffe_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/medicine/epinephrine = 4,
		/datum/reagent/consumable/coffee = 4, //more coffee
	)

/obj/item/food/donkpocket/nova/caffe/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, caffe_added_reagents)

/obj/item/food/donkpocket/nova/caffe/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, caffe_added_reagents)

//warm
/obj/item/food/donkpocket/warm/nova/caffe
	name = "warm Caffè-pocket"
	desc = ""
	icon_state = "donkpocketcaffe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/coffee = 4,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/medicine/epinephrine = 4,
	)
	tastes = list("coffee" = 2, "dough" = 2, "melting caramel" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/donkpocket/caffe
	time = 15
	name = "Caffè-Pocket"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/coffee = 5,
		/datum/reagent/consumable/sugar = 3
	)
	result = /obj/item/food/donkpocket/nova/caffe
	category = CAT_PASTRY

///Dank pockets - Overwriting the pre-dating yet strangely unfinished dank-pockets
//box
/obj/item/storage/box/donkpockets/nova/donkpocketdank
	name = "box of weed donk-pockets"
	icon_state = "donkpocketboxdank"
	donktype = /obj/item/food/donkpocket/nova/dank

//plain
/obj/item/food/donkpocket/nova/dank
	name = "\improper Dank-pocket"
	desc = "The food of choice for the seasoned botanist."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/drug/cannabis = 3,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("cannabis" = 2, "dough" = 2, "mothballs" = 1)
	foodtypes = GRAIN | VEGETABLES
	warm_type = /obj/item/food/donkpocket/warm/nova/dank
	crafting_complexity = FOOD_COMPLEXITY_3
	var/static/list/dank_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/toxin/lipolicide = 2,
	)

/obj/item/food/donkpocket/nova/dank/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, dank_added_reagents)

/obj/item/food/donkpocket/nova/dank/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, dank_added_reagents)

//warm
/obj/item/food/donkpocket/warm/nova/dank
	name = "warm Dank-pocket"
	desc = ""
	icon = 'icons/obj/food/food.dmi'
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/toxin/lipolicide = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/drug/cannabis = 3,
	)
	tastes = list("cannabis" = 2, "dough" = 2, "hot mothballs" = 1)
	foodtypes = GRAIN | VEGETABLES
