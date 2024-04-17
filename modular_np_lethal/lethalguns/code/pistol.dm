// Pistol but its evil and uses miecz magazines

/obj/item/gun/ballistic/automatic/pistol/weevil
	name = "\improper Zomushi pistol"
	desc = "A rare pistol firing the CIN .27-54 cartridge out of standard Miecz magazines."

	icon = 'modular_np_lethal/lethalguns/icons/guns32x.dmi'
	icon_state = "zomushi"

	rack_sound = 'modular_np_lethal/lethalguns/sound/zomushi/zomushi_rack.wav'
	fire_sound = 'modular_np_lethal/lethalguns/sound/zomushi/zomushi.wav'
	suppressed_sound = 'modular_np_lethal/lethalguns/sound/zomushi/zomushi_silenced.wav'

	pickup_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_lightgun.wav'
	drop_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_lightgun.wav'

	w_class = WEIGHT_CLASS_NORMAL

	accepted_magazine_type = /obj/item/ammo_box/magazine/miecz

	suppressor_x_offset = 7
	suppressor_y_offset = 0

	fire_delay = 0.25 SECONDS

/obj/item/gun/ballistic/automatic/pistol/weevil/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/automatic/pistol/weevil/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/weevil/examine_more(mob/user)
	. = ..()

	. += "An unusual competitor to the widely popular Wespe pistols, \
		firing a CIN cartridge instead of any locally produced by Solfed. \
		Taking advantage of existing technology, it uses Miecz magazines in a functional, \
		though 'interesting' solution."

	return .

/obj/item/gun/ballistic/automatic/pistol/weevil/starts_empty
	spawnwithmagazine = FALSE

// What if the sindano fired CIN ammo?

/obj/item/gun/ballistic/automatic/seiba_smg
	name = "\improper Seiba submachine gun"
	desc = "A compact submachinegun firing .27-54 cartridges out of Miecz magazines."

	icon = 'modular_np_lethal/lethalguns/icons/guns48x.dmi'
	icon_state = "seiba"

	worn_icon = 'modular_np_lethal/lethalguns/icons/mob_sprites/worn.dmi'
	worn_icon_state = "seiba"

	lefthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/lefthand.dmi'
	righthand_file = 'modular_np_lethal/lethalguns/icons/mob_sprites/righthand.dmi'
	inhand_icon_state = "seiba"

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/miecz

	load_sound = 'modular_np_lethal/lethalguns/sound/seiba/seiba_magin.wav'
	rack_sound = 'modular_np_lethal/lethalguns/sound/seiba/seiba_rack.wav'
	fire_sound = 'modular_np_lethal/lethalguns/sound/seiba/seiba.wav'
	suppressed_sound = 'modular_np_lethal/lethalguns/sound/seiba/seiba_silenced.wav'
	can_suppress = TRUE

	pickup_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_lightgun.wav'
	drop_sound = 'modular_np_lethal/lethalguns/sound/pickup_sounds/drop_lightgun.wav'

	can_bayonet = FALSE

	suppressor_x_offset = 6

	burst_size = 3
	fire_delay = 0.18 SECONDS

	spread = 7.5

/obj/item/gun/ballistic/automatic/seiba_smg/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/seiba_smg/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/seiba_smg/examine_more(mob/user)
	. = ..()

	. += "Another unusual competitor to a local sol design, the Seiba was made as an alternative to the venerable Sindano. \
		Much like it's .27-54 firing pistol counterpart, the Seiba uses Miecz magazines in the role of a submachinegun this time. \
		Similarly to the Sindano, it sports a three round burst fire, though it manages slightly faster firing speeds to the sindano \
		thanks to the specs of the .27-54 cartridge."

	return .

/obj/item/gun/ballistic/automatic/seiba_smg/starts_empty
	spawnwithmagazine = FALSE
