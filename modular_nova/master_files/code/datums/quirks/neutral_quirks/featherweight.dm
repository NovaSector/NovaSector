/datum/controller/subsystem/processing/quirks/Initialize()
	GLOB.quirk_blacklist += list(list(/datum/quirk/featherweight, /datum/quirk/oversized))
	GLOB.quirk_string_blacklist = generate_quirk_string_blacklist()

	get_quirks()
	return SS_INIT_SUCCESS

#define FEATHERWEIGHT_FLIGHT_TRAIT "featherweight_flight"
#define FEATHERWEIGHT_FRAGILITY_MOD 1.5
#define FEATHERWEIGHT_FLIGHT_DISABLE_TIME (6 SECONDS)
#define FEATHERWEIGHT_HIT_KNOCKDOWN_TIME (2 SECONDS)

/datum/reagent/flightpotion/New(data)
	. = ..()
	RegisterSignal(src, COMSIG_REAGENT_EXPOSE_MOB, PROC_REF(on_featherweight_flight_potion_exposure))

/datum/reagent/flightpotion/proc/on_featherweight_flight_potion_exposure(datum/source, mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	SIGNAL_HANDLER

	if(!ishuman(exposed_mob) || exposed_mob.stat == DEAD || !(methods & (INGEST | TOUCH)))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	var/obj/item/bodypart/chest/chest = exposed_human.get_bodypart(BODY_ZONE_CHEST)
	if(!chest?.wing_types || reac_volume < 5 || !exposed_human.dna)
		return

	if(exposed_human.has_quirk(/datum/quirk/featherweight))
		exposed_human.remove_quirk(/datum/quirk/featherweight)

/datum/action/innate/flight/featherweight
	name = "Toggle Featherweight Flight"
	desc = "Beat your wings to fly."

/datum/bodypart_overlay/mutant/wings/functional/featherweight
	/// Name of the owner's normal wing sprite, used when the open-wing list has no matching sprite.
	var/closed_accessory_name
	/// If true, render from FEATURE_WINGS_OPEN while the wings are open.
	var/using_open_sprite = FALSE

/datum/bodypart_overlay/mutant/wings/functional/featherweight/get_global_feature_list()
	if(wings_open && using_open_sprite)
		return SSaccessories.sprite_accessories[FEATURE_WINGS_OPEN]

	return SSaccessories.sprite_accessories[FEATURE_WINGS]

/datum/bodypart_overlay/mutant/wings/functional/featherweight/proc/set_closed_appearance(accessory_name, new_draw_color, new_dye_color)
	closed_accessory_name = accessory_name
	wings_open = FALSE
	using_open_sprite = FALSE
	feature_key = FEATURE_WINGS
	set_appearance_from_name(closed_accessory_name)
	draw_color = new_draw_color
	dye_color = new_dye_color
	imprint_on_next_insertion = FALSE

/datum/bodypart_overlay/mutant/wings/functional/featherweight/open_wings()
	closed_accessory_name ||= sprite_datum?.name
	using_open_sprite = !isnull(SSaccessories.sprite_accessories[FEATURE_WINGS_OPEN]?[closed_accessory_name])
	wings_open = TRUE
	feature_key = using_open_sprite ? FEATURE_WINGS_OPEN : FEATURE_WINGS
	if(closed_accessory_name)
		set_appearance_from_name(closed_accessory_name)

/datum/bodypart_overlay/mutant/wings/functional/featherweight/close_wings()
	closed_accessory_name ||= sprite_datum?.name
	wings_open = FALSE
	using_open_sprite = FALSE
	feature_key = FEATURE_WINGS
	if(closed_accessory_name)
		set_appearance_from_name(closed_accessory_name)

/obj/item/organ/wings/functional/featherweight
	name = "lightened wings"
	desc = "A pair of wings made flight-capable by an unusually light body."
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/featherweight
	food_reagents = list()
	/// Quirk that owns this temporary functional-wing organ.
	var/datum/quirk/featherweight/featherweight_quirk

/obj/item/organ/wings/functional/featherweight/Destroy()
	featherweight_quirk = null
	return ..()

/obj/item/organ/wings/functional/featherweight/grind_results()
	return null

/obj/item/organ/wings/functional/featherweight/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(fly))
		fly = new /datum/action/innate/flight/featherweight
	return ..()

