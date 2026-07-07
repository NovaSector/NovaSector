/// Heres where the Administrative Fabricator and the Admin Techweb live

// techweb: modular_nova\master_files\code\modules\research\techweb\techweb_types.dm
// machine.dm define w/ nova edit code\__DEFINES\machines.dm
// TODO: sprites, flatpacks of common admin machines like the debug chem spawner, etc
/// Admin lathe, waow so cool, wow, wow so cool
/obj/machinery/rnd/production/colony_lathe/admin
	name = "administrative fabricator"
	desc = "These bad boys are seen just about anywhere someone would want or need to build fast, damn the consequences. \
		That tends to be colonies, especially on dangerous worlds, where the influences of this one machine can be seen \
		in every bit of architecture."
	icon = 'modular_nova/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "colony_lathe"
	base_icon_state = "colony_lathe"
	circuit = null
	production_animation = "colony_lathe_n"
	light_color = LIGHT_COLOR_BRIGHT_YELLOW
	light_power = 5
	allowed_buildtypes = COLONY_FABRICATOR
	speedup_disabled = TRUE
	/// techweb we intend to use for unlocking stuff.
	techweb_path = /datum/techweb/colony_fabricator
	/// The item we turn into when repacked
	repacked_type = /obj/item/flatpacked_machine/admin

/obj/machinery/rnd/production/colony_lathe/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/// Flat-packed version of the administrative fabricator
/obj/item/flatpacked_machine/admin
	name = "flat-packed administrative fabricator"
	/// For all flatpacked machines, set the desc to the type_to_deploy followed by ::desc to reuse the type_to_deploy's description
	desc = /obj/machinery/rnd/production/colony_lathe/admin::desc
	icon = 'modular_nova/modules/colony_fabricator/icons/packed_machines.dmi'
	icon_state = "colony_lathe_packed"
	/// What structure is created by this item.
	type_to_deploy = /obj/machinery/rnd/production/colony_lathe/admin
	/// How long it takes to create the structure in question.
	deploy_time = 4 SECONDS
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/flatpacked_machine/admin)

/obj/item/flatpacked_machine/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/// Printables list of admin items
/// When adding new items to the module, you should really add them here
// This also adds some printables of other various debug items
/datum/design/admin_pneumatic_cannon
	name = "Subspace Ballmatter Mass Projector"
	id = "admin_pneumatic_cannon"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/pneumatic_cannon/subspace
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_baseball_bat
	name = "Subspace Baseball Bat"
	id = "admin_baseball_bat"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/melee/baseball_bat/admin
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_pda
	name = "Subspace PDA"
	id = "admin_pda"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/modular_computer/pda/admin
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_laser_pointer
	name = "Subspace Laser Pointer"
	id = "admin_laser_pointer"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/laser_pointer/admin
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_door_remote
	name = "Subspace Door Remote"
	id = "admin_door_remote"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/door_remote/admin
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_reagent_gun
	name = "Subspace Reagent Gun"
	id = "admin_reagent_gun"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/gun/chem/admin
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_dagenblicky
	name = "Subspace Mass Projector Pen"
	id = "admin_dagenblicky"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/gun/magic/subspace/dagenblicky
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_vendor_beacon
	name = "Debug Vendor Beacon"
	id = "admin_vendor_beacon"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/summon_beacon/vendors/debug
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_health_analyzer
	name = "Subspace Health Analyzer"
	id = "admin_health_analyzer"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/healthanalyzer/advanced/admin
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_contacts
	name = "Subspace Contacts"
	id = "admin_contacts"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/clothing/glasses/meson/engine/admin/debug
	category = list(RND_CATEGORY_EQUIPMENT)

/datum/design/admin_multitool
	name = "Subspace Multitool"
	id = "admin_multitool"
	build_type = ADMIN_TECHWEB
	materials = list()
	build_path = /obj/item/multitool/admin
	category = list(RND_CATEGORY_EQUIPMENT)
