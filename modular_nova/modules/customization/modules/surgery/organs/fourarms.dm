// Kept as a single organ for the sake of simplicity.
/obj/item/organ/fourarms
	name = "extra arms"
	desc = "An extra pair of grabby appendages."
	organ_flags = ORGAN_EXTERNAL

	mutantpart_key = FEATURE_FOURARMS

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_FOURARMS

	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/fourarms

/*
	It is not an oversight that this organ is not co-dependent with the four-arms trait.

	By keeping traits and sprite overlays separate, players aren't forced to engage with finnicky four-arm mechanics if they...
	...only want a different appearance.
*/

/datum/bodypart_overlay/mutant/fourarms
	feature_key = FEATURE_FOURARMS
	layers = ALL_EXTERNAL_OVERLAYS
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/fourarms/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/fourarms/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_FOURARMS]
