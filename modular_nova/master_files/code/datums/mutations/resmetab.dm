#define RESTMETA_BRUTE_THRESHOLD 25
#define RESTMETA_BRUTE_AMOUNT -0.4
#define RESTMETA_BURN_THRESHOLD 25
#define RESTMETA_BURN_AMOUNT -0.2
#define RESTMETA_TOX_THRESHOLD 20
#define RESTMETA_TOX_AMOUNT -0.1

/datum/mutation/restorative_metabolism
	name = "Restorative Metabolism"
	desc = "Your body possesses a differentiated reconstructive ability, allowing you to slowly recover from light to moderate injuries. Critical injuries, wounds, and genetic damage will still require medical attention."
	text_gain_indication = span_notice("You feel a surge of reconstructive vitality coursing through your")
	text_lose_indication = span_notice("You sense your enhanced reconstructive ability fading away...")
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MAJOR
	difficulty = 16
	synchronizer_coeff = 1
	power_coeff = 1
	var /mob/living/carbon/human/our_being = null

/datum/mutation/restorative_metabolism/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	our_being = owner
	START_PROCESSING(SSobj, src)

/datum/mutation/restorative_metabolism/on_losing(mob/living/carbon/human/owner)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/datum/mutation/restorative_metabolism/process(seconds_per_tick)
	// Mutation holder must be injured
	if(our_being.health >= our_being.maxHealth)
		// Do nothing
		return

	// Define health needing updates
	var/need_mob_update = FALSE
	// Check brute threshold
	if(our_being.get_brute_loss() <= RESTMETA_BRUTE_THRESHOLD*(1/synchronizer_coeff))
		need_mob_update += our_being.adjust_brute_loss(RESTMETA_BRUTE_AMOUNT*power_coeff * seconds_per_tick, updating_health = FALSE)

	// Check burn threshold
	if(our_being.get_fire_loss() <= RESTMETA_BURN_THRESHOLD*(1/synchronizer_coeff))
		need_mob_update += our_being.adjust_fire_loss(RESTMETA_BURN_AMOUNT*power_coeff * seconds_per_tick, updating_health = FALSE)

	// Check tox threshold
	if(our_being.get_tox_loss() <= RESTMETA_TOX_THRESHOLD*(1/synchronizer_coeff))
		need_mob_update += our_being.adjust_tox_loss(RESTMETA_TOX_AMOUNT*power_coeff * seconds_per_tick, updating_health = FALSE, forced = TRUE)

	// Check if healing will be applied
	if(need_mob_update)
		// Update health
		our_being.updatehealth()

#undef RESTMETA_BRUTE_THRESHOLD
#undef RESTMETA_BRUTE_AMOUNT
#undef RESTMETA_BURN_THRESHOLD
#undef RESTMETA_BURN_AMOUNT
#undef RESTMETA_TOX_THRESHOLD
#undef RESTMETA_TOX_AMOUNT
