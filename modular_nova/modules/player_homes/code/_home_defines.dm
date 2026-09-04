/*
 * Persistent player homes. A player steps through a terminal in the cafe into an instanced interior,
 * rearranges it, and saves it from a console inside. The save is a real .dmm written under their
 * ckey, so it reloads identically next round and is shared by every character on that account.
 *
 * Homes are a CLOSED ECONOMY: everything the save file spawned is marked TRAIT_HOME_FURNISHING and
 * can never leave, while a player's own belongings come and go freely. That is what makes saving
 * safe - an item can only be duplicated by being saved, and anything saved comes back marked.
 */

/// Bump when the on-disk format changes.
#define HOME_SAVE_VERSION 1

/// Refuse a save holding more movables than this.
#define HOME_MAX_OBJECTS 1500

/// Largest footprint a home interior may have, in tiles.
#define HOME_MAX_DIMENSION 40

/// What write_map() may put in a save file, minus what save_blacklist strips.
#define HOME_SAVE_FLAGS (SAVE_TURFS | SAVE_AREAS | SAVE_OBJECTS | SAVE_MOBS | SAVE_SPACE | SAVE_TURF_DECALS)

/// Applied to everything the save file spawns, every load. The front door takes back exactly what
/// carries this and nothing else - the whole anti-duplication scheme.
#define TRAIT_HOME_FURNISHING "home_furnishing"
#define HOME_FURNISHING_TRAIT "home_furnishing_trait"

/// Brightness steps the console offers. HOME_BRIGHTNESS_MIN is lights out.
#define HOME_BRIGHTNESS_MIN 0
#define HOME_BRIGHTNESS_MAX 3

/// Set to 0 in config to turn persistent player homes off entirely. The cafe terminal goes inert.
/datum/config_entry/flag/player_homes_enabled
	default = TRUE

/// Seconds a player must wait between filing home requisitions. Set to 0 to remove the wait.
/datum/config_entry/number/player_home_supply_cooldown
	default = 30
	min_val = 0

/// Tells a home's reservation apart from any other block of reserved turfs, as condos do.
/datum/turf_reservation/player_home
	/// The home currently loaded into these turfs.
	var/datum/home_instance/home

/*
 * HEY!!! LISTEN!!!
 * Same rule as the condo templates: the bottom-left turf of your interior HAS to touch the rest of it
 * AND share its /area/, or the loader won't stitch it together properly. Every starter also needs
 * exactly one /turf/closed/indestructible/hoteldoor/fakedoor/player_home - loading fits one if it is
 * missing, but it lands somewhere arbitrary and looks broken.
 */

/// Starter interiors a first-time player picks from. Separate from the condo templates on purpose:
/// condos are disposable scratch space, these are the seed of something permanent.
/datum/map_template/home
	/// Landing spot as a 0-based offset from the interior's bottom-left turf, as the condos do it.
	var/landing_zone_x_offset = 1
	var/landing_zone_y_offset = 1
	/// One line shown beside the name while a first-time player is choosing.
	var/blurb

/// Built at runtime from a player's own save file. No compile-time mappath, which is what keeps
/// preload_starter_templates() from offering it as a starter.
/datum/map_template/home/player_save
	name = "Filed Residence"

/// Try to keep these alphabetical.

/datum/map_template/home/apartment
	name = "Home - Apartment"
	blurb = "A tidy little unit with a bedroom, a kitchenette, and a window that doesn't open."
	mappath = "_maps/nova/persistent_housing/home_apartment.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 9

// Blank plots: a wall perimeter, plating, a front door and a console, and nothing else. For players
// who would rather build from scratch than move into somebody's idea of a house.

/datum/map_template/home/blank_10x10
	name = "Home - Blank Plot (Small)"
	blurb = "Four walls, a floor, and a door. Everything else is your problem."
	mappath = "_maps/nova/persistent_housing/home_blank_10x10.dmm"
	landing_zone_x_offset = 4
	landing_zone_y_offset = 1

/datum/map_template/home/blank_10x15
	name = "Home - Blank Plot (Tall)"
	blurb = "A narrow, empty shell. Good for anyone with plans that go upward."
	mappath = "_maps/nova/persistent_housing/home_blank_10x15.dmm"
	landing_zone_x_offset = 4
	landing_zone_y_offset = 1

/datum/map_template/home/blank_15x10
	name = "Home - Blank Plot (Wide)"
	blurb = "A broad, empty shell. Room enough to regret your own floor plan."
	mappath = "_maps/nova/persistent_housing/home_blank_15x10.dmm"
	landing_zone_x_offset = 6
	landing_zone_y_offset = 1

/datum/map_template/home/blank_15x15
	name = "Home - Blank Plot (Large)"
	blurb = "The biggest empty lot the registry will issue. Nothing in it but you."
	mappath = "_maps/nova/persistent_housing/home_blank_15x15.dmm"
	landing_zone_x_offset = 6
	landing_zone_y_offset = 1

/datum/map_template/home/cabin
	name = "Home - Cabin In The Woods"
	blurb = "Timber walls, a stove, and a great many trees that are none of your business."
	mappath = "_maps/nova/persistent_housing/home_cabin.dmm"
	landing_zone_x_offset = 2
	landing_zone_y_offset = 1

/datum/map_template/home/snowy_cabin
	name = "Home - Snowy Cabin"
	blurb = "A nice cozy cabin out in the snow. Bundle up!"
	mappath = "_maps/nova/persistent_housing/home_snowycabin.dmm"
	landing_zone_x_offset = 10
	landing_zone_y_offset = 5
