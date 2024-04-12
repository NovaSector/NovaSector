// LESSER ARCANE BARRAGE
/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage/lesser
	name = "Lesser Arcane Barrage"
	desc = "Unleash a small torrent of energy at your foes with this spell. \
		Consumes 2 mana with every shot, and will spend up to 60 before dispersing."
	button_icon_state = "arcane_barrage"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	cooldown_time = 10 SECONDS

	item_type = /obj/item/gun/magic/wand/arcane_barrage/lesser
	/// The cost in mana to initially channel this spell
	var/mana_cost = 25

/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage/lesser/cast(atom/cast_on)
	var/mob/living/carbon/human/owner_human = owner
	var/datum/quirk/magical/mage = owner_human.get_quirk(/datum/quirk/magical)
	if (!mage)
		owner.balloon_alert(owner, "can't cast: no magical talent!")
		return FALSE

	if (!mage.can_cast_spell(mana_cost))
		owner.balloon_alert(owner, "not enough mana!")
		return FALSE

	. = ..()

	//tell the quirk we've cast this spell and deduct initial mana accordingly
	mage.cast_quirk_spell(mana_cost)

/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage/lesser

/obj/item/ammo_casing/magic/arcane_barrage/lesser
	projectile_type = /obj/projectile/magic/arcane_barrage/lesser

/obj/projectile/magic/arcane_barrage/lesser
	name = "lesser arcane bolt"
	icon_state = "arcane_barrage"
	damage = 10
	damage_type = BURN
	hitsound = 'sound/weapons/barragespellhit.ogg'

/obj/item/gun/magic/wand/arcane_barrage/lesser
	name = "lesser arcane barrage"
	ammo_type = /obj/item/ammo_casing/magic/arcane_barrage/lesser
	// How much quirk mana does this cost to fire?
	var/cost_to_fire = 2

/obj/item/gun/magic/wand/arcane_barrage/lesser/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(!.)
		return
	if(!charges)
		user.dropItemToGround(src, TRUE)
	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/quirk/magical/magic_quirk = human_user.get_quirk(/datum/quirk/magical)
		// check to make sure we have enough mana to cast and if we can, deduct, etc
		if (magic_quirk && magic_quirk.can_cast_spell(cost_to_fire))
			magic_quirk.cast_quirk_spell(cost_to_fire)
		else
			human_user.balloon_alert(human_user, "out of mana!")
			user.dropItemToGround(src, TRUE)

