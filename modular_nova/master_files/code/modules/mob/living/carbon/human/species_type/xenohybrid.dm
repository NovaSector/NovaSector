/datum/mood_event/xenohybrid_resin
	description = "I like being on resin. It calms my body and soul."
	mood_change = 4
	timeout = 15 SECONDS // It will stay a little bit after you leave resin, but generally should only be applied on resin

/obj/item/organ/alien/plasmavessel/roundstart/on_life(seconds_per_tick, times_fired)
	. = ..()
	if(locate(/obj/structure/alien/weeds) in owner.loc)
		owner.add_mood_event("area_beauty", /datum/mood_event/xenohybrid_resin)
