/**
 * Protean Bodypart Macros
 * These macros condense identical bodypart logic instead of having a 500 line file.
 */

/**
 * PROTEAN_BODYPART_DEFINE(path, health)
 * Gives a Protean's limbs the proper bodytypes and names.
 */
#define PROTEAN_BODYPART_DEFINE(path, health) \
##path {\
	max_damage = ##health; \
	bodytype = BODYTYPE_ROBOTIC; \
	dmg_overlay_type = "robotic"; \
	light_brute_msg = LIGHT_NANO_BRUTE; \
	medium_brute_msg = MEDIUM_NANO_BRUTE; \
	heavy_brute_msg = HEAVY_NANO_BRUTE; \
	light_burn_msg = LIGHT_NANO_BURN; \
	medium_burn_msg = MEDIUM_NANO_BURN; \
	heavy_burn_msg = HEAVY_NANO_BURN; \
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO); \
	var/qdel_timer; \
}\
##path/Destroy() {\
	if(!isnull(qdel_timer)) {\
		deltimer(qdel_timer); \
		qdel_timer = null; \
	}\
	return ..(); \
}

/**
 * PROTEAN_DELIMB_DEFINE(path)
 * Reworks delimbing logic. Once a limb reaches max damage, it falls off and auto-deletes after a timer.
 */
#define PROTEAN_DELIMB_DEFINE(path) \
##path/try_dismember(wounding_type, wounding_dmg, wound_bonus, exposed_wound_bonus) {\
	if(((get_damage() + wounding_dmg) >= max_damage)) {\
		dismember(); \
		qdel_timer = QDEL_IN_STOPPABLE(src, PROTEAN_LIMB_TIME); \
	} \
}

/**
 * PROTEAN_LIMB_ATTACH(path)
 * If you reattach your limb, it will cancel the qdel timer.
 */
#define PROTEAN_LIMB_ATTACH(path) \
##path/can_attach_limb(limb_owner, special) {\
	. = ..(); \
	if(!.) {\
		return FALSE; \
	} \
	if(!isnull(qdel_timer)) { \
		deltimer(qdel_timer); \
		qdel_timer = null; \
	return TRUE; \
	} \
}

// Core bodyparts
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/head/mutant/protean, 120)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/head/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/head/mutant/protean)

PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/chest/mutant/protean, LIMB_MAX_HP_CORE)

/obj/item/bodypart/chest/mutant/protean
	wing_types = list(
		/obj/item/organ/wings/functional/robotic,
	)

// Arm limbs
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/left/mutant/protean, 40)
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/right/mutant/protean, 40)

/// Legs are a little more special due to digitigrade support, so they're not macro'd
/obj/item/bodypart/leg/right/mutant/protean
	max_damage = 40
	bodytype = BODYTYPE_SYNTHETIC
	dmg_overlay_type = "robotic"
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BURN
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)
	digitigrade_type = /obj/item/bodypart/leg/right/mutant/protean/digitigrade
	var/qdel_timer

/obj/item/bodypart/leg/right/mutant/protean/Destroy()
	if(!isnull(qdel_timer))
		deltimer(qdel_timer)
		qdel_timer = null
	return ..()

/obj/item/bodypart/leg/left/mutant/protean
	max_damage = 40
	bodytype = BODYTYPE_SYNTHETIC
	dmg_overlay_type = "robotic"
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BURN
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)
	digitigrade_type = /obj/item/bodypart/leg/left/mutant/protean/digitigrade
	var/qdel_timer

/obj/item/bodypart/leg/left/mutant/protean/Destroy()
	if(!isnull(qdel_timer))
		deltimer(qdel_timer)
		qdel_timer = null
	return ..()

/obj/item/bodypart/leg/right/mutant/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/right/mutant/protean/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()

/obj/item/bodypart/leg/left/mutant/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/left/mutant/protean/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()

// Apply delimb and reattach macros to all limbs
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/left/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/right/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/left/mutant/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/right/mutant/protean)

PROTEAN_LIMB_ATTACH(/obj/item/bodypart/arm/left/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/arm/right/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/leg/left/mutant/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/leg/right/mutant/protean)

#undef PROTEAN_BODYPART_DEFINE
#undef PROTEAN_DELIMB_DEFINE
#undef PROTEAN_LIMB_ATTACH
