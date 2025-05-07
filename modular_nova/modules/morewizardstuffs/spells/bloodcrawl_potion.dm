/obj/item/bloodcrawl_bottle
	name = "bloodlust in a bottle"
	desc = "Drinking this will give you unimaginable powers... and mildly disgust you because of its metallic taste."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/bloodcrawl_bottle/attack_self(mob/user)
	to_chat(user, span_notice("You drink the contents of [src]."))
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/mining/new_spell =  new(user)
	new_spell.Grant(user)
	user.log_message("learned the spell bloodcrawl (Limited) ([new_spell])", LOG_ATTACK, color="orange")
	qdel(src)

datum/action/cooldown/spell/jaunt/bloodcrawl
	/// A list of allowed areas that the spell can be used in
	var/list/allowed_areas = list(
		/area,
	)

/datum/action/cooldown/spell/jaunt/bloodcrawl/can_cast_spell(feedback = TRUE)
	if (!is_type_in_list(get_area(owner), allowed_areas))
		if(feedback)
			owner.balloon_alert(owner, "This spell cannot be used in this area!")
		return FALSE
	. = ..()

datum/action/cooldown/spell/jaunt/bloodcrawl/mining
	allowed_areas = list(
			/area/forestplanet,
			/area/icemoon,
			/area/lavaland,
			/area/ocean/generated,
			/area/ruin,
			/area/mine,
	)
