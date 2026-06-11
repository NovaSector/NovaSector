//! Admin tech storage bags

/// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Let's make our own.
/// Using a construction bag as our base, instead of the sheetsnatcher.
/// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing.
/// TODO: Descriptions and inspects.
/obj/item/storage/bag/construction/admin
	name = "bluespace construction bag"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "blue-bag"
	worn_icon_state = "null" // Don't fuck with my drip
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	slot_flags = ITEM_SLOT_POCKETS // pockets only >:( if i accidentally equip a construction bag to my belt slot instead of my pockets first, where the value proposition is much higher, i will explode
	storage_type = /datum/storage/admin/bag

/// Clears the bag
/obj/item/storage/bag/construction/admin/click_alt_secondary(mob/user)
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	return

/// Refreshes the bag's contents
/obj/item/storage/bag/construction/admin/click_ctrl_shift(mob/user)
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	PopulateContents()
	return

/obj/item/storage/bag/construction/admin/PopulateContents()
	// TODO: This could be more optimized by having /fifty subtypes for the types that don't already have /fifty subtypes
	// (allegedly that's faster than initializing 50 objects and then having them all merge into one big stack?)
	var/static/items_inside = list(
		/obj/item/stack/rods = 50,// amount should be null if it should spawn with the type's default amount
		/obj/item/stack/sheet/iron/fifty = null,
		/obj/item/stack/rods/lava/thirty = null,
		/obj/item/stack/rods/shuttle/fifty = null,
		/obj/item/stack/sheet/glass/fifty = null,
		/obj/item/stack/sheet/rglass/fifty = null,
		/obj/item/stack/sheet/mineral/plasma/fifty = null,
		/obj/item/stack/sheet/plasmaglass/fifty = null,
		/obj/item/stack/sheet/plasmarglass/fifty = null,
		/obj/item/stack/sheet/plasteel/fifty = null,
		/obj/item/stack/sheet/mineral/titanium/fifty = null,
		/obj/item/stack/sheet/titaniumglass/fifty = null,
		/obj/item/stack/sheet/mineral/plastitanium = 50,
		/obj/item/stack/sheet/plastitaniumglass/fifty = null,
		/obj/item/stack/sheet/mineral/gold/fifty = null,
		/obj/item/stack/sheet/mineral/silver/fifty = null,
		/obj/item/stack/sheet/mineral/uranium/fifty = null, // uranium stacks irradiating shit is not real
		/obj/item/stack/sheet/mineral/diamond/fifty = null,
		/obj/item/stack/sheet/bluespace_crystal/fifty = null,
		/obj/item/stack/sheet/mineral/bananium = 50,
		/obj/item/stack/sheet/mineral/wood/fifty = null,
		/obj/item/stack/sheet/plastic/fifty = null,
		/obj/item/stack/sheet/runed_metal/fifty = null,
		/obj/item/stack/sheet/mineral/abductor = 50,
		/obj/item/stack/sheet/mineral/sandstone = 50,
		/obj/item/stack/sheet/cardboard/fifty = null,
		/obj/item/stack/sheet/leather = 50,
		/obj/item/stack/sheet/hairlesshide = 50,
		/obj/item/stack/sheet/hot_ice = 50,
		/obj/item/stack/sheet/mineral/sandbags/fifty = null,
		/obj/item/stack/sheet/cloth = 50,
		/obj/item/stack/cable_coil/thirty = null,
		/obj/item/stack/sheet/mineral/snow = 50,
		/obj/item/stack/sheet/mineral/adamantine = 50,
		/obj/item/stack/sheet/mineral/runite = 50,
		/obj/item/stack/sheet/mineral/coal = 50,
		/obj/item/stack/sheet/mineral/metal_hydrogen = 50,
		/obj/item/stack/sheet/paperframes = 50,
		/obj/item/stack/sheet/meat = 50,
		/obj/item/stack/sheet/durathread = 50,
		/obj/item/stack/sheet/mineral/stone = 50,
		/obj/item/stack/sheet/mineral/bamboo = 50,
		/obj/item/stack/sheet/mineral/zaukerite = 50,
		/obj/item/stack/sheet/brussite = 50,
		/obj/item/stack/sheet/tinumium = 50,
		/obj/item/stack/sheet/copporcitite = 50,//why do copper tools exist in minecraft?
		/obj/item/stack/sheet/cobolterium = 50,
		/obj/item/stack/sheet/pizza/fifty = 50,
		/obj/item/stack/sheet/spaceship = 50,
		/obj/item/stack/sheet/spaceshipglass = 50,
		/obj/item/stack/circuit_stack/full = null,
	)
	for(var/obj/item/stack/stack_type as anything in items_inside)
		var/amt = items_inside[stack_type]
		new stack_type(src, amt, FALSE)

/obj/item/storage/bag/construction/admin/subspace
	name = "subspace construction bag"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon_state = "sub-bag"
