// Debug Datums
// TODO: merge traits, weight classes, and shit into these, to reduce input on the items themselves. Need one thats just armor, and one thats got the additional bonuses
// todo: make defines?
// Debug Storage Datums. Need more slots? Raise the number on max_slots
// This top level datum contains a copy-paste of the base storage datum readout, because I expect people to learn off these eventually.
// I researched the progenitor for each subtype in the making of each of these admin types, which will have a relative path next to it
/datum/storage/admin
	/// For use with an exception typecache:
	/// The maximum amount of items of the exception type that can be inserted into this storage.
	exception_max = INFINITY
	/// Determines whether we play a rustle animation when inserting/removing items.
	animated = TRUE
	/// Determines whether we play a rustle sound when inserting/removing items.
	do_rustle = TRUE
	rustle_vary = TRUE
	/// Path for the item's rustle sound.
	rustle_sound = SFX_RUSTLE
	/// Path for the item's rustle sound when removing items.
	remove_rustle_sound = SFX_RUSTLE
	/// The sound to play when we open/access the storage
	//var/open_sound
	open_sound_vary = TRUE
	/// The maximum amount of items that can be inserted into this storage.
	max_slots = 78 //max columns X max rows, selected because it doesn't cover the player icon
	/// The largest weight class that can be inserted into this storage, inclusive.
	max_specific_storage = WEIGHT_CLASS_GIGANTIC//fixes boxes down the chain too
	/// Determines the maximum amount of weight that can be inserted into this storage.
	/// Weight is calculated by the sum of all of our content's weight classes.
	max_total_storage = INFINITY
	/// If TRUE, we can use-in-hand the storage object to dump all of its contents.
	allow_quick_empty = TRUE
	///do we insert items when clicked by them?
	insert_on_attack = TRUE
	/// If TRUE, chat messages for inserting/removing items will not be shown.
	silent = FALSE
	/// Same as above but only for the user.
	/// Useful to cut on chat spam without removing feedback for other players.
	silent_for_user = FALSE
	/// Maximum amount of columns a storage object can have
	screen_max_columns = 13//I personally think that more columns and fewer rows looks better. So Im doing that.
	/// Maximum amount of rows a storage object can have
	screen_max_rows = 6
	/// X-pixel location of the boxes and close button
	screen_pixel_x = 16
	/// Y-pixel location of the boxes and close button
	screen_pixel_y = 16
	/// Where storage starts being rendered, x-screen_loc wise
	screen_start_x = 4
	/// Where storage starts being rendered, y-screen_loc wise
	screen_start_y = 2
	/// If TRUE, shows the contents of the storage in open_storage
	display_contents = TRUE
	/// Switch this off if you want to handle click_alt in the parent atom
	click_alt_open = TRUE
	/// Whether we allow storage objects of the same size inside.
	allow_big_nesting = TRUE//Usually false but lets just make life easier for ourselves later
	/// Whether we open when attack_handed (clicked on with an empty hand).
	attack_hand_interact = TRUE
	/// If TRUE, we can click on items with the storage object to pick them up and insert them.
	allow_quick_gather = FALSE
	/// The mode for collection when allow_quick_gather is enabled. See [code/__DEFINES/storage.dm]
	collection_mode = COLLECT_EVERYTHING
	/// If we support smartly removing/inserting things from ourselves
	supports_smart_equip = TRUE
	/// if TRUE, alt-click takes an item out instantly rather than opening up storage.
	quickdraw = FALSE
	/// Instead of displaying multiple items of the same type, display them as numbered contents.
	numerical_stacking = FALSE

//Bags, like the trashbag / construction bag, utilize pickup mechanics
/datum/storage/admin/bag
	/// If TRUE, we can click on items with the storage object to pick them up and insert them.
	allow_quick_gather = TRUE
	/// If we support smartly removing/inserting things from ourselves
	supports_smart_equip = FALSE
	/// if TRUE, alt-click takes an item out instantly rather than opening up storage.
	//quickdraw = false
	/// Instead of displaying multiple items of the same type, display them as numbered contents.
	numerical_stacking = TRUE

// Used by the subspace pocket. Be careful with this!
/datum/storage/admin/bag/badmin
	/// The maximum amount of items that can be inserted into this storage.
	max_slots = 78 //max columns X max rows, selected because it doesn't cover the player icon
	/// Maximum amount of rows a storage object can have
	screen_max_rows = INFINITY

//Debug Pockets!
/datum/storage/admin/pockets
	max_slots = 2
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = INFINITY

//Admin armors
/datum/armor/admin//No one is invincible.
	acid = 98
	bio = 95
	bomb = 95
	bullet = 95
	consume = 95
	energy = 95
	laser = 95
	fire = 98
	melee = 95
	wound = 95

/datum/armor/admin/badmin//Not as good as you think
	acid = 100
	bio = 100
	bomb = 100
	bullet = 100
	consume = 100
	energy = 100
	laser = 100
	fire = 100
	melee = 100
	wound = 100
