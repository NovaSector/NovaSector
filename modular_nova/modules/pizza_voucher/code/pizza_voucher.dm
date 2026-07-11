/// Pizzas that we aren't allowed to pick, for one reason or another.
#define EXCLUDED_PIZZA_LIST list( \
	/obj/item/food/pizza/custom, \
	/obj/item/food/pizza/flatbread, \
	/obj/item/food/pizza/arnold, \
	/obj/item/food/pizza/margherita/raw, \
	/obj/item/food/pizza/meat/raw, \
	/obj/item/food/pizza/mushroom/raw, \
	/obj/item/food/pizza/vegetable/raw, \
	/obj/item/food/pizza/donkpocket/raw, \
	/obj/item/food/pizza/dank/raw, \
	/obj/item/food/pizza/sassysage/raw, \
	/obj/item/food/pizza/pineapple/raw, \
	/obj/item/food/pizza/arnold/raw, \
	/obj/item/food/pizza/energy/raw, \
	/obj/item/food/pizza/margherita/robo, \
)

/obj/item/pizzavoucher
	name = "pizza voucher"
	desc = "A pocket-sized plastic slip with a button in the middle. The writing on it seems to have faded."
	icon = 'modular_nova/modules/pizza_voucher/icons/pizza_voucher.dmi'
	icon_state = "pizza_voucher"
	w_class = WEIGHT_CLASS_SMALL
	///Whether we announce our presence loudly or not.
	var/special_delivery = FALSE
	/// The custom tag to default to if we have no name (like mothic pizzas/lizard flatbreads).
	var/box_tag = "Low Orbit Pie Cannon"
	/// The empty box waiting for a pizza selection.
	var/obj/item/pizzabox/our_box

/obj/item/pizzavoucher/Initialize(mapload)
	. = ..()
	var/list/descstrings = list(
		"24/7 PIZZA PIE HEAVEN",
		"WE ALWAYS DELIVER!",
		"24-HOUR PIZZA PIE POWER!",
		"TOMATO SAUCE, CHEESE, WE'VE BOTH BOTH OF THESE!",
		"COOKED WITH LOVE INSIDE A BIG OVEN!",
		"WHEN YOU NEED A SLICE OF JOY IN YOUR LIFE!",
		"WHEN YOU NEED A DISK OF OVEN BAKED BLISS!",
		"EVERY TIME YOU DREAM OF CIRCULAR CUISINE!",
		"WE ALWAYS DELIVER! WE ALWAYS DELIVER! WE ALWAYS DELIVER!",
		)
	desc = "A pocket-sized plastic slip with a button in the middle. \"[pick(descstrings)]\" is written on the back."

/obj/item/pizzavoucher/attack_self(mob/user)
	. = ..()
	user.visible_message(span_notice("[user] presses a button on [src]!"))

	// Build radial menu from all the pizzalikes
	var/list/pizza_choices = list()
	for(var/obj/item/food/pizza/pizza_type as anything in valid_subtypesof(/obj/item/food/pizza) - EXCLUDED_PIZZA_LIST)
		var/pizza_name = initial(pizza_type.name)
		pizza_choices[pizza_name] = pizza_type

	// Show radial menu for pizza selection
	var/selection = show_radial_menu(user, src, pizza_choices)
	if(!selection)
		return
	else
		// Spawn the empty box with the witty tag (or a bomb box if emagged)
		if(special_delivery)
			our_box = new /obj/item/pizzabox/bomb/armed()
		else
			our_box = new /obj/item/pizzabox()

		user.visible_message(span_notice("A small bluespace rift opens just above [user]'s head and spits out a pizza box!"),
			span_notice("A small bluespace rift opens just above your head and spits out a pizza box!"),
			span_notice("You hear a fwoosh followed by a thump."),
		)
		fill_pizza(user, our_box, pizza_choices[selection]) // Look up the path using the name key
		podspawn(list(
			"target" = get_turf(src),
			"style" = /datum/pod_style/seethrough,
			"spawn" = our_box,
		))
		to_chat(user, span_warning("[src] self-immolates into a pile of ash!"))
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		qdel(src)

/obj/item/pizzavoucher/emag_act(mob/user)
	if(special_delivery)
		balloon_alert(user, "already special!")
		return FALSE
	to_chat(user, span_warning("You override [src]'s delivery protocols. The next pizza will be a <b>special delivery</b>!"))
	balloon_alert(user, "mamma mia!")
	special_delivery = TRUE
	return TRUE

///Fills the pizza box with the chosen pizza type; dynamically updating its appearance to accomodate it.
/obj/item/pizzavoucher/proc/fill_pizza(mob/user, obj/item/pizzabox/our_box, pizza_type)
	if(!pizza_type || !our_box)
		return
	var/obj/item/food/pizza/pizza = new pizza_type(our_box)
	our_box.pizza = pizza
	our_box.boxtag = box_tag
	our_box.update_appearance()

/obj/item/pizzavoucher/free
	name = "free pizza voucher"

/obj/item/pizzavoucher/free/Initialize(mapload)
	. = ..()
	desc += "<br> And it's free! Wow!"

#undef EXCLUDED_PIZZA_LIST
