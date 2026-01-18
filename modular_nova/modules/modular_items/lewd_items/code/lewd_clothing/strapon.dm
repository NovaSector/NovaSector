/obj/item/clothing/strapon
	name = "strapon"
	desc = "Sometimes you need a special way to humiliate someone."
	icon_state = "strapon_human"
	base_icon_state = "strapon"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	slot_flags = ITEM_SLOT_BELT
	obj_flags_nova = ERP_ITEM
	actions_types = list(/datum/action/item_action/take_strapon)
	/// Only allow a change once
	var/type_changed = FALSE
	/// The style of tool
	var/strapon_type = "human"
	/// The abstract hand item that can be toggled for use
	var/obj/item/strapon_dildo/strapon_item
	/// List of type choices for the radial menu
	var/static/list/strapon_types

/// Create the list for the radial menu
/obj/item/clothing/strapon/proc/populate_strapon_types()
	strapon_types = list(
		"avian" = image(icon = src.icon, icon_state = "strapon_avian"),
		"canine" = image(icon = src.icon, icon_state = "strapon_canine"),
		"dragon" = image(icon = src.icon, icon_state = "strapon_dragon"),
		"equine" = image(icon = src.icon, icon_state = "strapon_equine"),
		"human" = image(icon = src.icon, icon_state = "strapon_human"),
	)

/// to change model
/obj/item/clothing/strapon/click_alt(mob/user)
	if(type_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, strapon_types, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	strapon_type = choice
	update_appearance(UPDATE_ICON)
	type_changed = TRUE
	return CLICK_ACTION_SUCCESS

/// check if we can change strapon's model
/obj/item/clothing/strapon/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/strapon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_appearance(UPDATE_ICON)
	update_mob_action_buttonss()
	if(!length(strapon_types))
		populate_strapon_types()

/obj/item/clothing/strapon/Destroy(force)
	if(strapon_item)
		QDEL_NULL(strapon_item)
	return ..()

// shitcode here, please improve if you can. Genitals overlapping with strapon, doesn't cool!
/obj/item/clothing/strapon/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	if(src != affected_mob.belt)
		return
	var/obj/item/organ/genital/vagina/affected_vagina = affected_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/affected_womb = affected_mob.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/affected_penis = affected_mob.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/affected_testicles = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)

	affected_vagina?.visibility_preference = GENITAL_NEVER_SHOW
	affected_womb?.visibility_preference = GENITAL_NEVER_SHOW
	affected_penis?.visibility_preference = GENITAL_NEVER_SHOW
	affected_testicles?.visibility_preference = GENITAL_NEVER_SHOW
	affected_mob.update_body()

/obj/item/clothing/strapon/dropped(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	var/obj/item/organ/genital/vagina/affected_vagina = affected_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/affected_womb = affected_mob.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/affected_penis = affected_mob.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/affected_testicles = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)

	if(!QDELETED(src) || !QDELETED(strapon_item))
		strapon_item.forceMove(src)

	affected_vagina?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	affected_womb?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	affected_penis?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	affected_testicles?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	affected_mob.update_body()

/obj/item/clothing/strapon/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[strapon_type]"
	if(strapon_item)
		strapon_item.strapon_type = strapon_type
		strapon_item.update_appearance(UPDATE_ICON)

/// Functionality stuff
/obj/item/clothing/strapon/proc/update_mob_action_buttonss()
	for(var/datum/action/item_action/take_strapon/action_button in actions_types)
		action_button.button_icon_state = "dildo_[strapon_type]"
		action_button.button_icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	update_appearance(UPDATE_ICON)

// button stuff
/datum/action/item_action/take_strapon
	name = "Put strapon in hand"
	desc = "Put the strapon in your hand in order to use it properly."

/datum/action/item_action/take_strapon/Trigger(trigger_flags)
	var/obj/item/clothing/strapon/affected_item = target
	if(istype(affected_item))
		affected_item.check()

/obj/item/clothing/strapon/proc/check()
	var/mob/living/carbon/human/user = usr
	if(src == user.belt)
		toggle(user)
	else
		to_chat(user, span_warning("You need to put the strapon around your waist before you can use it!"))

