GLOBAL_LIST_EMPTY(aaerp_maskcache)

// == EXPANDED MIRROR OF ALT_APPEARANCE/BASIC ==
/datum/atom_hud/alternate_appearance/erp
	/// Target atom that this alt_appearance is applied to.
	var/atom/target
	/// The final mixdown image actually displayed in client.images, including layered overlays via BLEND_INSET_OVERLAY.
	var/image/image
	/// The original image that was provided for this overlay, before edits for BLEND_INSET_OVERLAY support.
	var/image/original_image
	/// The base key for this ERP part's series of appearances.  Used for finding other related alt_appearances.
	var/base_key = ""
	/// The size of this ERP part.  Used for bellies, et al, so people can disable hyper stuff.
	var/size

	/// Icon state used for the off-hand mask.  Some unique hand types will require overriding this.
	var/offhand_iconstate = "offhand_clip"
	/// List of bespoke off-hand mask variants for unique hand types.
	var/list/supported_offhands = list(
		SPECIES_TESHARI = "offhand_clip_teshari",
		SPECIES_VOX_PRIMALIS = "offhand_clip_vox_primalis"
	)
	/// Icon state used for the shoe mask.  Some unique leg types will require overriding this.
	var/shoe_iconstate = "shoe_clip"
	/// List of bespoke shoe mask variants for unique leg types.
	var/list/supported_shoes = list(
		SPECIES_TESHARI = "shoe_clip_teshari",
		SPECIES_VOX_PRIMALIS = "shoe_clip_vox_primalis"
	)

	uses_global_hud_category = FALSE
	/// List of hooked signals, as per basic alt_appearances.
	var/list/signals_registering = list(
		COMSIG_MOB_ANTAGONIST_REMOVED,
		COMSIG_MOB_GHOSTIZED,
		COMSIG_MOB_MIND_TRANSFERRED_INTO,
		COMSIG_MOB_MIND_TRANSFERRED_OUT_OF,
	)

/datum/atom_hud/alternate_appearance/erp/New(key, image/base_image, options = AA_TARGET_SEE_APPEARANCE, in_target, in_basekey, in_size, in_bodytype)
	target = in_target
	base_key = in_basekey
	size = in_size
	if(in_bodytype in supported_offhands)
		offhand_iconstate = supported_offhands[in_bodytype]
	if(in_bodytype in supported_shoes)
		shoe_iconstate = supported_shoes[in_bodytype]
	..()
	transfer_overlays = options & AA_MATCH_TARGET_OVERLAYS
	/// Set the alt_appearance image to the specified one.  This image gets modified.
	image = base_image
	/// Clone the original image to retain it for a final overlay.
	original_image = image(base_image)
	original_image.pixel_x -= image.pixel_x
	original_image.pixel_y -= image.pixel_y
	original_image.alpha = 255
	image.appearance_flags |= KEEP_TOGETHER
	var/temp_alpha = image.alpha
	image.color = COLOR_WHITE
	image.alpha = temp_alpha
	LAZYADD(target.update_on_z, image)
	if(transfer_overlays)
		copy_overlays(target, TRUE)

	add_atom_to_hud(target)
	target.set_hud_image_active(appearance_key, exclusive_hud = src)

	if((options & AA_TARGET_SEE_APPEARANCE) && ismob(target))
		if(mobShouldSee(target))
			show_to(target)

/datum/atom_hud/alternate_appearance/erp/mobShouldSee(mob/viewer)
	/// Sanity check section here.
	if(target == null)
		return FALSE
	if(!islist(target.alternate_appearances))
		return FALSE
	var/key = "[base_key][(size+1)]"
	if(isnull(key))
		return FALSE
	/// Determine the max size for the target to be able to view.
	var/maxsize = get_max_size(viewer)
	/// If we're already above the viewer's maximum size pref, back out.
	if(size > maxsize)
		return FALSE
	/// There is a higher size to render, either stop here or hide.
	if(target.alternate_appearances[key] != null)
		/// If it's too big for the user we won't render it, so stop here- this is the highest layer.
		if(size + 1 > maxsize)
			return TRUE
		/// Otherwise, hide this to avoid wasted draw calls.
		return FALSE
	else
		/// This is the top layer and nothing else says no: go ahead and render.
		return TRUE

