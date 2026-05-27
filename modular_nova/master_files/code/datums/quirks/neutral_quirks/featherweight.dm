/datum/controller/subsystem/processing/quirks/Initialize()
	GLOB.quirk_blacklist += list(list(/datum/quirk/featherweight, /datum/quirk/oversized))
	GLOB.quirk_string_blacklist = generate_quirk_string_blacklist()

	get_quirks()
	return SS_INIT_SUCCESS

#define FEATHERWEIGHT_FLIGHT_TRAIT "featherweight_flight"
#define FEATHERWEIGHT_CARRY_TRAIT "featherweight_carry"
#define FEATHERWEIGHT_FRAGILITY_MOD 1.25
#define FEATHERWEIGHT_FLIGHT_DISABLE_TIME (6 SECONDS)
#define FEATHERWEIGHT_HIT_KNOCKDOWN_TIME (2 SECONDS)

/datum/reagent/flightpotion/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE)
	if(ishuman(exposed_mob) && exposed_mob.stat != DEAD && (methods & (INGEST | TOUCH)))
		var/mob/living/carbon/human/exposed_human = exposed_mob
		var/obj/item/bodypart/chest/chest = exposed_human.get_bodypart(BODY_ZONE_CHEST)
		if(chest?.wing_types && reac_volume >= 5 && exposed_human.dna && exposed_human.has_quirk(/datum/quirk/featherweight))
			exposed_human.remove_quirk(/datum/quirk/featherweight)

	return ..()

/datum/action/innate/flight/featherweight
	name = "Toggle Featherweight Flight"
	desc = "Beat your wings to fly."

/datum/bodypart_overlay/mutant/wings/functional/featherweight
	var/closed_accessory_name
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
	var/datum/quirk/featherweight/featherweight_quirk
	var/next_flight_allowed = 0
	var/last_brute_loss = 0
	var/last_burn_loss = 0
	var/obj/item/organ/wings/original_wings
	var/added_passmachine = FALSE

/obj/item/organ/wings/functional/featherweight/Destroy()
	if(ishuman(owner))
		var/mob/living/carbon/human/human = owner
		cleanup_featherweight_flight(human)
	featherweight_quirk = null
	original_wings = null
	return ..()

/obj/item/organ/wings/functional/featherweight/grind_results()
	return null

/obj/item/organ/wings/functional/featherweight/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(fly))
		fly = new /datum/action/innate/flight/featherweight
	. = ..()
	if(!ishuman(receiver))
		return

	var/mob/living/carbon/human/human = receiver
	last_brute_loss = human.get_brute_loss()
	last_burn_loss = human.get_fire_loss()
	RegisterSignals(human, list(
		COMSIG_MOB_STATCHANGE,
		COMSIG_LIVING_SET_BODY_POSITION,
		COMSIG_MOVABLE_MOVED,
	), PROC_REF(on_featherweight_state_changed))
	RegisterSignals(human, list(
		COMSIG_LIVING_HEALTH_UPDATE,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
	), PROC_REF(on_featherweight_grounding_signal))
	sync_featherweight_flight(human)

/obj/item/organ/wings/functional/featherweight/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	if(organ_owner && wings_open && !HAS_TRAIT_FROM(organ_owner, TRAIT_MOVE_FLOATING, SPECIES_FLIGHT_TRAIT))
		close_wings()
	. = ..()
	if(ishuman(organ_owner))
		var/mob/living/carbon/human/human = organ_owner
		cleanup_featherweight_flight(human)

/obj/item/organ/wings/functional/featherweight/can_fly(silent = FALSE)
	if(!ishuman(owner))
		return FALSE

	var/mob/living/carbon/human/human = owner
	if(!featherweight_quirk || QDELETED(featherweight_quirk) || QDELETED(human) || featherweight_quirk.quirk_holder != human)
		return FALSE

	if(world.time < next_flight_allowed)
		if(!silent)
			to_chat(human, span_warning("You need [DisplayTimeText(next_flight_allowed - world.time)] before your wings can catch the air again!"))
		return FALSE

	var/obj/item/organ/wings/moth/original_moth_wings = original_wings
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
	sync_featherweight_flight(human)

