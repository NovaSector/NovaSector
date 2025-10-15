// Synth-specific emotes - ported from Bubberstation
// Original credits: Bubberstation contributors

/datum/emote/living/carbon/human/scary
	key = "scary"
	message = "emits a disconcerting tone."
	vary = FALSE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_scary.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	cooldown = 2 SECONDS

/datum/emote/living/carbon/human/scary/can_run_emote(mob/living/carbon/human/user, status_check = TRUE, intentional, params)
	// Check if user is a synthetic species
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user.dna?.species, /datum/species/synthetic))
		return FALSE
	return ..()

/datum/emote/living/carbon/human/error
	key = "error"
	message = "experiences a system error."
	vary = FALSE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_error.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	cooldown = 2 SECONDS

/datum/emote/living/carbon/human/error/can_run_emote(mob/living/carbon/human/user, status_check = TRUE, intentional, params)
	// Check if user is a synthetic species
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user.dna?.species, /datum/species/synthetic))
		return FALSE
	return ..()

/datum/emote/living/carbon/human/rstartup
	key = "startup"
	message = "chimes to life."
	vary = FALSE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_startup.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	cooldown = 2 SECONDS

/datum/emote/living/carbon/human/rstartup/can_run_emote(mob/living/carbon/human/user, status_check = TRUE, intentional, params)
	// Check if user is a synthetic species
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user.dna?.species, /datum/species/synthetic))
		return FALSE
	return ..()

/datum/emote/living/carbon/human/rshutdown
	key = "shutdown"
	message = "emits a nostalgic tone as they fall silent."
	vary = FALSE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_shutdown.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	cooldown = 2 SECONDS

/datum/emote/living/carbon/human/rshutdown/can_run_emote(mob/living/carbon/human/user, status_check = TRUE, intentional, params)
	// Check if user is a synthetic species
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user.dna?.species, /datum/species/synthetic))
		return FALSE
	return ..()

