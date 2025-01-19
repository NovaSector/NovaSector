// Core balance principles with these roundstart augments is that they are SLOW. 2 toolspeed minimum where possible - finding actual things in round should always be better, this is for flavor and accessibility. The accessibility alone already provides these with a lot of value.

// EYE IMPLANTS

/obj/item/organ/eyes/robotic/binoculars
	name = "digital magnification optics"
	desc = "Commonly used on frontier worlds with comparatively vast overland distances to aid in visual acquisition of coworkers and targets."
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/zoomed = FALSE
	var/range_power = 2 // what kind of range modifier do we feed to the scope component?

/obj/item/organ/eyes/robotic/binoculars/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = range_power)

/obj/item/organ/eyes/robotic/binoculars/ui_action_click(mob/user, actiontype)
	if (istype(actiontype, /datum/action/item_action/organ_action/toggle))
		toggle_active(user)

/obj/item/organ/eyes/robotic/binoculars/proc/toggle_active(mob/user)
	//this is so unbelievably, hysterically jank. i actually cannot believe this works. what the fuck
	var/datum/component/scope/zoom = src.GetComponent(/datum/component/scope)
	if (zoomed)
		zoom.stop_zooming(user)
		zoomed = FALSE
	else
		//check if they're blind
		if (user.is_blind())
			user.balloon_alert(user, "can't activate magnification while blind!")
			return

		zoom.zoom(user)
		zoomed = TRUE

// ARM IMPLANTS
/obj/item/organ/cyberimp/arm/adjuster
	name = "adjuster arm implant"
	desc = "A miniaturized toolset implant containing a simple fingertip-mounted universal screwdriver bit with an inverted torque-wrench head. Most commonly used when rearranging furniture or other station machinery."
	items_to_create = list(/obj/item/wrench/integrated, /obj/item/screwdriver/integrated)

/obj/item/organ/cyberimp/arm/adjuster/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/organ/cyberimp/arm/electrical_toolset
	name = "electrical toolset implant"
	desc = "Bereft of any kind of insulation to speak of, this aug has a very distinct nickname amongst frontier outpost crews: 'the sizzler'. Often used in high verticality environments where loadout space is at a premium."
	items_to_create = list(/obj/item/screwdriver/integrated, /obj/item/multitool/integrated, /obj/item/wirecutters/integrated)

/obj/item/organ/cyberimp/arm/electrical_toolset/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/organ/cyberimp/arm/arc_welder
	name = "shipbreaker's toolset implant"
	desc = "A specialized salvage-grade implant that houses an arc welder, miniaturized crowbar within the bearer's arm, plus a fingertip torque-wrench rated for enough newtons to get the job done. Renowned across the frontier for being the 'trashy tattoo' equivalent of someone's first aug."
	items_to_create = list(/obj/item/wrench/integrated, /obj/item/crowbar/integrated, /obj/item/weldingtool/electric/arc_welder/integrated)

/obj/item/organ/cyberimp/arm/arc_welder/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/organ/cyberimp/arm/emt_triage
	name = "triage actuator implant"
	desc = "Pioneered by Interdyne Pharmaceuticals for use in their frontier postings, this set of in-arm augments allows medical staff to perform basic life-saving surgeries out on the field with the assistance of a bladed instrument."
	items_to_create = list(/obj/item/surgical_drapes/integrated, /obj/item/retractor/integrated, /obj/item/hemostat/integrated)

/obj/item/organ/cyberimp/arm/emt_triage/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

/obj/item/organ/cyberimp/arm/civilian_barstaff
	name = "waitstaff implant"
	desc = "The galactic service industry demands only the finest from its (underpaid) employees, leading to the development of this sordid piece of technology which substitutes a user's organic arm for a food storage space and an integrated chamois cleaning cloth. Why?"
	items_to_create = list(/obj/item/storage/bag/tray/integrated, /obj/item/reagent_containers/cup/rag/integrated)

/obj/item/organ/cyberimp/arm/civilian_lighter
	name = "thumbtip lighter implant"
	desc = "This extraordinarily useless implant was a product of market demand, and it exists because the galactic diaspora apparently craves the ability to light things with their thumbtips."
	items_to_create = list(/obj/item/lighter/integrated)

/obj/item/organ/cyberimp/arm/blacksteel_forging
	name = "Blacksteel 'Starforge' metalworking toolset implant"
	desc = "A galactic favorite amongst burgeoning starfarer races with a fascination for basic metallurgy or mundane weaponry, this unlikely toolset augmentation is one of the Foundation's most popular products."
	items_to_create = list(/obj/item/forging/hammer/integrated, /obj/item/forging/tongs/integrated, /obj/item/forging/billow/integrated)

/obj/item/organ/cyberimp/arm/blacksteel_forging/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BLACKSTEEL)

/obj/item/organ/cyberimp/arm/bureaucracy
	name = "bureaucrat's 'Jacent' toolset implant"
	desc = "Popular amongst coreworld corporates, this integrated toolset includes a wrist-sheathed four-colour pen, a special motorized sheaf hollow for holding up to ten pieces of galactic-standard A4 paper and a set of two fingertip stamps for approving and denying things. Does not replenish."
	items_to_create = list(/obj/item/pen/fourcolor/integrated, /obj/item/paper_bin/integrated, /obj/item/stamp/integrated, /obj/item/stamp/denied/integrated)

/obj/item/organ/cyberimp/arm/cargo
	name = "FTU 'Deckhand' toolset implant"
	desc = "Containing a fingertip-mounted universal scanner and a boxcutter, deck workers across the sector favor this cheap and effective implant as both a means of self-defense from irate consumers and for keeping a set of handy scanners quite literally, close at hand."
	items_to_create = list(/obj/item/universal_scanner/integrated, /obj/item/boxcutter/extended/integrated)
