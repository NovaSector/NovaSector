/// Interdyne Pharmaceuticals — Proprietary Implants
/// Organ-type cybernetic implants, printed directly from the Interdyne fabricator.
/// Inserted via surgery or Autodoc.

#define ORGAN_SLOT_CHEST_INJECTOR "chest_injector"
#define ORGAN_SLOT_LIVER_AID "liverdrive"
#define ORGAN_SLOT_LEG_DASH "leg_dashdrive"

// ---- INTERDYNE IMPLANT BASE TYPES ----

/// Base type for Interdyne chest implants
/obj/item/organ/cyberimp/chest/interdyne
	abstract_type = /obj/item/organ/cyberimp/chest/interdyne
	icon = 'modular_nova/modules/interdyne/icons/interdyne_implants.dmi'

/// Base type for Interdyne leg implants (no upstream leg cyberimp exists)
/obj/item/organ/cyberimp/leg
	name = "cybernetic leg implant"
	desc = "Implants for the legs."
	abstract_type = /obj/item/organ/cyberimp/leg
	zone = BODY_ZONE_R_LEG

/obj/item/organ/cyberimp/leg/interdyne
	abstract_type = /obj/item/organ/cyberimp/leg/interdyne
	icon = 'modular_nova/modules/interdyne/icons/interdyne_implants.dmi'

// ---- IP-A1 "RESUVOL" AUTO-INJECTOR ----

/// An organ-type cybernetic implant pre-loaded with chemicals via syringe before implantation.
/// Grants an action button to manually inject 5u per use. Works while unconscious.
/obj/item/organ/cyberimp/chest/interdyne/resuvol
	name = "Resuvol auto-injector implant"
	desc = "An Interdyne Pharmaceuticals cybernetic implant with an internal chemical reservoir. \
		Load with chemicals via syringe before surgical implantation. Once installed, press the action \
		button to inject a 5u dose. Works even while unconscious. Capacity: 15u, 3 doses."
	icon_state = "resuvol"
	slot = ORGAN_SLOT_CHEST_INJECTOR
	actions_types = list(/datum/action/item_action/organ_action/resuvol_inject)
	/// Maximum reagent capacity
	var/reservoir_max = 15
	/// How much to inject per trigger
	var/inject_amount = 5

	COOLDOWN_DECLARE(inject_cooldown)

/obj/item/organ/cyberimp/chest/interdyne/resuvol/Initialize(mapload)
	. = ..()
	create_reagents(reservoir_max, OPENCONTAINER)

/obj/item/organ/cyberimp/chest/interdyne/resuvol/Insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	reagents.flags &= ~OPENCONTAINER // Seal the reservoir once implanted

/obj/item/organ/cyberimp/chest/interdyne/resuvol/Remove(mob/living/carbon/donor, special, movement_flags)
	reagents.flags |= OPENCONTAINER // Unseal if removed so it can be refilled
	return ..()

/// Accept syringe interactions to load chemicals before implantation
/obj/item/organ/cyberimp/chest/interdyne/resuvol/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/reagent_containers/syringe))
		if(owner) // Already implanted — no syringe loading
			to_chat(user, span_warning("The implant's reservoir is sealed while implanted!"))
			return ITEM_INTERACT_BLOCKING
		return tool.interact_with_atom(src, user, modifiers)
	return ..()

/obj/item/organ/cyberimp/chest/interdyne/resuvol/ui_action_click()
	do_inject()

/obj/item/organ/cyberimp/chest/interdyne/resuvol/proc/do_inject()
	if(!owner)
		return
	if(!reagents?.total_volume)
		to_chat(owner, span_warning("Your Resuvol implant is empty!"))
		return
	if(!COOLDOWN_FINISHED(src, inject_cooldown))
		to_chat(owner, span_warning("Your Resuvol implant is still recharging!"))
		return
	COOLDOWN_START(src, inject_cooldown, 30 SECONDS)
	reagents.trans_to(owner, inject_amount)
	to_chat(owner, span_notice("You feel a sharp sting as your Resuvol implant injects chemicals!"))
	playsound(owner, 'sound/items/hypospray.ogg', 50, TRUE)
	if(!reagents.total_volume)
		to_chat(owner, span_warning("Your Resuvol implant clicks empty."))

/obj/item/organ/cyberimp/chest/interdyne/resuvol/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	// EMP forces an involuntary injection
	if(reagents?.total_volume)
		reagents.trans_to(owner, inject_amount)
		to_chat(owner, span_danger("Your Resuvol implant misfires, dumping chemicals into your bloodstream!"))

// ---- RESUVOL ACTION (works while unconscious) ----

/datum/action/item_action/organ_action/resuvol_inject
	name = "Inject (Resuvol)"
	check_flags = NONE // Works while unconscious

