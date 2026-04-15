/**
 * Protean Bodypart Types
 *
 * Thin subtypes that set protean-specific appearance and stats.
 * All limb behavior (dissolution, dismemberment) is handled by /datum/component/protean_limb.
 * Chest keeps species_modsuit var and signal registrations for modsuit management.
 */

/// -- Core bodyparts --
/obj/item/bodypart/head/robot/protean
	max_damage = 120
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	should_draw_greyscale = TRUE
	change_exempt_flags = NONE
	is_dimorphic = TRUE
	head_flags = HEAD_DEFAULT_FEATURES
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BURN
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)

/obj/item/bodypart/chest/robot/protean
	max_damage = LIMB_MAX_HP_CORE
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	should_draw_greyscale = TRUE
	change_exempt_flags = NONE
	is_dimorphic = TRUE
	wing_types = list(/obj/item/organ/wings/functional/robotic)
	light_brute_msg = LIGHT_NANO_BRUTE
	medium_brute_msg = MEDIUM_NANO_BRUTE
	heavy_brute_msg = HEAVY_NANO_BRUTE
	light_burn_msg = LIGHT_NANO_BURN
	medium_burn_msg = MEDIUM_NANO_BURN
	heavy_burn_msg = HEAVY_NANO_BURN
	damage_examines = list(BRUTE = BRUTE_EXAMINE_NANO, BURN = BURN_EXAMINE_NANO)
	/// Reference to this protean's modsuit.
	var/obj/item/mod/control/pre_equipped/protean/species_modsuit

/obj/item/bodypart/arm/left/robot/protean
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

/obj/item/bodypart/arm/right/robot/protean
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

/// -- Legs (support digitigrade) --
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

/obj/item/bodypart/leg/right/robot/protean/clear_ownership(mob/living/carbon/old_owner)
	old_owner.remove_overlay(SHOES_LAYER)
	old_owner.update_worn_shoes()
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

/obj/item/bodypart/leg/left/robot/protean/clear_ownership(mob/living/carbon/old_owner)
	old_owner.remove_overlay(SHOES_LAYER)
	old_owner.update_worn_shoes()
	return ..()

/// -- Digitigrade variants --

/obj/item/bodypart/leg/right/robot/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/left/robot/protean/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/// -- Chest: modsuit management (stays on the chest, not the component) --

/obj/item/bodypart/chest/robot/protean/apply_ownership(mob/living/carbon/new_owner)
	. = ..()
	RegisterSignals(new_owner, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_ITEM_INTERACTION_SECONDARY), PROC_REF(on_item_interaction))
	RegisterSignal(new_owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_item_equipped))

/obj/item/bodypart/chest/robot/protean/clear_ownership(mob/living/carbon/old_owner)
	species_modsuit = null
	UnregisterSignal(old_owner, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_ITEM_INTERACTION_SECONDARY, COMSIG_MOB_EQUIPPED_ITEM))
	return ..()

/// When a non-protean-modsuit item is equipped to the back slot, converts it into a protean modsuit.
/obj/item/bodypart/chest/robot/protean/proc/on_item_equipped(mob/living/carbon/human/source, obj/item/equipped_item, slot)
	SIGNAL_HANDLER
	if(slot != ITEM_SLOT_BACK)
		return
	if(istype(equipped_item, /obj/item/mod/control/pre_equipped/protean))
		return
	if(!species_modsuit)
		return // pre_equip_outfit dropped it, post_equip_outfit will handle
	var/datum/species/protean/species = source.dna?.species
	if(!istype(species))
		return
	equipped_item.atom_storage?.remove_all(get_turf(source))
	species.equip_modsuit(source, src)
	qdel(equipped_item)

/// Protean limbs reject welder/cable healing.
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

/**
 * Protean Limb Component
 *
 * Attached to each bodypart when a mob gains the protean species.
 * Handles limb-specific protean behavior via signals:
 * - Dismemberment at max damage (instead of wound-based)
 * - Dissolution timer + effects when limbs are removed
 * - Timer cancellation when limbs are reattached
 */
/datum/component/protean_limb
	/// Timer ID for the auto-dissolution of a dismembered limb
	var/qdel_timerid

/datum/component/protean_limb/Initialize()
	if(!isbodypart(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/protean_limb/Destroy()
	if(qdel_timerid)
		deltimer(qdel_timerid)
		qdel_timerid = null
	return ..()

/datum/component/protean_limb/RegisterWithParent()
	var/obj/item/bodypart/limb = parent
	if(limb.owner)
		register_owner_signals(limb.owner)
	RegisterSignal(parent, COMSIG_BODYPART_CHANGED_OWNER, PROC_REF(on_owner_changed))

/datum/component/protean_limb/UnregisterFromParent()
	var/obj/item/bodypart/limb = parent
	if(limb.owner)
		unregister_owner_signals(limb.owner)
	UnregisterSignal(parent, COMSIG_BODYPART_CHANGED_OWNER)

/// When the limb changes owner, migrate signals and cancel dissolution timer if reattached.
/datum/component/protean_limb/proc/on_owner_changed(obj/item/bodypart/source, mob/living/carbon/new_owner, mob/living/carbon/old_owner)
	SIGNAL_HANDLER
	if(old_owner)
		unregister_owner_signals(old_owner)
	if(new_owner)
		register_owner_signals(new_owner)
		if(qdel_timerid)
			deltimer(qdel_timerid)
			qdel_timerid = null

/datum/component/protean_limb/proc/register_owner_signals(mob/living/carbon/owner)
	RegisterSignal(owner, COMSIG_CARBON_LIMB_DAMAGED, PROC_REF(on_limb_damaged))
	RegisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(on_limb_removed))

/datum/component/protean_limb/proc/unregister_owner_signals(mob/living/carbon/owner)
	UnregisterSignal(owner, list(COMSIG_CARBON_LIMB_DAMAGED, COMSIG_CARBON_REMOVE_LIMB))

/// -- Dismemberment at max damage --
/datum/component/protean_limb/proc/on_limb_damaged(mob/living/carbon/source, obj/item/bodypart/limb, brute, burn)
	SIGNAL_HANDLER
	if(limb != parent)
		return
	if((limb.get_damage() + brute + burn) >= limb.max_damage)
		limb.dismember()

/// -- Dissolution timer --
/datum/component/protean_limb/proc/on_limb_removed(mob/living/carbon/source, obj/item/bodypart/removed_limb, special, dismembered)
	SIGNAL_HANDLER
	if(removed_limb != parent || special)
		return
	qdel_timerid = addtimer(CALLBACK(src, PROC_REF(dissolve_limb)), PROTEAN_LIMB_TIME, TIMER_STOPPABLE)

/datum/component/protean_limb/proc/dissolve_limb()
	var/obj/item/bodypart/limb = parent
	var/turf/limb_turf = get_turf(limb)
	if(limb_turf)
		playsound(limb_turf, 'sound/effects/wounds/sizzle2.ogg', 30, TRUE)
		new /obj/effect/decal/cleanable/blood(limb_turf, null, get_blood_type(BLOOD_TYPE_IRON))
	qdel(limb)
