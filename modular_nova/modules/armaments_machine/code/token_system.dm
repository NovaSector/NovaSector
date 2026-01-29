/obj/machinery/equipment_vendor
	name = "Debug Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor"
	icon = 'modular_nova/modules/armaments_machine/icons/vendors.dmi'

	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/equipment_vendor
	max_integrity = 2000
	density = TRUE
	/// The list of points this active vending machine has
	var/list/points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 0,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 0,
		EQUIPMENT_VENDOR_CATEGORY_UNIFORM = 0,
		EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT = 0,
		EQUIPMENT_VENDOR_CATEGORY_UTILITIES = 0,
		EQUIPMENT_VENDOR_CATEGORY_SPECIAL = 0,
	)
	/// The stock of this active vending machine, look at /datum/vendor_equipment, make sure to fill this with vendor equipment)
	var/list/datum/equipment_stock = list()

	/// Remove maybe?
	var/list/product_categories = null

	/// Which token and its subtypes are accepted (EX: /obj/item/equipment_token accepts all tokens and /obj/item/equipment_token/security only accepts security tokens)
	var/accepted_token = /obj/item/equipment_token

	/// The sound when a purchase is successfully made.
	var/purchase_sound = 'sound/machines/machine_vend.ogg'
	/// The sound when a purchase is denied
	var/denial_sound = 'sound/machines/cryo_warning.ogg'
	/// The sound when a coin is slotted in successfully
	var/token_sound = 'sound/machines/coindrop2.ogg'
	/// The sound when a item is rejected
	var/token_denial = 'sound/machines/terminal/terminal_error.ogg'

/obj/item/circuitboard/machine/equipment_vendor
	name = "Equipment Vendor (Machine Board)"
	icon_state = "circuit_map"
	build_path = /obj/machinery/equipment_vendor
	req_components = list(
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stock_parts/capacitor = 2)

/obj/machinery/equipment_vendor/wrench_act(mob/living/user, obj/item/item)
	default_unfasten_wrench(user, item, 120)
	return TRUE

/obj/machinery/equipment_vendor/attacked_by(obj/item/equipment_token/token, mob/living/redeemer)
	if(!istype(token, /obj/item/equipment_token))
		return

	if(!istype(token, accepted_token))
		to_chat(redeemer, span_notice("You try to use this [token.item_type]... but it simply gets spat back out."))
		return

	RedeemToken(token, redeemer)
	return


/// Code relevant to redeeming the token itself.
/obj/machinery/equipment_vendor/proc/RedeemToken(obj/item/equipment_token/token, mob/redeemer)
	/// Opens the UI when slotting the token
	src.ui_interact(redeemer)
	if(QDELETED(token))
		return
	playsound(src, token_sound, 50, TRUE, extrarange = -3)
	to_chat(redeemer, "Thank you for redeeming your [token.item_type]. Remember to use your equipment safely and wisely!")
	add_tokenpoints(token)
	SSblackbox.record_feedback("tally", "equipment_token_used", 1)
	qdel(token)

/// adds the amount of token points of the inserted token
/obj/machinery/equipment_vendor/proc/add_tokenpoints(obj/item/equipment_token/token)
	for(var/category in token.points)
		points[category] += token.points[category]

/// Locks in and sets the amount of tokens slotted into it.
/obj/machinery/equipment_vendor/proc/set_tokenpoint(amount)
	src.points = amount


/// This machine cannot be emagged no matter what
/obj/machinery/equipment_vendor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user)
		to_chat(user, span_notice("You try to change the internal protocols, but the machine displays a runtime error and reboots!"))
	return FALSE

/obj/machinery/equipment_vendor/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ArmamentVendor", src.name)
		ui.open()

/obj/machinery/equipment_vendor/ui_static_data(mob/user)
	var/list/armsdata = list()
	armsdata = list("stock" = list())

	for (var/datum/vendor_equipment/purchasable as anything in equipment_stock)
		armsdata["stock"] += list(list(
			"ref" = "\ref[purchasable]",
			"name" = purchasable.name,
			"description" = purchasable.description,
			"cost" = purchasable.cost,
			"category" = purchasable.category,
			"product" = purchasable.product_path,
			"buy_limit" = purchasable.vend_limit,
			"permit_req" = purchasable.permit_required,
		))

