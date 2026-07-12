/datum/psionic_power/psiblade
	action_type = /datum/action/cooldown/psionic/psiblade

/datum/psionic_rank_variant/psiblade
	rank = PSIONIC_RANK_GAMMA
	variant_name = "machete"
	strain_gain = 10
	cooldown_time = 8 SECONDS
	/// Psiblade item spawned for this form.
	var/obj/item/psionic_blade/blade_type = /obj/item/psionic_blade/machete

/datum/psionic_rank_variant/psiblade/epsilon
	rank = PSIONIC_RANK_EPSILON
	variant_name = "knife"
	blade_type = /obj/item/psionic_blade/knife
	strain_gain = 5
	cooldown_time = 4 SECONDS

/datum/psionic_rank_variant/psiblade/delta
	rank = PSIONIC_RANK_DELTA
	variant_name = "sabre"
	blade_type = /obj/item/psionic_blade/sabre
	strain_gain = 14
	cooldown_time = 10 SECONDS

/datum/psionic_rank_variant/psiblade/beta
	rank = PSIONIC_RANK_BETA
	variant_name = "energy blade"
	blade_type = /obj/item/psionic_blade/energy
	strain_gain = 18
	cooldown_time = 12 SECONDS

/datum/psionic_rank_variant/psiblade/alpha
	rank = PSIONIC_RANK_ALPHA
	variant_name = "twinblade"
	blade_type = /obj/item/psionic_blade/twinblade
	strain_gain = 24
	cooldown_time = 16 SECONDS

/datum/action/cooldown/psionic/psiblade
	name = "Psiblade"
	desc = "Shape hardlight into a melee weapon. Higher ranks form stronger blades."
	button_icon_state = "psi_psiblade"
	point_cost = 1
	psionic_flags = PSIONIC_KINETIC|PSIONIC_THERMAL
	school = PSIONIC_SCHOOL_FLUX
	needs_hands = TRUE
	rank_variant_types = list(
		/datum/psionic_rank_variant/psiblade/epsilon,
		/datum/psionic_rank_variant/psiblade,
		/datum/psionic_rank_variant/psiblade/delta,
		/datum/psionic_rank_variant/psiblade/beta,
		/datum/psionic_rank_variant/psiblade/alpha,
	)
	/// Currently manifested psiblade.
	var/obj/item/psionic_blade/psiblade
	/// TRUE while the action is intentionally deleting its blade.
	var/removing_psiblade = FALSE

/datum/action/cooldown/psionic/psiblade/Remove(mob/living/remove_from)
	clear_psiblade(remove_from, TRUE)
	return ..()

/datum/action/cooldown/psionic/psiblade/IsAvailable(feedback = FALSE)
	if(has_active_psiblade())
		return TRUE

	return ..()

/datum/action/cooldown/psionic/psiblade/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return has_active_psiblade()

/datum/action/cooldown/psionic/psiblade/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE
	if(has_active_psiblade())
		return clear_psiblade(living_owner)

	return ..()

/datum/action/cooldown/psionic/psiblade/before_psionic(atom/target)
	var/mob/living/living_owner = owner
	if(!length(living_owner.get_empty_held_indexes()))
		living_owner.balloon_alert(living_owner, "free a hand!")
		to_chat(living_owner, span_warning("You need a free hand to shape [src]."))
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/psiblade/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!profile)
		return FALSE

	var/datum/psionic_rank_variant/selected_variant = get_selected_rank_variant(profile)
	var/datum/psionic_rank_variant/psiblade/form
	if(istype(selected_variant, /datum/psionic_rank_variant/psiblade))
		form = selected_variant
	if(!form?.blade_type)
		return FALSE

	var/obj/item/psionic_blade/new_psiblade = new form.blade_type(living_owner)
	profile.apply_manifestation_color(new_psiblade)
	if(!living_owner.put_in_hands(new_psiblade, del_on_fail = TRUE))
		living_owner.balloon_alert(living_owner, "free a hand!")
		to_chat(living_owner, span_warning("You need a free hand to shape [src]."))
		return FALSE

	psiblade = new_psiblade
	RegisterSignal(psiblade, COMSIG_QDELETING, PROC_REF(on_psiblade_deleted))
	RegisterSignal(psiblade, COMSIG_ITEM_DROPPED, PROC_REF(on_psiblade_dropped))
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_owner_life))
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_warning("[living_owner] shapes hardlight into [psiblade]."),
		span_purple("You shape [psiblade] into your hand."),
	)
	playsound(living_owner, 'sound/items/weapons/saberon.ogg', 35, TRUE)
	return TRUE

/datum/action/cooldown/psionic/psiblade/proc/has_active_psiblade()
	return psiblade && !QDELETED(psiblade)

/datum/action/cooldown/psionic/psiblade/proc/can_maintain_psiblade(mob/living/living_owner, datum/component/psionic_profile/profile)
	if(action_disabled || !istype(living_owner) || !profile)
		return FALSE
	if(living_owner.stat != CONSCIOUS)
		return FALSE
	if(HAS_TRAIT(living_owner, TRAIT_INCAPACITATED))
		return FALSE
	if(!can_use_hands(living_owner))
		return FALSE
	if(profile.is_burned_out())
		return FALSE

	return living_owner.can_cast_psionics(psionic_flags)

