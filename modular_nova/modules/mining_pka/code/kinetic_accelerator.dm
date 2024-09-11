//Proto-Kinetic Accelerators

/obj/item/gun/energy/recharge/kinetic_accelerator/nomod/railgun
	name = "proto-kinetic railgun"
	desc = "Before the nice streamlined and modern day Proto-Kinetic Accelerator was created, multiple designs were drafted by the Mining Research and Development \
	team. Many were failures, including this one, which came out too bulky and too ineffective. Well recently the MR&D Team got drunk and said 'fuck it we ball' and \
	went back to the bulky design, overclocked it, and made it functional, turning it into what is essentially a literal man portable particle accelerator. \
	The design results in a massive hard to control blast of kinetic energy, with the power to punch right through creatures and cause massive damage. The \
	only problem with the design is that it is so bulky you need to carry it with two hands, and the technology has been outfitted with a special firing pin \
	that denies use near or on the station, due to its destructive nature."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticrailgun"
	base_icon_state = "kineticrailgun"
	inhand_icon_state = "kineticgun"
	w_class = WEIGHT_CLASS_HUGE
	pin = /obj/item/firing_pin/wastes
	recharge_time = 3 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/railgun)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_HEAVY
	max_mod_capacity = 0 
	recoil = 3
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/recharge/kinetic_accelerator/nomod/railgun/add_bayonet_point()
	return

/obj/item/gun/energy/recharge/kinetic_accelerator/repeater
	name = "proto-kinetic repeater"
	desc = "During the pizza party celebrating the release of the new crusher designs, the Mining Research and Development team members were only allowed one slice. \
	One member exclaimed 'I wish we could have more than one slice' and another replied 'I wish we could shoot the accelerator more than once' and thus, the repeater \
	on the spot. The repeater trades a bit of power for the ability to fire three shots before becoming empty, while retaining the ability to fully recharge in one \
	go. The extra technology packed inside to make this possible unfortunately reduces mod space meaning you cant carry as many mods compared to a regular accelerator."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticrepeater"
	base_icon_state = "kineticrepeater"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/repeater)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	max_mod_capacity = 60

/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun
	name = "proto-kinetic shotgun"
	desc = "During the crusher design pizza party, one member of the Mining Research and Development team brought out a real riot shotgun, and killed three \
	other research members with one blast. The MR&D Director immedietly thought of a genuis idea, creating the proto-kinetic shotgun moments later, which he \
	immedietly used to execute the research member who brought the real shotgun. The proto-kinetic shotgun trades off some mod capacity and cooldown in favor \
	of firing three shots at once with reduce range and power. The total damage of all three shots is higher than a regular PKA but the individual shots are weaker."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticshotgun"
	base_icon_state = "kineticshotgun"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shotgun)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	max_mod_capacity = 60

/obj/item/gun/energy/recharge/kinetic_accelerator/glock
	name = "proto-kinetic pistol"
	desc = "During the pizza party for the Mining Research and Development team, one special snowflake researcher wanted a mini murphy instead of a regular \
	pizza slice, so reluctantly the Director bought him his mini murphy, which the dumbass immedietly dropped ontop of a PKA. Suddenly the idea to create \
	a 'build your own PKA' design was created. The proto-kinetic pistol is arguably worse than the base PKA, sporting lower damage and range. But this lack \
	of base efficiency allows room for nearly double the mods, making it truely 'your own PKA'."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticpistol"
	base_icon_state = "kineticpistol"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/glock)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	max_mod_capacity = 200

/obj/item/gun/energy/recharge/kinetic_accelerator/glock/add_bayonet_point()
	return

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave
	name = "proto-kinetic shockwave"
	desc = "Quite frankly, we have no idea how the Mining Research and Development team came up with this one, all we know is that alot of \
	beer was involved. This proto-kinetic design will slam the ground, creating a shockwave around the user, with the same power as the base PKA.\
	The only downside is the lowered mod capacity, the lack of range it offers, and the higher cooldown, but its pretty good for clearing rocks."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticshockwave"
	base_icon_state = "kineticshockwave"
	inhand_icon_state = "kineticgun"
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shockwave)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	max_mod_capacity = 60

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/add_bayonet_point()
	return

/obj/item/gun/energy/recharge/kinetic_accelerator/nomod/m79
	name = "proto-kinetic grenade launcher"
	desc = "Made in a drunk frenzy during the creation of the kinetic railgun, the kinetic grenade launcher fires the same bombs used by \
	the mining modsuit. Due to the technology needed to pack the bombs into this weapon, there is no space for modification."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticglauncher"
	base_icon_state = "kineticglauncher"
	inhand_icon_state = "kineticgun"
	pin = /obj/item/firing_pin/wastes
	recharge_time = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/m79)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	max_mod_capacity = 0

/obj/item/gun/energy/recharge/kinetic_accelerator/nomod/m79/add_bayonet_point()
	return

/obj/item/gun/energy/recharge/kinetic_accelerator/nomod/crowbar_act(mob/living/user, obj/item/I)
	. = TRUE
	to_chat(user, span_notice("This weapon cannot have its modifications removed."))

/obj/item/gun/energy/recharge/kinetic_accelerator/nomod/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/borg/upgrade/modkit))
		to_chat(user, span_notice("This weapon cannot have its modifications removed."))
	else
		..()
