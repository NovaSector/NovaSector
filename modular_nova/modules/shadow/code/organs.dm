// grant this spell regardless of nightmare traitor datum, because this brain is exclusive to the nightmare - who is already traitor only
/obj/item/organ/brain/shadow/nightmare/on_mob_insert(mob/living/carbon/nightmare)
	. = ..()
	if(isnull(terrorize_spell))
		terrorize_spell = new(src)
		terrorize_spell.Grant(nightmare)

// adds a strong wound, limb and blood regeneration status effect when it is dark
/obj/item/organ/brain/shadow/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/turf/owner_turf = owner.loc
	if(!isturf(owner_turf))
		return
	var/light_amount = owner_turf.get_lumcount()
	if (light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD) // read 'modular_nova\modules\shadow\code\buffs.dm'
		owner.apply_status_effect(/datum/status_effect/shadow/regeneration)

#define NIGHTMARE_DODGE_FILTER "nightmare_dodge_filter"
#define NIGHTMARE_DODGE_COLOR "nightmare_dodge_color"
#define NIGHTMARE_DODGE_SHADOW "nightmare_dodge_shadow"

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
			"name" = NIGHTMARE_DODGE_COLOR,
			"priority" = 2,
			"params" = color_matrix_filter(in_matrix = COLOR_ALMOST_BLACK),
		),
		list(
			"name" = NIGHTMARE_DODGE_SHADOW,
			"priority" = 3,
			"params" = drop_shadow_filter(x = 0, y = 0, size = 2, color = COLOR_BLACK),
		)
	))
	addtimer(CALLBACK(nightmare, TYPE_PROC_REF(/datum, remove_filter), list(NIGHTMARE_DODGE_FILTER, NIGHTMARE_DODGE_COLOR, NIGHTMARE_DODGE_SHADOW)), 0.5 SECONDS)

#undef NIGHTMARE_DODGE_FILTER
#undef NIGHTMARE_DODGE_COLOR
#undef NIGHTMARE_DODGE_SHADOW

// glowing red eyes like in the description
/obj/item/organ/eyes/shadow
	is_emissive = TRUE