/obj/item/organ/wings/functional/featherweight/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	if(organ_owner && wings_open && !HAS_TRAIT_FROM(organ_owner, TRAIT_MOVE_FLOATING, SPECIES_FLIGHT_TRAIT))
		close_wings()
	return ..()

/obj/item/organ/wings/functional/featherweight/can_fly(silent = FALSE)
	var/mob/living/carbon/human/human = owner
	if(!human || !featherweight_quirk || QDELETED(featherweight_quirk) || QDELETED(human) || featherweight_quirk.quirk_holder != human)
		return FALSE

	if(world.time < featherweight_quirk.next_flight_allowed)
		if(!silent)
			to_chat(human, span_warning("You need [DisplayTimeText(featherweight_quirk.next_flight_allowed - world.time)] before your wings can catch the air again!"))
		return FALSE

	var/obj/item/organ/wings/moth/original_moth_wings = featherweight_quirk.original_featherweight_wings
	if(istype(original_moth_wings) && original_moth_wings.burnt)
		if(!silent)
			to_chat(human, span_warning("Your wings are too badly burnt to fly!"))
		return FALSE

	if(human.obscured_slots & HIDEMUTWINGS)
		if(!silent)
			to_chat(human, span_warning("Your clothing blocks your wings from extending!"))
		return FALSE

	return ..()

/obj/item/organ/wings/functional/featherweight/toggle_flight(mob/living/carbon/human/human)
	. = ..()
	featherweight_quirk?.sync_featherweight_flight()

/obj/item/organ/wings/functional/featherweight/proc/copy_appearance_from(obj/item/organ/wings/source_wings)
	name = source_wings.name
	desc = source_wings.desc

	var/datum/bodypart_overlay/mutant/source_overlay = source_wings.bodypart_overlay
	var/datum/bodypart_overlay/mutant/wings/functional/featherweight/featherweight_overlay = bodypart_overlay
	if(source_overlay && source_wings.bodypart_owner)
		source_overlay.inherit_color(source_wings.bodypart_owner, TRUE)
	var/accessory_name = source_overlay?.sprite_datum?.name || get_consistent_feature_entry(featherweight_overlay.get_global_feature_list())
	featherweight_overlay.set_closed_appearance(accessory_name, source_overlay?.draw_color, source_overlay?.dye_color)

/datum/quirk/featherweight
	name = "Featherweight"
	desc = "Your body is lighter and more fragile than others'. You can be picked up with ease, and wings can carry you through the air."
	icon = FA_ICON_FEATHER
	value = 0
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = span_notice("Your body feels lighter!")
	lose_text = span_notice("Your body feels slightly more dense.")
	medical_record_text = "Subject's body is lighter and more fragile than usual, they can be carried with relative ease."
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	mail_goodies = list(/obj/item/food/lollipop)
	/// Track physiology changes so removal only reverts what this quirk applied.
	var/fragility_applied = FALSE
	/// World time after which Featherweight flight can be used again.
	var/next_flight_allowed = 0
	/// Prevents duplicate grounding signals from stacking from one event.
	var/last_flight_disable = 0
	var/last_brute_loss = 0
	var/last_burn_loss = 0
	/// The holder's normal wings, stored while Featherweight temporarily upgrades them.
	var/obj/item/organ/wings/original_featherweight_wings
	/// Temporary functional wings that reuse the strange-elixir flight implementation.
	var/obj/item/organ/wings/functional/featherweight/featherweight_wings
	/// Prevents organ gain/loss signals from recursing while swapping wings.
	var/swapping_featherweight_wings = FALSE

