/mob/living/carbon/proc/protean_ui()
	set name = "Open Suit UI"
	set desc = "Opens your suit UI"
	set category = "Protean"

	var/obj/item/bodypart/chest/robot/protean/chest = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/mod/control/pre_equipped/protean/suit = chest?.species_modsuit
	if(isnull(suit))
		return
	suit.ui_interact(src)

/mob/living/carbon/proc/protean_heal()
	set name = "Heal Organs and Limbs"
	set desc = "Heals your replaceable organs and limbs with 6 metal."
	set category = "Protean"

	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return

	var/obj/item/bodypart/chest/robot/protean/chest = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/mod/control/pre_equipped/protean/suit = chest?.species_modsuit
	if(isnull(suit))
		return
	if(incapacitated && loc != suit)
		balloon_alert(src, "incapacitated!")
		return

	brain.replace_limbs()

/mob/living/carbon/proc/lock_suit()
	set name = "Lock Suit"
	set desc = "Locks your suit on someone"
	set category = "Protean"

	var/obj/item/bodypart/chest/robot/protean/chest = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/mod/control/pre_equipped/protean/suit = chest?.species_modsuit
	if(isnull(suit))
		return

	suit.toggle_lock()
	to_chat(src, span_notice("You [suit.modlocked ? "<b>lock</b>" : "<b>unlock</b>"] the suit [isprotean(suit.wearer) || loc == suit ? "" : "onto [suit.wearer]"]"))
	playsound(src, 'sound/machines/click.ogg', 25)

/mob/living/carbon/proc/suit_transformation()
	set name = "Toggle Suit Transformation"
	set desc = "Either leave or enter your suit."
	set category = "Protean"
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return
	var/obj/item/bodypart/chest/robot/protean/chest = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/mod/control/pre_equipped/protean/suit = chest?.species_modsuit
	if(isnull(suit))
		return
	if(loc == suit)
		brain.leave_modsuit()
	else if(isturf(loc))
		if(!incapacitated)
			brain.go_into_suit()
		else
			balloon_alert(src, "incapacitated!")

/mob/living/carbon/proc/remove_assimilated_modsuit()
	set name = "Remove Assimilated Modsuit"
	set desc = "Pry out an absorbed modsuit from your protean suit."
	set category = "Protean"

	var/obj/item/bodypart/chest/robot/protean/chest = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/mod/control/pre_equipped/protean/suit = chest?.species_modsuit
	if(isnull(suit))
		return
	suit.unassimilate_modsuit(src)

/mob/living/carbon/proc/remove_assimilated_plating()
	set name = "Remove Assimilated Plating"
	set desc = "Reset your modsuit appearance back to default."
	set category = "Protean"

	var/obj/item/bodypart/chest/robot/protean/chest = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/mod/control/pre_equipped/protean/suit = chest?.species_modsuit
	if(isnull(suit))
		return
	suit.unassimilate_theme()

/mob/living/carbon/proc/low_power()
	set name = "Toggle Low Power Mode"
	set desc = "Toggle whether you are running on low power mode."
	set category = "Protean"

	var/obj/item/bodypart/chest/robot/protean/chest = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/mod/control/pre_equipped/protean/suit = chest?.species_modsuit
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
