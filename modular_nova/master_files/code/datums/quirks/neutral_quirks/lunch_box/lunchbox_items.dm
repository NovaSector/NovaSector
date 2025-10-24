/obj/item/storage/toolbox/lunchbox
	name = "Lunchbox"
	icon = 'modular_nova/master_files/code/datums/quirks/neutral_quirks/lunch_box/lunchbox.dmi'
	icon_state = "nanotrasen"
	desc = "A Spessman's best friend, a beautifully packed lunch."
	material_flags = NONE
	storage_type = /datum/storage/toolbox/lunchbox

/datum/storage/toolbox/lunchbox/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/food,
		/obj/item/reagent_containers/cup,
		/obj/item/paper,
		/obj/item/pen,
	))

/obj/item/storage/toolbox/lunchbox
	name = "Lunchbox"
	icon = 'modular_nova/master_files/code/datums/quirks/neutral_quirks/lunch_box/lunchbox.dmi'
	icon_state = "nanotrasen"
	desc = "A Spessman's best friend, a beautifully packed lunch."

/obj/item/storage/toolbox/lunchbox/nt_gold
	icon_state = "nanotrasen_gold"

/obj/item/storage/toolbox/lunchbox/syndicate
	icon_state = "syndicate"

/obj/item/storage/toolbox/lunchbox/interdyne
	icon_state = "interdyne"

/obj/item/storage/toolbox/lunchbox/solfed
	icon_state = "solfed"

/obj/item/storage/toolbox/lunchbox/gold
	icon_state = "gold"

/obj/item/storage/toolbox/lunchbox/light
	icon_state = "blank"

/obj/item/storage/toolbox/lunchbox/dark
	icon_state = "dark"

/obj/item/storage/toolbox/lunchbox/space
	icon_state = "space"

/obj/item/storage/toolbox/lunchbox/hearts
	icon_state = "hearts"
