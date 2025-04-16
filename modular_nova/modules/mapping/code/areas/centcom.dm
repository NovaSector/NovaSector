// Nova Sector CC area defines

/*
 * Ghost Cafe
 */

/area/centcom/holding
	name = "Holding Facility"
	area_flags = parent_type::area_flags | UNLIMITED_FISHING
	mood_bonus = 25
	mood_message = "I am taking a well deserved rest!"

/area/centcom/holding/cafe
	name = "Ghost Cafe"

/area/centcom/holding/cafevox
	name = "Cafe Vox Box"

/area/centcom/holding/cafedorms
	name = "Ghost Cafe Dorms"

/area/centcom/holding/cafepark
	name = "Ghost Cafe Outdoors"

/area/centcom/interlink
	name = "The Interlink"

/area/centcom/interlink/dorm_rooms
	name = "Interlink Dorm Rooms"
	mood_bonus = /area/centcom/holding::mood_bonus
	mood_message = /area/centcom/holding::mood_message
