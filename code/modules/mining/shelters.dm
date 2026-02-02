///Map templates used for bluespace survival capsules.
/datum/map_template/shelter
	has_ceiling = TRUE
	ceiling_turf = /turf/open/floor/engine/hull
	ceiling_baseturfs = list(/turf/open/floor/plating)
	///The id of the shelter template in the relative list from the mapping subsystem
	var/shelter_id
	///The description of the shelter, shown when examining survival capsule.
	var/description
	///If turf in the affected turfs is in this list, the survival capsule cannot be deployed.
	var/list/blacklisted_turfs
	///Areas where the capsule cannot be deployed.
	var/list/banned_areas
	///If any object in this list is found in the affected turfs, the capsule cannot deploy.
	var/list/banned_objects = list()

/datum/map_template/shelter/New()
	. = ..()
	blacklisted_turfs = typecacheof(/turf/closed)
	banned_areas = typecacheof(list(/area/shuttle, /area/station/holodeck))

/datum/map_template/shelter/proc/check_deploy(turf/deploy_location, obj/item/survivalcapsule/capsule, ignore_flags = NONE)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/turf in affected)
		var/area/area = get_area(turf)
		if(is_type_in_typecache(area, banned_areas))
			return SHELTER_DEPLOY_BAD_AREA

		if(is_type_in_typecache(turf, blacklisted_turfs))
			return SHELTER_DEPLOY_BAD_TURFS

		for(var/obj/object in turf)
			if(!(ignore_flags & CAPSULE_IGNORE_ANCHORED_OBJECTS) && object.density && object.anchored)
				return SHELTER_DEPLOY_ANCHORED_OBJECTS
			if(!(ignore_flags & CAPSULE_IGNORE_BANNED_OBJECTS) && is_type_in_typecache(object, banned_objects))
				return SHELTER_DEPLOY_BANNED_OBJECTS

	// Check if the shelter sticks out of map borders
	var/shelter_origin_x = deploy_location.x - round(width/2)
	if(shelter_origin_x <= 1 || shelter_origin_x+width > world.maxx)
		return SHELTER_DEPLOY_OUTSIDE_MAP
	var/shelter_origin_y = deploy_location.y - round(height/2)
	if(shelter_origin_y <= 1 || shelter_origin_y+height > world.maxy)
		return SHELTER_DEPLOY_OUTSIDE_MAP

	return SHELTER_DEPLOY_ALLOWED

/datum/map_template/shelter/alpha
	name = "Shelter Alpha"
	shelter_id = "shelter_alpha"
	description = "A cosy self-contained pressurized shelter, with \
		built-in navigation, entertainment, medical facilities and a \
		sleeping area! Order now, and we'll throw in a TINY FAN, \
		absolutely free!"
	mappath = "_maps/templates/shelter_1.dmm"

/datum/map_template/shelter/alpha/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/beta
	name = "Shelter Beta"
	shelter_id = "shelter_beta"
	description = "An extremely luxurious shelter, containing all \
		the amenities of home, including carpeted floors, hot and cold \
		running water, a gourmet three course meal, cooking facilities, \
		and a deluxe companion to keep you from getting lonely during \
		an ash storm."
	mappath = "_maps/templates/shelter_2.dmm"

/datum/map_template/shelter/beta/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/charlie
	name = "Shelter Charlie"
	shelter_id = "shelter_charlie"
	description = "A luxury elite bar which holds an entire bar \
		along with two vending machines, tables, and a restroom that \
		also has a sink. This isn't a survival capsule and so you can \
		expect that this won't save you if you're bleeding out to \
		death."
	mappath = "_maps/templates/shelter_3.dmm"

/datum/map_template/shelter/charlie/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/toilet
	name = "Emergency Relief Shelter"
	shelter_id = "shelter_toilet"
	description = "A stripped-down emergency shelter focused on providing \
		only the most essential amenities to unfortunate employees who find \
		themselves in need far from home."
	mappath = "_maps/templates/shelter_t.dmm"

/datum/map_template/shelter/toilet/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

