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
		if(do_cut == TRUE)
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
	overlay_horizontal_all -= overlay_horizontal_all
	overlay_south_all -= overlay_south_all
	overlay_north_all -= overlay_north_all

	var/oldstate = worn_icon_state
	/// Size counts down from maximum to minimum to ensure correct layering.
	var/counter = inbound_size
	var/max = inbound_size
	/// Dummies don't need advanced layering, as they directly use add_overlay.
	if(isdummy(user))
		max = 1
	for(var/cycles in 1 to max)
		/// Pick an icon file first.
		var/iconfile = counter > 10 ? worn_icon_64x : worn_icon
		if(use_skintone == TRUE)
			iconfile = counter > 10 ? skintone_worn_icon_64x : skintone_worn_icon
		else if(user.dna.species.id == SPECIES_TESHARI)
			iconfile = counter > 10 ? worn_icon_teshari_64x : worn_icon_teshari

		/// Slimes need translucency
		if(use_slime_alpha)
			alpha = 155

		/// Generate appearances next.
		var/icon_state_wew = "[base_icon_state]-[counter]"
		worn_icon_state = "[icon_state_wew]_HORIZONTAL"
		overlay_horizontal = src.build_worn_icon(default_layer = (hori_layer), default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = "[icon_state_wew]_FRONT"
		overlay_south = src.build_worn_icon(default_layer = (south_layer), default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = "[icon_state_wew]_BACK"
		overlay_north = src.build_worn_icon(default_layer = (north_layer), default_icon_file = iconfile, isinhands = FALSE, override_file = iconfile)
		worn_icon_state = oldstate

		/// Sizes above 10 use the 64x icon file, and therefor need offsets.
		if(counter > 10)
			overlay_horizontal.pixel_x -= 16
			overlay_horizontal.pixel_y -= 16
			overlay_south.pixel_x -= 16
			overlay_south.pixel_y -= 16
			overlay_north.pixel_x -= 16
			overlay_north.pixel_y -= 16

		/// Teshari chests are about 3px lower than normal, this allows them to still have the same variety of sizes without flattening out.
		if(user.dna.species.id == SPECIES_TESHARI)
			overlay_horizontal.pixel_y -= 3
			overlay_south.pixel_y -= 3
			overlay_north.pixel_y -= 3

		/// Create final image() instances suitable for alt_apperance & log them in overlays to cut later as needed.
		overlay_horizontal = image(overlay_horizontal, loc = user, layer = overlay_horizontal.layer)
		overlay_south = image(overlay_south, loc = user, layer = overlay_south.layer)
		overlay_north = image(overlay_north, loc = user, layer = overlay_north.layer)
		overlay_horizontal_all += overlay_horizontal
		overlay_south_all += overlay_south
		overlay_north_all += overlay_north

		/// Finally, actually add this layer of overlays.
		do_alt_appearance(user, FALSE, counter)
		counter -= 1


/// Belly AAERP setup - use the belly_maxsize pref.
/datum/atom_hud/alternate_appearance/erp/belly/get_max_size(mob/viewer)
	return viewer.client?.prefs?.read_preference(/datum/preference/numeric/erp_belly_maxsize)

/// Belly AAERP setup - only show if the viewer has already opted in to see bellies whatsoever.
/datum/atom_hud/alternate_appearance/erp/belly/mobShouldSee(mob/viewer)
	if((viewer.client?.prefs?.read_preference(/datum/preference/toggle/erp/belly) == TRUE))
		return ..()
	return FALSE
