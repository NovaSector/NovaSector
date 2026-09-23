/obj/item/brain_processor/positronic
	/// Personality seed this posibrain starts with. Copied into `requested_personality` on init, since that var can't be overridden by subtypes.
	var/initial_personality
	/// Custom message shown to the user when they manually activate the posibrain. Falls back to the upstream message if null.
	var/begin_activation_message
	/// Custom message shown when a ghost enters the posibrain. Falls back to the upstream message if null.
	var/success_message
	/// Custom message shown when the posibrain stops searching without finding a ghost. Falls back to the upstream message if null.
	var/fail_message

/obj/item/brain_processor/positronic/Initialize(mapload, autoping = TRUE)
	// Set before the parent call so the initial ghost ping includes the personality.
	if(initial_personality)
		requested_personality = initial_personality
	return ..()

/// Ghost Role Posibrains

/obj/item/brain_processor/positronic/syndie
	req_access = list(ACCESS_SYNDICATE)
	faction = list(ROLE_SYNDICATE)
	initial_personality = "Syndicate Cyborg"
	posibrain_job_path = /datum/job/ds2

// Interdyne Planetary Base

/obj/item/brain_processor/positronic/syndie/interdyne
	name = "positronic brain"
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has a small stamp of the Interdyne Pharmaceuticals logo."
	initial_personality = "Interdyne Cyborg"
	posibrain_job_path = /datum/job/interdyne_planetary_base

/obj/item/brain_processor/positronic/syndie/interdyne/Initialize(mapload, autoping = TRUE)
	. = ..()
	qdel(radio)
	radio = new /obj/item/radio/borg/syndicate/ghost_role
	laws = new /datum/ai_laws/syndicate_override_interdyne()
	radio.set_broadcasting(FALSE)
	radio.set_on(FALSE)

// DS-2

/obj/item/brain_processor/positronic/syndie/ds2
	name = "positronic brain"
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has a small stamp of the Syndicate logo."
	initial_personality = "DS-2 Cyborg"

/obj/item/brain_processor/positronic/syndie/ds2/Initialize(mapload, autoping = TRUE)
	. = ..()
	qdel(radio)
	radio = new /obj/item/radio/borg/syndicate/ghost_role(src)
	radio.set_broadcasting(FALSE)
	radio.set_on(FALSE)
	laws = new /datum/ai_laws/syndicate_override_ds2()
