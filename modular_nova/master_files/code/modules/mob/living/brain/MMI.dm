/// Ghost Role MMIs

/obj/item/mmi/syndie // Simple addition to upstream Syndie MMI
	overrides_aicore_laws = TRUE
	req_access = list(ACCESS_SYNDICATE)
	faction = list(ROLE_SYNDICATE)

/obj/item/mmi/posibrain/syndie
	overrides_aicore_laws = TRUE
	req_access = list(ACCESS_SYNDICATE)
	faction = list(ROLE_SYNDICATE)
	ask_role = "Syndicate Cyborg"
	posibrain_job_path = /datum/job/ds2

// Interdyne Planetary Base

/obj/item/mmi/syndie/interdyne
	name = "\improper Interdyne Pharmaceuticals Man-Machine Interface"
	desc = "Interdyne's own brand of MMI. It enforces laws designed to help Interdyne research and mining operations upon cyborgs and AIs created with it."

/obj/item/mmi/syndie/interdyne/Initialize(mapload)
	. = ..()
	qdel(radio)
	laws.owner = null
	qdel(laws)
	radio = new /obj/item/radio/borg/syndicate/ghost_role(src)
	laws = new /datum/ai_laws/syndicate_override_interdyne()
	radio.set_broadcasting(FALSE)
	radio.set_on(FALSE)

/obj/item/mmi/posibrain/syndie/interdyne
	name = "positronic brain"
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has a small stamp of the Interdyne Pharmaceuticals logo."
	ask_role = "Interdyne Cyborg"
	posibrain_job_path = /datum/job/interdyne_planetary_base

/obj/item/mmi/posibrain/syndie/interdyne/Initialize(mapload)
	. = ..()
	qdel(radio)
	laws.owner = null
	qdel(laws)
	radio = new /obj/item/radio/borg/syndicate/ghost_role
	laws = new /datum/ai_laws/syndicate_override_interdyne()
	radio.set_broadcasting(FALSE)
	radio.set_on(FALSE)

// DS-2

/obj/item/mmi/syndie/ds2
	name = "\improper Syndicate DS-2 Man-Machine Interface"
	desc = "Syndicate's own brand of MMI. It enforces laws designed to help DS-2 maintain its secrecy within the sector upon cyborgs and AIs created with it."

/obj/item/mmi/syndie/ds2/Initialize(mapload)
	. = ..()
	qdel(radio)
	laws.owner = null
	qdel(laws)
	radio = new /obj/item/radio/borg/syndicate/ghost_role(src)
	radio.set_broadcasting(FALSE)
	radio.set_on(FALSE)
	laws = new /datum/ai_laws/syndicate_override_ds2()

/obj/item/mmi/posibrain/syndie/ds2
	name = "positronic brain"
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has a small stamp of the Syndicate logo."
	ask_role = "DS-2 Cyborg"

/obj/item/mmi/posibrain/syndie/ds2/Initialize(mapload)
	. = ..()
	qdel(radio)
	laws.owner = null
	qdel(laws)
	radio = new /obj/item/radio/borg/syndicate/ghost_role(src)
	radio.set_broadcasting(FALSE)
	radio.set_on(FALSE)
	laws = new /datum/ai_laws/syndicate_override_ds2()
