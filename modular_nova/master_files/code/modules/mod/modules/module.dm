

/obj/item/mod/module/add_module_overlay(obj/item/source, list/overlays, mutable_appearance/standing, mutable_appearance/draw_target, isinhands, icon_file)
	if(!isnull(get_species_overlay_icon()))
		add_custom_worn_overlay(source, overlays, standing, draw_target, isinhands, icon_file)
		return
	. = ..()

/obj/item/mod/module/proc/get_species_overlay_icon()
	return mod.wearer?.dna?.species.get_custom_mod_module_icon()

/obj/item/mod/module/proc/add_custom_worn_overlay(obj/item/source, list/overlays, mutable_appearance/standing, mutable_appearance/draw_target, isinhands, icon_file)

	if (isinhands)
		return

	var/list/added_overlays = generate_custom_worn_overlay(source, standing)
	if (!added_overlays)
		return

	if (!mask_worn_overlay)
		overlays += added_overlays
		return

	for (var/mutable_appearance/overlay as anything in added_overlays)
		overlay.add_filter("mod_mask_overlay", 1, alpha_mask_filter(icon = icon(draw_target.icon, draw_target.icon_state)))
		overlays += overlay

/obj/item/mod/module/proc/generate_custom_worn_overlay(atom/movable/source, mutable_appearance/standing)
	if(!mask_worn_overlay)
		if(!has_required_parts(mod.mod_parts, need_active = TRUE))
			return
	else
		var/datum/mod_part/part_datum = mod.get_part_datum(source)
		if (!part_datum?.sealed)
			return

	. = list()
	var/used_overlay = get_current_overlay_state()
	if (!used_overlay)
		return

	var/mutable_appearance/module_icon = mutable_appearance(get_species_overlay_icon(), used_overlay, layer = standing.layer + 0.1)
	if(use_mod_colors)
		module_icon.color = mod.color
		if (mod.cached_color_filter)
			module_icon = filter_appearance_recursive(module_icon, mod.cached_color_filter)

	. += module_icon
	SEND_SIGNAL(src, COMSIG_MODULE_GENERATE_WORN_OVERLAY, ., standing)

