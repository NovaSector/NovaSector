/// how many life ticks are required for the nightmare's heart to revive the nightmare
#define HEART_RESPAWN_THRESHHOLD (1 MINUTES)

// slightly clunky but we have to pick one subtype to commit to. copying nightmare heart behavior is less work + we can tweak nightmare gimmicks here
/obj/item/organ/heart/hemophage/shadow
	name = "darkened pulsating tumor"
	// we only need master of the house
	actions_types = list(/datum/action/cooldown/hemophage/master_of_the_house)
	// no love is to be found in a heart so twisted
	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5)
	/// how many life ticks in the dark the owner has been dead for. Used for nightmare respawns
	var/respawn_progress = 0
	/// the armblade granted to the host of this heart
	var/obj/item/light_eater/blade

// copy the eating behavior from the basic nightmare heart, except we lock this to hemophagic beings
/obj/item/organ/heart/hemophage/shadow/attack(mob/eater, mob/living/carbon/user, obj/target)
	if(eater != user)
		return ..()
	if(!(is_species(user, /datum/species/shadow) || is_species(user, /datum/species/hemophage)))
		return ..()
	user.visible_message(
		span_warning("[user] raises [src] to [user.p_their()] mouth and tears into it with [user.p_their()] teeth!"),
		span_danger("[src] feels unnaturally cold in your hands. You raise [src] to your mouth and devour it!")
	)
	playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
	user.visible_message(
		span_warning("Blood erupts from [user]'s arm as it reforms into a weapon!"),
		span_userdanger("Icy blood pumps through your veins as your arm reforms itself!")
	)
	user.temporarilyRemoveItemFromInventory(src, TRUE)
	Insert(user)

// copy the light eater spawning
/obj/item/organ/heart/hemophage/shadow/on_mob_insert(mob/living/carbon/heart_owner, special, movement_flags)
	. = ..()
	if(isnull(blade))
		blade = new /obj/item/light_eater
		heart_owner.put_in_hands(blade)

// and the removal
/obj/item/organ/heart/hemophage/shadow/on_mob_remove(mob/living/carbon/heart_owner, special, movement_flags)
	. = ..()
	respawn_progress = 0
	if(blade)
		heart_owner.visible_message(span_warning("\The [blade] disintegrates!"))
		QDEL_NULL(blade)

// the revival mechanic
/obj/item/organ/heart/hemophage/shadow/on_death(seconds_per_tick, times_fired)
	if(!owner)
		return
	var/turf/T = get_turf(owner)
	if(istype(T))
		var/light_amount = T.get_lumcount()
		if(light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD)
			respawn_progress += seconds_per_tick SECONDS
			playsound(owner, 'sound/effects/singlebeat.ogg', 40, TRUE)
	if(respawn_progress < HEART_RESPAWN_THRESHHOLD)
		return

	owner.revive(HEAL_ALL)
	owner.visible_message(span_warning("[owner] staggers to [owner.p_their()] feet!"))
	playsound(owner, 'sound/effects/hallucinations/far_noise.ogg', 50, TRUE)
	respawn_progress = 0

/obj/item/organ/heart/hemophage/shadow/Stop()
	return FALSE

#undef HEART_RESPAWN_THRESHHOLD

// grant this spell regardless of nightmare traitor datum, because this brain is exclusive to the nightmare - who is already traitor only
/obj/item/organ/brain/shadow/nightmare/on_mob_insert(mob/living/carbon/nightmare)
	. = ..()
	if(isnull(terrorize_spell))
		terrorize_spell = new(src)
		terrorize_spell.Grant(nightmare)

// adds a strong wound and limb regeneration status effect when it is dark
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