/obj/item/organ/wings/functional/featherweight/proc/copy_appearance_from(obj/item/organ/wings/source_wings)
	name = source_wings.name
	desc = source_wings.desc

	var/datum/bodypart_overlay/mutant/source_overlay = source_wings.bodypart_overlay
	var/datum/bodypart_overlay/mutant/wings/functional/featherweight/featherweight_overlay = bodypart_overlay
	if(source_overlay && source_wings.bodypart_owner)
		source_overlay.inherit_color(source_wings.bodypart_owner, TRUE)
	var/accessory_name = source_overlay?.sprite_datum?.name || get_consistent_feature_entry(featherweight_overlay.get_global_feature_list())
	featherweight_overlay.set_closed_appearance(accessory_name, source_overlay?.draw_color, source_overlay?.dye_color)

/obj/item/organ/wings/functional/featherweight/proc/on_featherweight_state_changed(datum/source, changed_thing = null)
	SIGNAL_HANDLER

	if(is_featherweight_flying() && !can_fly(silent = TRUE))
		stop_featherweight_flight()

/obj/item/organ/wings/functional/featherweight/proc/on_featherweight_grounding_signal(mob/living/carbon/human/source, knockdown_amount = null)
	SIGNAL_HANDLER

	if(!isnull(knockdown_amount))
		if(knockdown_amount > 0)
			disable_featherweight_flight(source, knock_down = FALSE, show_message = FALSE)
		return

	var/current_brute_loss = source.get_brute_loss()
	var/current_burn_loss = source.get_fire_loss()
	if(current_brute_loss > last_brute_loss || current_burn_loss > last_burn_loss)
		disable_featherweight_flight(source)
	last_brute_loss = current_brute_loss
	last_burn_loss = current_burn_loss

/obj/item/organ/wings/functional/featherweight/proc/is_featherweight_flying(mob/living/carbon/human/human)
	if(!human)
		if(!ishuman(owner))
			return FALSE
		human = owner
	return human && HAS_TRAIT_FROM(human, TRAIT_MOVE_FLOATING, SPECIES_FLIGHT_TRAIT)

/obj/item/organ/wings/functional/featherweight/proc/sync_featherweight_flight(mob/living/carbon/human/human)
	if(!human)
		if(!ishuman(owner))
			return
		human = owner
	if(QDELETED(human))
		return

	if(is_featherweight_flying(human))
		ADD_TRAIT(human, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)
		if(!(human.pass_flags & PASSMACHINE))
			added_passmachine = TRUE
		human.pass_flags |= PASSMACHINE
		return

	REMOVE_TRAIT(human, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)
	if(added_passmachine)
		human.pass_flags &= ~PASSMACHINE
		added_passmachine = FALSE

/obj/item/organ/wings/functional/featherweight/proc/stop_featherweight_flight(mob/living/carbon/human/human)
	if(!human)
		if(!ishuman(owner))
			return
		human = owner

	if(HAS_TRAIT_FROM(human, TRAIT_MOVE_FLOATING, SPECIES_FLIGHT_TRAIT))
		toggle_flight(human)
		return

	if(wings_open)
		close_wings()
	sync_featherweight_flight(human)

