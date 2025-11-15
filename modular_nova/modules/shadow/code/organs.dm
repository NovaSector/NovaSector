#define NIGHTMARE_DODGE_FILTER "nightmare_dodge_filter"
#define NIGHTMARE_DODGE_BLUR "nightmare_dodge_blur"

// add a filter effect when the bullets are dodged, for clarity and coolness. thanks paxil
/datum/status_effect/shadow/nightmare/dodge_bullets(mob/living/carbon/human/nightmare, obj/projectile/hitting_projectile, def_zone)
	. = ..()
	nightmare.add_filters(list(
		list(
			"name" = NIGHTMARE_DODGE_FILTER,
			"priority" = 1,
			"params" = phase_filter(size = 8),
		),
		list(
			"name" = NIGHTMARE_DODGE_BLUR,
			"priority" = 2,
			"params" = bloom_filter(threshold = COLOR_BLACK, size = 1, offset = 1, alpha = 200),
		)
	))
	addtimer(CALLBACK(nightmare, TYPE_PROC_REF(/datum, remove_filter), list(NIGHTMARE_DODGE_FILTER, NIGHTMARE_DODGE_BLUR)), 0.5 SECONDS)

#undef NIGHTMARE_DODGE_FILTER
#undef NIGHTMARE_DODGE_BLUR

// glowing red eyes like in the description
/obj/item/organ/eyes/shadow
	is_emissive = TRUE

// grant this spell regardless of nightmare traitor datum, because this brain is exclusive to the nightmare - who is already traitor only
/obj/item/organ/brain/shadow/nightmare/on_mob_insert(mob/living/carbon/nightmare)
	. = ..()
	if(isnull(terrorize_spell))
		terrorize_spell = new(src)
		terrorize_spell.Grant(nightmare)
