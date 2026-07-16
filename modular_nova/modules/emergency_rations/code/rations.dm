//Emergency rations, and their contents

/* RATION BAG */

// Because i couldn't figure out how to override the PopulateContents() of the import vendor foodpack, i've decided to make the ration bag its own type.

/obj/item/storage/box/ration
	name = "emergency ration"
	desc = "A blue plastic sack containing an emergency ration, meant to keep the crew fed in the event a chef is absent or incapable of working. \
			Intended for distribution in times of disaster or war, its contents are nourishing, and intended to be edible to a wide variety of potential species."
	icon = 'modular_nova/modules/emergency_rations/icons/rations.dmi'
	icon_state = "foodpack_ration_big"
	illustration = null
	custom_price = PAYCHECK_CREW * 1.8
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	foldable_result = /obj/item/stack/sheet/plastic

/obj/item/storage/box/ration/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/vendor_meal_mains/ration_one(src) // First main.
	new /obj/effect/spawner/random/vendor_meal_mains/ration_two(src) // Second main.
	new /obj/effect/spawner/random/vendor_meal_sides/ration_one(src) // First side.
	new /obj/effect/spawner/random/vendor_meal_sides/ration_two(src) // Second side.
	new /obj/item/food/vendor_tray_meal/side/ration/bag/cracker(src) // Crackers.
	new /obj/item/reagent_containers/condiment/pack/peanut_butter(src) // Peanut butter.

/obj/item/storage/box/ration/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You can make out a faded logo of some sort on the side, that almost looks like...</i>")
	return .

/* MAINS */

/obj/item/food/vendor_tray_meal/ration
	name = "\improper Emergency Ration Main: Beans and Yellow Rice"
	desc = "Red beans and green onion, mixed in with steaming yellow rice."
	icon = 'modular_nova/modules/emergency_rations/icons/rations.dmi'
	icon_state = "foodtray_ricenbeans"
	tastes = list("rice" = 1, "beans" = 1, "onion" = 1)
	foodtypes = VEGETABLES

/obj/item/food/vendor_tray_meal/ration/peasnsauce
	name = "\improper Emergency Ration Main: Peas and Carrots in Sauce"
	desc = "Steamed carrots and peas, swimming in a savory tomato sauce."
	icon_state = "foodtray_peasnsauce"
	tastes = list("peas" = 1, "carrots" = 1, "tomatoes" = 1)

/obj/item/food/vendor_tray_meal/ration/pasta
	name = "\improper Emergency Ration Main: Gnocchi and Tomatoes in Sauce"
	desc = "Soft, gluten free potato gnocchi and tomato chunks, in marinara sauce."
	icon_state = "foodtray_pasta"
	tastes = list("potato pasta" = 1, "sauce" = 1, "tomatoes" = 1)

/obj/item/food/vendor_tray_meal/ration/bncstew
	name = "\improper Emergency Ration Main: Bean and Corn Stew"
	desc = "Pinto beans, green beans, and corn, simmering in a thick, vegetable-based stew."
	icon_state = "foodtray_bncstew"
	tastes = list("beans" = 1, "corn" = 1, "green beans" = 1)

/obj/item/food/vendor_tray_meal/ration/wildrice
	name = "\improper Emergency Ration Main: Wild Rice and Vegetables"
	desc = "Fluffy wild rice, with carrots and peas mixed in."
	icon_state = "foodtray_wildrice"
	tastes = list("rice" = 1, "carrots" = 1, "peas" = 1)

/obj/item/food/vendor_tray_meal/ration/splitpea
	name = "\improper Emergency Ration Main: Split Pea Stew"
	desc = "Thick, savory split pea stew, filled with pinto beans and sliced mushrooms."
	icon_state = "foodtray_splitpea"
	tastes = list("beans" = 1, "mushrooms" = 1, "peas" = 1)

/* SIDES */

/obj/item/food/vendor_tray_meal/side/ration
	name = "\improper Emergency Ration Side"
	desc = "This is the base type for emergency ration sides. If you somehow managed to get this in normal gameplay, please file a bug report."
	icon = 'modular_nova/modules/emergency_rations/icons/rations.dmi'
	icon_state = "foodpack_ration"
	trash_type = /obj/item/trash/empty_side_pack/ration
	abstract_type = /obj/item/food/vendor_tray_meal/side/ration
	foodtypes = VEGETABLES

/obj/item/food/vendor_tray_meal/side/ration/bag
	trash_type = /obj/item/trash/empty_side_pack/ration/bag
	abstract_type = /obj/item/food/vendor_tray_meal/side/ration/bag

