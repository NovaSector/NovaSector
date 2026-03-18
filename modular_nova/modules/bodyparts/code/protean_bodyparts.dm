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
	icon_greyscale = BODYPART_ICON_MAMMAL; \
	limb_id = SPECIES_MAMMAL; \
	should_draw_greyscale = TRUE; \
	change_exempt_flags = NONE; \
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
	var/turf/limb_turf = get_turf(src); \
	var/was_dismembered = !isnull(qdel_timer); \
	if(!isnull(qdel_timer)) {\
		deltimer(qdel_timer); \
		qdel_timer = null; \
	}\
	if(was_dismembered && limb_turf && !owner) {\
		playsound(limb_turf, 'sound/effects/wounds/sizzle2.ogg', 30, TRUE); \
		new /obj/effect/decal/cleanable/blood(limb_turf, null, get_blood_type(BLOOD_TYPE_IRON)); \
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
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/head/robot/protean, 120)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/head/robot/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/head/robot/protean)

/obj/item/bodypart/head/robot/protean
	is_dimorphic = TRUE
	head_flags = HEAD_DEFAULT_FEATURES

PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/chest/robot/protean, LIMB_MAX_HP_CORE)

/obj/item/bodypart/chest/robot/protean
	is_dimorphic = TRUE
	wing_types = list(
		/obj/item/organ/wings/functional/robotic,
	)

// Arm limbs
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/left/robot/protean, 40)
PROTEAN_BODYPART_DEFINE(/obj/item/bodypart/arm/right/robot/protean, 40)

/// Legs are a little more special due to digitigrade support, so they're not macro'd
/obj/item/bodypart/leg/right/robot/protean
	max_damage = 40
	biological_state = (BIO_ROBOTIC|BIO_JOINTED|BIO_BLOODED)
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	should_draw_greyscale = TRUE
	change_exempt_flags = NONE
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BURN
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)
	digitigrade_type = /obj/item/bodypart/leg/right/robot/protean/digitigrade
	var/qdel_timer

/obj/item/bodypart/leg/right/robot/protean/clear_ownership(mob/living/carbon/old_owner)
	old_owner.remove_overlay(SHOES_LAYER)
	old_owner.update_worn_shoes()
	return ..()

/obj/item/bodypart/leg/right/robot/protean/Destroy()
	var/turf/limb_turf = get_turf(src)
	var/was_dismembered = !isnull(qdel_timer)
	if(!isnull(qdel_timer))
		deltimer(qdel_timer)
		qdel_timer = null
	if(was_dismembered && limb_turf && !owner)
		playsound(limb_turf, 'sound/effects/wounds/sizzle2.ogg', 30, TRUE)
		new /obj/effect/decal/cleanable/blood(limb_turf, null, get_blood_type(BLOOD_TYPE_IRON))
	return ..()

/obj/item/bodypart/leg/left/robot/protean
	max_damage = 40
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	should_draw_greyscale = TRUE
	change_exempt_flags = NONE
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BURN
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)
	digitigrade_type = /obj/item/bodypart/leg/left/robot/protean/digitigrade
	var/qdel_timer

/obj/item/bodypart/leg/left/robot/protean/clear_ownership(mob/living/carbon/old_owner)
	old_owner.remove_overlay(SHOES_LAYER)
	old_owner.update_worn_shoes()
	return ..()

/obj/item/bodypart/leg/left/robot/protean/Destroy()
	var/turf/limb_turf = get_turf(src)
	var/was_dismembered = !isnull(qdel_timer)
	if(!isnull(qdel_timer))
		deltimer(qdel_timer)
		qdel_timer = null
	if(was_dismembered && limb_turf && !owner)
		playsound(limb_turf, 'sound/effects/wounds/sizzle2.ogg', 30, TRUE)
		new /obj/effect/decal/cleanable/blood(limb_turf, null, get_blood_type(BLOOD_TYPE_IRON))
	return ..()

/obj/item/bodypart/leg/right/robot/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/right/robot/protean/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()

/obj/item/bodypart/leg/left/robot/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/left/robot/protean/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()

// Apply delimb and reattach macros to all limbs
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/left/robot/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/arm/right/robot/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/left/robot/protean)
PROTEAN_DELIMB_DEFINE(/obj/item/bodypart/leg/right/robot/protean)

PROTEAN_LIMB_ATTACH(/obj/item/bodypart/arm/left/robot/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/arm/right/robot/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/leg/left/robot/protean)
PROTEAN_LIMB_ATTACH(/obj/item/bodypart/leg/right/robot/protean)

/// Protean limbs reject welder/cable healing — intercept before the tool interaction even starts.
/// Registered on owner from the chest bodypart (always present). Returns ITEM_INTERACT_SKIP_TO_ATTACK
/// so the welder attacks instead of healing.
/obj/item/bodypart/chest/robot/protean/apply_ownership(mob/living/carbon/new_owner)
	. = ..()
	RegisterSignals(new_owner, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_ITEM_INTERACTION_SECONDARY), PROC_REF(on_item_interaction))

/obj/item/bodypart/chest/robot/protean/clear_ownership(mob/living/carbon/old_owner)
	UnregisterSignal(old_owner, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_ITEM_INTERACTION_SECONDARY))
	return ..()

/obj/item/bodypart/chest/robot/protean/proc/on_item_interaction(mob/living/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER
	if(!istype(tool, /obj/item/weldingtool) && !istype(tool, /obj/item/stack/cable_coil))
		return NONE
	if(user.combat_mode)
		return NONE
	var/obj/item/bodypart/affecting = source.get_bodypart(check_zone(user.zone_selected))
	if(isnull(affecting) || !IS_ROBOTIC_LIMB(affecting))
		return NONE
	return ITEM_INTERACT_SKIP_TO_ATTACK

#undef PROTEAN_BODYPART_DEFINE
#undef PROTEAN_DELIMB_DEFINE
#undef PROTEAN_LIMB_ATTACH