/obj/item/clothing/strapon/proc/toggle(mob/living/carbon/human/user)
	playsound_if_pref(user, 'modular_nova/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE)

	// already in hands, toggle it off
	if(strapon_item && user.is_holding(strapon_item))
		strapon_item.forceMove(src)
		user.visible_message(
			span_notice("[user] puts the strapon back."),
			span_notice("You put the strapon back."),
		)
		return

	if(user.belt != src)
		return

	if(isnull(strapon_item))
		create_strapon_item()

	if(user.put_in_hands(strapon_item))
		user.visible_message(
			span_notice("[user] holds the strapon in [user.p_their()] hand menacingly."),
			span_notice("You hold the strapon in your hand menacingly."),
		)
	else
		user.visible_message(
			span_notice("[user] tries to hold the strapon in [user.p_their()] hand, but [user.p_their()] hand isn't empty!"),
			span_notice("You try to hold the strapon in one of your hands, but your hands are not empty!"),
		)

/// Makes a new item within contents
/obj/item/clothing/strapon/proc/create_strapon_item()
	if(strapon_item)
		return

	strapon_item = new(src, strapon_type)
	RegisterSignal(strapon_item, COMSIG_QDELETING, PROC_REF(on_strapon_item_qdeling))

/// Clean our ref if it’s deleted
/obj/item/clothing/strapon/proc/on_strapon_item_qdeling(datum/source, force)
	SIGNAL_HANDLER
	UnregisterSignal(strapon_item, COMSIG_QDELETING)
	strapon_item = null

/obj/item/strapon_dildo
	name = "strapon"
	desc = "An item with which to be menacing and merciless."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "dildo_human"
	base_icon_state = "dildo"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = ABSTRACT | HAND_ITEM
	/// The type, determined by the clothing item
	var/strapon_type = "human"

/obj/item/strapon_dildo/Initialize(mapload, strapon_type)
	. = ..()
	var/obj/item/clothing/strapon/strapon_loc = loc
	if(!istype(strapon_loc))
		return INITIALIZE_HINT_QDEL // Don't let these abstract items be spawned anywhere else

	src.strapon_type = strapon_type
	AddElement(/datum/element/update_icon_updates_onmob)
	update_appearance(UPDATE_ICON)
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_STRAPON)

/obj/item/strapon_dildo/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[strapon_type]"

/obj/item/strapon_dildo/attack(mob/living/carbon/human/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(target_mob == user)
		return

	. = ..()

	if(!istype(target_mob))
		return

	if(!target_mob.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target_mob] doesn't want you to do that."))
		return

	var/message = ""
	var/obj/item/organ/genital/vagina = target_mob.get_organ_slot(ORGAN_SLOT_VAGINA)

	switch(user.zone_selected)
		if(BODY_ZONE_PRECISE_GROIN)
			if(!vagina)
				to_chat(user, span_danger("[target_mob] doesn't have suitable genitalia for that!"))
				return
			if(!(target_mob.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW))
				to_chat(user, span_danger("[target_mob]'s groin is covered!"))
				return
			message = pick(
				"delicately rubs [target_mob]'s vagina with [src]",
				"uses [src] to fuck [target_mob]'s vagina",
				"jams [target_mob]'s pussy with [src]",
				"teases [target_mob]'s pussy with [src]",
			)
			target_mob.adjust_arousal(6)
			target_mob.adjust_pleasure(8)
			if(prob(40))
				target_mob.try_lewd_autoemote(pick("twitch_s", "moan"))
			user.visible_message(span_purple("[user] [message]!"))
			playsound_if_pref(loc, pick(
				'modular_nova/modules/modular_items/lewd_items/sounds/bang1.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang2.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang3.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang4.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang5.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang6.ogg'), 60, TRUE)

		if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES)
			if(target_mob.is_mouth_covered())
				to_chat(user, span_danger("[target_mob]'s mouth is covered!"))
				return
			message = pick(
				"fucks [target_mob]'s mouth with [src]",
				"chokes [target_mob] by inserting [src] into [target_mob.p_their()] throat",
				"forces [target_mob] to suck [src]",
				"inserts [src] into [target_mob]'s throat",
			)
			target_mob.adjust_arousal(4)
			target_mob.adjust_pleasure(1)
			target_mob.adjust_oxy_loss(1.5)
			if(prob(70))
				target_mob.try_lewd_autoemote(pick("gasp", "moan"))
			user.visible_message(span_purple("[user] [message]!"))
			playsound_if_pref(loc, pick(
				'modular_nova/modules/modular_items/lewd_items/sounds/bang1.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang2.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang3.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang4.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang5.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang6.ogg'), 40, TRUE)

		else
			if(!target_mob.is_bottomless())
				to_chat(user, span_danger("[target_mob]'s anus is covered!"))
				return
			message = pick(
				"fucks [target_mob]'s ass with [src]",
				"uses [src] to fuck [target_mob]'s anus",
				"jams [target_mob]'s ass with [src]",
				"roughly fucks [target_mob]'s ass with [src], causing [target_mob.p_their()] eyes to roll back",
				)
			target_mob.adjust_arousal(5)
			target_mob.adjust_pleasure(5)
			if(prob(60))
				target_mob.try_lewd_autoemote(pick("twitch_s", "moan", "shiver"))
			user.visible_message(span_purple("[user] [message]!"))
			playsound_if_pref(loc, pick(
				'modular_nova/modules/modular_items/lewd_items/sounds/bang1.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang2.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang3.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang4.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang5.ogg',
				'modular_nova/modules/modular_items/lewd_items/sounds/bang6.ogg'), 100, TRUE)
