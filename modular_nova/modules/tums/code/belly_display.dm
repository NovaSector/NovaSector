/// This isn't where the magic happens for doing the overlays.
/// See the /erp/ alt_appearance subtype for more info.
/obj/item/belly_function/proc/do_alt_appearance(mob/living/carbon/human/target, do_cut, size)
	/// Don't do anything on null targets.
	if(isnull(target))
		return
	/// Dummies use normal overlays instead of alt_appearance for correct chargen behaviour.
	/// If an admin puts a belly on a dummy in tdome for some reason & you get flashbanged, yell at them!
	else if(isdummy(target))
		if(do_cut == TRUE)
			target.cut_overlay(overlay_south)
			target.cut_overlay(overlay_north)
			target.cut_overlay(overlay_horizontal)
			last_size = -1
			/// Overlay_south is used as an indicator that overlays are present, so axe it.
			overlay_south = null
		else
			target.add_overlay(overlay_south)
			target.add_overlay(overlay_north)
			target.add_overlay(overlay_horizontal)
	/// Normal players use alt_appearance for the proper ability to hide bellies from nonconsenting viewers.
	else
		if(do_cut)
			for(var/ticker in 1 to size)
				target.remove_alt_appearance("erp_belly_south-[ticker]")
				target.remove_alt_appearance("erp_belly_north-[ticker]")
				target.remove_alt_appearance("erp_belly_horizontal-[ticker]")
			last_size = -1
			/// Overlay_south is used as an indicator that overlays are present, so axe it.
			overlay_south = null
		else
			/// TODO: We might need to migrate handtype from user.dna.species.id to a bespoke check.
			/// Depending on how scrungly people are willing to make their blorbos, generating entirely bespoke masks might become necessary.
			target.add_alt_appearance(/datum/atom_hud/alternate_appearance/erp/belly, "erp_belly_south-[size]", image(overlay_south, loc=target, layer=overlay_south.layer), AA_TARGET_SEE_APPEARANCE | AA_MATCH_TARGET_OVERLAYS, target, "erp_belly_south-", size, target.dna.species.id)
			target.add_alt_appearance(/datum/atom_hud/alternate_appearance/erp/belly, "erp_belly_north-[size]", image(overlay_north, loc=target, layer=overlay_north.layer), AA_TARGET_SEE_APPEARANCE | AA_MATCH_TARGET_OVERLAYS, target, "erp_belly_north-", size, target.dna.species.id)
			target.add_alt_appearance(/datum/atom_hud/alternate_appearance/erp/belly, "erp_belly_horizontal-[size]", image(overlay_horizontal, loc=target, layer=overlay_horizontal.layer), AA_TARGET_SEE_APPEARANCE | AA_MATCH_TARGET_OVERLAYS, target, "erp_belly_horizontal-", size, target.dna.species.id)

/// Helper function that handles rebuilding overlays.
/obj/item/belly_function/proc/refresh_overlays(mob/living/carbon/human/user, inbound_size)
	/// Cut out-of-date overlays.
	if(overlay_south != null)
		do_alt_appearance(user, TRUE, last_size)
	overlay_horizontal_all.Cut()
	overlay_south_all.Cut()
	overlay_north_all.Cut()

	var/oldstate = worn_icon_state

	/// Pick the icon file pair once - none of this depends on per-layer counter.
	var/icon/base_file = worn_icon
	var/icon/base_file_64x = worn_icon_64x
	var/is_teshari = istype(user.dna.species, /datum/species/teshari)
	if(use_skintone && draw_color == color)
		base_file = skintone_worn_icon
		base_file_64x = skintone_worn_icon_64x
	else if(is_teshari)
		base_file = worn_icon_teshari
		base_file_64x = worn_icon_teshari_64x


	/// Size counts down from maximum to minimum to ensure correct layering.
	var/counter = inbound_size
	var/max = inbound_size
	/// Dummies don't need advanced layering, as they directly use add_overlay.
	if(isdummy(user))
		max = 1
		/// Manually clamp to maxsize.
		if(maxsize < counter)
			counter = maxsize

	/// Slimes need translucency
	if(istype(user.dna.species, /datum/species/jelly))
		alpha = 155

	var/oldcolor = color
	color = draw_color

	for(var/cycles in 1 to max)
		var/icon/iconfile = counter > 10 ? base_file_64x : base_file

		/// Generate appearances.
		var/icon_state_wew = "[base_icon_state]-[counter]"
		worn_icon_state = "[icon_state_wew]_HORIZONTAL"
		overlay_horizontal = build_worn_icon(default_layer = horizontal_layer, default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = "[icon_state_wew]_FRONT"
		overlay_south = build_worn_icon(default_layer = south_layer, default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = "[icon_state_wew]_BACK"
		overlay_north = build_worn_icon(default_layer = north_layer, default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)

		/// Sizes above 10 use the 64x icon file, and therefore need offsets.
		if(counter > 10)
			overlay_horizontal.pixel_w -= 16
			overlay_horizontal.pixel_z -= 16
			overlay_south.pixel_w -= 16
			overlay_south.pixel_z -= 16
			overlay_north.pixel_w -= 16
			overlay_north.pixel_z -= 16

		/// Teshari chests sit ~3px lower, keeping size variety without flattening out.
		if(is_teshari)
			overlay_horizontal.pixel_z -= 3
			overlay_south.pixel_z -= 3
			overlay_north.pixel_z -= 3

		/// Final image() instances suitable for alt_appearance, logged for later cutting.
		overlay_horizontal = image(overlay_horizontal, loc = user, layer = overlay_horizontal.layer)
		overlay_south = image(overlay_south, loc = user, layer = overlay_south.layer)
		overlay_north = image(overlay_north, loc = user, layer = overlay_north.layer)
		overlay_horizontal_all += overlay_horizontal
		overlay_south_all += overlay_south
		overlay_north_all += overlay_north

		/// Add this layer.
		do_alt_appearance(user, FALSE, counter)
		counter -= 1

	worn_icon_state = oldstate
	color = oldcolor

/// Belly AAERP setup - use the belly_maxsize pref.
/datum/atom_hud/alternate_appearance/erp/belly/get_max_size(mob/viewer)
	return viewer.client?.prefs?.read_preference(/datum/preference/numeric/erp_belly_maxsize)

/// Belly AAERP setup - only show if the viewer has already opted in to see bellies whatsoever.
/datum/atom_hud/alternate_appearance/erp/belly/mobShouldSee(mob/viewer)
	if(viewer.client?.prefs?.read_preference(/datum/preference/toggle/erp/belly))
		return ..()
	return FALSE
