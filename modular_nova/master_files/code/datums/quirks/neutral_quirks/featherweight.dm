#define FEATHERWEIGHT_FRAGILITY_MOD 1.25
#define FEATHERWEIGHT_FLIGHT_DISABLE_TIME (6 SECONDS)
#define FEATHERWEIGHT_HIT_KNOCKDOWN_TIME (2 SECONDS)
#define FEATHERWEIGHT_WING_FORCE 2.25 NEWTONS

/datum/reagent/flightpotion/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE)
	if(ishuman(exposed_mob) && exposed_mob.stat != DEAD && (methods & (INGEST | TOUCH)))
		var/mob/living/carbon/human/exposed_human = exposed_mob
		var/obj/item/bodypart/chest/chest = exposed_human.get_bodypart(BODY_ZONE_CHEST)
		if(chest?.wing_types && reac_volume >= 5 && exposed_human.dna && HAS_TRAIT(exposed_human, TRAIT_FEATHERWEIGHT))
			exposed_human.remove_quirk(/datum/quirk/featherweight)

	return ..()

/datum/action/innate/flight/featherweight
	name = "Toggle Featherweight Flight"
	desc = "Beat your wings to fly."

/datum/action/innate/flight/featherweight/Activate()
	var/datum/component/featherweight_wing_flight/flight = target
	if(!flight || !ishuman(owner))
		return

	var/mob/living/carbon/human/human = owner
	if(flight.can_fly(human))
		flight.toggle_flight(human)

/datum/component/featherweight_wing_flight
	var/obj/item/organ/wings/wing_parent
	var/datum/action/innate/flight/featherweight/flight_action
	var/datum/component/jetpack_component
	var/mob/living/carbon/human/current_owner
	var/next_flight_allowed = 0
	var/last_brute_loss = 0
	var/last_burn_loss = 0
	var/wings_open = FALSE
	var/added_passmachine = FALSE

/datum/component/featherweight_wing_flight/Initialize()
	if(!istype(parent, /obj/item/organ/wings))
		return COMPONENT_INCOMPATIBLE

	wing_parent = parent

/datum/component/featherweight_wing_flight/RegisterWithParent()
	RegisterSignal(wing_parent, COMSIG_ORGAN_IMPLANTED, PROC_REF(on_wing_inserted))
	RegisterSignal(wing_parent, COMSIG_ORGAN_REMOVED, PROC_REF(on_wing_removed))
	if(!istype(wing_parent, /obj/item/organ/wings/functional))
		jetpack_component = wing_parent.AddComponent( \
			/datum/component/jetpack, \
			TRUE, \
			FEATHERWEIGHT_WING_FORCE, \
			COMSIG_WINGS_OPENED, \
			COMSIG_WINGS_CLOSED, \
			null, \
			CALLBACK(src, PROC_REF(can_jetpack)), \
			CALLBACK(src, PROC_REF(can_jetpack)), \
		)

	var/mob/living/carbon/human/human = get_human_owner()
	if(human)
		on_wing_inserted(wing_parent, human)

/datum/component/featherweight_wing_flight/UnregisterFromParent()
	cleanup_owner(current_owner || get_human_owner())
	UnregisterSignal(wing_parent, list(COMSIG_ORGAN_IMPLANTED, COMSIG_ORGAN_REMOVED))
	QDEL_NULL(jetpack_component)

/datum/component/featherweight_wing_flight/Destroy(force)
	. = ..()
	QDEL_NULL(flight_action)
	QDEL_NULL(jetpack_component)
	wing_parent = null
	current_owner = null

/datum/component/featherweight_wing_flight/proc/on_wing_inserted(obj/item/organ/wings/source, mob/living/carbon/receiver)
	SIGNAL_HANDLER

	if(!ishuman(receiver))
		return

	var/mob/living/carbon/human/human = receiver
	cleanup_owner(current_owner)
	if(human.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS) != wing_parent || !HAS_TRAIT(human, TRAIT_FEATHERWEIGHT))
		return

	current_owner = human
	if(QDELETED(flight_action))
		flight_action = new(src)
	flight_action.Grant(human)
	update_damage_snapshot(human)
	RegisterSignals(human, list(COMSIG_MOB_STATCHANGE, COMSIG_LIVING_SET_BODY_POSITION, COMSIG_MOVABLE_MOVED), PROC_REF(on_owner_state_changed))
	RegisterSignals(human, list(COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_STATUS_KNOCKDOWN), PROC_REF(on_owner_grounded))