/datum/quirk/featherweight/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	ADD_TRAIT(human_holder, TRAIT_EASILY_WOUNDED, FEATHERWEIGHT_FLIGHT_TRAIT)
	human_holder.physiology.brute_mod *= FEATHERWEIGHT_FRAGILITY_MOD
	human_holder.physiology.burn_mod *= FEATHERWEIGHT_FRAGILITY_MOD
	fragility_applied = TRUE
	last_brute_loss = human_holder.get_brute_loss()
	last_burn_loss = human_holder.get_fire_loss()

	RegisterSignals(human_holder, list(
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_LOSE_ORGAN,
		COMSIG_MOB_STATCHANGE,
		COMSIG_LIVING_SET_BODY_POSITION,
		COMSIG_MOVABLE_MOVED,
	), PROC_REF(on_featherweight_state_changed))
	RegisterSignals(human_holder, list(
		COMSIG_LIVING_HEALTH_UPDATE,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
	), PROC_REF(on_featherweight_grounding_signal))
	update_featherweight_wings()

/datum/quirk/featherweight/remove()
	cleanup_featherweight_flight()
	return ..()

/datum/quirk/featherweight/should_process()
	return is_featherweight_flying() && ..()

/datum/quirk/featherweight/process(seconds_per_tick)
	var/obj/item/organ/wings/functional/featherweight/wings = get_featherweight_functional_wings()
	if(!wings?.can_fly(silent = TRUE))
		stop_featherweight_flight()

/datum/quirk/featherweight/proc/on_featherweight_state_changed(datum/source, changed_thing = null)
	SIGNAL_HANDLER

	if(istype(changed_thing, /obj/item/organ/wings))
		if(swapping_featherweight_wings)
			return
		update_featherweight_wings()
		return

	var/obj/item/organ/wings/functional/featherweight/wings = get_featherweight_functional_wings()
	if(is_featherweight_flying() && !wings?.can_fly(silent = TRUE))
		stop_featherweight_flight()

/datum/quirk/featherweight/proc/on_featherweight_grounding_signal(mob/living/source, knockdown_amount = null)
	SIGNAL_HANDLER

	if(!isnull(knockdown_amount))
		if(knockdown_amount > 0)
			disable_featherweight_flight(knock_down = FALSE, show_message = FALSE)
		return

	var/current_brute_loss = source.get_brute_loss()
	var/current_burn_loss = source.get_fire_loss()
	if(current_brute_loss > last_brute_loss || current_burn_loss > last_burn_loss)
		disable_featherweight_flight()
	last_brute_loss = current_brute_loss
	last_burn_loss = current_burn_loss

/datum/quirk/featherweight/proc/update_featherweight_wings()
	if(QDELETED(quirk_holder))
		return

	var/obj/item/organ/wings/wings = get_featherweight_wings()
	if(istype(wings, /obj/item/organ/wings/functional/featherweight))
		featherweight_wings = wings
		featherweight_wings.featherweight_quirk = src
		sync_featherweight_flight()
		return

	if(istype(wings, /obj/item/organ/wings/functional))
		release_original_featherweight_wings()
		sync_featherweight_flight()
		return

	if(wings)
		replace_with_featherweight_wings(wings)
		return

	restore_featherweight_wings()

/datum/quirk/featherweight/proc/replace_with_featherweight_wings(obj/item/organ/wings/wings)
	if(swapping_featherweight_wings || QDELETED(wings) || istype(wings, /obj/item/organ/wings/functional))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/wings/functional/featherweight/new_wings = new()
	new_wings.featherweight_quirk = src
	new_wings.copy_appearance_from(wings)

	original_featherweight_wings = wings
	swapping_featherweight_wings = TRUE
	wings.Remove(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)
	wings.moveToNullspace()
	new_wings.Insert(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)
	swapping_featherweight_wings = FALSE

	featherweight_wings = new_wings
	human_holder.update_body_parts()
	sync_featherweight_flight()

/datum/quirk/featherweight/proc/release_original_featherweight_wings()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/wings/functional/featherweight/stored_wings = featherweight_wings
	if(human_holder && !QDELETED(human_holder))
		REMOVE_TRAIT(human_holder, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)

	if(!original_featherweight_wings)
		if(stored_wings && !QDELETED(stored_wings) && stored_wings.owner != human_holder)
			qdel(stored_wings)
		featherweight_wings = null
		return

	if(!QDELETED(original_featherweight_wings))
		original_featherweight_wings.forceMove(get_turf(human_holder))
	if(stored_wings && !QDELETED(stored_wings) && stored_wings.owner != human_holder)
		qdel(stored_wings)
	original_featherweight_wings = null
	featherweight_wings = null