/datum/action/cooldown/psionic/psiblade/proc/on_owner_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!can_maintain_psiblade(living_owner, profile))
		clear_psiblade(living_owner)

/datum/action/cooldown/psionic/psiblade/proc/on_owner_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_psiblade(living_owner, TRUE)

/datum/action/cooldown/psionic/psiblade/proc/clear_psiblade(mob/living/living_owner, silent = FALSE)
	if(!has_active_psiblade())
		psiblade = null
		return FALSE

	if(!istype(living_owner))
		living_owner = owner
	removing_psiblade = TRUE
	UnregisterSignal(psiblade, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED))
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
		living_owner.temporarilyRemoveItemFromInventory(psiblade, force = TRUE)
		if(!silent)
			to_chat(living_owner, span_notice("The psiblade disperses."))
			playsound(living_owner, 'sound/items/weapons/saberoff.ogg', 35, TRUE)
	QDEL_NULL(psiblade)
	removing_psiblade = FALSE
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE

/datum/action/cooldown/psionic/psiblade/proc/on_psiblade_deleted(datum/source)
	SIGNAL_HANDLER

	psiblade = null
	if(removing_psiblade || QDELETED(owner))
		return
	var/mob/living/living_owner = owner
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

/datum/action/cooldown/psionic/psiblade/proc/on_psiblade_dropped(datum/source, mob/living/dropper)
	SIGNAL_HANDLER

	psiblade = null
	if(removing_psiblade || QDELETED(owner))
		return
	var/mob/living/living_owner = owner
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
	build_all_button_icons(UPDATE_BUTTON_STATUS)


/obj/item/psionic_blade
	name = "psionic machete"
	desc = "A shimmering blade of psionically-shaped hardlight."
	icon = 'modular_nova/modules/psionics/icons/psiblades.dmi'
	icon_state = "psiblade_gamma"
	inhand_icon_state = "psiblade_gamma"
	icon_angle = -45
	lefthand_file = 'modular_nova/modules/psionics/icons/psiblades_lefthand.dmi'
	righthand_file = 'modular_nova/modules/psionics/icons/psiblades_righthand.dmi'
	item_flags = ABSTRACT | DROPDEL | NO_BLOOD_ON_ITEM
	resistance_flags = INDESTRUCTIBLE | ACID_PROOF | FIRE_PROOF | LAVA_PROOF | UNACIDABLE
	force = 20
	throwforce = 0
	throw_speed = 0
	throw_range = 0
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/blade1.ogg'
	block_sound = 'sound/items/weapons/block_blade.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LIGHT_CYAN
	light_on = TRUE
	wound_bonus = 10
	exposed_wound_bonus = 20
	var/psionic_rank = PSIONIC_RANK_GAMMA
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/psionic_blade/Initialize(mapload)
	. = ..()
	add_atom_colour(PSIONIC_DEFAULT_COLOR, FIXED_COLOUR_PRIORITY)
	set_light_color(PSIONIC_DEFAULT_COLOR)
	ADD_TRAIT(src, TRAIT_NODROP, PSIONIC_TRAIT_SOURCE)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)

/obj/item/psionic_blade/knife
	name = "psionic knife"
	desc = "A compact hardlight knife."
	icon_state = "psiblade_epsilon"
	inhand_icon_state = "psiblade_epsilon"
	force = 10
	w_class = WEIGHT_CLASS_SMALL
	armour_penetration = 0
	block_chance = 0
	wound_bonus = 5
	exposed_wound_bonus = 15
	light_range = 1
	psionic_rank = PSIONIC_RANK_EPSILON

/obj/item/psionic_blade/machete
	desc = "A chopping hardlight blade."

/obj/item/psionic_blade/sabre
	name = "psionic sabre"
	desc = "A focused hardlight sabre."
	icon_state = "psiblade_delta"
	inhand_icon_state = "psiblade_delta"
	force = 25
	w_class = WEIGHT_CLASS_NORMAL
	armour_penetration = 20
	block_chance = 30
	psionic_rank = PSIONIC_RANK_DELTA

/obj/item/psionic_blade/energy
	name = "psionic energy blade"
	desc = "A lethal hardlight blade."
	icon_state = "psiblade_beta"
	inhand_icon_state = "psiblade_beta"
	force = 30
	armour_penetration = 35
	block_chance = 50
	wound_bonus = 0
	light_range = 3
	psionic_rank = PSIONIC_RANK_BETA

/obj/item/psionic_blade/twinblade
	name = "psionic twinblade"
	desc = "A double-ended hardlight blade."
	icon_state = "psiblade_alpha"
	inhand_icon_state = "psiblade_alpha"
	force = 40
	armour_penetration = 35
	block_chance = 75
	wound_bonus = -10
	light_range = 6
	psionic_rank = PSIONIC_RANK_ALPHA

/obj/item/psionic_blade/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	if(attack_type == LEAP_ATTACK)
		final_block_chance -= 25

	return ..()

/obj/item/psionic_blade/IsReflect()
	if(psionic_rank != PSIONIC_RANK_ALPHA)
		return FALSE

	return prob(block_chance)
