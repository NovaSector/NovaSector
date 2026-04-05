/datum/emote/backflip
	key = "backflip"
	key_third_person = "backflips"
	hands_use_check = TRUE
	mob_type_allowed_typecache = list(/mob/living, /mob/dead/observer, /mob/eye/imaginary_friend)
	mob_type_ignore_stat_typecache = list(/mob/dead/observer, /mob/living/silicon/ai, /mob/eye/imaginary_friend)

/datum/emote/backflip/run_emote(mob/user, params , type_override, intentional)
	. = ..()
	// NOVA EDIT ADDITION START - backflips for everyone, but freerunners do it faster
	if(intentional && !HAS_TRAIT(user, TRAIT_FREERUNNING) && !HAS_TRAIT(user, TRAIT_STYLISH) && !do_after(user, 0.5 SECONDS, target = user, hidden = TRUE))
		return
	// NOVA EDIT ADDITION END
	user.SpinAnimation(FLIP_EMOTE_DURATION, 1, clockwise = FALSE) //Make that backflip!

/datum/emote/backflip/check_cooldown(mob/user, intentional)
	. = ..()
	if(.)
		return
	if(!can_run_emote(user, intentional=intentional))
		return
	if(isliving(user))
		var/mob/living/flippy_mcgee = user
		if(prob(20))
			flippy_mcgee.Knockdown(1 SECONDS)
			flippy_mcgee.visible_message(
				span_notice("[flippy_mcgee] attempts to do a flip and falls over, what a doofus!"),
				span_notice("You attempt to do a flip while still off balance from the last flip and fall down!")
			)
			if(prob(50))
				flippy_mcgee.adjust_brute_loss(1)
		else
			flippy_mcgee.visible_message(
				span_notice("[flippy_mcgee] stumbles a bit after their flip."),
				span_notice("You stumble a bit from still being off balance from your last flip.")
			)