/obj/item/organ/wings/functional/featherweight/proc/disable_featherweight_flight(mob/living/carbon/human/human, knock_down = TRUE, show_message = TRUE)
	if(!human)
		if(!ishuman(owner))
			return
		human = owner
	if(QDELETED(human) || !is_featherweight_flying(human))
		return

	next_flight_allowed = max(next_flight_allowed, world.time + FEATHERWEIGHT_FLIGHT_DISABLE_TIME)
	stop_featherweight_flight(human)

	if(knock_down)
		human.Knockdown(FEATHERWEIGHT_HIT_KNOCKDOWN_TIME)
	if(show_message)
		human.visible_message(
			span_warning("[human] loses [human.p_their()] balance from the hit!"),
			span_userdanger("The hit knocks you off-balance and your wings refuse to catch the air!"),
			span_hear("You hear someone stumble hard."),
		)
	addtimer(CALLBACK(src, PROC_REF(on_flight_lockout_finished)), FEATHERWEIGHT_FLIGHT_DISABLE_TIME, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/item/organ/wings/functional/featherweight/proc/on_flight_lockout_finished()
	if(QDELETED(owner) || world.time < next_flight_allowed)
		return

	to_chat(owner, span_notice("Your wings feel steady enough to fly again."))

/obj/item/organ/wings/functional/featherweight/proc/cleanup_featherweight_flight(mob/living/carbon/human/human)
	UnregisterSignal(human, list(
		COMSIG_MOB_STATCHANGE,
		COMSIG_LIVING_SET_BODY_POSITION,
		COMSIG_MOVABLE_MOVED,
		COMSIG_LIVING_HEALTH_UPDATE,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
	))
	REMOVE_TRAIT(human, TRAIT_SILENT_FOOTSTEPS, FEATHERWEIGHT_FLIGHT_TRAIT)
	if(added_passmachine)
		human.pass_flags &= ~PASSMACHINE
		added_passmachine = FALSE

/datum/quirk/featherweight
	name = "Featherweight"
	desc = "Due to hollow bones, a chassis made of light alloys or other esoteric means, your body is lighter and more fragile than others'. You can be picked up with ease, and wings can carry you through the air. Your body will suffer more wounds and be more fragile as a result."
	icon = FA_ICON_FEATHER
	value = 0
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = span_notice("Your body feels lighter!")
	lose_text = span_notice("Your body feels slightly more dense.")
	medical_record_text = "Subject's body is lighter and more fragile than usual, they can be carried with relative ease."
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/reagent_containers/cup/soda_cans/grey_bull)
	var/obj/item/organ/wings/functional/featherweight/featherweight_wings
	var/swapping_featherweight_wings = FALSE

/datum/quirk/featherweight/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	ADD_TRAIT(human_holder, TRAIT_EASILY_WOUNDED, FEATHERWEIGHT_FLIGHT_TRAIT)
	human_holder.physiology.brute_mod *= FEATHERWEIGHT_FRAGILITY_MOD
	human_holder.physiology.burn_mod *= FEATHERWEIGHT_FRAGILITY_MOD

	RegisterSignals(human_holder, list(
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_LOSE_ORGAN,
	), PROC_REF(on_featherweight_organ_changed))
	update_featherweight_wings()

/datum/quirk/featherweight/remove()
	cleanup_featherweight_flight()
	return ..()

/datum/quirk/featherweight/proc/on_featherweight_organ_changed(datum/source, changed_thing = null)
	SIGNAL_HANDLER

	if(swapping_featherweight_wings || !istype(changed_thing, /obj/item/organ/wings))
		return

	update_featherweight_wings()

/datum/quirk/featherweight/proc/update_featherweight_wings()
	if(QDELETED(quirk_holder) || swapping_featherweight_wings)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/wings/wings = get_featherweight_wings()
	if(istype(wings, /obj/item/organ/wings/functional/featherweight))
		featherweight_wings = wings
		featherweight_wings.featherweight_quirk = src
		featherweight_wings.sync_featherweight_flight(human_holder)
		return

	if(istype(wings, /obj/item/organ/wings/functional))
		if(!QDELETED(featherweight_wings?.original_wings))
			featherweight_wings.original_wings.forceMove(get_turf(human_holder))
		QDEL_NULL(featherweight_wings)
		featherweight_wings = null
		return

	if(wings)
		replace_with_featherweight_wings(wings)
		return

	restore_featherweight_wings()

/datum/quirk/featherweight/proc/replace_with_featherweight_wings(obj/item/organ/wings/wings)
	if(QDELETED(wings) || istype(wings, /obj/item/organ/wings/functional))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/wings/functional/featherweight/new_wings = new()
	new_wings.featherweight_quirk = src
	new_wings.original_wings = wings
	new_wings.copy_appearance_from(wings)

	swapping_featherweight_wings = TRUE
	wings.Remove(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)
	wings.moveToNullspace()
	new_wings.Insert(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)
	swapping_featherweight_wings = FALSE

	featherweight_wings = new_wings
	human_holder.update_body_parts()