// ---- IP-F1 "HEPATIXOL" TOXIN FILTER ----

/obj/item/organ/cyberimp/chest/interdyne/hepatixol
	name = "Hepatixol toxin filter implant"
	desc = "An Interdyne Pharmaceuticals cybernetic implant that continuously filters toxins from the bloodstream and reinforces liver tissue. \
		The aggressive filtration slightly reduces chemical metabolism speed."
	icon_state = "hepatixol"
	slot = ORGAN_SLOT_LIVER_AID
	/// The metabolism efficiency multiplier applied while implanted (lower = slower metabolism)
	var/metabolism_penalty = 0.7

/obj/item/organ/cyberimp/chest/interdyne/hepatixol/Insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	receiver.metabolism_efficiency *= metabolism_penalty

/obj/item/organ/cyberimp/chest/interdyne/hepatixol/Remove(mob/living/carbon/donor, special, movement_flags)
	donor.metabolism_efficiency /= metabolism_penalty
	return ..()

/obj/item/organ/cyberimp/chest/interdyne/hepatixol/on_life(seconds_per_tick)
	. = ..()
	if(organ_flags & ORGAN_FAILING)
		return
	// Passively purge toxin damage
	if(owner.get_tox_loss() > 0)
		owner.adjust_tox_loss(-0.5 * seconds_per_tick, updating_health = TRUE, required_biotype = ALL)
	// Reduce liver organ damage passively
	var/obj/item/organ/liver/host_liver = owner.get_organ_slot(ORGAN_SLOT_LIVER)
	if(host_liver && host_liver.damage > 0)
		host_liver.apply_organ_damage(-0.25 * seconds_per_tick)

/obj/item/organ/cyberimp/chest/interdyne/hepatixol/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	// EMP causes a burst of toxin damage as the filter fails
	owner.adjust_tox_loss(8 / severity, updating_health = TRUE)
	to_chat(owner, span_warning("Your toxin filter sparks and sputters!"))

// ---- IP-L1 "PROPELLER" DASH IMPLANT ----

/// A leg cybernetic implant that grants a short-range directional dash on a cooldown.
/obj/item/organ/cyberimp/leg/interdyne/propeller
	name = "Propeller dash implant"
	desc = "An Interdyne Pharmaceuticals cybernetic leg implant with a micro-propulsion system. \
		Once installed, press the action button to dash forward in the direction you're facing. \
		Cooldown: 8 seconds."
	icon_state = "propeller"
	slot = ORGAN_SLOT_LEG_DASH
	actions_types = list(/datum/action/item_action/organ_action/propeller_dash)
	/// How many tiles the dash covers (actual distance is this minus 1)
	var/dash_distance = 5
	/// How fast the dash throw moves
	var/dash_speed = 3

	COOLDOWN_DECLARE(dash_cooldown)

/obj/item/organ/cyberimp/leg/interdyne/propeller/ui_action_click()
	do_dash()

/obj/item/organ/cyberimp/leg/interdyne/propeller/proc/do_dash()
	if(!owner)
		return
	if(!COOLDOWN_FINISHED(src, dash_cooldown))
		to_chat(owner, span_warning("Your Propeller implant is still recharging!"))
		return
	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		return

	var/atom/target = get_edge_target_turf(owner, owner.dir)
	ADD_TRAIT(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)
	if(owner.throw_at(target, dash_distance, dash_speed, spin = FALSE, diagonals_first = TRUE, callback = TRAIT_CALLBACK_REMOVE(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)))
		COOLDOWN_START(src, dash_cooldown, 8 SECONDS)
		playsound(owner, 'sound/effects/stealthoff.ogg', 50, TRUE, TRUE)
		owner.visible_message(span_warning("[owner] dashes forward!"))
		to_chat(owner, span_notice("Your Propeller implant propels you forward!"))
	else
		REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)
		to_chat(owner, span_warning("Something prevents you from dashing!"))

/obj/item/organ/cyberimp/leg/interdyne/propeller/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	// EMP forces an involuntary dash in a random direction
	var/random_dir = pick(GLOB.cardinals)
	owner.dir = random_dir
	var/atom/target = get_edge_target_turf(owner, random_dir)
	ADD_TRAIT(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)
	if(owner.throw_at(target, dash_distance, dash_speed, spin = TRUE, diagonals_first = TRUE, callback = TRAIT_CALLBACK_REMOVE(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)))
		to_chat(owner, span_danger("Your Propeller implant misfires, launching you uncontrollably!"))
	else
		REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)

// ---- PROPELLER ACTION ----

/datum/action/item_action/organ_action/propeller_dash
	name = "Dash (Propeller)"
	check_flags = AB_CHECK_CONSCIOUS
