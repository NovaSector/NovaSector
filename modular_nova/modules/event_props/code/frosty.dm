#define TRAIT_COZY_COLD "cozy_cold"
/obj/item/clothing/suit/hooded/wintercoat/Initialize(mapload)
	. = ..()
	LAZYADD(clothing_traits, TRAIT_COZY_COLD)

/area/station/service/christmasthing
	/// Is this place unfomfortably cold without a winter coat
	var/frosty = FALSE

/area/station/service/christmasthing/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	var/mob/living/carbon/human/frosty_toes = arrived
	if(!frosty || !istype(frosty_toes))
		return
	if(!HAS_TRAIT(frosty_toes, TRAIT_COZY_COLD))
		frosty_toes.add_mood_event("frosty", /datum/mood_event/frosty)
	RegisterSignals(frosty_toes, list(SIGNAL_REMOVETRAIT(TRAIT_COZY_COLD), SIGNAL_ADDTRAIT(TRAIT_COZY_COLD)), PROC_REF(update_frosty))

/area/station/service/christmasthing/Exited(atom/movable/gone, direction)
	. = ..()
	var/mob/living/carbon/human/frosty_toes = gone
	if(!frosty || !istype(frosty_toes))
		return
	frosty_toes.clear_mood_event("frosty")
	UnregisterSignal(frosty_toes, list(SIGNAL_REMOVETRAIT(TRAIT_COZY_COLD), SIGNAL_ADDTRAIT(TRAIT_COZY_COLD)))

/area/proc/update_frosty(mob/living/carbon/human/frosty_toes)
	if(!HAS_TRAIT(frosty_toes, TRAIT_COZY_COLD))
		frosty_toes.add_mood_event("frosty", /datum/mood_event/frosty)
	else
		frosty_toes.clear_mood_event("frosty")

/datum/mood_event/frosty
	description = "It's freezing out here without a proper coat!"
	mood_change = -4

/area/station/service/christmasthing/indoors
	name = "\improper Indoors"
	icon_state = "explored"
	requires_power = TRUE
	default_gravity = STANDARD_GRAVITY
	frosty = FALSE

/area/station/service/christmasthing/outdoors
	name = "\improper Outdoors"
	icon_state = "explored"
	static_lighting = TRUE
	base_lighting_alpha = 175
	base_lighting_color = "#eab8faff"
	requires_power = TRUE
	default_gravity = STANDARD_GRAVITY
	frosty = TRUE

/area/station/service/christmasthing/outdoors/hotsprings
	frosty = FALSE

/obj/item/clothing/shoes/winterboots/ice_boots/skates
	name = "ice skates"
	desc = "A pair of winter boots with integrated skates on the bottom, perfect for snow and ice"

/obj/machinery/drone_dispenser/binoculars/skates
	name = "skates fabricator"
	desc = "A hefty machine that periodically creates a pair of ice skates. Handy!"
	dispense_type = list(/obj/item/clothing/shoes/winterboots/ice_boots/skates)
	end_create_message = "dispenses a pair of ice skates."

/obj/machinery/drone_dispenser/binoculars/flashlights
	name = "flashlight fabricator"
	desc = "A hefty machine that periodically creates a high end flashlight. Handy!"
	dispense_type = list(/obj/item/flashlight)
	end_create_message = "dispenses a flashlight."

/obj/machinery/drone_dispenser/binoculars/wintercoats
	name = "winter coat fabricator"
	desc = "A hefty machine that periodically creates a warm and cozy winter coat. Better button up!"
	dispense_type = list(/obj/item/clothing/suit/hooded/wintercoat)
	end_create_message = "dispenses an extra warm and comfy coat."

/obj/machinery/drone_dispenser/binoculars/pamphlet
	name = "pamphlet fabricator"
	desc = "A hefty machine that prints promotional brochures."
	dispense_type = list(/obj/item/paper/fluff/holiday_pamphlet)
	end_create_message = "dispenses an extra warm and comfy coat."

/obj/item/paper/fluff/holiday_pamphlet
	name = "Holiday Resort Pamphlet"
	default_raw_text = {"<B>Greetings Esteemed Resort Guests!</B>
	<br>
	<br>From the entrance, if you head north along the road, you'll pass the local Donk Factory. Be mindful not to disturb	their operation this time of year. They're very busy!
	<br>Following the road east will take you to the spa complex. Be sure to secure your belongings as you enjoy the geothermally heated springs.
	<br>Further north from the factory, you'll find our ice skating	rink and raptor stables to the west, while east takes you to the main event hall. Eat, drink, and be merry!
	<br>Not feeling the main hall? There are plenty of places to go! Explore our attractions! See the sights, make snow angels, take a trip up to the natural hot springs! It's your vacation, don't let some stuffy pamphlet tell you what to do!
	<br>We welcome you to this mostly paid-for vacation* and hope you enjoy your stay. Don't forget your coat!
	<br>
	<br>
	<br>
	<br>
	<br>*Please note that intentional property destruction will incur a wage garnishment."}
