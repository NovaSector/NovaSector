/obj/item/reagent_containers/hash
	name = "hash"
	desc = "Concentrated cannabis extract. Delivers a much better high when used in a bong."
	icon = 'modular_nova/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hash"
	volume = 20
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc = 15, /datum/reagent/toxin/lipolicide = 5)

/obj/item/reagent_containers/hash/dabs
	name = "dab"
	desc = "Oil extract from cannabis plants. Just delivers a different type of hit."
	icon = 'modular_nova/modules/morenarcotics/icons/crack.dmi'
	icon_state = "dab"
	volume = 40
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc/concentrated = 40) //horrendously powerful

/obj/item/reagent_containers/hashbrick
	name = "hash brick"
	desc = "A brick of hash. Good for transport!"
	icon = 'modular_nova/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hashbrick"
	volume = 80
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc = 60, /datum/reagent/toxin/lipolicide = 20)


/obj/item/reagent_containers/hashbrick/attack_self(mob/user)
	user.visible_message(span_notice("[user] starts breaking up the [src]."))
	if(do_after(user,10))
		to_chat(user, span_notice("You finish breaking up the [src]."))
		for(var/i = 1 to 4)
			new /obj/item/reagent_containers/hash(user.loc)
		qdel(src)

/datum/crafting_recipe/hashbrick
	name = "Hash brick"
	result = /obj/item/reagent_containers/hashbrick
	reqs = list(/obj/item/reagent_containers/hash = 4)
	parts = list(/obj/item/reagent_containers/hash = 4)
	time = 20
	category = CAT_CHEMISTRY

//export values
/datum/export/hash
	cost = CARGO_CRATE_VALUE * 0.35
	unit_name = "hash"
	export_types = list(/obj/item/reagent_containers/hash)
	include_subtypes = FALSE

/datum/export/crack/hashbrick
	cost = CARGO_CRATE_VALUE * 2
	unit_name = "hash brick"
	export_types = list(/obj/item/reagent_containers/hashbrick)
	include_subtypes = FALSE

/datum/export/dab
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "dab"
	export_types = list(/obj/item/reagent_containers/hash/dabs)
	include_subtypes = FALSE

/obj/item/food/brownie/thc
	name = "hash brownie"
	desc = "A square slice of delicious, chewy brownie infused with THC. A favorite among cannabis enthusiasts."
	icon = 'modular_nova/modules/morenarcotics/icons/thcsnacks.dmi'
	icon_state = "brownieweed"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/drug/thc = 10, // These brownies and no joke.
	)

/obj/item/storage/fancy/cigarettes/crownhaze
	name = "\improper Crown Smoke King's Haze"
	desc = "Ethically sourced from the finest cannabis plants, these pre-rolls are sure to leave you feeling like royalty. Please smoke responsibly."
	icon = 'modular_nova/modules/morenarcotics/icons/thcsnacks.dmi'
	icon_state = "weedpack"
	base_icon_state = "weedpack"
	spawn_type = /obj/item/cigarette/rollie/thc

/obj/item/cigarette/rollie/thc
	list_reagents = list(/datum/reagent/drug/thc = 15)

/obj/item/reagent_containers/cup/soda_cans/thc
	name = "\improper Orchard Green"
	desc = "The taste of a star in liquid form. Spiked with an orange-flavored THC blend to make the day go by a little easier."
	icon = 'modular_nova/modules/morenarcotics/icons/thcsnacks.dmi'
	icon_state = "thcdrink"
	list_reagents = list(/datum/reagent/consumable/space_cola = 11, /datum/reagent/consumable/orangejuice = 11, /datum/reagent/drug/thc = 8)
	drink_type = SUGAR | FRUIT | JUNKFOOD

/obj/item/food/thcgummies
	name = "sour-apple THC gummies"
	desc = "Just a little bit too hard to chew comfortably, but with all the right flavors. This Product contains THC."
	icon = 'modular_nova/modules/morenarcotics/icons/thcsnacks.dmi'
	icon_state = "thcgummy"
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/drug/thc = 8,
	)
	junkiness = 20
	tastes = list("cannabis" = 1, "sour... apple?" = 1, "something sweet" = 1)
	foodtypes = FRUIT|JUNKFOOD //Fruity Twist
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cookie/thc
	name = "THC cookie"
	desc = "COOKIE!!! But with a twist!"
	icon = 'modular_nova/modules/morenarcotics/icons/thcsnacks.dmi'
	icon_state = "thccookie"
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/drug/thc = 10,
	)
	tastes = list("cookie" = 1, "cannabis" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
