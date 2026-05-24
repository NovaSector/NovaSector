/obj/effect/rune/bloodwashed_soulstone
	cultist_name = "Fracture Soulstone"
	cultist_desc = "condenses a soulstone shard from Nar'Sie's lingering influence."
	invocation = "N'ath reth sh'yro!"
	icon_state = "3"
	color = COLOR_CULT_RED
	scribe_delay = 8 SECONDS
	scribe_damage = 10
	construct_invoke = FALSE
	can_be_scribed = FALSE

/obj/effect/rune/bloodwashed_soulstone/invoke(list/invokers)
	. = ..()

	var/mob/living/user = invokers[1]
	var/turf/rune_turf = get_turf(src)
	if(!rune_turf)
		return

	var/obj/item/soulstone/soulstone = new(rune_turf)
	ADD_TRAIT(soulstone, TRAIT_CONTRABAND, INNATE_TRAIT)
	soulstone.AddComponent(/datum/component/bloodwashed_ghost_pollable_soulstone)
	user.visible_message(
		span_warning("[src] cracks apart, leaving a soulstone shard in the blood."),
		span_cult_italic("The sigil breaks, and a soulstone shard clatters out of the veil."),
	)
	SEND_SOUND(user, sound('sound/effects/magic.ogg', FALSE, 0, 25))
	SSblackbox.record_feedback("tally", "cult_rune_invoke", 1, cultist_name)
	qdel(src)
