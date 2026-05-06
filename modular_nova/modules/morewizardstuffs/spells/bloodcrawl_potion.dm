/obj/item/bloodcrawl_bottle
	name = "bloodlust in a bottle"
	desc = "Drinking this will give you unimaginable powers... and mildly disgust you because of its metallic taste."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/bloodcrawl_bottle/attack_self(mob/user)
	to_chat(user, span_notice("You drink the contents of [src]."))
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/mining/new_spell =  new(user)
	new_spell.Grant(user)
	user.log_message("learned the spell bloodcrawl (Mining) ([new_spell])", LOG_ATTACK, color="orange")
	qdel(src)

/datum/action/cooldown/spell/jaunt/bloodcrawl/mining
	name = "Necropolis Blood Crawl"
	/// Instant was a bit too much.
	enter_blood_time = 2 SECONDS
	/// special snowflake jaunt type to eject on mining areas.
	jaunt_type = /obj/effect/dummy/phased_mob/blood/mining
	var/failure_message = "This ability can only be used on planetary areas untainted by civilization!"

/datum/action/cooldown/spell/jaunt/bloodcrawl/mining/can_cast_spell(feedback = TRUE)
	var/owner_area = get_area(owner)
	if(!is_necropolis_bloodcrawl_allowed(owner_area))
		if(feedback)
			to_chat(owner, span_warning(failure_message), type = MESSAGE_TYPE_WARNING)
		return FALSE
	return ..()

/obj/effect/dummy/phased_mob/blood/mining
	/// Small cooldown for the "can't enter that area!" message so it doesn't get spammed 500 times.
	COOLDOWN_DECLARE(alert_cooldown)

/obj/effect/dummy/phased_mob/blood/mining/phased_check(mob/living/user, direction)
	. = ..()
	if(!.)
		return
	if(!is_necropolis_bloodcrawl_allowed(get_area(.)))
		if(COOLDOWN_FINISHED(src, alert_cooldown))
			to_chat(user, span_warning("Something stops you from jaunting into that area!"), type = MESSAGE_TYPE_WARNING)
			balloon_alert(user, "can't enter that area!")
			COOLDOWN_START(src, alert_cooldown, 1 SECONDS)
		return null

/proc/is_necropolis_bloodcrawl_allowed(area)
	// Lazy initialized typecache, to avoid taking up memory if nobody ever uses necropolis bloodcrawl
	var/static/list/allowed_areas_typecache
	if(isnull(allowed_areas_typecache))
		allowed_areas_typecache = zebra_typecacheof(list(
			/area/forestplanet = TRUE,
			/area/icemoon = TRUE,
			/area/lavaland = TRUE,
			/area/ocean = TRUE,
			/area/ruin = TRUE,
			/area/ruin/interdyne_planetary_base = FALSE,
			/area/ruin/unpowered/ash_walkers = FALSE,
			/area/ruin/unpowered/primitive_catgirl_den = FALSE,
		))
	return is_type_in_typecache(area, allowed_areas_typecache)
