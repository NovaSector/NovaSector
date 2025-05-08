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

/datum/action/cooldown/spell/jaunt/bloodcrawl
	/// A list of allowed areas that the spell can be used in
	var/list/allowed_areas = list(
		/area,
	)
	/// A list of disallowed areas that the spell can't be used in
	var/list/disallowed_areas = list()
	/// Custom message we say to the user when they try to cast in the wrong area
	var/failure_message = "This spell cannot be used in this area!"

/datum/action/cooldown/spell/jaunt/bloodcrawl/can_cast_spell(feedback = TRUE)
	if (!is_type_in_list(get_area(owner), allowed_areas) || is_type_in_list(get_area(owner), disallowed_areas))
		if(feedback)
			owner.balloon_alert(owner, failure_message)
		return FALSE
	. = ..()

/datum/action/cooldown/spell/jaunt/bloodcrawl/mining
	/// Instant was a bit too much.
	enter_blood_time = 2 SECONDS
	failure_message = "This ability can only be used on planetary areas untainted by civilization!"
	/// special snowflake jaunt type to eject on mining areas.
	jaunt_type = /obj/effect/dummy/phased_mob/blood/mining
	/// Mining areas we got.
	allowed_areas = list(
			/area/forestplanet,
			/area/icemoon,
			/area/lavaland,
			/area/ocean/generated,
			/area/ruin,
	)
	disallowed_areas = list(
			/area/ruin/interdyne_planetary_base,
			/area/ruin/unpowered/ash_walkers,
			/area/ruin/unpowered/primitive_catgirl_den,
	)

/obj/effect/dummy/phased_mob/blood
	var/list/allowed_areas = list(
		/area,
	)
	var/list/disallowed_areas = list()

/obj/effect/dummy/phased_mob/blood/mining/
	allowed_areas = list(
			/area/forestplanet,
			/area/icemoon,
			/area/lavaland,
			/area/ocean/generated,
			/area/ruin,
	)
	disallowed_areas = list(
			/area/ruin/interdyne_planetary_base,
			/area/ruin/unpowered/ash_walkers,
			/area/ruin/unpowered/primitive_catgirl_den,
	)

/obj/effect/dummy/phased_mob/blood/relaymove(mob/living/user, direction)
	var/turf/oldloc = loc
	. = ..()
	if(loc != oldloc)
		if (!is_type_in_list(get_area(user), allowed_areas) || is_type_in_list(get_area(user), disallowed_areas))
			user.balloon_alert(user, "You are forcibly ejected!")
			eject_jaunter(TRUE)
