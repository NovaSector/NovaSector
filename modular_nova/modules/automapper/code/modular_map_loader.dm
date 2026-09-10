/**
 * Maps like Tramstation build themselves out of map modules, which are loaded from
 * /obj/modular_map_root. Those roots are INITIALIZE_IMMEDIATE and load their module through
 * INVOKE_ASYNC, so a module (and any attachment root nested inside it) finishes loading at an
 * arbitrary point after the base map has been parsed - frequently after LoadGroup() has already
 * asked SSautomapper to place its templates. Whichever load lands last wins the turf, so the
 * automapper's templates end up buried under the modules.
 *
 * Rather than trying to force an order onto two loaders that both yield mid-load, we make the
 * modules honour the same turf blacklist the base map does. The automapper's footprint is then
 * carved out of every module too, and the template can be placed whenever it likes.
 */
/datum/map_template/map_module/update_blacklist(turf/placement, list/input_blacklist)
	. = ..()
	for(var/turf/reserved_turf as anything in SSautomapper.reserved_turfs)
		input_blacklist[reserved_turf] = TRUE