/datum/quirk/featherweight/proc/restore_featherweight_wings()
	if(swapping_featherweight_wings)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/wings/functional/featherweight/current_wings = get_featherweight_functional_wings()
	var/obj/item/organ/wings/functional/featherweight/stored_wings = current_wings || featherweight_wings
	var/obj/item/organ/wings/original_wings = original_featherweight_wings
	REMOVE_TRAIT(human_holder, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)
	if(!stored_wings && !original_wings)
		return

	swapping_featherweight_wings = TRUE
	if(current_wings)
		if(is_featherweight_flying())
			current_wings.toggle_flight(human_holder)
		else if(current_wings.wings_open)
			current_wings.close_wings()
		current_wings.Remove(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)

	var/obj/item/organ/wings/current_slot_wings = get_featherweight_wings()
	if(original_wings && !QDELETED(original_wings))
		if(!current_slot_wings)
			original_wings.Insert(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)
		else
			original_wings.forceMove(get_turf(human_holder))

	if(stored_wings && !QDELETED(stored_wings))
		qdel(stored_wings)

	original_featherweight_wings = null
	featherweight_wings = null
	swapping_featherweight_wings = FALSE
	human_holder.update_body_parts()
	sync_featherweight_flight()

/datum/quirk/featherweight/proc/get_featherweight_wings()
	var/mob/living/carbon/human/human_holder = quirk_holder
	return human_holder?.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)

/datum/quirk/featherweight/proc/get_featherweight_functional_wings()
	var/obj/item/organ/wings/functional/featherweight/wings = get_featherweight_wings()
	if(istype(wings))
		return wings

/datum/quirk/featherweight/proc/is_featherweight_flying()
	return get_featherweight_functional_wings() && HAS_TRAIT_FROM(quirk_holder, TRAIT_MOVE_FLOATING, SPECIES_FLIGHT_TRAIT)

/datum/quirk/featherweight/proc/sync_featherweight_flight()
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!human_holder || QDELETED(human_holder))
		STOP_PROCESSING(SSquirks, src)
		return

	if(is_featherweight_flying())
		ADD_TRAIT(human_holder, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)
	else
		REMOVE_TRAIT(human_holder, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)

	if(should_process())
		START_PROCESSING(SSquirks, src)
	else
		STOP_PROCESSING(SSquirks, src)

/datum/quirk/featherweight/proc/stop_featherweight_flight()
	var/obj/item/organ/wings/functional/featherweight/wings = get_featherweight_functional_wings()
	if(!wings)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	if(is_featherweight_flying())
		wings.toggle_flight(human_holder)
	else if(wings.wings_open)
		wings.close_wings()
	sync_featherweight_flight()

/datum/quirk/featherweight/proc/disable_featherweight_flight(knock_down = TRUE, show_message = TRUE)
	if(QDELETED(quirk_holder) || !get_featherweight_functional_wings())
		return
	if(last_flight_disable == world.time)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/was_flying = is_featherweight_flying()
	if(!was_flying)
		return

	last_flight_disable = world.time
	next_flight_allowed = max(next_flight_allowed, world.time + FEATHERWEIGHT_FLIGHT_DISABLE_TIME)
	stop_featherweight_flight()

	if(knock_down)
		human_holder.Knockdown(FEATHERWEIGHT_HIT_KNOCKDOWN_TIME)
	if(show_message)
		human_holder.visible_message(
			span_warning("[human_holder] loses [human_holder.p_their()] balance from the hit!"),
			span_userdanger("The hit knocks you off-balance and your wings refuse to catch the air!"),
			span_hear("You hear someone stumble hard."),
		)
	addtimer(CALLBACK(src, PROC_REF(on_flight_lockout_finished)), FEATHERWEIGHT_FLIGHT_DISABLE_TIME, TIMER_UNIQUE|TIMER_OVERRIDE)

/datum/quirk/featherweight/proc/on_flight_lockout_finished()
	if(QDELETED(quirk_holder) || world.time < next_flight_allowed)
		return

	to_chat(quirk_holder, span_notice("Your wings feel steady enough to fly again."))