/// Helper function for getting a viewer's maximum size pref.
/// Base form: return viewer.client?.prefs?.read_preference(some_numeric_preference)
/datum/atom_hud/alternate_appearance/erp/proc/get_max_size(mob/viewer)
	return 0

/datum/atom_hud/alternate_appearance/erp/Destroy()
	. = ..()
	LAZYREMOVE(target.update_on_z, image)
	QDEL_NULL(image)
	target = null

/datum/atom_hud/alternate_appearance/erp/track_mob(mob/new_viewer)
	RegisterSignals(new_viewer, signals_registering, PROC_REF(check_hud), override = TRUE)

/datum/atom_hud/alternate_appearance/erp/untrack_mob(mob/former_viewer)
	UnregisterSignal(former_viewer, signals_registering)

/datum/atom_hud/alternate_appearance/erp/add_atom_to_hud(atom/target_atom)
	LAZYINITLIST(target_atom.hud_list)
	target_atom.hud_list[appearance_key] = image
	return ..()

/datum/atom_hud/alternate_appearance/erp/remove_atom_from_hud(atom/target_atom)
	. = ..()
	LAZYREMOVE(target_atom.hud_list, appearance_key)
	target_atom.set_hud_image_inactive(appearance_key)
	if(. && !QDELETED(src))
		qdel(src)

/// This is where the magic happens.  This overrides base copy_overlays.
/// By copying only overlays that would layer above the core image...
/// ...and using BLEND_INSET_OVERLAY, they only overlay over the core image.
/// This means you don't get duplicate parts or pixels that then render over your actual appearance.overlays.
/datum/atom_hud/alternate_appearance/erp/copy_overlays(atom/other, cut_old)
	var/list/cached_other = target.overlays
	if(length(image.overlays) != length(cached_other) + 1)
		image.overlays -= image.overlays
		for(var/an_overlay in cached_other)
			var/arm_check = FALSE
			if(findtext(an_overlay:icon_state, "_arm"))
				if(an_overlay:layer == -BODYPARTS_LAYER)
					arm_check = TRUE
			if(an_overlay:layer >= image.layer || arm_check)
				var/image/new_overlay = image(an_overlay)
				var/static/mask_icons = list()
				if(arm_check)
					new_overlay.layer = -BODYPARTS_HIGH_LAYER
				if(new_overlay.layer == -HANDS_LAYER || new_overlay.layer == -GLOVES_LAYER || new_overlay.layer == -BODYPARTS_HIGH_LAYER || arm_check)
					if(!(offhand_iconstate in mask_icons))
						mask_icons[offhand_iconstate] = icon('modular_nova/modules/tums/icons/helpers.dmi', offhand_iconstate)
					if(!(new_overlay.icon in GLOB.aaerp_maskcache))
						GLOB.aaerp_maskcache[new_overlay.icon] = list()
					if(!(offhand_iconstate in GLOB.aaerp_maskcache[new_overlay.icon]))
						var/icon/masked_iconfile = icon(new_overlay.icon)
						masked_iconfile.Blend(mask_icons[offhand_iconstate], ICON_MULTIPLY)
						GLOB.aaerp_maskcache[new_overlay.icon][offhand_iconstate] = masked_iconfile
					new_overlay.icon = GLOB.aaerp_maskcache[new_overlay.icon][offhand_iconstate]
				else if(new_overlay.layer == -SHOES_LAYER)
					if(!(shoe_iconstate in mask_icons))
						mask_icons[shoe_iconstate] = icon('modular_nova/modules/tums/icons/helpers.dmi', shoe_iconstate)
					if(!(new_overlay.icon in GLOB.aaerp_maskcache))
						GLOB.aaerp_maskcache[new_overlay.icon] = list()
					if(!(shoe_iconstate in GLOB.aaerp_maskcache[new_overlay.icon]))
						var/icon/masked_iconfile = icon(new_overlay.icon)
						masked_iconfile.Blend(mask_icons[shoe_iconstate], ICON_MULTIPLY)
						GLOB.aaerp_maskcache[new_overlay.icon][shoe_iconstate] = masked_iconfile
					new_overlay.icon = GLOB.aaerp_maskcache[new_overlay.icon][shoe_iconstate]
				else
					new_overlay.blend_mode = BLEND_INSET_OVERLAY
				new_overlay.pixel_x -= image.pixel_x
				new_overlay.pixel_y -= image.pixel_y
				image.overlays += new_overlay
		image.overlays += original_image
