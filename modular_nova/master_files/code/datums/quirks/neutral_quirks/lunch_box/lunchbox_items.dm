/obj/item/storage/lunchbox
	name = "Lunchbox"
	icon = 'modular_nova/master_files/code/datums/quirks/neutral_quirks/lunch_box/lunchbox.dmi'
	icon_state = "nanotrasen"
	desc = "A Spessman's best friend, a beautifully packed lunch."

	inhand_icon_state = "toolbox_default"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'


	material_flags = NONE
	storage_type = /datum/storage/lunchbox
	w_class = WEIGHT_CLASS_NORMAL
	obj_flags = CONDUCTS_ELECTRICITY

	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 7
	demolition_mod = 1
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5)
	attack_verb_continuous = list("bonks")
	attack_verb_simple = list("bonks")
	hitsound = 'sound/items/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	wound_bonus = 5
	storage_type = /datum/storage/lunchbox

/datum/storage/lunchbox
	open_sound = 'sound/items/handling/toolbox/toolbox_open.ogg'
	rustle_sound = 'sound/items/handling/toolbox/toolbox_rustle.ogg'

/datum/storage/lunchbox/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/food,
		/obj/item/reagent_containers/cup,
		/obj/item/paper,
		/obj/item/pen,
	))

/obj/item/storage/lunchbox/nt_gold
	icon_state = "nanotrasen_gold"

/obj/item/storage/lunchbox/syndicate
	icon_state = "syndicate"

/obj/item/storage/lunchbox/interdyne
	icon_state = "interdyne"

/obj/item/storage/lunchbox/solfed
	icon_state = "solfed"

/obj/item/storage/lunchbox/gold
	icon_state = "gold"

/obj/item/storage/lunchbox/light
	icon_state = "blank"

/obj/item/storage/lunchbox/dark
	icon_state = "dark"

/obj/item/storage/lunchbox/space
	icon_state = "space"

/obj/item/storage/lunchbox/hearts
	icon_state = "hearts"

/obj/item/storage/lunchbox/heart
	icon_state = "heart"

/obj/item/storage/lunchbox/heart/monster
	icon_state = "heart_monster"

/obj/item/storage/lunchbox/tvtime
	icon_state = "tvtime"

/obj/item/storage/lunchbox/ally
	icon_state = "ally"

/obj/item/storage/lunchbox/ship
	desc = "A Spessman's best friend: a beautifully packed lunch, on the side depicting a ship moving fast around a planet."
	icon_state = "ship"

/obj/item/storage/lunchbox/ammo
	desc = "A well packed ammo box..."
	icon_state = "ammo"

/obj/item/storage/lunchbox/cyber
	icon_state = "cyber"

/obj/item/storage/lunchbox/cyber/dark
	icon_state = "cyber_dark"

/obj/item/storage/lunchbox/lavaland
	icon_state = "lavaland"

/obj/item/storage/lunchbox/rainy
	icon_state = "rainy"

/obj/item/storage/lunchbox/fire_clock
	desc = "A lunchbox with a flaming clock on it... weird... it seems to have the letter 'L' but the rest is scratched out."
	icon_state = "fire_clock"