///Not exactly mining shelters, but they make use of survival capsules code.
/datum/map_template/shelter/fishing
	name = "Freshwater Spring"
	shelter_id = "fishing_default"
	description = "A spring from which you can fish several freshwater fish, including goldfish, catfish and pikes."
	mappath = "_maps/templates/fishing_freshwater.dmm"
	has_ceiling = FALSE
	///The icon shown in the radial menu
	var/radial_icon = "river"
	/**
	 * If FALSE, the capsule needs to be emagged for this template to be selectable.
	 * its usage will also be logged, and admins warned if used indoors.
	 */
	var/safe = TRUE

/datum/map_template/shelter/fishing/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	blacklisted_turfs += typecacheof(/turf/open/openspace)
	// Stop the capsule from being used around pipes and cables (if not emagged) cuz it'd look bad and a bit disruptive.
	banned_objects = typecacheof(list(
		/obj/structure/disposalpipe,
		/obj/machinery/atmospherics/pipe,
		/obj/structure/cable,
		/obj/structure/transit_tube,
	))

/datum/map_template/shelter/fishing/beach
	name = "Saltwater Spring"
	shelter_id = "fishing_beach"
	mappath = "_maps/templates/fishing_saltwater.dmm"
	description = "A spring from which you can fish several saltwater fish, including clownfish, pufferfish and stingrays."
	radial_icon = "seaboat"

/datum/map_template/shelter/fishing/tizira
	name = "Tiziran Spring"
	shelter_id = "fishing_tizira"
	mappath = "_maps/templates/fishing_tizira.dmm"
	description = "A spring from which you can fish several fish native to the lizardfolk's native planet, Tizira."
	radial_icon = "planet"

/datum/map_template/shelter/fishing/hot_spring
	name = "Hot Spring"
	shelter_id = "fishing_hot_spring"
	mappath = "_maps/templates/fishing_hot_spring.dmm"
	description = "A hot spring. Its purposes as a fishing spot is limited, but at least you get to have a relaxing bath."
	radial_icon = "onsen"

/datum/map_template/shelter/fishing/ice
	name = "Ice Fishing Spot"
	shelter_id = "fishing_ice"
	mappath = "_maps/templates/fishing_ice.dmm"
	description = "A small, already dug ice hole surrounded by snow. You can catch salmon and arctic char here."
	radial_icon = "ice"

/datum/map_template/shelter/fishing/lava
	name = "Lava Fishing Spot"
	shelter_id = "fishing_lava"
	mappath = "_maps/templates/fishing_lava.dmm"
	description = "A small 2x2 puddle of not-safe-for-live lava. You can catch lava loops here, and maybe a chest."
	radial_icon = "lava"
	safe = FALSE

/datum/map_template/shelter/fishing/plasma
	name = "Plasma Fishing Spot"
	shelter_id = "fishing_plasma"
	mappath = "_maps/templates/fishing_plasma.dmm"
	description = "A small 2x2 puddle of not-safe-for-live plasma. You can catch lava loops and arctic chrabs here."
	radial_icon = "plasma"
	safe = FALSE

/datum/map_template/shelter/fishing/depths
	name = "Deep Ocean Fishing Spot"
	shelter_id = "fishing_depths"
	mappath = "_maps/templates/fishing_depths.dmm"
	description = "A 3x3 pool of deep water, enough that it's tiring to wade across. You can catch ocean fish here."
	radial_icon = "depths"
	safe = FALSE

/datum/map_template/shelter/prefab_wall3h
	name = "Vertical 1x3"
	shelter_id = "prefab_wall3h"
	description = "Prefabricated, unpowered, simple and fast 1x3 wall, currently set to be horizontal"
	mappath = "_maps/templates/prefab_wall3h.dmm"

/datum/map_template/shelter/prefab_wall3h/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_wall3v
	name = "Vertical 1x3"
	shelter_id = "prefab_wall3v"
	description = "Prefabricated, unpowered, simple and fast 1x3 wall, currently set to be vertical"
	mappath = "_maps/templates/prefab_wall3v.dmm"

/datum/map_template/shelter/prefab_wall3v/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_wall5h
	name = "Horizontal 1x5"
	shelter_id = "prefab_wall5h"
	description = "Prefabricated, unpowered, simple and fast 1x5 wall, currently set to be horizontal"
	mappath = "_maps/templates/prefab_wall5h.dmm"

/datum/map_template/shelter/prefab_wall5h/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_wall5v
	name = "Vertical 1x5"
	shelter_id = "prefab_wall5v"
	description = "Prefabricated, unpowered, simple and fast 1x5 wall, currently set to be vertical"
	mappath = "_maps/templates/prefab_wall5v.dmm"

