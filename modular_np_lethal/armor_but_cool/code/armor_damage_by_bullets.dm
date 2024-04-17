/obj/item/clothing
	/// If the clothing should be damaged by piercing wounds (like bullets)
	var/damaged_by_bullets = FALSE
	/// What multiplier of incoming damage should be directed to limbs
	var/limb_damage_multiplier = 1

// Allow check_woundings_mods to account for piercing damage as well

/obj/item/bodypart/proc/check_woundings_mods(wounding_type, damage, wound_bonus, bare_wound_bonus)
	SHOULD_CALL_PARENT(TRUE)

	var/armor_ablation = 0
	var/injury_mod = 0

	if(owner && ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		var/list/clothing = human_owner.get_clothing_on_part(src)
		for(var/obj/item/clothing/clothes as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			armor_ablation += clothes.get_armor_rating(WOUND)
			if((wounding_type == WOUND_SLASH) || ((wounding_type == WOUND_PIERCE) && clothes.damaged_by_bullets))
				clothes.take_damage_zone(body_zone, damage, BRUTE)
			else if(wounding_type == WOUND_BURN && damage >= 10) // lazy way to block freezing from shredding clothes without adding another var onto apply_damage()
				clothes.take_damage_zone(body_zone, damage, BURN)

		if(!armor_ablation)
			injury_mod += bare_wound_bonus

	injury_mod -= armor_ablation
	injury_mod += wound_bonus

	for(var/datum/wound/wound as anything in wounds)
		injury_mod += wound.threshold_penalty

	var/part_mod = -wound_resistance
	if(get_damage() >= max_damage)
		part_mod += disabled_wound_penalty

	injury_mod += part_mod

	return injury_mod

// Change the clothing take_damage_zone proc to allow use of the vars added for piercing and limb damage multipliers

/obj/item/clothing/take_damage_zone(def_zone, damage_amount, damage_type, armour_penetration)
	if(!def_zone || !limb_integrity || (initial(body_parts_covered) in GLOB.bitflags)) // the second check sees if we only cover one bodypart anyway and don't need to bother with this
		return
	var/list/covered_limbs = cover_flags2body_zones(body_parts_covered) // what do we actually cover?
	if(!(def_zone in covered_limbs))
		return

	var/damage_dealt = take_damage(damage_amount * 0.1, damage_type, armour_penetration, FALSE) * 10 // only deal 10% of the damage to the general integrity damage, then multiply it by 10 so we know how much to deal to limb
	LAZYINITLIST(damage_by_parts)
	damage_by_parts[def_zone] += damage_dealt * limb_damage_multiplier
	if(damage_by_parts[def_zone] > limb_integrity)
		disable_zone(def_zone, damage_type)
