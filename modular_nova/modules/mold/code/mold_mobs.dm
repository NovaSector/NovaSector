// Radiation slime
#define RAD_PULSE_RANGE 300
#define RAD_PULSE_THRESHOLD 1

/mob/living/basic/slime/mold
	gold_core_spawnable = NO_SPAWN
	basic_mob_flags = DEL_ON_DEATH

/mob/living/basic/slime/mold/Initialize(mapload, new_colour, new_life_stage)
	. = ..()
	ai_controller?.set_blackboard_key(BB_SLIME_RABID, TRUE)

/**
 * TOXIC MOLD
 */
/datum/reagent/toxin/hunterspider/mold_slime
	name = "Mold Toxin"
	description = "A toxic chemical produced by mold slimes to weaken prey."

/mob/living/basic/slime/mold/toxic
	/// What the mob injects per bite
	var/inject_reagent = /datum/reagent/toxin/hunterspider/mold_slime
	/// How many units to inject per bite
	var/inject_amount = 2

/mob/living/basic/slime/mold/toxic/Initialize(mapload, new_colour, new_life_stage)
	. = ..(mapload, /datum/slime_type/purple)
	AddElement(/datum/element/venomous, inject_reagent, inject_amount)


/**
 * FIRE MOLD
 */
/mob/living/basic/slime/mold/fire
	/// The chance to apply fire stacks on melee hit
	var/ignite_chance = 20
	/// How many fire stacks to apply on hit
	var/additional_fire_stacks = 2

/mob/living/basic/slime/mold/fire/Initialize(mapload, new_colour, new_life_stage)
	var/slime_type = pick(/datum/slime_type/red, /datum/slime_type/orange)
	. = ..(mapload, slime_type)

/mob/living/basic/slime/mold/fire/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(!isliving(target))
		return

	var/mob/living/ignite_target = target
	if(prob(ignite_chance))
		ignite_target.adjust_fire_stacks(additional_fire_stacks)

	ignite_target.ignite_mob()


/**
 * DISEASE MOLD
 */
/mob/living/basic/slime/mold/disease
	/// The disease given on melee attacks
	var/datum/disease/given_disease = /datum/disease/cryptococcus

/mob/living/basic/slime/mold/disease/Initialize(mapload, new_colour, new_life_stage)
	. = ..(mapload, /datum/slime_type/oil)

/mob/living/basic/slime/mold/disease/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()

	if(!isliving(target))
		return

	var/mob/living/carbon/disease_target = target
	if(can_inject(disease_target))
		to_chat(disease_target, span_danger("[src] violently extrudes a spike from its gelatin, sucessfully puncturing it into your skin!"))
		disease_target.ForceContractDisease(new given_disease(), FALSE, TRUE)


/**
 * ELECTRIC MOLD
 */
/mob/living/basic/slime/mold/electric
	/// What the mob injects per bite
	var/inject_reagent = /datum/reagent/teslium
	/// How many units to inject per bite
	var/inject_amount = 2

/mob/living/basic/slime/mold/electric/Initialize(mapload, new_colour, new_life_stage)
	. = ..(mapload, /datum/slime_type/yellow)
	AddElement(/datum/element/venomous, inject_reagent, inject_amount)


/**
 * RADIATION MOLD
 */
/mob/living/basic/slime/mold/radiation
	/// The chance to irradiate on hit
	var/irradiate_chance = 33

/mob/living/basic/slime/mold/radiation/Initialize(mapload, new_colour, new_life_stage)
	. = ..(mapload, /datum/slime_type/green)

/mob/living/basic/slime/mold/radiation/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()

	if(!isliving(target))
		return

	var/mob/living/radiation_target = target
	if(prob(irradiate_chance))
		radiation_pulse(radiation_target, RAD_PULSE_RANGE, RAD_PULSE_THRESHOLD, FALSE, TRUE)


#undef RAD_PULSE_RANGE
#undef RAD_PULSE_THRESHOLD
