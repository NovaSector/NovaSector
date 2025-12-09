/obj/item/pizzavoucher
	name = "pizza voucher"
	desc = "A pocket-sized plastic slip with a button in the middle. The writing on it seems to have faded."
	icon = 'modular_nova/modules/pizza_voucher/icons/pizza_voucher.dmi'
	icon_state = "pizza_voucher"
	var/spent = FALSE
	var/special_delivery = FALSE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/pizzavoucher/Initialize(mapload)
	. = ..()
	var/list/descstrings = list("24/7 PIZZA PIE HEAVEN",
	"WE ALWAYS DELIVER!",
	"24-HOUR PIZZA PIE POWER!",
	"TOMATO SAUCE, CHEESE, WE'VE BOTH BOTH OF THESE!",
	"COOKED WITH LOVE INSIDE A BIG OVEN!",
	"WHEN YOU NEED A SLICE OF JOY IN YOUR LIFE!",
	"WHEN YOU NEED A DISK OF OVEN BAKED BLISS!",
	"EVERY TIME YOU DREAM OF CIRCULAR CUISINE!",
	"WE ALWAYS DELIVER! WE ALWAYS DELIVER! WE ALWAYS DELIVER!")
	desc = "A pocket-sized plastic slip with a button in the middle. \"[pick(descstrings)]\" is written on the back."

/obj/item/pizzavoucher/attack_self(mob/user)
	add_fingerprint(user)
	if(!spent)
		user.visible_message(span_notice("[user] presses a button on [src]!"))
		desc = desc + " This one seems to be used-up."
		spent = TRUE
		user.visible_message(span_notice("A small bluespace rift opens just above [user]'s head and spits out a pizza box!"),
			span_notice("A small bluespace rift opens just above your head and spits out a pizza box!"),
			span_notice("You hear a fwoosh followed by a thump."))
		if(special_delivery)
			priority_announce(
			text = "SPECIAL DELIVERY PIZZA ORDER #[rand(1000,9999)]-[rand(100,999)] HAS BEEN RECEIVED. SHIPMENT DISPATCHED \
			VIA EXTRA-POWERFUL BALLISTIC LAUNCHERS FOR IMMEDIATE DELIVERY! THANK YOU AND ENJOY YOUR PIZZA!",
			title = "WE ALWAYS DELIVER!",
			sound = SSstation.announcer.get_rand_report_sound(),
			has_important_message = TRUE,
			)
		podspawn(list(
		"target" = get_turf(src),
		"style" = /datum/pod_style/seethrough,
		"spawn" = pick(\
			/obj/item/pizzabox/meat, \
			/obj/item/pizzabox/margherita, \
			/obj/item/pizzabox/vegetable, \
			/obj/item/pizzabox/mushroom, \
			/obj/item/pizzabox/meat, \
			/obj/item/pizzabox/sassysage, \
			/obj/item/pizzabox/pineapple, \
			),
		))
	else
		to_chat(user, span_warning("The [src] is spent!"))

/obj/item/pizzavoucher/emag_act(mob/user)
	if(spent)
		to_chat(user, span_warning("The [src] is spent!"))
		return
	if(!special_delivery)
		to_chat(user, span_warning("You activate the special delivery protocol on the [src]!"))
		special_delivery = TRUE
		return 1
	else
		to_chat(user, span_warning("The [src] is already in special delivery mode!"))

/obj/item/pizzavoucher/free
	name = "free pizza voucher"
	desc = parent_type::desc + "<br> And it's free! Wow!"