/obj/item/food/vendor_tray_meal/side/ration/bag/cracker
	name = "\improper Emergency Ration Side: Cracker"
	desc = "A crisp, rice flour cracker. Would go great with some peanut butter"
	icon_state = "bag_ration_cracker"
	tastes = list("cracker" = 1)

/obj/item/food/vendor_tray_meal/side/ration/bag/cookie
	name = "\improper Emergency Ration Side: Sweet Potato Cookie"
	desc = "A crumbly, sweet potato-based cookie."
	icon_state = "bag_ration_cookie"
	tastes = list("sweet potato" = 1, "sugar" = 1)
	foodtypes = VEGETABLES | SUGAR

/obj/item/food/vendor_tray_meal/side/ration/bag/bstart
	name = "\improper Emergency Ration Side: Brown Sugar Toaster Pastry"
	desc = "A gluten-free, rice flour-based toaster pastry. This one's brown sugar flavored."
	icon_state = "bag_ration_bstart"
	tastes = list("brown sugar" = 1, "pastry" = 1)
	foodtypes = VEGETABLES | SUGAR

/obj/item/food/vendor_tray_meal/side/ration/shortbread
	name = "\improper Emergency Ration Side: Shortbread Bar"
	desc = "A rice flour shortbread cookie."
	icon_state = "foodpack_ration_shortbread"
	tastes = list("pastry" = 1)
	foodtypes = VEGETABLES | SUGAR

/obj/item/food/vendor_tray_meal/side/ration/bag/cornnuts
	name = "\improper Emergency Ration Side: Corn Nuts"
	desc = "A bunch of crunchy corn nuts."
	icon_state = "bag_ration_cornnuts"
	tastes = list("roasted corn" = 1)

/obj/item/food/vendor_tray_meal/side/ration/bag/pretzels
	name = "\improper Emergency Ration Side: Pretzel Bites"
	desc = "A bunch of crunchy, gluten free, salted pretzel bites."
	icon_state = "bag_ration_pretzels"
	tastes = list("hard pretzel" = 1)

/obj/item/food/vendor_tray_meal/side/ration/granola
	name = "\improper Emergency Ration Side: Granola Bar"
	desc = "A classic, honey and oat granola bar."
	icon_state = "foodpack_ration_granola"
	tastes = list("honey" = 1, "oats" = 1)

/obj/item/reagent_containers/condiment/pack/peanut_butter // This didn't already exist, for some reason.
	name = "peanut butter pack"
	originalname = "peanut butter"
	volume = 10
	list_reagents = list(/datum/reagent/consumable/peanut_butter = 10)

/* MISC */

// Using two different main and side spawners, to ensure that you don't get the same main/side twice in a ration.

/obj/effect/spawner/random/vendor_meal_mains/ration_one
	name = "random ration first main spawner"
	loot = list(
		/obj/item/food/vendor_tray_meal/ration,
		/obj/item/food/vendor_tray_meal/ration/peasnsauce,
		/obj/item/food/vendor_tray_meal/ration/pasta,
	)

/obj/effect/spawner/random/vendor_meal_mains/ration_two
	name = "random ration second main spawner"
	loot = list(
		/obj/item/food/vendor_tray_meal/ration/bncstew,
		/obj/item/food/vendor_tray_meal/ration/wildrice,
		/obj/item/food/vendor_tray_meal/ration/splitpea,
	)

/obj/effect/spawner/random/vendor_meal_sides/ration_one
	name = "random ration first side spawner"
	loot = list(
		/obj/item/food/vendor_tray_meal/side/ration/bag/cookie,
		/obj/item/food/vendor_tray_meal/side/ration/bag/bstart,
		/obj/item/food/vendor_tray_meal/side/ration/shortbread,
	)

/obj/effect/spawner/random/vendor_meal_sides/ration_two
	name = "random ration second side spawner"
	loot = list(
		/obj/item/food/vendor_tray_meal/side/ration/granola,
		/obj/item/food/vendor_tray_meal/side/ration/bag/pretzels,
		/obj/item/food/vendor_tray_meal/side/ration/bag/cornnuts,
	)

/obj/item/trash/empty_side_pack/ration
	icon = 'modular_nova/modules/emergency_rations/icons/rations.dmi'
	icon_state = "foodpack_ration_trash"

/obj/item/trash/empty_side_pack/ration/bag
	name = "empty side bag"
	icon_state = "bag_ration_trash"
