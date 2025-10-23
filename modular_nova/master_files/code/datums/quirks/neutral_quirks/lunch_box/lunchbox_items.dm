/obj/item/storage/toolbox/lunchbox
	name = "Lunchbox"
	icon = 'modular_nova/master_files/code/datums/quirks/neutral_quirks/lunch_box/lunchbox.dmi'
	icon_state = "nanotrasen"
	desc = "A Spessman's best friend, a beautifully packed lunch."
	storage_type = /datum/storage/toolbox/lunchbox

/datum/storage/toolbox/lunchbox
	silent = TRUE

/datum/storage/toolbox/lunchbox/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/food,
		/obj/item/reagent_containers/cup,
		/obj/item/paper,
		/obj/item/pen,
	))
