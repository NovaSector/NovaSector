//Proto-Kinetic Accelerators

/obj/item/gun/energy/recharge/kinetic_accelerator/variant //Parent Variant so we can apply general changes
/obj/item/gun/energy/recharge/kinetic_accelerator/variant/Initialize(mapload)
	. = ..()
	if(type == /obj/item/gun/energy/recharge/kinetic_accelerator/variant) // we don't want these prototypes to exist
		return INITIALIZE_HINT_QDEL

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/attackby(obj/item/attacking_item, mob/user)
	if(istype(attacking_item, /obj/item/borg/upgrade/modkit/chassis_mod))
		to_chat(user, span_notice("This weapon doesn't have variant appearances."))
	else
		return ..()

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/nomod/crowbar_act(mob/living/user, obj/item/I)
	to_chat(user, span_notice("This weapon cannot have its modifications removed."))
	return ITEM_INTERACT_BLOCKING

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/nomod/

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/nomod/attackby(obj/item/attacking_item, mob/user)
	if(istype(attacking_item, /obj/item/borg/upgrade/modkit))
		to_chat(user, span_notice("This weapon cannot have modifications applied."))
	else
		return ..()


/obj/item/gun/energy/recharge/kinetic_accelerator/variant/railgun
	name = "proto-kinetic railgun"
	desc = parent_type::desc + " This variant seems to use all its energy into an hyper focused shoot, and needs two hands to use."
	special_desc = "Before the nice streamlined and modern day Proto-Kinetic Accelerator was created, multiple designs were drafted by the Mining Research and Development \
	team. Many were failures, including this one, which came out too bulky and too ineffective. Well recently the MR&D Team got drunk and said 'fuck it we ball' and \
	went back to the bulky design, overclocked it, and made it functional, turning it into what is essentially a literal man portable particle accelerator. \
	The design results in a massive hard to control blast of kinetic energy, with the power to punch right through creatures and cause massive damage. The \
	only problem with the design is that it is so bulky you need to carry it with two hands. On the positive side, the weapon is easy to fire, so even those with \
	chunky fingers 	will be able to use it."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticrailgun"
	base_icon_state = "kineticrailgun"
	inhand_icon_state = "kineticgun"
	w_class = WEIGHT_CLASS_HUGE
	pin = /obj/item/firing_pin/wastes
	recharge_time = 3 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/railgun)
	weapon_weight = WEAPON_HEAVY
	max_mod_capacity = 0
	recoil = 3
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/railgun/add_bayonet_point()
	return

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/repeater
	name = "proto-kinetic repeater"
	desc = parent_type::desc + " This variant seems to be specialized into firing thrice and has a longer barrel."
	special_desc = "During the pizza party celebrating the release of the new crusher designs, the Mining Research and Development team members were only allowed one slice. \
	One member exclaimed 'I wish we could have more than one slice' and another replied 'I wish we could shoot the accelerator more than once' and thus, the repeater \
	on the spot. The repeater trades a bit of power for the ability to fire three shots before becoming empty, while retaining the ability to fully recharge in one \
	go. The extra technology packed inside to make this possible unfortunately reduces mod space meaning you cant carry as many mods compared to a regular accelerator."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticrepeater"
	base_icon_state = "kineticrepeater"
	inhand_icon_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/repeater)
	max_mod_capacity = 65

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/repeater/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shotgun
	name = "proto-kinetic shotgun"
	desc = parent_type::desc + " This variant seems to have a prism that splits the ray in three."
	special_desc = "During the crusher design pizza party, one member of the Mining Research and Development team brought out a real riot shotgun, and killed three \
	other research members with one blast. The MR&D Director immediately thought of a genius idea, creating the proto-kinetic shotgun moments later, which he \
	immediately used to execute the research member who brought the real shotgun. The proto-kinetic shotgun trades off some mod capacity and cooldown in favor \
	of firing three shots at once with reduce range and power. The total damage of all three shots is higher than a regular PKA but the individual shots are weaker."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticshotgun"
	base_icon_state = "kineticshotgun"
	inhand_icon_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shotgun)
	max_mod_capacity = 65
	randomspread = 0

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/glock
	name = "proto-kinetic pistol"
	desc = parent_type::desc + " This variant seems bare, but has a significant amount of mod slots."
	special_desc = "During the pizza party for the Mining Research and Development team, one special snowflake researcher wanted a mini murphy instead of a regular \
	pizza slice, so reluctantly the Director bought him his mini murphy, which the dumbass immediately dropped ontop of a PKA. Suddenly the idea to create \
	a 'build your own PKA' design was created. The proto-kinetic pistol is arguably worse than the base PKA, sporting lower damage and range. But this lack \
	of base efficiency allows room for a bit over double the mods, making it truly 'your own PKA'."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticpistol"
	base_icon_state = "kineticpistol"
	inhand_icon_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/glock)
	max_mod_capacity = 220 // 30 over base.

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/glock/add_bayonet_point()
	return

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave
	name = "proto-kinetic shockwave"
	desc = parent_type::desc + " This variant produces a shockwave that surrounds the user with kinetic energy."
	special_desc = "This proto-kinetic design will slam the ground, creating a shockwave around the user, with the same power as the base PKA.\
	The only downside is the lowered mod capacity, the lack of range it offers, and the higher cooldown, but its pretty good for clearing rocks. \
	Quite frankly, we have no idea how the Mining Research and Development team came up with this one, all we know is that alot of beer was involved."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticshockwave"
	base_icon_state = "kineticshockwave"
	inhand_icon_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shockwave)
	max_mod_capacity = 65
	randomspread = 0

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave/add_bayonet_point()
	return

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/nomod/m79
	name = "proto-kinetic grenade launcher"
	desc = parent_type::desc + " This variant launches mining charges, using the kinetic energy to propel them."
	special_desc = "Made in a drunk frenzy during the creation of the kinetic railgun, the kinetic grenade launcher fires the same bombs used by \
	the mining modsuit. Due to the technology needed to pack the bombs into this weapon, there is no space for modification."
	icon = 'modular_nova/modules/mining_pka/icons/pka.dmi'
	icon_state = "kineticglauncher"
	base_icon_state = "kineticglauncher"
	inhand_icon_state = "kineticgun"
	pin = /obj/item/firing_pin/wastes
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/m79)
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	max_mod_capacity = 0

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/nomod/m79/add_bayonet_point()
	return

//Shockwave process_fire override to prevent Point Blank, we shoot towards the edge of the direction of the user, like with jumpboots.

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	target = get_edge_target_turf(user, user.dir)
	return ..()