/datum/quirk/featherweight/proc/cleanup_featherweight_flight()
	if(QDELETED(quirk_holder))
		QDEL_NULL(featherweight_wings)
		QDEL_NULL(original_featherweight_wings)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	UnregisterSignal(human_holder, list(
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_LOSE_ORGAN,
		COMSIG_MOB_STATCHANGE,
		COMSIG_LIVING_SET_BODY_POSITION,
		COMSIG_MOVABLE_MOVED,
		COMSIG_LIVING_HEALTH_UPDATE,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
	))

	REMOVE_TRAIT(human_holder, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)
	restore_featherweight_wings()

	if(fragility_applied)
		REMOVE_TRAIT(human_holder, TRAIT_EASILY_WOUNDED, FEATHERWEIGHT_FLIGHT_TRAIT)
		human_holder.physiology.brute_mod /= FEATHERWEIGHT_FRAGILITY_MOD
		human_holder.physiology.burn_mod /= FEATHERWEIGHT_FRAGILITY_MOD
		fragility_applied = FALSE

#define FEATHERWEIGHT_OFFSET 6
#define FEATHERWEIGHT_SIDE_OFFSET 3
#define FEATHERWEIGHT_OVERSIZED_OFFSET 18
#define FEATHERWEIGHT_OVERSIZED_SIDE_OFFSET 11
#define FEATHERWEIGHT_REGULAR_OFFSET 6
#define FEATHERWEIGHT_REGULAR_SIDE_OFFSET 4

/datum/component/riding/creature/human
	/// Hand used by the carrier for Featherweight side-carry offsets.
	var/obj/item/bodypart/featherweight_used_hand

/datum/component/riding/creature/human/Initialize(mob/living/riding_mob, force = FALSE, ride_check_flags = NONE)
	. = ..()
	var/mob/living/carbon/human/human_parent = parent
	//human_parent.add_movespeed_modifier(/datum/movespeed_modifier/human_carry) // NOVA EDIT REMOVAL
	// NOVA EDIT ADDITION START - Taur saddles
	if (!(ride_check_flags & RIDING_TAUR))
		human_parent.add_movespeed_modifier(/datum/movespeed_modifier/human_carry)
	// NOVA EDIT ADDITION END

	if(ride_check_flags & RIDER_NEEDS_ARMS || (ride_check_flags & RIDING_TAUR)) // NOVA CHANGE - ORIGINAL: if(ride_check_flags & RIDER_NEEDS_ARMS) // piggyback
		human_parent.buckle_lying = 0
		// the riding mob is made nondense so they don't bump into any dense atoms the carrier is pulling,
		// since pulled movables are moved before buckled movables
		ADD_TRAIT(riding_mob, TRAIT_UNDENSE, VEHICLE_TRAIT)
	else if(ride_check_flags & CARRIER_NEEDS_ARM) // fireman
		if(riding_mob.has_quirk(/datum/quirk/featherweight))
			human_parent.buckle_lying = 0
			featherweight_used_hand = human_parent.get_active_hand()
			ADD_TRAIT(riding_mob, TRAIT_UNDENSE, VEHICLE_TRAIT)
		else
			human_parent.buckle_lying = 90

/datum/component/riding/creature/human/proc/get_featherweight_side_carry_offsets()
	if(featherweight_used_hand?.body_zone == BODY_ZONE_L_ARM)
		return list(
			TEXT_NORTH = list(-FEATHERWEIGHT_OFFSET, 0, MOB_BELOW_PIGGYBACK_LAYER),
			TEXT_SOUTH = list(FEATHERWEIGHT_OFFSET, 0, MOB_ABOVE_PIGGYBACK_LAYER),
			TEXT_EAST = list(FEATHERWEIGHT_SIDE_OFFSET, 0, MOB_BELOW_PIGGYBACK_LAYER),
			TEXT_WEST = list(-FEATHERWEIGHT_SIDE_OFFSET, 0, MOB_ABOVE_PIGGYBACK_LAYER),
		)

	return list(
		TEXT_NORTH = list(FEATHERWEIGHT_OFFSET, 0, MOB_BELOW_PIGGYBACK_LAYER),
		TEXT_SOUTH = list(-FEATHERWEIGHT_OFFSET, 0, MOB_ABOVE_PIGGYBACK_LAYER),
		TEXT_EAST = list(FEATHERWEIGHT_SIDE_OFFSET, 0, MOB_ABOVE_PIGGYBACK_LAYER),
		TEXT_WEST = list(-FEATHERWEIGHT_SIDE_OFFSET, 0, MOB_BELOW_PIGGYBACK_LAYER),
	)