/obj/machinery/equipment_vendor/ui_data(mob/user)
	. = list("points" = points)


/*
/obj/machinery/equipment_vendor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state, mob/redeemer)
	. = ..()
	if(.)
		return
	switch(action)
		if("Dispense")
			. = dispense(params)

/obj/machinery/equipment_vendor/proc/dispense(list/params) // Maybe this works?
	var/datum/vendor_equipment/purchased = locate(params["ref"]) in equipment_stock
	if (src.points[purchased.category] >= purchased.cost)
		src.points[purchased.category] -= purchased.cost
		playsound(src.loc, purchase_sound, 80, 1)
		usr.put_in_active_hand
		return TRUE
	else
		playsound(src.loc, denial_sound, 80, 1)
	priority_announce("TEST RECIEVED","VENDING_DEBUG")
*/




/*
	ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
		. = ..()
		if (. || GET_COOLDOWN(src, "anti-spam"))
			return

		switch(action)
			if ("redeem")
				var/datum/vendor_equipment/purchasable = locate(params["ref"]) in equipment_stock
				if (src.credits[purchasable.category] >= purchasable.cost)
					src.credits[purchasable.category] -= purchasable.cost
					if (!purchasable.cost)
						ON_COOLDOWN(src, "anti-spam", 1 SECOND)
					var/atom/Antispam = new purchasable.path(src.loc)
					playsound(src.loc, sound_buy, 80, 1)
					src.vended(Antispam)
					usr.put_in_hand_or_eject(Antispam)
					return TRUE
*/

/obj/item/equipment_token
	name = "ERROR TOKEN"
	desc = "If you have this or see this, let the admins know!"
	icon = 'modular_nova/modules/armaments_machine/icons/tokens.dmi'
	icon_state = "token_error"
	w_class = WEIGHT_CLASS_TINY

	/// What do we describe this as? "Thank you for redeeming your [token.item_type]" & "You try to use this [inserted.item_type]... but it simply gets spat back out."
	var/item_type = "token"

	/// Points for tokens should always be reasonable, such as no more than 3 for any category
	var/list/points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 0,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 0,
		EQUIPMENT_VENDOR_CATEGORY_UNIFORM = 0,
		EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT = 0,
		EQUIPMENT_VENDOR_CATEGORY_UTILITIES = 0,
		EQUIPMENT_VENDOR_CATEGORY_SPECIAL = 0,
	)

/// Base Datam, Use it!
/datum/vendor_equipment
	/// Name override of the object in view (make code use item's default name if undefined)
	var/name = "intimidating military object"
	/// Description override of the object or set (make code use item's default name if undefined)
	var/description = "Report me if you see me, you really fuckin shouldn't be able to see me"
	/// What Category should this belong to? (Use defines to place them in the proper categories)
	var/category = null
	/// How many points should it cost. (uses var/category to charge points to relevant category) (Think of these as weaker telecrystals kinda, points should be)
	var/cost = 0
	/// If this has an object defined, it will use that image (Great for when equipment_path is a guncase or something that is a container).
	/// If image_object is not defined or is null then it will just use equipment_path
	var/obj/image_object
	/// What path does it uses to spawn?
	var/obj/product_path
	/// In case admemes want to make specific requisitions require permits
	var/permit_required = FALSE
	/// In case admemes want specific jobs or accesses required
	var/access_required = list()
	/// In case admins want to have a limit on weapon amounts. This limits how much a certain weapon can be vended out of this machine, by default infinite
	var/vend_limit = null

/datum/vendor_equipment/primary
	category = EQUIPMENT_VENDOR_CATEGORY_PRIMARY

/datum/vendor_equipment/secondary
	category = EQUIPMENT_VENDOR_CATEGORY_SECONDARY

/datum/vendor_equipment/uniforms
	category = EQUIPMENT_VENDOR_CATEGORY_UNIFORM

/datum/vendor_equipment/equipment
	category = EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT

/datum/vendor_equipment/utilities
	category = EQUIPMENT_VENDOR_CATEGORY_UTILITIES

/datum/vendor_equipment/special
	category = EQUIPMENT_VENDOR_CATEGORY_SPECIAL

