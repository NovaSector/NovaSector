/datum/action/cooldown/spell/touch/fleshmend_lesser
	name = "Lesser Fleshmend"
	desc = "Tought to nearly every apprentice by the Spinward Independent Magicians, \
		this spell transmutes a portion of the target's blood and the caster's mana into freshly grown bands \
		of new flesh with one slight caveat: <b>it is EXCRUCIATINGLY painful for the recipient.</b> It also \
		cannot completely mend flesh - some medical assistance will be required, but it is enough to a mage \
		or their apprentice back on their feet (and maybe wishing they weren't)."
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "r_transmit"

	school = SCHOOL_SANGUINE
	cooldown_time = 60 SECONDS

	invocation_type = INVOCATION_NONE
	invocation = "Tronsum Lunae Santinus Eurekant Oonzu" //if you know, you know

	hand_path = /obj/item/melee/touch_attack/fleshmend_lesser
	can_cast_on_self = TRUE // yeah but... do you want to?
	/// The amount of mana from the magical quirk this costs to cast.
	var/mana_cost = 15
	/// How much mana each tick of healing uses
	var/mana_per_heal_tick = 5

/datum/action/cooldown/spell/touch/fleshmend_lesser/cast(mob/living/carbon/cast_on)
	var/mob/living/carbon/human/owner_human = owner
	var/datum/quirk/magical/mage = owner_human.get_quirk(/datum/quirk/magical)
	if (!mage)
		owner.balloon_alert(owner, "can't cast: no magical talent!")
		return FALSE

	if (!mage.can_cast_spell(mana_cost))
		owner.balloon_alert(owner, "not enough mana!")
		return FALSE

	mage.cast_quirk_spell(mana_cost)
	. = ..()

/datum/action/cooldown/spell/touch/fleshmend_lesser/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/human/caster)
	var/datum/quirk/magical/mage = caster.get_quirk(/datum/quirk/magical)
	if (!mage)
		caster.balloon_alert(caster, "can't cast: no magical talent!")
		return TRUE

	if (!mage.can_cast_spell(mana_cost))
		caster.balloon_alert(caster, "not enough mana!")
		return FALSE

	if (!ishuman(victim))
		caster.balloon_alert(caster, "can't heal that!")
		return FALSE

	var/mob/living/carbon/human/human_victim = victim
	//only works if they're pretty severely brute/burn injured and not much else
	if ((human_victim.getBruteLoss() + human_victim.getFireLoss()) < 44)
		caster.balloon_alert(caster, "not injured enough!")
		return FALSE

	//otherwise, LET'S GET HEALING YAAAY
	caster.visible_message(
		span_danger("[caster] hovers [caster.p_their()] hands over [human_victim] and closes [caster.p_their()] eyes, the flesh of their exposed wounds writhing angrily..."),
		span_notice("You hover your hands over [human_victim] and begin forcing flesh to knit and mend itself...")
	)
	caster.whisper(invocation)
	mage.halt_regen = TRUE // stop regenerating mana while we channel
	var/sound/channel_sound = sound('sound/magic/cosmic_energy.ogg')
	channel_sound.pitch = 1.25

	while (do_after(caster, 1 SECONDS, human_victim) && (human_victim.getBruteLoss() + human_victim.getFireLoss()) > 44 && mage.can_cast_spell(mana_per_heal_tick))
		human_victim.adjustBruteLoss(-5, updating_health = TRUE)
		human_victim.adjustFireLoss(-2.5, updating_health = TRUE)
		human_victim.bleed(1.5)
		playsound(caster, channel_sound, 75, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE)

		if (human_victim.stat == UNCONSCIOUS)
			human_victim.adjustOxyLoss(-2.5) //just a smidge so crit people aren't unconscious for seven hundred years

		mage.cast_quirk_spell(mana_per_heal_tick)
		if (prob(66))
			//pain time
			human_victim.visible_message(
				span_danger("[human_victim] involuntarily writhes in agony as [caster] continues to mend their flesh together!"),
				span_userdanger("A bolt of RAW AGONY ricochets through your being as nerves that were never meant to touch, touch. It is EXCRUCIATING!!!")
			)
			human_victim.Knockdown(6 SECONDS)
			human_victim.set_jitter_if_lower(5 SECONDS)
			if (prob(50))
				human_victim.emote("scream")

	mage.halt_regen = FALSE
	return TRUE


/obj/item/melee/touch_attack/fleshmend_lesser
	name = "\improper blood-wreathed hand"
	desc = "Uh, this really doesn't look like healing magic, boss..."
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "scream_for_me"
	inhand_icon_state = "disintegrate"