/datum/component/riding/creature/human/proc/get_featherweight_fireman_offsets(oversized)
	if(oversized)
		return list(
			TEXT_NORTH = list(0, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_ABOVE_PIGGYBACK_LAYER),
			TEXT_SOUTH = list(0, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
			TEXT_EAST = list(0, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
			TEXT_WEST = list(0, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
		)

	return list(
		TEXT_NORTH = list(0, FEATHERWEIGHT_REGULAR_OFFSET, MOB_ABOVE_PIGGYBACK_LAYER),
		TEXT_SOUTH = list(0, FEATHERWEIGHT_REGULAR_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
		TEXT_EAST = list(0, FEATHERWEIGHT_REGULAR_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
		TEXT_WEST = list(0, FEATHERWEIGHT_REGULAR_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
	)

/datum/component/riding/creature/human/proc/get_featherweight_piggyback_offsets(oversized)
	if(oversized)
		return list(
			TEXT_NORTH = list(0, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_ABOVE_PIGGYBACK_LAYER),
			TEXT_SOUTH = list(0, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
			TEXT_EAST = list(-FEATHERWEIGHT_OVERSIZED_SIDE_OFFSET, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
			TEXT_WEST = list(FEATHERWEIGHT_OVERSIZED_SIDE_OFFSET, FEATHERWEIGHT_OVERSIZED_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
		)

	return list(
		TEXT_NORTH = list(0, FEATHERWEIGHT_REGULAR_OFFSET, MOB_ABOVE_PIGGYBACK_LAYER),
		TEXT_SOUTH = list(0, FEATHERWEIGHT_REGULAR_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
		TEXT_EAST = list(-FEATHERWEIGHT_REGULAR_OFFSET, FEATHERWEIGHT_REGULAR_SIDE_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
		TEXT_WEST = list(FEATHERWEIGHT_REGULAR_OFFSET, FEATHERWEIGHT_REGULAR_SIDE_OFFSET, MOB_BELOW_PIGGYBACK_LAYER),
	)

/datum/component/riding/creature/human/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	var/mob/living/carbon/human/seat = parent
	if(ride_check_flags & RIDING_TAUR)
		var/obj/item/organ/taur_body/taur_body = seat.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAUR)
		return taur_body.get_riding_offset(oversized = HAS_TRAIT(seat, TRAIT_OVERSIZED))
	else if(ride_check_flags & CARRIER_NEEDS_ARM)
		var/mob/living/living_offsetter = offsetter
		if(istype(living_offsetter) && living_offsetter.has_quirk(/datum/quirk/featherweight))
			return get_featherweight_side_carry_offsets()

		return get_featherweight_fireman_offsets(HAS_TRAIT(seat, TRAIT_OVERSIZED))
	else if(ride_check_flags & RIDER_NEEDS_ARMS)
		return get_featherweight_piggyback_offsets(HAS_TRAIT(seat, TRAIT_OVERSIZED))

#undef FEATHERWEIGHT_OFFSET
#undef FEATHERWEIGHT_SIDE_OFFSET
#undef FEATHERWEIGHT_OVERSIZED_OFFSET
#undef FEATHERWEIGHT_OVERSIZED_SIDE_OFFSET
#undef FEATHERWEIGHT_REGULAR_OFFSET
#undef FEATHERWEIGHT_REGULAR_SIDE_OFFSET
#undef FEATHERWEIGHT_FLIGHT_TRAIT
#undef FEATHERWEIGHT_FRAGILITY_MOD
#undef FEATHERWEIGHT_FLIGHT_DISABLE_TIME
#undef FEATHERWEIGHT_HIT_KNOCKDOWN_TIME
