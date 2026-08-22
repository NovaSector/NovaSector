/*
HEY!!! LISTEN!!!
Same rule as the condo templates: the bottom-left turf of your interior HAS to touch the rest of it
AND has to share its /area/, or the loader won't stitch it together properly.

Every starter also needs exactly one /turf/closed/indestructible/hoteldoor/fakedoor/player_home.
Loading self-heals an interior that has lost its door, but a starter shipping without one means the
door gets fitted somewhere arbitrary, which looks broken.
*/

/// Starter interiors a first-time player picks from. A separate tree from the condo templates on
/// purpose: condos are disposable scratch space, these are the seed of something permanent.
/datum/map_template/home
	/// Landing spot as an offset from the interior's bottom-left turf. Same 0-based convention the
	/// condo templates use for landing_zone_x_offset.
	var/landing_zone_x_offset = 1
	var/landing_zone_y_offset = 1
	/// One line shown beside the name while a first-time player is choosing.
	var/blurb

/// Built at runtime from a player's own save file. It deliberately has no compile-time mappath,
/// which is exactly what keeps preload_starter_templates() from offering it as a starter.
/datum/map_template/home/player_save
	name = "Filed Residence"

/// Keep these alphabetical.

/datum/map_template/home/apartment
	name = "Home - Apartment"
	blurb = "A tidy little unit with a bedroom, a kitchenette, and a window that doesn't open."
	mappath = "modular_nova/modules/player_homes/_maps/home_apartment.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 8

/datum/map_template/home/cabin
	name = "Home - Cabin In The Woods"
	blurb = "Timber walls, a stove, and a great many trees that are none of your business."
	mappath = "modular_nova/modules/player_homes/_maps/home_cabin.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/home/ocean_view
	name = "Home - Ocean View"
	blurb = "Open water on three sides. Excellent for thinking, poor for keeping things dry."
	mappath = "modular_nova/modules/player_homes/_maps/home_oceanview.dmm"
	landing_zone_x_offset = 7
	landing_zone_y_offset = 1
