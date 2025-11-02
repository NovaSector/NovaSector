#define REGEN_TIME (30 SECONDS) // () are important for order of operations. Fuck you too, byond
/obj/item/organ/stomach/protean
	name = "refactory"
	desc = "An extremely fragile factory used to recycle materials and create more nanite mass. Needed to facilitate the repair process on a collapsed Protean; it can be installed as a module in the rig, or as an organ."
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "refactory"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_NOHUNGER)

	/// How much max metal can we hold at any given time (In sheets). This isn't using nutrition code because nutrition code gets weird without livers.
	var/metal_max = PROTEAN_STOMACH_FULL
	/// How much metal are we holding currently (In sheets)
	var/metal = PROTEAN_STOMACH_FULL
	/// Multiplicative modifier to how fast we lose metal
	var/metabolism_modifier = 0.5
	COOLDOWN_DECLARE(starving_message)
	COOLDOWN_DECLARE(damage_delay)

/obj/item/organ/stomach/protean/oversized
	name = "massive refactory"
	desc = "A massive nanite manufacturing plant designed for oversized proteans. RIP AND TEAR YOUR HUGE NANITES! Stores significantly more metal and processes materials faster."
	icon_state = "refactory" // TODO: Make bigger sprite if desired
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_modifier = 0.35 // 30% more efficient than normal (0.5 -> 0.35)
	metal_max = PROTEAN_STOMACH_FULL * 1.5 // 15 metal instead of 10
	is_oversized = TRUE

/obj/item/organ/stomach/protean/oversized/Initialize(mapload)
	. = ..()
	metal = metal_max // Start with full capacity (15 metal)

/obj/item/organ/stomach/protean/Initialize(mapload)
	. = ..() // Call the rest of the proc
	metal = PROTEAN_STOMACH_FULL // NOVA EDIT: Proteans spawn with full energy instead of random

/obj/item/organ/stomach/protean/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(receiver, COMSIG_CARBON_ATTEMPT_EAT, PROC_REF(try_stomach_eat))
	RegisterSignal(receiver, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(damage_listener))
	RegisterSignal(src, COMSIG_STOMACH_AFTER_EAT, PROC_REF(after_eat))

/obj/item/organ/stomach/protean/on_mob_remove(mob/living/carbon/stomach_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(stomach_owner, COMSIG_CARBON_ATTEMPT_EAT)
	UnregisterSignal(stomach_owner, COMSIG_MOB_AFTER_APPLY_DAMAGE)
	UnregisterSignal(src, COMSIG_STOMACH_AFTER_EAT)

/obj/item/organ/stomach/protean/on_life(seconds_per_tick, times_fired)
	var/datum/species/protean/species = owner?.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(owner.loc == suit)
		return
	/// Zero out any nutrition. We do not use hunger in this species.
	for(var/datum/reagent/consumable/food in reagents.reagent_list)
		food.nutriment_factor = 0
	. = ..()
	handle_protean_hunger(owner, seconds_per_tick)

/obj/item/organ/stomach/protean/proc/handle_protean_hunger(mob/living/carbon/human/human, seconds_per_tick)
	if(!isprotean(owner))
		return
	if(isnull(owner.client)) // So we dont die from afk/crashing out
		return

	// If in low power mode, don't consume any metal - they're conserving energy
	if(owner.has_status_effect(/datum/status_effect/protean_low_power_mode/low_power))
		return

	if(metal > PROTEAN_STOMACH_FALTERING)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)
		var/hunger_modifier = metabolism_modifier
		// If we're high enough on metal we might try to heal or recover blood
		if(metal > PROTEAN_STOMACH_FULL * 0.3)
			if(owner.health < owner.maxHealth)
				var/healing_amount = -2
				hunger_modifier += 20
				if(!COOLDOWN_FINISHED(src, damage_delay))
					var/cooldown_left = (REGEN_TIME - COOLDOWN_TIMELEFT(src, damage_delay)) / REGEN_TIME
					hunger_modifier *= cooldown_left
					healing_amount *= cooldown_left
				owner.adjustBruteLoss(healing_amount, forced = TRUE)
				owner.adjustFireLoss(healing_amount, forced = TRUE)
			if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
				hunger_modifier += 100
				owner.blood_volume = min(owner.blood_volume + (((BLOOD_REGEN_FACTOR * PROTEAN_METABOLISM_RATE) * 0.05) * seconds_per_tick), BLOOD_VOLUME_NORMAL)
		metal -= clamp(((PROTEAN_STOMACH_FULL / PROTEAN_METABOLISM_RATE) * hunger_modifier * seconds_per_tick), 0, metal_max)
		return

	// Starvation state - cap damage to prevent pseudo-death, apply heavy debuffs instead
	// Only deal damage if health is above 50% to prevent accumulation
	if(owner.health > (owner.maxHealth * 0.5))
		owner.adjustBruteLoss(1.5, forced = TRUE)

	// Apply heavy slowdown and debuffs
	owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 3)

	if(COOLDOWN_FINISHED(src, starving_message))
		to_chat(owner, span_warning("You are starving! Your mass is cannibalizing itself!"))
		owner.adjust_temp_blindness(1 SECONDS)
		COOLDOWN_START(src, starving_message, 20 SECONDS)

/obj/item/organ/stomach/protean/proc/damage_listener()
	SIGNAL_HANDLER

	if(COOLDOWN_STARTED(src, damage_delay))
		COOLDOWN_RESET(src, damage_delay)
	COOLDOWN_START(src, damage_delay, REGEN_TIME)

/// Check to see if our metal storage is full before eating materials
/obj/item/organ/stomach/protean/proc/try_stomach_eat(mob/eater, atom/eating)
	SIGNAL_HANDLER

	// Check if eating a material stack (iron, glass, plasteel, etc.)
	if(istype(eating, /obj/item/stack))
		var/obj/item/stack/material = eating
		// Only allow eating materials with RCD matter value
		if(!material.matter_amount)
			return

		// Calculate nutritional value based on RCD matter amount
		// matter_amount ranges from 2 (rods) to 12+ (plasteel)
		// Convert to metal units: matter_amount / 4 = metal units per sheet
		var/nutrition_value = material.matter_amount / 4

		if(metal >= (metal_max - nutrition_value + 0.1))
			balloon_alert(owner, "storage full!")
			return COMSIG_CARBON_BLOCK_EAT

/// Process eaten materials based on their RCD matter value
/obj/item/organ/stomach/protean/after_eat(atom/edible)
	SIGNAL_HANDLER
	
	// Handle material stacks (sheets, rods, etc.)
	if(istype(edible, /obj/item/stack))
		var/obj/item/stack/material = edible
		// Only process materials with RCD matter value
		if(!material.matter_amount)
			return

		// Calculate nutrition from RCD matter amount
		// Iron (4) = 1 metal, Glass (4) = 1 metal, Plasteel (12) = 3 metal, etc.
		var/nutrition_value = material.matter_amount / 4
		var/old_metal = metal
		metal = clamp(metal + nutrition_value, 0, metal_max)

		// Calculate healing based on material value
		var/healing_amount = nutrition_value * 20 // 20 HP per metal unit
		owner.adjustBruteLoss(-healing_amount, forced = TRUE)

		var/metal_gained = metal - old_metal
		to_chat(owner, span_notice("You absorb [material], gaining [metal_gained] metal units. [nutrition_value > 1 ? "High quality material!" : ""]"))

		if(owner.health >= owner.maxHealth)
			owner.balloon_alert_to_viewers("fully restored!")
		else if(healing_amount > 0)
			owner.balloon_alert_to_viewers("nanites restored!")

#undef REGEN_TIME

