/// GPS module for proteans - works just like a regular GPS
/obj/item/mod/module/gps/protean
	name = "MOD integrated positioning system"
	desc = "This module uses common galactic positioning technology to calculate the user's position anywhere in space, \
		allowing you to see and share your location with tracking devices."
	icon_state = "gps"
	module_type = MODULE_USABLE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 0.2
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/gps)
	cooldown_time = 0.5 SECONDS
	complexity = 0 // Built into protean suits by default
	allow_flags = MODULE_ALLOW_INACTIVE

/obj/item/mod/module/gps/protean/Initialize(mapload)
	. = ..()
	// Set up the GPS component with "Protean" as the default tag
	AddComponent(/datum/component/gps/item, "Protean", state = GLOB.deep_inventory_state, overlay_state = FALSE)

/obj/item/mod/module/gps/protean/on_use(mob/activator)
	// Open the GPS interface when activated
	attack_self(mod.wearer)

