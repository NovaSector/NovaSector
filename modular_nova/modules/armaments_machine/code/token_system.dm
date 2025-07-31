#define EQUIPMENT_VENDOR_CATEGORY_PRIMARY "primary"
#define EQUIPMENT_VENDOR_CATEGORY_SECONDARY "secondary"
#define EQUIPMENT_VENDOR_CATEGORY_UNIFORM "uniform"
#define EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT "equipment"
#define EQUIPMENT_VENDOR_CATEGORY_UTILITIES "utilities"

/obj/machinery/equipment_vendor
	name = "Debug Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor"
	icon = 'modular_nova/modules/armaments_machine/icons/token_system_icons.dmi'

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
	)
	/// The stock of this active vending machine
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

/obj/machinery/equipment_vendor/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ArmamentVendor", src.name)
		ui.open()

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

/obj/machinery/equipment_vendor/attacked_by(obj/item/inserted, mob/living/user)
	if(!istype(inserted, /obj/item/equipment_token))
		return

	if(!istype(inserted, accepted_token))
		to_chat(user, span_notice("You try to use this token... but it simply gets spat back out."))
		return

	RedeemToken(inserted, user)
	return

/obj/machinery/equipment_vendor/proc/RedeemToken(obj/item/equipment_token/token, mob/redeemer)

	message_admins("ARMAMENT LOG: [redeemer] attempted to redeem a [token.name]!")
	if(QDELETED(token))
		return
	playsound(src, token_sound, 50, TRUE, extrarange = -3)
	to_chat(redeemer, "Thank you for redeeming your token. Remember. Use eye protection to not shoot your eye out!")
	SSblackbox.record_feedback("tally", "equipment_token_used", 1)
	qdel(token)

/obj/machinery/equipment_vendor/proc/vend_selected(mob/redeemer)


/// This machine cannot be emagged no matter what
/obj/machinery/equipment_vendor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user)
		to_chat(user, span_notice("You try to change the internal protocols, but the machine displays a runtime error and reboots!"))
	return FALSE








/*
	ui_interact(mob/user, datum/tgui/ui)
		ui = tgui_process.try_update_ui(user, src, ui)
		if(!ui)
			ui = new(user, src, "WeaponVendor", src.name)
			ui.open()

	ui_static_data(mob/user)
		. = list("stock" = list())

		for (var/datum/vendor_equipment/purchasable as anything in equipment_stock)
			.["stock"] += list(list(
				"ref" = "\ref[purchasable]",
				"name" = purchasable.name,
				"description" = purchasable.description,
				"cost" = purchasable.cost,
				"category" = purchasable.category,
			))

	ui_data(mob/user)
		. = list(
			"credits" = src.credits,
		)

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




/*
	if(build_inv) //non-constructable vending machine
		///Non-constructible vending machines do not have a refill canister to populate its products list from,
		///Which apparently is still needed in the case we use product categories instead.
		if(product_categories)
			for(var/list/category as anything in product_categories)
				products |= category["products"]
		build_inventories()
*/

/*
/obj/machinery/vending/proc/build_inventory(list/productlist, list/recordlist, list/categories, start_empty = FALSE, premium = FALSE)
	var/inflation_value = HAS_TRAIT(SSeconomy, TRAIT_MARKET_CRASHING) ? SSeconomy.inflation_value() : 1
	default_price = round(initial(default_price) * inflation_value)
	extra_price = round(initial(extra_price) * inflation_value)

	var/list/product_to_category = list()
	for (var/list/category as anything in categories)
		var/list/products = category["products"]
		for (var/product_key in products)
			product_to_category[product_key] = category

	for(var/typepath in productlist)
		var/amount = productlist[typepath]
		if(isnull(amount))
			amount = 0

		var/obj/item/temp = typepath
		var/datum/data/vending_product/new_record = new /datum/data/vending_product()
		new_record.name = initial(temp.name)
		new_record.product_path = typepath
		if(!start_empty)
			new_record.amount = amount
		new_record.max_amount = amount

		///Prices of vending machines are all increased uniformly.
		var/custom_price = round(initial(temp.custom_price) * inflation_value)
		if(!premium)
			new_record.price = custom_price || default_price
		else
			var/premium_custom_price = round(initial(temp.custom_premium_price) * inflation_value)
			if(!premium_custom_price && custom_price) //For some ungodly reason, some premium only items only have a custom_price
				new_record.price = extra_price + custom_price
			else
				new_record.price = premium_custom_price || extra_price

		new_record.age_restricted = initial(temp.age_restricted)
		new_record.colorable = !!(initial(temp.greyscale_config) && initial(temp.greyscale_colors) && (initial(temp.flags_1) & IS_PLAYER_COLORABLE_1))
		new_record.category = product_to_category[typepath]
		recordlist += new_record
*/




