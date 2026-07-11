/obj/item/organ/frills
	mutantpart_key = FEATURE_FRILLS

/datum/bodypart_overlay/mutant/frills
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/frills/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/frills/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner)
	if(!..())
		return FALSE
	var/mob/living/carbon/human/human = owner || bodypart_owner.owner
	if(!istype(human))
		return TRUE
	return !sprite_datum.is_hidden(human)

/datum/bodypart_overlay/mutant/frills/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_FRILLS]

// Frills special case for hat - this is unfortunately copy pasted from TG because we need image_icon_state and there is no cleaner way to do this short of refactoring the whole thing...
/datum/bodypart_overlay/mutant/frills/get_singular_image(image_icon_state, layer_index, layer_real, mob/living/carbon/human/owner, icon_override = null, obj/item/bodypart/limb)
	if(!LAZYLEN(limb?.owner?.hair_masks))
		return ..()

	var/list/hair_masks_to_use = limb.owner.hair_masks
	var/frill_cache_key = "[sprite_datum.type]-[image_icon_state]-[jointext(hair_masks_to_use, ",")]"
	var/static/list/cached_frill_icons
	var/icon/cached_icon = LAZYACCESS(cached_frill_icons, frill_cache_key)
	if(isnull(cached_icon))
		cached_icon = icon(icon_override || sprite_datum.get_special_icon(owner), image_icon_state)
		for(var/datum/hair_mask/mask as anything in hair_masks_to_use)
			cached_icon.Blend(icon(mask::icon, mask::icon_state), ICON_ADD)
		LAZYSET(cached_frill_icons, frill_cache_key, cached_icon)

	var/mutable_appearance/uncached_appearance = mutable_appearance(cached_icon, layer = layer_real)
	if(sprite_datum.center)
		center_image(uncached_appearance, sprite_datum.special_x_dimension ? sprite_datum.get_special_x_dimension(owner) : sprite_datum.dimension_x, sprite_datum.dimension_y)
	return uncached_appearance
