/obj/item/defibrillator/compact/combat/loaded/interdyne
	name = "\improper Interdyne rapid combative defibrillator"
	desc = "A belt-equipped combative defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, and can be utilized as a weapon via applying the paddles while in a combat stance."
	icon_state = "defibcompact"
	inhand_icon_state = null
	worn_icon_state = "defibcompact"

/obj/item/storage/backpack/duffelbag/syndie/interdyne/advancedkit
	name = "\improper Interdyne advanced kit"
	desc = "Carries three premium tactical medical kits for your most intense needs!"

/obj/item/storage/backpack/duffelbag/syndie/interdyne/advancedkit/PopulateContents()
	new /obj/item/storage/medkit/tactical/premium(src)
	new /obj/item/storage/medkit/tactical/premium(src)
	new /obj/item/storage/medkit/tactical/premium(src)

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing
	name = "tactical maid kit"
	desc = "Only carries one tactical maid set."

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing/PopulateContents()
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_multi
	name = "bulk Tactical maid kit"
	desc = "Carries 3 Tactical maid sets!"

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_multi/PopulateContents()
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)



/// Combat maiden kit
/// - x3 Combat maid uniforms