/datum/quirk/featherweight/proc/restore_featherweight_wings()
	if(swapping_featherweight_wings)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/wings/functional/featherweight/current_wings = get_featherweight_functional_wings()
	var/obj/item/organ/wings/functional/featherweight/stored_wings = current_wings || featherweight_wings
	var/obj/item/organ/wings/original_wings = stored_wings?.original_wings
	if(!stored_wings && !original_wings)
		return

	swapping_featherweight_wings = TRUE
	if(current_wings)
		current_wings.stop_featherweight_flight(human_holder)
		current_wings.Remove(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)

	var/obj/item/organ/wings/current_slot_wings = get_featherweight_wings()
	if(original_wings && !QDELETED(original_wings))
		if(!current_slot_wings)
			original_wings.Insert(human_holder, special = TRUE, movement_flags = KEEP_IN_MUTANT_BODYPARTS)
		else
			original_wings.forceMove(get_turf(human_holder))

	if(stored_wings && !QDELETED(stored_wings))
		stored_wings.original_wings = null
		stored_wings.featherweight_quirk = null
		qdel(stored_wings)

	featherweight_wings = null
	swapping_featherweight_wings = FALSE
	human_holder.update_body_parts()

/datum/quirk/featherweight/proc/get_featherweight_wings()
	var/mob/living/carbon/human/human_holder = quirk_holder
	return human_holder?.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)

/datum/quirk/featherweight/proc/get_featherweight_functional_wings() as /obj/item/organ/wings/functional/featherweight
	var/obj/item/organ/wings/functional/featherweight/wings = get_featherweight_wings()
	if(istype(wings))
		return wings

/datum/quirk/featherweight/proc/cleanup_featherweight_flight()
	if(QDELETED(quirk_holder))
		if(!QDELETED(featherweight_wings?.original_wings))
			qdel(featherweight_wings.original_wings)
		QDEL_NULL(featherweight_wings)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	UnregisterSignal(human_holder, list(
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_LOSE_ORGAN,
	))

	restore_featherweight_wings()

	REMOVE_TRAIT(human_holder, TRAIT_EASILY_WOUNDED, FEATHERWEIGHT_FLIGHT_TRAIT)
	human_holder.physiology.brute_mod /= FEATHERWEIGHT_FRAGILITY_MOD
	human_holder.physiology.burn_mod /= FEATHERWEIGHT_FRAGILITY_MOD

/mob/living/carbon/human/fireman_carry(mob/living/carbon/target)
	if(target?.has_quirk(/datum/quirk/featherweight) && !HAS_TRAIT(src, TRAIT_QUICKER_CARRY))
		ADD_TRAIT(src, TRAIT_QUICKER_CARRY, FEATHERWEIGHT_CARRY_TRAIT)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/datum, remove_traits), list(TRAIT_QUICKER_CARRY), FEATHERWEIGHT_CARRY_TRAIT), 0)

	return ..()

/mob/living/update_pull_movespeed()
	. = ..()
	if(!isliving(pulling))
		return

	var/mob/living/pulled_living = pulling
	if(!pulled_living.has_quirk(/datum/quirk/featherweight) || HAS_TRAIT(pulled_living, TRAIT_HEAVYSET) || HAS_TRAIT(pulled_living, TRAIT_OVERSIZED))
		return
	if(pulled_living.body_position == STANDING_UP || pulled_living.buckled || grab_state >= GRAB_AGGRESSIVE)
		return

	remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)

#undef FEATHERWEIGHT_CARRY_TRAIT
#undef FEATHERWEIGHT_FLIGHT_TRAIT
#undef FEATHERWEIGHT_FRAGILITY_MOD
#undef FEATHERWEIGHT_FLIGHT_DISABLE_TIME
#undef FEATHERWEIGHT_HIT_KNOCKDOWN_TIME