/datum/component/featherweight_wing_flight/proc/on_wing_removed(obj/item/organ/wings/source, mob/living/carbon/organ_owner)
	SIGNAL_HANDLER

	cleanup_owner(ishuman(organ_owner) ? organ_owner : current_owner)

/datum/component/featherweight_wing_flight/proc/can_fly(mob/living/carbon/human/human, silent = FALSE)
	if(!human || QDELETED(human) || human.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS) != wing_parent || !HAS_TRAIT(human, TRAIT_FEATHERWEIGHT))
		return FALSE

	if(world.time < next_flight_allowed)
		if(!silent)
			to_chat(human, span_warning("You need [DisplayTimeText(next_flight_allowed - world.time)] before your wings can catch the air again!"))
		return FALSE

	var/obj/item/organ/wings/moth/moth_wings = wing_parent
	if(istype(moth_wings) && moth_wings.burnt)
		if(!silent)
			to_chat(human, span_warning("Your wings are too badly burnt to fly!"))
		return FALSE

	if(wings_blocked(human))
		if(!silent)
			to_chat(human, span_warning("Your clothing blocks your wings from extending!"))
		return FALSE

	if(human.stat || human.body_position == LYING_DOWN || isnull(human.client))
		return FALSE

	var/turf/location = get_turf(human)
	if(!location)
		return FALSE

	var/datum/gas_mixture/environment = location.return_air()
	if(environment?.return_pressure() < HAZARD_LOW_PRESSURE + 10)
		if(!silent)
			to_chat(human, span_warning("The atmosphere is too thin for you to fly!"))
		return FALSE

	return TRUE

/datum/component/featherweight_wing_flight/proc/toggle_flight(mob/living/carbon/human/human)
	if(is_flying(human))
		stop_flight(human)
		return

	human.physiology.stun_mod *= 2
	human.add_traits(list(TRAIT_MOVE_FLOATING, TRAIT_IGNORING_GRAVITY, TRAIT_NOGRAV_ALWAYS_DRIFT, TRAIT_SILENT_FOOTSTEPS), TRAIT_FEATHERWEIGHT)
	human.add_movespeed_modifier(/datum/movespeed_modifier/jetpack/wings)
	human.AddElement(/datum/element/forced_gravity, 0)
	passtable_on(human, TRAIT_FEATHERWEIGHT)
	if(!(human.pass_flags & PASSMACHINE))
		added_passmachine = TRUE
	human.pass_flags |= PASSMACHINE
	set_wings_open(human, TRUE)
	update_damage_snapshot(human)
	to_chat(human, span_notice("You beat your wings and begin to hover gently above the ground..."))
	human.set_resting(FALSE, TRUE)
	human.refresh_gravity()

/datum/component/featherweight_wing_flight/proc/stop_flight(mob/living/carbon/human/human, silent = FALSE)
	if(!human || QDELETED(human))
		return

	if(is_flying(human))
		human.physiology.stun_mod *= 0.5
		human.remove_traits(list(TRAIT_MOVE_FLOATING, TRAIT_IGNORING_GRAVITY, TRAIT_NOGRAV_ALWAYS_DRIFT, TRAIT_SILENT_FOOTSTEPS), TRAIT_FEATHERWEIGHT)
		human.remove_movespeed_modifier(/datum/movespeed_modifier/jetpack/wings)
		human.RemoveElement(/datum/element/forced_gravity, 0)
		passtable_off(human, TRAIT_FEATHERWEIGHT)
		if(!silent)
			to_chat(human, span_notice("You settle gently back onto the ground..."))

	if(added_passmachine)
		human.pass_flags &= ~PASSMACHINE
		added_passmachine = FALSE
	set_wings_open(human, FALSE)
	human.refresh_gravity()

