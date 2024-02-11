/obj/structure/maintenance_loot_structure
	name = "abandoned crate"
	icon = 'modular_nova/modules/epic_loot/icons/loot_structures.dmi'
	density = TRUE
	anchored = TRUE
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT
	pass_flags = LETPASSTHROW
	max_integrity = 100

	/// What sound this makes when people open it's storage
	var/opening_sound = 'modular_nova/modules/epic_loot/sound/containers/plastic.mp3'
	/// What storage datum we use
	var/storage_datum_to_use = /datum/storage/maintenance_loot_structure
	/// Weighted list of the loot that can spawn in this
	var/list/loot_weighted_list = list(
		/obj/effect/spawner/random/maintenance = 1,
	)

/obj/structure/maintenance_loot_structure/Initialize(mapload)
	. = ..()
	create_storage(storage_type = storage_datum_to_use)
	make_contents()

/obj/structure/maintenance_loot_structure/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!.)
		return
	playsound(src, opening_sound, 40, TRUE)

/// Fills random contents into this structure's inventory, starting a loop to respawn loot if the container is empty later
/obj/structure/maintenance_loot_structure/proc/make_contents()
	var/refill_check_time = 10 MINUTES
	if(!length(contents))
		spawn_loot()
		refill_check_time = 30 MINUTES
	addtimer(CALLBACK(src, PROC_REF(make_contents)), refill_check_time)

/// Spawns a random amount of loot into the structure, random numbers based on the amount of storage slots inside it
/obj/structure/maintenance_loot_structure/proc/spawn_loot()
	var/random_loot_amount = rand(1, atom_storage.max_slots)
	for(var/loot_spawn in 1 to random_loot_amount)
		var/obj/new_loot = pick_weight(loot_weighted_list)
		new new_loot(src)
	Shake(2, 2, 1 SECONDS)

/datum/storage/maintenance_loot_structure
	max_slots = 9
	max_specific_storage = WEIGHT_CLASS_BULKY
	max_total_storage = WEIGHT_CLASS_BULKY * 6
	numerical_stacking = FALSE
	screen_max_columns = 3

// Loot items basetype, for convenience
/obj/item/epic_loot
	name = "epic loot!!!!!"
	desc = "Unknown purpose, unknown maker, unknown value. The only thing I know for real: There will be loot."
	icon = 'modular_nova/modules/epic_loot/icons/epic_loot.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	inhand_icon_state = "binoculars"
	w_class = WEIGHT_CLASS_SMALL
