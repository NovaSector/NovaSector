/// Toggle: equips or strips a chitinous suit and helmet.
/datum/action/cooldown/spell/hiveless/chitinous_armor
	name = "Chitinous Armor"
	desc = "Harden your flesh into a suit of black chitin. Toggle off to reabsorb it."
	button_icon_state = "chitinous_armor"
	cooldown_time = 2 SECONDS
	protein_cost = HIVELESS_COST_ARMOR
	/// Outer suit item equipped on form.
	var/suit_type = /obj/item/clothing/suit/armor/changeling
	/// Helmet item equipped on form.
	var/helmet_type = /obj/item/clothing/head/helmet/changeling

/datum/action/cooldown/spell/hiveless/chitinous_armor/can_cast_spell(feedback = TRUE)
	if(!ishuman(owner))
		return FALSE
	if(wearing_carapace())
		return TRUE
	return ..()

/datum/action/cooldown/spell/hiveless/chitinous_armor/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return .
	if(wearing_carapace())
		return .
	var/mob/living/carbon/human/user = owner
	if(!user.canUnEquip(user.wear_suit))
		user.balloon_alert(user, "body occupied!")
		return .|SPELL_CANCEL_CAST
	if(!user.canUnEquip(user.head))
		user.balloon_alert(user, "head occupied!")
		return .|SPELL_CANCEL_CAST

/// TRUE if the suit or helmet is currently equipped.
/datum/action/cooldown/spell/hiveless/chitinous_armor/proc/wearing_carapace()
	var/mob/living/carbon/human/user = owner
	if(!istype(user))
		return FALSE
	return istype(user.wear_suit, suit_type) || istype(user.head, helmet_type)

/datum/action/cooldown/spell/hiveless/chitinous_armor/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/user = owner
	if(wearing_carapace())
		var/obj/item/old_suit = user.wear_suit
		var/obj/item/old_helmet = user.head
		if(istype(old_suit, suit_type) && user.temporarilyRemoveItemFromInventory(old_suit, TRUE))
			qdel(old_suit)
		if(istype(old_helmet, helmet_type) && user.temporarilyRemoveItemFromInventory(old_helmet, TRUE))
			qdel(old_helmet)
		spray_cast_blood(user)
		playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
		user.visible_message(
			span_warning("[user]'s chitinous plating sloughs off in wet sheets."),
			span_notice("We cast off our carapace."),
			span_hear("You hear organic matter ripping and tearing!"),
		)
		user.update_worn_oversuit()
		user.update_worn_head()
		user.update_body_parts()
		return TRUE
	if(!spend_protein())
		return FALSE
	user.dropItemToGround(user.wear_suit)
	user.dropItemToGround(user.head)
	user.equip_to_slot_if_possible(new suit_type(user), ITEM_SLOT_OCLOTHING, TRUE, TRUE, TRUE)
	user.equip_to_slot_if_possible(new helmet_type(user), ITEM_SLOT_HEAD, TRUE, TRUE, TRUE)
	spray_cast_blood(user)
	playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
	return TRUE
