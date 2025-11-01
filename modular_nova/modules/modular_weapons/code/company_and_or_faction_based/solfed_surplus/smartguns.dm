/obj/item/gun/ballistic/automatic/smart_machine_gun/solfed
	name = "type-1 vasili smartgun"



	// Sounds (Very weighty sounds, cause god forbid solfed has fun)
	fire_sound = 'sound/items/weapons/gun/hmg/hmg.ogg'
	rack_sound = 'sound/items/weapons/gun/shotgun/rack.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_pickup1.ogg'
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	load_empty_sound = 'sound/items/weapons/gun/general/magazine_insert_empty.ogg'


	fire_sound_volume = 90

	pin = /obj/item/firing_pin

	accepted_magazine_type = /obj/item/ammo_box/magazine/smartgun_drum/vasili
	/// Just so fellow rescue teams cannot be shot
	iff_factions = list("sol-federation","ert")
