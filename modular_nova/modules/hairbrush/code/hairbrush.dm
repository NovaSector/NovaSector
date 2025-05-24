// Hairbrushes

/obj/item/hairbrush
	name = "hairbrush"
	desc = "A small, circular brush with an ergonomic grip for efficient brush application."
	icon = 'modular_nova/modules/hairbrush/icons/hairbrush.dmi'
	icon_state = "brush"
	inhand_icon_state = "inhand"
	lefthand_file = 'modular_nova/modules/hairbrush/icons/inhand_left.dmi'
	righthand_file = 'modular_nova/modules/hairbrush/icons/inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/brush_speed = 3 SECONDS

/obj/item/hairbrush/attack(mob/target, mob/user)
	if(target.stat == DEAD)
		to_chat(user, span_warning("There isn't much point brushing someone who can't appreciate it!"))
		return
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Brushes someone, giving them a small mood boost
/obj/item/hairbrush/proc/brush(mob/living/target, mob/living/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)
		var/brush_target = "hair" // Where did we brush? Default is hair

		// Don't brush if you can't reach their head or cancel the action
		if(!head)
			to_chat(user, span_warning("[human_target] has no head!"))
			return
		if(human_target.is_mouth_covered(ITEM_SLOT_HEAD))
			to_chat(user, span_warning("You can't brush [human_target]'s hair while [human_target.p_their()] head is covered!"))
			return
		if(!do_after(user, brush_speed, human_target))
			return

		// Combat mode gives one brute damage.
		if(user.combat_mode)
			human_target.visible_message(span_warning("[user] scrapes the bristles uncomfortably over [human_target]'s scalp."), span_warning("You scrape the bristles uncomfortably over [human_target]'s scalp."))
			head.receive_damage(1)
			return

		// Self brushing
		if(human_target == user)
			if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Skinhead")
				brush_target = "head"
			if(user.zone_selected == BODY_ZONE_PRECISE_GROIN && !isnull(human_target.get_organ_by_type(/obj/item/organ/tail)))
				brush_target = "tail"
			human_target.visible_message(span_notice("[user] brushes [user.p_their()] [brush_target]!"), span_notice("You brush your [brush_target]."))
			human_target.add_mood_event("brushed", /datum/mood_event/brushed/self, brush_target)
		else // Brushing others
			if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Skinhead")
				brush_target = "head"
			if(user.zone_selected == BODY_ZONE_PRECISE_GROIN && !isnull(human_target.get_organ_by_type(/obj/item/organ/tail)))
				brush_target = "tail"
			user.visible_message(span_notice("[user] brushes [human_target]'s [brush_target]!"), span_notice("You brush [human_target]'s [brush_target]."), ignored_mobs=list(human_target))
			human_target.show_message(span_notice("[user] brushes your [brush_target]!"), MSG_VISUAL)
			human_target.add_mood_event("brushed", /datum/mood_event/brushed, user, brush_target)

	else if(istype(target, /mob/living/basic/pet))
		if(!do_after(user, brush_speed, target))
			return
		to_chat(user, span_notice("[target] closes [target.p_their()] eyes as you brush [target.p_them()]!"))
		var/mob/living/living_user = user
		if(istype(living_user))
			living_user.add_mood_event("brushed", /datum/mood_event/brushed/pet, target)