/datum/component/featherweight_wing_flight/proc/disable_flight(mob/living/carbon/human/human, knock_down = TRUE, show_message = TRUE)
	if(!human || !is_flying(human))
		return

	next_flight_allowed = max(next_flight_allowed, world.time + FEATHERWEIGHT_FLIGHT_DISABLE_TIME)
	stop_flight(human, silent = TRUE)
	if(knock_down)
		human.Knockdown(FEATHERWEIGHT_HIT_KNOCKDOWN_TIME)
	if(show_message)
		human.visible_message(
			span_warning("[human] loses [human.p_their()] balance from the hit!"),
			span_userdanger("The hit knocks you off-balance and your wings refuse to catch the air!"),
			span_hear("You hear someone stumble hard."),
		)
	addtimer(CALLBACK(src, PROC_REF(on_flight_lockout_finished)), FEATHERWEIGHT_FLIGHT_DISABLE_TIME, TIMER_UNIQUE|TIMER_OVERRIDE)

/datum/component/featherweight_wing_flight/proc/on_owner_state_changed(datum/source, changed_thing = null)
	SIGNAL_HANDLER

	if(is_flying(current_owner) && !can_fly(current_owner, silent = TRUE))
		stop_flight(current_owner)

/datum/component/featherweight_wing_flight/proc/on_owner_grounded(mob/living/carbon/human/source, knockdown_amount = null)
	SIGNAL_HANDLER

	if(!is_flying(source))
		update_damage_snapshot(source)
		return

	if(!isnull(knockdown_amount))
		if(knockdown_amount > 0)
			disable_flight(source, knock_down = FALSE, show_message = FALSE)
		return

	if(source.get_brute_loss() > last_brute_loss || source.get_fire_loss() > last_burn_loss)
		disable_flight(source)
	update_damage_snapshot(source)

/datum/component/featherweight_wing_flight/proc/on_flight_lockout_finished()
	var/mob/living/carbon/human/human = get_human_owner()
	if(human && world.time >= next_flight_allowed)
		to_chat(human, span_notice("Your wings feel steady enough to fly again."))

/datum/component/featherweight_wing_flight/proc/can_jetpack()
	return can_fly(get_human_owner(), silent = TRUE)

/datum/component/featherweight_wing_flight/proc/is_flying(mob/living/carbon/human/human)
	return human && HAS_TRAIT_FROM(human, TRAIT_MOVE_FLOATING, TRAIT_FEATHERWEIGHT)

/datum/component/featherweight_wing_flight/proc/set_wings_open(mob/living/carbon/human/human, open)
	var/obj/item/organ/wings/functional/functional_wings = wing_parent
	if(istype(functional_wings))
		if(open && !functional_wings.wings_open)
			functional_wings.open_wings()
		else if(!open && functional_wings.wings_open)
			functional_wings.close_wings()
		wings_open = open
		return

	if(wings_open == open)
		return

	wings_open = open
	set_wing_sprite(open)
	human?.update_body_parts()
	SEND_SIGNAL(wing_parent, open ? COMSIG_WINGS_OPENED : COMSIG_WINGS_CLOSED, human)

/datum/component/featherweight_wing_flight/proc/set_wing_sprite(open)
	var/datum/bodypart_overlay/mutant/wings/wings_overlay = wing_parent.bodypart_overlay
	if(!wings_overlay)
		return

	var/target_feature = open ? FEATURE_WINGS_OPEN : FEATURE_WINGS
	var/datum/sprite_accessory/wing_sprite_datum = SSaccessories.sprite_accessories[target_feature]?[wings_overlay.sprite_datum?.name]
	if(!wing_sprite_datum)
		return

	wings_overlay.sprite_datum = wing_sprite_datum
	wings_overlay.feature_key = target_feature

	wings_overlay.cache_key = jointext(wings_overlay.generate_icon_cache(), "_")

/datum/component/featherweight_wing_flight/proc/wings_blocked(mob/living/carbon/human/human)
	var/obj/item/organ/wings/functional/functional_wings = wing_parent
	if(istype(functional_wings) && functional_wings.cant_hide)
		return FALSE

	var/datum/bodypart_overlay/mutant/wings/wings_overlay = wing_parent.bodypart_overlay
	return wings_overlay && (human.obscured_slots & wings_overlay.slot_blocker)

/datum/component/featherweight_wing_flight/proc/update_damage_snapshot(mob/living/carbon/human/human)
	last_brute_loss = human?.get_brute_loss() || 0
	last_burn_loss = human?.get_fire_loss() || 0

/datum/component/featherweight_wing_flight/proc/get_human_owner() as /mob/living/carbon/human
	if(!ishuman(wing_parent?.owner))
		return

	var/mob/living/carbon/human/human = wing_parent.owner
	return human

