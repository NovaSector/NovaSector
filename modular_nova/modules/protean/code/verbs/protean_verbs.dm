GAME_VERB_PROC_DESC(/mob/living/carbon, protean_ui, "Open Suit UI", "Opens your suit UI", "Protean")
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(src)
	if(isnull(suit))
		return
	suit.ui_interact(src)

GAME_VERB_PROC_DESC(/mob/living/carbon, protean_heal, "Heal Organs and Limbs", "Heals your replaceable organs and limbs with 6 metal.", "Protean")
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(src)
	if(isnull(suit))
		return
	if(incapacitated && loc != suit)
		balloon_alert(src, "incapacitated!")
		return

	brain.replace_limbs()

GAME_VERB_PROC_DESC(/mob/living/carbon, lock_suit, "Lock Suit", "Locks your suit on someone", "Protean")
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(src)
	if(isnull(suit))
		return

	suit.toggle_lock()
	to_chat(src, span_notice("You [suit.modlocked ? "<b>lock</b>" : "<b>unlock</b>"] the suit [isprotean(suit.wearer) || loc == suit ? "" : "onto [suit.wearer]"]"))
	playsound(src, 'sound/machines/click.ogg', 25)

GAME_VERB_PROC_DESC(/mob/living/carbon, suit_transformation, "Toggle Suit Transformation", "Either leave or enter your suit.", "Protean")
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(src)
	if(isnull(suit))
		return
	if(loc == suit)
		brain.leave_modsuit()
	else if(isturf(loc))
		if(!incapacitated)
			brain.go_into_suit()
		else
			balloon_alert(src, "incapacitated!")

GAME_VERB_PROC_DESC(/mob/living/carbon, remove_assimilated_modsuit, "Remove Assimilated Modsuit", "Pry out an absorbed modsuit from your protean suit.", "Protean")
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(src)
	if(isnull(suit))
		return
	suit.unassimilate_modsuit(src)

GAME_VERB_PROC_DESC(/mob/living/carbon, remove_assimilated_plating, "Remove Assimilated Plating", "Reset your modsuit appearance back to default.", "Protean")
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(src)
	if(isnull(suit))
		return
	suit.unassimilate_theme()

GAME_VERB_PROC_DESC(/mob/living/carbon, low_power, "Toggle Low Power Mode", "Toggle whether you are running on low power mode.", "Protean")
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(src)
	if(isnull(suit))
		return
	var/obj/item/organ/stomach/protean/stomach = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach))
		to_chat(src, span_warning("You are missing a stomach and can't turn on low power mode"))
		return
	if(loc == suit)
		to_chat(src, span_notice("You can't toggle low power when in a suit form!"))
		return
	if(!do_after(src, 2.5 SECONDS))
		src.loc.balloon_alert(src, "toggle interrupted")
		return
	var/datum/status_effect/protean_low_power_mode/effect = /datum/status_effect/protean_low_power_mode/low_power
	if(istype(has_status_effect(effect), effect))
		remove_status_effect(effect)
	else
		if(suit.active)
			suit.toggle_activate(usr, TRUE)
		// Preventing low power slowdown being removed by reform cooldown
		if(has_status_effect(/datum/status_effect/protean_low_power_mode))
			remove_status_effect(/datum/status_effect/protean_low_power_mode)
		apply_status_effect(effect)
