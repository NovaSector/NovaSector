// visor  skins
/datum/atom_skin/techno_visor
	abstract_type = /datum/atom_skin/techno_visor
	change_base_icon_state = TRUE

/datum/atom_skin/techno_visor/black
	preview_name = "Tactical Black"
	new_icon_state = "black"

/datum/atom_skin/techno_visor/steel
	preview_name = "Shiny Steel"
	new_icon_state = "shiny"

/datum/atom_skin/techno_visor/copper
	preview_name = "Polished Copper"
	new_icon_state = "copper"

/datum/atom_skin/techno_visor/green
	preview_name = "Display Green"
	new_icon_state = "green"

/datum/atom_skin/techno_visor/vintage
	preview_name = "Vintage Computer"
	new_icon_state = "vintage"

/datum/atom_skin/techno_visor/red
	preview_name = "Violent Red"
	new_icon_state = "violent"

/obj/item/clothing/glasses/techno_visor
	name = "techno-visor"
	desc = "A complicated, curved visor with a network of cameras that allow vision through it. \
		Has the unique ability to consume the traits of specialized huds and glasses it touches, \
		becoming like the much lamer piece of eyewear it just destroyed. Surely it's fine to have this \
		so close to your eyes."
	icon = 'modular_iris/doppler_ports/super_glasses/icons/visors.dmi'
	icon_state = "black"
	worn_icon = 'modular_iris/doppler_ports/super_glasses/icons/worn/visors.dmi'
	worn_icon_state = "black"
	obj_flags = UNIQUE_RENAME

/obj/item/clothing/glasses/techno_visor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/glasses_stats_thief)

/obj/item/clothing/glasses/techno_visor/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/techno_visor)

/obj/item/clothing/glasses/techno_visor/change_glass_color(new_color_type)
	if(glass_colour_type)
		RemoveElement(/datum/element/wearable_client_colour, glass_colour_type, ITEM_SLOT_EYES, forced = forced_glass_color, comsig_toggle = COMSIG_CLICK_CTRL)
	glass_colour_type = new_color_type
	if(glass_colour_type)
		AddElement(/datum/element/wearable_client_colour, glass_colour_type, ITEM_SLOT_EYES, forced = forced_glass_color, comsig_toggle = COMSIG_CLICK_CTRL)
