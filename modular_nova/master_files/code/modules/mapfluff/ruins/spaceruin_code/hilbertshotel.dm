// GHOST HOTEL UPDATE
/obj/item/hilbertshotel
	var/static/list/hotel_maps = list("Generic", "Apartment", "Beach Condo", "Shuttle")
	//standard - hilbert's hotel room
	//apartment - see /datum/map_template/ghost_cafe_rooms
	var/datum/map_template/ghost_cafe_rooms/apartment/ghost_cafe_rooms_apartment
	var/datum/map_template/ghost_cafe_rooms/beach_condo/ghost_cafe_rooms_beach_condo
	var/datum/map_template/ghost_cafe_rooms/shuttle/ghost_cafe_rooms_shuttle


// GHOST HOTEL UPDATE
/obj/item/hilbertshotel/prepare_rooms()
	. = ..()
	ghost_cafe_rooms_apartment = new()
	ghost_cafe_rooms_beach_condo = new()
	ghost_cafe_rooms_shuttle = new()

// GHOST HOTEL UPDATE
/area/misc/hilbertshotel
	mood_bonus = 25
	mood_message = "I am taking a well deserved rest!"
	ambientsounds = null
