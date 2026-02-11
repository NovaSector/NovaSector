//shelter_templates
//Uses mining shelter code, create new datum, give it name, give it shelter_id, desc it, and give it path to a MAP template to load upon deploy.

/datum/map_template/shelter/prefab_wall3h
	name = "Vertical 1x3"
	shelter_id = "prefab_wall3h"
	description = "A prefabricated, unpowered, simple and fast 1x3 wall, currently set to be horizontal."
	mappath = "_maps/templates/prefab_wall3h.dmm"

/datum/map_template/shelter/prefab_wall3h/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_wall3v
	name = "Vertical 1x3"
	shelter_id = "prefab_wall3v"
	description = "A prefabricated, unpowered, simple and fast 1x3 wall, currently set to be vertical."
	mappath = "_maps/templates/prefab_wall3v.dmm"

/datum/map_template/shelter/prefab_wall3v/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_wall5h
	name = "Horizontal 1x5"
	shelter_id = "prefab_wall5h"
	description = "Prefabricated, unpowered, simple and fast 1x5 wall, currently set to be horizontal."
	mappath = "_maps/templates/prefab_wall5h.dmm"

/datum/map_template/shelter/prefab_wall5h/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_wall5v
	name = "Vertical 1x5"
	shelter_id = "prefab_wall5v"
	description = "Prefabricated, unpowered, simple and fast 1x5 wall, currently set to be vertical."
	mappath = "_maps/templates/prefab_wall5v.dmm"

/datum/map_template/shelter/prefab_wall5v/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_airlock
	name = "Nakamura LC-12 Airlock"
	shelter_id = "prefab_airlock"
	description = "Prefabricated, unpowered, simple and fast airlock system, brought to you by leading engineering solutions on the market. If only it also dispensed Lollipops on entrance... WARNING: DO NOT USE ON WATERWORLDS, WHIRLPOOL HAZARD." // *arf
	mappath = "_maps/templates/prefab_airlock.dmm"

/datum/map_template/shelter/prefab_airlock/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)


/datum/map_template/shelter/prefab_medical
	name = "Deforest Infirmary Pattern Tent"
	shelter_id = "prefab_medical"
	description = "Prefabricated, unpowered, universal solution for the unforgiving frontier. Features basic operating theatre, highest-quality Deforest medical tools, and BONUS surplus equipment - for our dear customers!"
	mappath = "_maps/templates/prefab_medical.dmm"

/datum/map_template/shelter/prefab_medical/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_production
	name = "Science-Exploration Anchor Kit"
	shelter_id = "prefab_production"
	description = "Recycled assortment of gear, tech and science material to help your adventurous explorers make that brave new planetoid truly yours! \
			Delve into depths of fishing, the vastness of xenobiology, or even smack those rocks away! Comes with complimentary autolathe. Go and tap some Vents already! (Information regarding budget cuts are biased and slander.)"
	mappath = "_maps/templates/prefab_production.dmm"

/datum/map_template/shelter/prefab_production/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_room_10
	name = "Nakamura Freeform-10 Habitat"
	shelter_id = "prefab_room_10"
	description = "A colonist looking to size his living space up? An engineer who needs that sweet, sweet project space? Maybe even a new wave bar looking to open in the middle of the desert? \
			WE HEARD YOU! Vacuum-sealed 10 by 10 habitat to suit your every need. CAUTION:VACUUM INSIDE, OPEN WITH FACE AWAY."
	mappath = "_maps/templates/prefab_room_10.dmm"

/datum/map_template/shelter/prefab_room_10/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_room_7
	name = "Nakamura Freeform-7 Habitat"
	shelter_id = "prefab_room_7"
	description = "A colonist looking to size his living space up? An engineer who needs that sweet, sweet project space? Maybe even a new wave bar looking to open in the middle of the desert? \
			WE HEARD YOU! Vacuum-sealed 7 by 7 habitat to suit your every minimum need. CAUTION: VACUUM INSIDE, OPEN WITH FACE AWAY."
	mappath = "_maps/templates/prefab_room_7.dmm"

/datum/map_template/shelter/prefab_room_7/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_defenseplatform
	name = "Surplus Defense System SOL-EXP-40"
	shelter_id = "prefab_defenseplatform"
	description = "A mass-produced, blocky, flimsy Solarian-made turret meant to reinforce and protect brave colonists in their sleep. Packed with its own platform and some cover. \
		Not as scary as you might want it, but hey, it still gets the job done. Hate or love the Stun mode, this one just doesn't have one. \
		FACTORY TARGETING UNIT SETTING REQUIRED. THIS LABEL VOIDS LIABILITY FOR ANY ACCIDENTAL TRAUMAS."
	mappath = "_maps/templates/prefab_defenseplatform.dmm"

/datum/map_template/shelter/prefab_defenseplatform/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_solarunit
	name = "Nakamura Heliantus-8 Solar Array"
	shelter_id = "prefab_solarunit"
	description = "Almost-universal power solution used widely among plenty - Frontier or Not! Miniature Solar platform housing 8 panels in a flower-like shape, ensuring no matter the angle, we got you powered! \
		Be your star a dwarf, a supernova or just some ambient jungleworld thunder, as you watch upon the raining sky, holding someone dear to you."
	mappath = "_maps/templates/prefab_solarunit.dmm"

/datum/map_template/shelter/prefab_solarunit/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_infrastructure
	name = "Nakamura Air/Power/Logistics Node"
	shelter_id = "prefab_infrastructure"
	description = "Rudimentary air supply and initial power supply, packed with ore silo, wind turbine for life support, recycler, pipes and engineering tools. \
		Fabulous and Elegant. Lone or not, puts your I, closer to your X goals. If only it came with an adorable Engineering borgo gal..." //not a typo, but please can this stay between us dear reader?
	mappath = "_maps/templates/prefab_infrastructure.dmm"

/datum/map_template/shelter/prefab_infrastructure/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_botany
	name = "Nakamura X NT Sustenance Greenhouse"
	shelter_id = "prefab_botany"
	description = "Basic green house to help sate your hunger, even on a distant system. Or grow a couple of cute, plant gals."
	mappath = "_maps/templates/prefab_botany.dmm"

/datum/map_template/shelter/prefab_botany/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_factory
	name = "Nakamura Streamline Basics"
	shelter_id = "prefab_factory"
	description = "Factory in a box! Less compact and.... not really that efficient, but hey, automation is automation"
	mappath = "_maps/templates/prefab_factory.dmm"

/datum/map_template/shelter/prefab_factory/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)
