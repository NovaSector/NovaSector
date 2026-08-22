/*
 * Persistent player homes.
 *
 * A Home is a condo that survives. The player walks up to a terminal in the cafe, steps into an
 * instanced interior, rearranges it however they like, and saves it from a console inside. The save
 * is a real .dmm written to disk under their ckey, so it reloads identically next round and is
 * shared by every character on that account.
 *
 * Homes are a CLOSED ECONOMY, in the holodeck's sense: anything the save file spawned is marked
 * TRAIT_HOME_FURNISHING and can never leave, while a player's own belongings come and go freely.
 * That is what makes saving safe - an item can only be duplicated by being saved, and anything
 * saved comes back marked, so a duplicate can never reach the round. Round-critical gear left
 * behind is pushed back out to the terminal when the home unloads rather than destroyed with it,
 * exactly as the condos do (see SShomes.eject_blacklist).
 */

/// Version stamped into every home's sidecar. Bump when the on-disk format changes.
#define HOME_SAVE_VERSION 1

/// Refuse a save holding more movables than this. Keeps pathological files off the disk.
#define HOME_MAX_OBJECTS 1500

/// Largest footprint a home interior may have, in tiles.
#define HOME_MAX_DIMENSION 40

/// Everything write_map() is allowed to put in a save file, minus what save_blacklist strips.
#define HOME_SAVE_FLAGS (SAVE_TURFS | SAVE_AREAS | SAVE_OBJECTS | SAVE_MOBS | SAVE_SPACE | SAVE_ATMOS)

/**
 * Marks a movable as part of a home's saved contents.
 *
 * Applied to everything the save file spawns, every time a home loads. The front door takes back
 * exactly what carries this and nothing else, which is what gives homes the holodeck's behaviour:
 * anything that came out of the record can never leave, while a player's own belongings - their ID,
 * their PDA, the crate they hauled in - come and go freely.
 *
 * That is also what makes saving safe. An item can only be duplicated by being saved, and anything
 * saved comes back marked, so a duplicate can never reach the round.
 */
#define TRAIT_HOME_FURNISHING "home_furnishing"
#define HOME_FURNISHING_TRAIT "home_furnishing_trait"

/// Brightness steps the console offers. HOME_BRIGHTNESS_MIN is lights out.
#define HOME_BRIGHTNESS_MIN 0
#define HOME_BRIGHTNESS_MAX 3
