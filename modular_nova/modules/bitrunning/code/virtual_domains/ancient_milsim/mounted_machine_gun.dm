/obj/item/automatic_turret_folded
	name = "folded heavy machine gun"
	desc = "A folded and unloaded heavy machine gun, ready to be deployed and used."
	icon = 'modular_nova/modules/mounted_machine_gun/icons/turret_objects.dmi'
	icon_state = "folded_hmg"
	inhand_icon_state = "folded_hmg"
	max_integrity = 250
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/automatic_turret_folded/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, 7 SECONDS, /obj/machinery/deployable_turret/hmg/ancient_milsim)

/obj/machinery/deployable_turret/hmg/ancient_milsim
	icon = 'modular_nova/modules/mounted_machine_gun/icons/turret.dmi'
	icon_state = "mmg"
	projectile_type = /obj/projectile/bullet/manned_turret/hmg/ancient_milsim
	number_of_shots = 1
	cooldown_duration = 1 SECONDS
	rate_of_fire = 2
	spawned_on_undeploy = /obj/item/automatic_turret_folded

/obj/machinery/deployable_turret/hmg/ancient_milsim/checkfire(atom/targeted_atom, mob/user)
	target = targeted_atom
	if(target == user || target == get_turf(src))
		return
	target_turf = get_turf(target)
	fire_helper(user)

/obj/projectile/bullet/manned_turret/hmg/ancient_milsim
	damage = 25
	armour_penetration = 15
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 1.4
	light_color = COLOR_SOFT_RED
	ricochets_max = 4
	ricochet_chance = 30
	dismemberment = 1