/*

/obj/machinery/vending/proc/build_inventories(start_empty)
	build_inventory(products, product_records, product_categories, start_empty)
	build_inventory(contraband, hidden_records, create_categories_from("Contraband", "mask", contraband), start_empty, premium = TRUE)
	build_inventory(premium, coin_records, create_categories_from("Premium", "coins", premium), start_empty, premium = TRUE)
*/














/obj/machinery/equipment_vendor/security
	name = "Security Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_security"
	accepted_token = /obj/item/equipment_token/security
	equipment_stock = list()




/obj/machinery/equipment_vendor/solfed
	name = "Sol Federation Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_solfed"
	accepted_token = /obj/item/equipment_token/security

/obj/machinery/equipment_vendor/syndicate
	name = "Syndicate Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_syndicate"
	accepted_token = /obj/item/equipment_token/security

/obj/machinery/equipment_vendor/destwo
	name = "Deepspace Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_destwo"
	accepted_token = /obj/item/equipment_token/security

/obj/machinery/equipment_vendor/nukie
	name = "Nuclear Operations Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_nukie"
	accepted_token = /obj/item/equipment_token/security

/obj/machinery/equipment_vendor/interdyne
	name = "Interdyne Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_interdyne"
	accepted_token = /obj/item/equipment_token/security

/obj/machinery/equipment_vendor/interdyne
	name = "Interdyne Equipment Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption. If you see this report it to admins"
	icon_state = "equipment_vendor_tarkon"
	accepted_token = /obj/item/equipment_token/security

/obj/item/equipment_token
	name = "ERROR TOKEN"
	desc = "If you have this or see this, let the admins know!"
	icon = 'modular_nova/modules/armaments_machine/icons/token_system_icons.dmi'
	icon_state = "token_error"
	w_class = WEIGHT_CLASS_TINY

	var/list/points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 0,
		EQUIPMENT_VENDOR_CATEGORY_SECONDARY = 0,
		EQUIPMENT_VENDOR_CATEGORY_UNIFORM = 0,
		EQUIPMENT_VENDOR_CATEGORY_EQUIPMENT = 0,
		EQUIPMENT_VENDOR_CATEGORY_UTILITIES = 0,
	)

/obj/item/equipment_token/security
	name = "Standard Security Token"
	desc = "Valued worth one point!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 1,
	)

/obj/item/equipment_token/security/warden
	name = "Warden Security Token"
	desc = "A special security pre-loaded for the warden!"
	icon_state = "token_primary"
	points = list(
		EQUIPMENT_VENDOR_CATEGORY_PRIMARY = 3,
	)

/datum/vendor_equipment
	/// Name of the object in view
	var/name = "intimidating military object"
	/// Description of the object or set
	var/description = "Report me if you see me, you really fuckin shouldn't be able to see me"
	/// What Category should this belong to? (Use defines to place them in the proper categories)
	var/category = null
	/// How many points should it cost. (uses var/category to charge points to relevant category)
	var/cost = 0
	/// What path does it uses to spawn?
	var/equipment_path = null
	/// In case admemes want to make specific requisitions require permits
	var/permit_required = FALSE
	/// In case admemes want specific jobs or accesses required
	var/access_required = list()
	/// In case admins want to have a limit on weapon amounts. This limits how much a certain weapon can be vended out of this machine, by default infinite
	var/vend_limit = null

/datum/vendor_equipment/primary
	category = EQUIPMENT_VENDOR_CATEGORY_PRIMARY