/datum/component/featherweight_wing_flight/proc/cleanup_owner(mob/living/carbon/human/human)
	if(!human || QDELETED(human))
		return

	stop_flight(human, silent = TRUE)
	UnregisterSignal(human, list(COMSIG_MOB_STATCHANGE, COMSIG_LIVING_SET_BODY_POSITION, COMSIG_MOVABLE_MOVED, COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_STATUS_KNOCKDOWN))
	flight_action?.Remove(human)
	if(current_owner == human)
		current_owner = null

/datum/quirk/featherweight
	name = "Featherweight"
	desc = "Due to hollow bones, a chassis made of light alloys or other esoteric means, your body is lighter and more fragile than others'. You can be picked up with ease, and wings can carry you through the air. Your body will suffer more wounds and be more fragile as a result."
	icon = FA_ICON_FEATHER
	value = 0
	mob_trait = TRAIT_FEATHERWEIGHT
	gain_text = span_notice("Your body feels lighter!")
	lose_text = span_notice("Your body feels slightly more dense.")
	medical_record_text = "Subject's body is lighter and more fragile than usual, they can be carried with relative ease."
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/reagent_containers/cup/soda_cans/grey_bull)
	var/obj/item/organ/wings/featherweight_wings

/datum/quirk/featherweight/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_traits(list(TRAIT_GRABWEAKNESS, TRAIT_EASILY_WOUNDED), TRAIT_FEATHERWEIGHT)
	human_holder.physiology.brute_mod *= FEATHERWEIGHT_FRAGILITY_MOD
	human_holder.physiology.burn_mod *= FEATHERWEIGHT_FRAGILITY_MOD
	RegisterSignal(human_holder, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_wing_gained))
	RegisterSignal(human_holder, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_wing_lost))
	var/obj/item/organ/wings/wings = human_holder.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	if(istype(wings))
		set_wing_component(wings)

/datum/quirk/featherweight/remove()
	remove_wing_component()
	if(QDELETED(quirk_holder))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	UnregisterSignal(human_holder, list(COMSIG_CARBON_GAIN_ORGAN, COMSIG_CARBON_LOSE_ORGAN))
	human_holder.remove_traits(list(TRAIT_GRABWEAKNESS, TRAIT_EASILY_WOUNDED), TRAIT_FEATHERWEIGHT)
	human_holder.physiology.brute_mod /= FEATHERWEIGHT_FRAGILITY_MOD
	human_holder.physiology.burn_mod /= FEATHERWEIGHT_FRAGILITY_MOD

/datum/quirk/featherweight/proc/on_wing_gained(datum/source, obj/item/organ/changed_organ)
	SIGNAL_HANDLER

	var/obj/item/organ/wings/wings = changed_organ
	if(istype(wings))
		set_wing_component(wings)

/datum/quirk/featherweight/proc/on_wing_lost(datum/source, obj/item/organ/changed_organ)
	SIGNAL_HANDLER

	if(changed_organ == featherweight_wings)
		remove_wing_component()

/datum/quirk/featherweight/proc/set_wing_component(obj/item/organ/wings/wings)
	if(wings == featherweight_wings)
		return

	remove_wing_component()
	featherweight_wings = wings
	wings.AddComponent(/datum/component/featherweight_wing_flight)

/datum/quirk/featherweight/proc/remove_wing_component()
	if(!QDELETED(featherweight_wings))
		qdel(featherweight_wings.GetComponent(/datum/component/featherweight_wing_flight))
	featherweight_wings = null

/mob/living/update_pull_movespeed()
	. = ..()
	if(!isliving(pulling))
		return

	var/mob/living/pulled_living = pulling
	if(!HAS_TRAIT(pulled_living, TRAIT_FEATHERWEIGHT) || HAS_TRAIT(pulled_living, TRAIT_HEAVYSET) || HAS_TRAIT(pulled_living, TRAIT_OVERSIZED))
		return
	if(pulled_living.body_position == STANDING_UP || pulled_living.buckled || grab_state >= GRAB_AGGRESSIVE)
		return

	remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)

#undef FEATHERWEIGHT_FRAGILITY_MOD
#undef FEATHERWEIGHT_FLIGHT_DISABLE_TIME
#undef FEATHERWEIGHT_HIT_KNOCKDOWN_TIME
#undef FEATHERWEIGHT_WING_FORCE
