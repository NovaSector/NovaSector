#define MAX_CREDIT_ON_CARD 5000
#define MIN_CREDIT_ON_CARD 1000

/datum/quirk/item_quirk/rich
	name = "Rich"
	desc = "You have really much money. So much, that you ever take your credit card with you. Be sure you won't lose it."
	gain_text = span_danger("You feel yourself rich!")
	lose_text = span_notice("You suddenly feel yourself poor.")
	medical_record_text = "Patient has a large amount of money."
	icon = FA_ICON_COINS
	value = 4

/datum/quirk/item_quirk/rich/add_unique(client/client_source)
	var/obj/item/card/credit_card/C = new /obj/item/card/credit_card()
	..()
	C.credit = rand(MIN_CREDIT_ON_CARD, MAX_CREDIT_ON_CARD)
	give_item_to_holder(C, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))

#undef MAX_CREDIT_ON_CARD
#undef MIN_CREDIT_ON_CARD
