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

/datum/action/cooldown/spell/jaunt/bloodcrawl/mining/can_cast_spell(feedback = TRUE)
	var/owner_area = get_area(owner)
	if (!is_type_in_typecache(owner_area, allowed_areas) || is_type_in_typecache(owner_area, disallowed_areas))
		if(feedback)
			to_chat(owner, failure_message)
		return FALSE
	return ..()

/datum/action/cooldown/spell/jaunt/bloodcrawl/mining
	name = "Necropolis Blood Crawl"
	/// Instant was a bit too much.
	enter_blood_time = 2 SECONDS
	var/failure_message = "This ability can only be used on planetary areas untainted by civilization!"
	/// special snowflake jaunt type to eject on mining areas.
	jaunt_type = /obj/effect/dummy/phased_mob/blood/mining
	/// Mining areas we got.
	var/static/list/allowed_areas = typecacheof(list(
			/area/forestplanet,
			/area/icemoon,
			/area/lavaland,
			/area/ocean/generated,
			/area/ruin,
	))
	var/static/list/disallowed_areas = typecacheof(list(
			/area/ruin/interdyne_planetary_base,
			/area/ruin/unpowered/ash_walkers,
			/area/ruin/unpowered/primitive_catgirl_den,
	))

/obj/effect/dummy/phased_mob/blood/mining/
	var/static/list/allowed_areas = typecacheof(list(
			/area/forestplanet,
			/area/icemoon,
			/area/lavaland,
			/area/ocean/generated,
			/area/ruin,
	))
	var/static/list/disallowed_areas = typecacheof(list(
			/area/ruin/interdyne_planetary_base,
			/area/ruin/unpowered/ash_walkers,
			/area/ruin/unpowered/primitive_catgirl_den,
	))

/obj/effect/dummy/phased_mob/blood/mining/relaymove(mob/living/user, direction)
	var/turf/oldloc = loc
	. = ..()
	if(loc != oldloc)
		var/user_area = get_area(user)
		if (!is_type_in_typecache(user_area, allowed_areas) || is_type_in_typecache(user_area, disallowed_areas))
			to_chat(user, "You are forcibly ejected!")
			eject_jaunter(TRUE)
