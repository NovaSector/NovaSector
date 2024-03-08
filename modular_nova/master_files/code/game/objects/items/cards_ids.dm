// GENERIC
/obj/item/card/id/advanced/silver/generic
	name = "generic silver identification card"
	icon = 'modular_nova/master_files/icons/obj/card.dmi'
	icon_state = "card_silvergen"
	assigned_icon_state = null

/obj/item/card/id/advanced/gold/generic
	name = "generic gold identification card"
	icon = 'modular_nova/master_files/icons/obj/card.dmi'
	icon_state = "card_goldgen"
	assigned_icon_state = null

// Interdyne (Deck Officer's)
/obj/item/card/id/advanced/chameleon/black/silver
	name = "silver identification card"
	desc = "A silver card which shows honour and dedication."
	icon_state = "card_silver"
	inhand_icon_state = "silver_id"
	assigned_icon_state = "assigned_silver"

// DS2
/obj/item/card/id/advanced/prisoner/ds2
	name = "syndicate prisoner card"
	icon = 'modular_nova/master_files/icons/obj/card.dmi'
	icon_state = "card_ds2prisoner"

// SOLFED
/obj/item/card/id/advanced/solfed
	name = "solfed identification card"
	icon = 'modular_nova/master_files/icons/obj/card.dmi'
	icon_state = "card_solfed"
	assigned_icon_state = "assigned_solfed"

#define TO_USER_ID "Credit Card → ID"
#define TO_CREDIT_CARD "ID → Credit Card"

/obj/item/card/credit_card
	name = "credit card"
	desc = "A small, reusable card for keeping and transfering credits. Swipe your ID card over it to start the process."
	icon = 'modular_nova/master_files/icons/obj/card.dmi'
	icon_state = "credit_card"

	//Amount of credit this card contains.
	var/credit = 0

/obj/item/card/credit_card/examine(mob/user)
	. = ..()
	. += span_notice("It can only interact with ID cards.")
	. += span_notice("There's [credit] credit\s on the card.")

/obj/item/card/credit_card/attackby(obj/item/attacking_item, mob/user, params)
	if(!isidcard(attacking_item))
		return ..()
	var/obj/item/card/id/attacking_id = attacking_item
	balloon_alert(user, "starting transfer")
	var/credit_movement = tgui_alert(user, "To ID (from card) or to card (from ID)?", "Credit Transfer", list(TO_USER_ID, TO_CREDIT_CARD))
	if(!credit_movement)
		return
	var/amount = tgui_input_number(user, "How much do you want to transfer? ID Balance: [attacking_id.registered_account.account_balance], Card Balance: [credit]", "Transfer credit", min_value = 0, round_value = 1)
	if(!amount)
		return
	switch(credit_movement)
		if(TO_USER_ID)
			if(amount > credit)
				amount = credit
			attacking_id.registered_account.adjust_money(amount, "Transfer from credit card")
			credit -= amount
			to_chat(user, span_notice("You transfer [amount] credits from [src] to [attacking_id]."))
		if(TO_CREDIT_CARD)
			if(amount > attacking_id.registered_account.account_balance)
				amount = attacking_id.registered_account.account_balance
			attacking_id.registered_account.account_balance -= amount
			credit += amount
			to_chat(user, span_notice("You transfer [amount] credits from [attacking_id] to [src]."))

#undef TO_CREDIT_CARD
#undef TO_USER_ID
