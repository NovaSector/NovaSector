#define RESTMETA_BRUTE_THRESHOLD 40
#define RESTMETA_BRUTE_AMOUNT -0.3
#define RESTMETA_BURN_THRESHOLD 40
#define RESTMETA_BURN_AMOUNT -0.2
#define RESTMETA_TOX_THRESHOLD 20
#define RESTMETA_TOX_AMOUNT -0.1
#define RESTMETA_HUNGRY_MOD 1.2 // 20% more hungry

/datum/mutation/restorative_metabolism
	name = "Restorative Metabolism"
	desc = "Your body possesses a differentiated reconstructive ability, allowing you to slowly recover from light to moderate injuries while it's well fed at the cost of a higher metabolism. Critical injuries, wounds, and radiation damage will still require medical attention."
	text_gain_indication = span_notice("You feel a surge of reconstructive vitality coursing through your body.")
	text_lose_indication = span_notice("You sense your enhanced reconstructive ability fading away...")
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MAJOR
	difficulty = 16
	energy_coeff = 1
	power_coeff = 1
	synchronizer_coeff = 1
	/// The mutation's power coefficient.
	var/power_coefficient = 1
	/// The mutation's synchronizer coefficient.
	var/synchronizer_coefficient = 1

/datum/mutation/restorative_metabolism/on_acquiring(mob/living/carbon/human/owner)
	. = ..()

	if(istype(owner))
		owner.physiology.hunger_mod *= RESTMETA_HUNGRY_MOD

	START_PROCESSING(SSobj, src)

/datum/mutation/restorative_metabolism/setup()
	. = ..()
	var/datum/mutation/restorative_metabolism/to_modify = .

	if(!istype(to_modify)) // null or invalid
		return

	// doubles healing power if strengthened. (1.5->2 with power chromosome)
	to_modify.power_coefficient = ceil(GET_MUTATION_POWER(src))
	// doubles threshold if synchronized. (0.5 with synchronizer chromosome)
	to_modify.synchronizer_coefficient = GET_MUTATION_SYNCHRONIZER(src)

/datum/mutation/restorative_metabolism/on_losing(mob/living/carbon/human/owner)
	. = ..()

	if(istype(owner))
		owner.physiology.hunger_mod /= RESTMETA_HUNGRY_MOD

	STOP_PROCESSING(SSobj, src)

/datum/mutation/restorative_metabolism/process(seconds_per_tick)
	// Mutation holder must be injured and not starving
	if(owner.health >= owner.maxHealth || owner.nutrition <= NUTRITION_LEVEL_STARVING)
		// Do nothing
		return

	// Define health needing updates
	var/need_mob_update = FALSE
	// Check brute threshold
	if(owner.get_brute_loss() <= RESTMETA_BRUTE_THRESHOLD*(1/synchronizer_coefficient))
		need_mob_update += owner.adjust_brute_loss(RESTMETA_BRUTE_AMOUNT * power_coefficient * seconds_per_tick, updating_health = FALSE)

	// Check burn threshold
	if(owner.get_fire_loss() <= RESTMETA_BURN_THRESHOLD*(1/synchronizer_coefficient))
		need_mob_update += owner.adjust_fire_loss(RESTMETA_BURN_AMOUNT * power_coefficient * seconds_per_tick, updating_health = FALSE)

	// Check tox threshold
	if(owner.get_tox_loss() <= RESTMETA_TOX_THRESHOLD*(1/synchronizer_coefficient))
		need_mob_update += owner.adjust_tox_loss(RESTMETA_TOX_AMOUNT * power_coefficient * seconds_per_tick, updating_health = FALSE, forced = TRUE)

	// Check if healing will be applied
	if(need_mob_update)
		// Update health
		owner.updatehealth()

#undef RESTMETA_BRUTE_THRESHOLD
#undef RESTMETA_BRUTE_AMOUNT
#undef RESTMETA_BURN_THRESHOLD
#undef RESTMETA_BURN_AMOUNT
#undef RESTMETA_TOX_THRESHOLD
#undef RESTMETA_TOX_AMOUNT
#undef RESTMETA_HUNGRY_MOD