/datum/map_template/shelter/prefab_wall5v/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_airlock
	name = "Nakamura LC-02 Airlock"
	shelter_id = "prefab_airlock"
	description = "Prefabricated, unpowered, simple and fast airlock system, brought to you by leading engineering solutions on the market. If only it also dispenced Lollipops on entrance... WARNING: DO NOT USE ON WATERWORLDS, WHIRLPOOL HAZARD. "
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
	description = "Recycled assortment of gear, tech and science material to help your adventerous explorers make that brave new planetoid truly yours! Delve into depths of fishing, the vastness of xenobiology, or even smack those rocks away! Comes with complimentary autolathe. Go and tap some Vents already! (Information regarding budget cuts are biased and slander.)"
	mappath = "_maps/templates/prefab_production.dmm"

/datum/map_template/shelter/prefab_production/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_room_10
	name = "Nakamura Freeform-10 Habitat"
	shelter_id = "prefab_room_10"
	description = "A colonist looking to size his living space up? An engineer who needs that sweet, sweet project space? Maybe even a newwave bar looking to open in the middle of the desert? WE HEARD YOU! Vaccum-sealed 10 by 10 habbitat to suit your every need. CAUTION:VACCUM INSIDE, OPEN WITH FACE AWAY."
	mappath = "_maps/templates/prefab_room_10.dmm"

/datum/map_template/shelter/prefab_room_10/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_room_7
	name = "Nakamura Freeform-7 Habitat"
	shelter_id = "prefab_room_7"
	description = "A colonist looking to size his living space up? An engineer who needs that sweet, sweet project space? Maybe even a newwave bar looking to open in the middle of the desert? WE HEARD YOU! Vaccum-sealed 7 by 7 habbitat to suit your every mimiam need. CAUTION:VACCUM INSIDE, OPEN WITH FACE AWAY." //not a typo as well
	mappath = "_maps/templates/prefab_room_7.dmm"

/datum/map_template/shelter/prefab_room_7/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_defenseplatform
	name = "Surplus Defense System SOL-EXP-40"
	shelter_id = "prefab_defenseplatform"
	description = "Massproduced, blocky, flimsy Solarian-made turret meant to reinforce and protect brave colonists in their sleep. Packed with its own platform and some cover. Not as scary as you might want it, but hey, it still gets the job done. Hate or love the Stun mode, this one just doesnt have one. FACTORY TARGETING UNIT SETTING REQUIRED. THIS LABEL VOIDS LIABILITY FOR ANY ACCIDENTAL TRAUMAS"
	mappath = "_maps/templates/prefab_defenseplatform.dmm"

/datum/map_template/shelter/prefab_defenseplatform/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_solarunit
	name = "Nakamura Heliantus-8 Solar Array"
	shelter_id = "prefab_solarunit"
	description = "Almost universal power solution used widely among plenty - Frontier or Not! Miniature Solar platform housing 8 panels in a flower-like shape, ensuring no matter the angle, we got you powered! Be your star a dwarf, a supernova or just some ambient jungleworld thunder, as you watch upon the raining sky, holding someone dear to you."
	mappath = "_maps/templates/prefab_solarunit.dmm"

/datum/map_template/shelter/prefab_solarunit/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_infrastructure
	name = "Nakamura Air/Power/Logistics Node"
	shelter_id = "prefab_infrastructure"
	description = "Rudimentary airsupply and innitial power supply, packed with ore silo, wind turbine for lifesupport, recycler, pipes and engineering tools. Fabulous and Elegant. Lone or not. Puts your I, closer to your X goals. If only it came with an adorable Engineering borgo gal..." //not a typo, but please can this stay between us dear reader?
	mappath = "_maps/templates/prefab_infrastructure.dmm"

/datum/map_template/shelter/prefab_infrastructure/New()
	. = ..()
	blacklisted_turfs -= typesof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/prefab_stardewvalley
	name = "Nakamura X NT Sustenance Greenhouse"
	shelter_id = "prefab_stardewvalley"
	description = "Basic green house to help sate your hunger, even on a distant system. Or grow a couple of cute, plant gals."
	mappath = "_maps/templates/prefab_stardewvalley.dmm"

/datum/map_template/shelter/prefab_stardewvalley/New()
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
