/datum/atom_skin/plant_bag
	abstract_type = /datum/atom_skin/plant_bag

/datum/atom_skin/plant_bag/original
	preview_name = "Original"
	new_icon = 'icons/obj/service/hydroponics/equipment.dmi'
	new_icon_state = "plantbag"
	new_worn_icon = 'icons/mob/clothing/belt.dmi'

/datum/atom_skin/plant_bag/linen
	preview_name = "Linen"
	new_icon = 'modular_nova/modules/primitive_cooking_additions/icons/plant_bag.dmi'
	new_icon_state = "plantbag_primitive"
	new_worn_icon = 'modular_nova/modules/primitive_cooking_additions/icons/plant_bag_worn.dmi'

/obj/item/storage/bag/plants

/obj/item/storage/bag/plants/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/plant_bag)

// This is so the linen reskin shows properly in the suit storage.
///obj/item/storage/bag/plants/build_worn_icon(default_layer, default_icon_file, isinhands, female_uniform, override_state, override_file, mutant_styles)
//	if(default_layer == SUIT_STORE_LAYER && current_skin == "Linen")
//		override_file = 'modular_nova/modules/primitive_cooking_additions/icons/plant_bag_worn_mirror.dmi'

//	return ..()

/// Simple helper to reskin this item into its primitive variant.
/obj/item/storage/bag/plants/proc/make_primitive()
	//current_skin = "Linen"

	//icon = unique_reskin[current_skin][RESKIN_ICON]
	//icon_state = unique_reskin[current_skin][RESKIN_ICON_STATE]
	//worn_icon = unique_reskin[current_skin][RESKIN_WORN_ICON]
	//worn_icon_state = unique_reskin[current_skin][RESKIN_WORN_ICON_STATE]

	update_appearance()

/// A helper for the primitive variant, for mappers.
/obj/item/storage/bag/plants/primitive
	//current_skin = "Linen" // Just so it displays properly when in suit storage
	icon = 'modular_nova/modules/primitive_cooking_additions/icons/plant_bag.dmi'
	icon_state = "plantbag_primitive"
	worn_icon = 'modular_nova/modules/primitive_cooking_additions/icons/plant_bag_worn.dmi'
	worn_icon_state = "plantbag_primitive"
	can_reskin = FALSE

/obj/item/storage/bag/plants/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	if(!isprimitivedemihuman(crafter) && !isashwalker(crafter))
		return
	make_primitive()

/obj/item/storage/bag/plants/portaseeder
	can_reskin = FALSE

