// Admin Tech Storage Belts //
// TODO: more variants for the other outfit types
// Empty variant
/obj/item/storage/belt/utility/debug
	name = "\improper bluespace satchel"
	desc = "This bad boy can fit all your bus in one place. Why do you have this?!"
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"
	storage_type = /datum/storage/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// Chief engineer tools variant, probably should just be killed off in favor the the bst bag
/obj/item/storage/belt/utility/full/powertools/debug
	name = "\improper engineer's bluespace satchel"
	desc = "Can hold a boatload of things... Why do you have this?!"
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"
	storage_type = /datum/storage/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// Yes hello I would like some tools in a debug outfit's belt
/obj/item/storage/belt/utility/debug/sst
	name = "\improper subspace technician's satchel"
	desc = "A hand manufactured satchel made of the finest materials, processes, and a creatively integrated bluespace anomaly core. \
	This one was carefully prestocked and organized by a Central Command Quartermaster to offer an extreme selection of goodies."
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"
	storage_type = /datum/storage/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/storage/belt/utility/debug/sst/PopulateContents()
	new	/obj/item/blueprints(src)
	new	/obj/item/construction/plumbing(src)
	new	/obj/item/universal_scanner(src)
	new	/obj/item/hand_labeler(src)
	new	/obj/item/storage/bag/trash/bluespace(src)
	new	/obj/item/melee/skateboard/hoverboard/admin(src)
	new	/obj/item/bodybag/bluespace(src)
	new	/obj/item/toy/crayon/spraycan/infinite(src)
	new	/obj/item/teleport_rod/admin(src)
	new	/obj/item/fishing_rod/telescopic/master(src)
	new	/obj/item/gun/energy/recharge/fisher/debug(src)
	new	/obj/item/mop/advanced(src)
	new	/obj/item/forcefield_projector(src)
	new	/obj/item/holosign_creator/atmos(src)
	new	/obj/item/lightreplacer/blue(src)
	new	/obj/item/construction/rld(src)
	new	/obj/item/rwd/admin(src)
	new	/obj/item/analyzer/ranged(src)
	new	/obj/item/construction/rtd/admin(src)
	new	/obj/item/construction/rcd/arcd(src)
	new	/obj/item/multitool/abductor(src)
	new	/obj/item/weldingtool/abductor(src)
	new	/obj/item/crowbar/power(src)
	new	/obj/item/screwdriver/power(src)
	new	/obj/item/pipe_dispenser/bluespace(src)
	new	/obj/item/rpd_upgrade/unwrench(src)

// Yes hello I would like some tools in a debug outfit's belt
/obj/item/storage/belt/utility/debug/bst
	name = "\improper bluespace technicians's satchel"
	desc = "A hand manufactured satchel made of the finest materials, processes, and a creatively integrated bluespace anomaly core. \
	This one was carefully prestocked and organized by a Central Command Quartermaster to service an engineering aligned technician."
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"
	storage_type = /datum/storage/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/storage/belt/utility/debug/bst/PopulateContents()
	new	/obj/item/blueprints(src)
	new	/obj/item/construction/plumbing(src)
	new	/obj/item/universal_scanner(src)
	new	/obj/item/storage/bag/trash/bluespace(src)
	new	/obj/item/bodybag/bluespace(src)
	new	/obj/item/teleport_rod/admin(src)
	new	/obj/item/mop/advanced(src)
	new	/obj/item/holosign_creator/atmos(src)
	new	/obj/item/lightreplacer/blue(src)
	new	/obj/item/construction/rld(src)
	new	/obj/item/rwd/admin(src)
	new	/obj/item/analyzer/ranged(src)
	new	/obj/item/construction/rtd/admin(src)
	new	/obj/item/construction/rcd/arcd(src)
	new	/obj/item/multitool/abductor(src)
	new	/obj/item/weldingtool/abductor(src)
	new	/obj/item/crowbar/power(src)
	new	/obj/item/screwdriver/power(src)
	new	/obj/item/pipe_dispenser/bluespace(src)
