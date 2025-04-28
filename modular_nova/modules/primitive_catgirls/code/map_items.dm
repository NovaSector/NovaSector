// Bonfires but with a grill pre-attached

/obj/structure/bonfire/grill_pre_attached

/obj/structure/bonfire/grill_pre_attached/Initialize(mapload)
	. = ..()

	grill = TRUE
	add_overlay("bonfire_grill")

// Dirt but icebox and also farmable

/turf/open/misc/dirt/icemoon
	baseturfs = /turf/open/openspace/icemoon
	initial_gas_mix = "ICEMOON_ATMOS"

/turf/open/misc/dirt/icemoon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_farm, set_plant = TRUE)

// Water that can be fished out of

/turf/open/water/hot_spring/icemoon
	desc = "Water kept warm through some unknown heat source, possibly a geothermal heat source far underground. \
		Whatever it is, it feels pretty damn nice to swim in given the rest of the environment around here, and you \
		can even catch a glimpse of the odd fish darting through the water."
	baseturfs = /turf/open/openspace/icemoon
	initial_gas_mix = "ICEMOON_ATMOS"
	fishing_datum = /datum/fish_source/icecat_hot_spring

// Copy of parent proc with custom moodlet (and no negative moodlet)
/turf/open/water/hot_spring/icemoon/dip_in(atom/movable/movable)
	..()
	movable.wash(CLEAN_RAD | CLEAN_WASH)
	if(!isliving(movable))
		return

	var/mob/living/living = movable
	if(living.has_status_effect(/datum/status_effect/washing_regen/hot_spring))
		return
	living.apply_status_effect(/datum/status_effect/washing_regen/hot_spring)
	living.add_mood_event("hotspring", /datum/mood_event/hotspring/nerfed)

/datum/mood_event/hotspring/nerfed
	description = span_nicegreen("The water was enjoyably warm!\n")
	mood_change = 2

// Fishing source for the above water turfs

/datum/fish_source/icecat_hot_spring
	fish_table = list(
		/obj/item/fish/moonfish/dwarf = 5,
		/obj/item/fish/needlefish = 10,
		/obj/item/fish/armorfish = 10,
		/obj/item/fish/chasm_crab/ice = 5,
		/obj/item/stack/sheet/bone = 5,
	)
	catalog_description = "Icemoon Hot Springs"

// The area

/area/ruin/unpowered/primitive_catgirl_den
	name = "\improper Icewalker Camp"
