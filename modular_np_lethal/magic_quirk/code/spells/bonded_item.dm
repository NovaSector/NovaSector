/datum/action/cooldown/spell/summonitem/lesser
	name = "Bonded Object"
	desc = "This spell allows you to tie some of your mana to a treasured object of yours, \
		allowing you to retrieve it from just about anywhere within a five solar system radius. \
		In addition, while held in your hands, your bonded item will help you regenerate mana more efficiently, \
		and if it is a staff of some kind, even more efficiently again."
	invocation_type = INVOCATION_NONE
	/// How much mana does this cost to use?
	var/mana_cost = 25

/datum/action/cooldown/spell/summonitem/lesser/cast(mob/living/cast_on)
	var/mob/living/carbon/human/owner_human = owner
	var/datum/quirk/magical/mage = owner_human.get_quirk(/datum/quirk/magical)
	if (!mage)
		owner.balloon_alert(owner, "can't cast: no magical talent!")
		return FALSE

	if (!mage.bonded_item)
		if (!mage.can_cast_spell(mana_cost*3))
			owner.balloon_alert(owner, "not enough mana (need 75 to bond an item)")
			return FALSE
		mage.cast_quirk_spell(mana_cost*3) //increase mana cost to 75 if we're bonding an item for the first time
	else
		if (!mage.can_cast_spell(mana_cost))
			owner.balloon_alert(owner, "not enough mana!")
			return FALSE
		mage.cast_quirk_spell(mana_cost)

	. = ..()

/datum/action/cooldown/spell/summonitem/lesser/mark_item(obj/to_mark)
	. = ..()
	var/mob/living/carbon/human/owner_human = owner
	var/datum/quirk/magical/mage = owner_human.get_quirk(/datum/quirk/magical)
	if (mage && marked_item)
		mage.set_bonded_item(marked_item)

/datum/action/cooldown/spell/summonitem/lesser/unmark_item()
	. = ..()
	var/mob/living/carbon/human/owner_human = owner
	var/datum/quirk/magical/mage = owner_human.get_quirk(/datum/quirk/magical)
	if (mage && marked_item)
		mage.bonded_item = null
