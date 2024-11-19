/obj/item/organ/internal/ears/mutant
	name = "fluffy ears"
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/obj/item/organ/internal/ears/mutant/with_inner
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears/with_inner

/obj/item/organ/internal/ears/cat

/obj/item/organ/internal/ears/fox

/obj/item/organ/external/ears
	name = "fluffy ears"
	desc = "Wait, there's two pairs of these?"
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"
	mutantpart_key = "ears"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("#FFAA00"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_EARS

	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/datum/bodypart_overlay/mutant/ears
	feature_key = "ears"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/ears/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/ears/get_global_feature_list()
	return SSaccessories.sprite_accessories["ears"]

/datum/bodypart_overlay/mutant/ears/with_inner
	feature_key = "ears"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

	/// Layer upon which we add the inner ears overlay
	var/inner_layer = EXTERNAL_FRONT


/datum/bodypart_overlay/mutant/ears/with_inner/get_image(image_layer, obj/item/bodypart/limb)
	var/mutable_appearance/base_ears = ..()

	// Only add inner ears on the inner layer
	if(image_layer != bitflag_to_layer(inner_layer))
		return base_ears

	// Construct image of inner ears, apply to base ears as an overlay
	feature_key += "inner"
	var/mutable_appearance/inner_ears = ..()
	inner_ears.appearance_flags = RESET_COLOR
	feature_key = initial(feature_key)

	base_ears.overlays += inner_ears
	return base_ears
