/datum/atom_skin/meson
	abstract_type = /datum/atom_skin/meson
	new_icon_state = "meson_scouter"

/datum/atom_skin/meson/glasses
	preview_name = "Meson Glasses"
	new_icon = 'icons/obj/clothing/glasses.dmi'
	new_icon_state = "meson"
	new_worn_icon = 'icons/mob/clothing/eyes.dmi'

/datum/atom_skin/meson/scouter
	preview_name = "Meson Scouter"
	new_icon = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi'
	new_icon_state = "meson_scouter"
	new_worn_icon = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'

/obj/item/clothing/glasses/meson/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/meson, blacklisted_subtypes = subtypesof(/datum/atom_skin/meson/engine))

/obj/item/clothing/glasses/meson/night

/obj/item/clothing/glasses/meson/night/setup_reskins()
	return

/obj/item/clothing/glasses/meson/gar

/obj/item/clothing/glasses/meson/gar/setup_reskins()
	return

/datum/atom_skin/meson/engine
	abstract_type = /datum/atom_skin/meson/engine

/datum/atom_skin/meson/engine/trayson
	preview_name = "Engine Glasses"
	new_icon = 'icons/obj/clothing/glasses.dmi'
	new_icon_state = "trayson-"
	new_worn_icon = 'icons/mob/clothing/eyes.dmi'

/datum/atom_skin/meson/engine/scouter
	preview_name = "Engine Scouter"
	new_icon = 'modular_nova/modules/meson_scouter/icons/meson_scouter.dmi'
	new_icon_state = "trayson-"
	new_worn_icon = 'modular_nova/modules/meson_scouter/icons/meson-scouter_mob.dmi'

/obj/item/clothing/glasses/meson/engine/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/meson/engine)

