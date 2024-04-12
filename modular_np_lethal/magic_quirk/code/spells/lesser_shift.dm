/datum/action/cooldown/spell/pointed/shift
	name = "Lesser Shift"
	desc = "Jaunt through the ether a short distance, incurring minor teleportation flux \
		and leaving some of your stomach contents behind. Becomes less accurate the lower on mana you are, and if you have \
		more flux accrued on your person. Teleporting with flux will hurt you a little bit."
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "r_transmit"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	cooldown_time = 3 SECONDS
	cast_range = 5
	/// Cost of the cast in quirk mana
	var/mana_cost = 35

/datum/action/cooldown/spell/pointed/shift/is_valid_target(atom/cast_on)
	. = ..()
	if (!.)
		return FALSE

	var/turf/start_turf = get_turf(owner)
	var/turf/target_turf = get_turf(cast_on)

	if(get_dist(start_turf, target_turf) > cast_range)
		owner.balloon_alert(owner, "too far!")
		return FALSE

	if(!(target_turf in view(owner, owner.client?.view || world.view)))
		owner.balloon_alert(owner, "out of view!")
		return FALSE

	if(target_turf.is_blocked_turf(exclude_mobs = TRUE, source_atom = owner))
		owner.balloon_alert(owner, "obstructed!")
		return FALSE

/datum/action/cooldown/spell/pointed/shift/cast(atom/cast_on)
	. = ..()
	handle_teleport(cast_on)

/datum/action/cooldown/spell/pointed/shift/proc/handle_teleport(atom/cast_on)
	// most of this is copy-pasted from teleport_rod.dm and adjusted to work w/ magic quirk
	var/mob/living/carbon/human/owner_human = owner
	var/turf/start_turf = get_turf(owner)
	var/turf/target_turf = get_turf(cast_on)
	var/teleport_precision = 0 // we start perfectly precise and get less depending on factors like flux/mana
	var/datum/quirk/magical/mage = owner_human.get_quirk(/datum/quirk/magical)

	if (!mage)
		owner.balloon_alert(owner, "can't cast: no magical talent!")
		return

	//can we cast the spell to begin with?
	if (!mage.can_cast_spell(mana_cost))
		owner.balloon_alert(owner, "not enough mana!")
		return

	if (mage.mana < (mage.max_mana*0.5))
		teleport_precision += 1
	if (mage.mana < (mage.max_mana*0.25))
		teleport_precision += 1
	if (owner.has_status_effect(/datum/status_effect/teleport_flux/shift))
		teleport_precision += 1

	var/tp_result = do_teleport(
		teleatom = owner,
		destination = target_turf,
		precision = teleport_precision,
		no_effects = TRUE,
		channel = TELEPORT_CHANNEL_MAGIC,
	)

	if(!tp_result)
		owner.balloon_alert(owner, "shift failed!")
		return

	//tell the magic quirk we've successfully cast the spell
	mage.cast_quirk_spell(mana_cost)

	var/sound/teleport_sound = sound('sound/magic/summonitems_generic.ogg')
	teleport_sound.pitch = 0.25
	new /obj/effect/temp_visual/teleport_flux(start_turf, owner.dir)
	new /obj/effect/temp_visual/teleport_flux(get_turf(owner), owner.dir)
	playsound(start_turf, teleport_sound, 90, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE)
	playsound(owner, teleport_sound, 90, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE)

	//clear some reagents from our stomach for jaunting
	var/obj/item/organ/user_stomach = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	owner.reagents?.remove_all(0.50, relative = TRUE)
	user_stomach?.reagents?.remove_all(0.50, relative = TRUE)
	if(owner.has_status_effect(/datum/status_effect/teleport_flux/perma))
		return

	if(owner.has_status_effect(/datum/status_effect/teleport_flux/shift))
		// The status effect handles the damage, but we'll add a special pop up for rod usage specifically
		owner.balloon_alert(owner, "too soon!")

	owner_human.apply_status_effect(/datum/status_effect/teleport_flux/shift)

/datum/status_effect/teleport_flux/shift
	duration = 12 SECONDS
