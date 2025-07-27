/datum/objective/heist
	name = "heist"
	explanation_text = "Score yourself a payday."
	admin_grantable = TRUE

/datum/objective/heist/New(text)
	. = ..()
	target_amount = rand(15000,35000)
	update_explanation_text()

/datum/objective/heist/update_explanation_text()
	. = ..()
	explanation_text = "Liberate [target_amount] Cr or more from the station's bank accounts or bank consoles, stored within a holochip or on your own bank account."

/datum/objective/heist/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/mind in owners)
		if(!isliving(mind.current))
			continue

		var/list/all_items = mind.current.get_all_contents()
		for(var/obj/item in all_items)
			if(HAS_TRAIT(item, TRAIT_ITEM_OBJECTIVE_BLOCKED))
				continue

			if(istype(item, /obj/item/holochip))
				var/obj/item/holochip/loot
				if(loot.credits >= target_amount)
					return TRUE

			if(istype(item, /obj/item/card/id))
				var/obj/item/card/id/card
				if(card.registered_account)
					var/datum/bank_account/piggy_bank
					if(piggy_bank.account_balance >= target_amount)
						return TRUE
	return FALSE
