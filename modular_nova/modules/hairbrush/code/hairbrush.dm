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
		return COMPONENT_CANCEL_ATTACK_CHAIN
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Brushes someone, giving them a small mood boost
/obj/item/hairbrush/proc/brush(mob/living/target, mob/living/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)
		var/brush_target // Where are we brushing?
		var/location = user.zone_selected

		if(!(location in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_GROIN)))
			to_chat(user, span_warning("You stop, look down at what you're currently holding and ponder to yourself, \"This is probably to be used on their hair.\""))
			return

		if(location == BODY_ZONE_HEAD)
			if(!head)
				to_chat(user, span_warning("[human_target] has no head!"))
				return
			if(human_target.is_mouth_covered(ITEM_SLOT_HEAD))
				to_chat(user, span_warning("You can't brush [human_target]'s hair while [human_target.p_their()] head is covered!"))
				return
			if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Skinhead")
				brush_target = "head"
			else
				brush_target = "hair"
		else if(location == BODY_ZONE_PRECISE_MOUTH)
			if(human_target.is_mouth_covered())
				to_chat(user, span_warning("You can't brush [human_target]'s facial hair while [human_target.p_their()] mouth is covered!"))
				return
			if(human_target.facial_hairstyle != "Shaved")
				brush_target = "beard"
			else
				brush_target = "chin"
		else if(location == BODY_ZONE_PRECISE_GROIN)
			if(!isnull(human_target.get_organ_by_type(/obj/item/organ/tail)))
				brush_target = "tail"
			else
				return

		// Don't brush if action isn't done yet
		if(!do_after(user, brush_speed, human_target))
			return

		// Combat mode gives one brute damage.
		if(user.combat_mode && human_target != user)
			user.visible_message(span_warning("[user] scrapes the bristles uncomfortably over [human_target]'s [brush_target]."), span_warning("You scrape the bristles uncomfortably over [human_target]'s [brush_target]."), ignored_mobs=list(human_target))
			human_target.show_message(span_warning("[user] scrapes the bristles uncomfortably over your [brush_target]!"))
			if(brush_target != "tail")
				head.receive_damage(1)
			else
				var/obj/item/bodypart/chest = human_target.get_bodypart(BODY_ZONE_CHEST)
				chest.receive_damage(1)
			human_target.add_mood_event("brushed", /datum/mood_event/brushed, user, brush_target)
			playsound(human_target, 'modular_nova/modules/hairbrush/sounds/rough_brush.ogg', 30, extrarange = -6, ignore_walls = FALSE)
			return

		// Self brushing
		if(human_target == user)
			if(HAS_TRAIT(user, TRAIT_SELF_AWARE) || HAS_TRAIT(user, TRAIT_HAIR_EXPERT)) // Do they have self awareness or the hair expert trait? If so, give them the better moodlet.
				human_target.visible_message(span_notice("[user] masterfully brushes [user.p_their()] [brush_target]!"), span_notice("You masterfully brush your [brush_target]."))
				human_target.add_mood_event("brushed", /datum/mood_event/brushed/self/expert, brush_target)
			else
				human_target.visible_message(span_notice("[user] brushes [user.p_their()] [brush_target]!"), span_notice("You brush your [brush_target]."))
				human_target.add_mood_event("brushed", /datum/mood_event/brushed/self, brush_target)
		else // Brushing others
			if(HAS_TRAIT(user, TRAIT_HAIR_EXPERT)) // Do they have the hair expert trait? If so, give them the better moodlet.
				user.visible_message(span_notice("[user] masterfully brushes [human_target]'s [brush_target]!"), span_notice("You masterfully brush [human_target]'s [brush_target]."), ignored_mobs=list(human_target))
				human_target.show_message(span_notice("[user] masterfully brushes your [brush_target]!"), MSG_VISUAL)
				human_target.add_mood_event("brushed", /datum/mood_event/brushed/expert, user, brush_target)
			else
				user.visible_message(span_notice("[user] brushes [human_target]'s [brush_target]!"), span_notice("You brush [human_target]'s [brush_target]."), ignored_mobs=list(human_target))
				human_target.show_message(span_notice("[user] brushes your [brush_target]!"), MSG_VISUAL)
				human_target.add_mood_event("brushed", /datum/mood_event/brushed, user, brush_target)
		playsound(human_target, 'modular_nova/modules/hairbrush/sounds/brush.ogg', 30, extrarange = -6, ignore_walls = FALSE)

	else if(istype(target, /mob/living/basic/pet))
		if(!do_after(user, brush_speed, target))
			return
		to_chat(user, span_notice("[target] closes [target.p_their()] eyes as you brush [target.p_them()]!"))
		playsound(target, 'modular_nova/modules/hairbrush/sounds/brush.ogg', 30, extrarange = -6, ignore_walls = FALSE)
		var/mob/living/living_user = user
		if(istype(living_user))
			living_user.add_mood_event("brushed", /datum/mood_event/brushed/pet, target)
