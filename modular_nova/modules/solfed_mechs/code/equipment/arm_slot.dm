/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_riotgun
	name = "\improper S-12 \"Warder\" Kinetic Riotgun"
	desc = "A Solfed riot-control weapon designed for suppression and area denial. Fires dense rubber slugs."
	icon_state = "mecha_scatter"
	equip_cooldown = 1.5 SECONDS
	projectile = /obj/projectile/bullet/c85x20mm/rubber
	projectiles = 20
	projectiles_cache = 20
	projectiles_cache_max = 80
	projectiles_per_shot = 1
	variance = 10
	harmful = TRUE
	ammo_type = MECHA_AMMO_RUBBER
	fire_sound = 'sound/items/weapons/gun/shotgun/shot.ogg'
	detachable = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_rotary
	name = "\improper VX-9 \"Brimstone\" Rotary Cannon"
	desc = "A Solfed assault-grade rotary cannon. Fires high-velocity incendiary rounds in rapid bursts."
	icon = 'modular_nova/modules/solfed_mechs/icons/mecha_equipment.dmi'
	icon_state = "rotary"
	equip_cooldown = 0.4 SECONDS
	projectile = /obj/projectile/bullet/c40sol/incendiary
	projectiles = 180
	projectiles_cache = 180
	projectiles_cache_max = 720
	projectiles_per_shot = 3
	variance = 5
	randomspread = 1
	projectile_delay = 1
	harmful = TRUE
	ammo_type = MECHA_AMMO_INCENDIARY
	fire_sound = 'sound/items/weapons/gun/hmg/hmg.ogg'
	detachable = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_railgun
	name = "\improper T-99 \"Hammerfall\" Mass Driver"
	desc = "A siege-grade ballistic weapon mounted on the Thanatos platform. Fires hyperdense slugs capable of penetrating reinforced structures."
	icon_state = "mecha_pulse"
	equip_cooldown = 6 SECONDS
	projectile = /obj/projectile/bullet/rocket/c250x40mm
	projectiles = 12
	projectiles_cache = 12
	projectiles_cache_max = 24
	projectiles_per_shot = 1
	variance = 2
	harmful = TRUE
	ammo_type = MECHA_AMMO_SIEGE
	fire_sound = 'modular_nova/modules/solfed_mechs/sounds/railgun.ogg'
	detachable = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/solfed_teargas
	name = "\improper SGL-7 \"Vigil\" Gas Launcher"
	desc = "A weapon for peacekeeper exosuits. Launches primed tear gas grenades to disperse hostile crowds."
	icon_state = "mecha_grenadelnchr"
	projectile = /obj/item/grenade/chem_grenade/solfed/teargas
	fire_sound = 'sound/items/weapons/gun/general/grenade_launch.ogg'
	projectiles = 6
	projectiles_cache = 6
	projectiles_cache_max = 24
	missile_speed = 1.5
	equip_cooldown = 6 SECONDS
	ammo_type = MECHA_AMMO_TEARGAS
	detachable = FALSE
	///Time between firing and grenade detonating.
	var/det_time = 1 SECONDS

/obj/item/grenade/chem_grenade/solfed
	icon = 'modular_nova/modules/solfed_mechs/icons/grenades.dmi'
	///icon_state for the detonated grenade.
	det_time = 1 SECONDS
	possible_fuse_time = list("10")
	var/post_detonation_icon_state = null
	///Has this exploded already?
	var/detonated = FALSE

/obj/item/grenade/chem_grenade/solfed/attack_self(mob/user)
	if (detonated)
		to_chat(user, span_warning("This grenade has already been used."))
	else
		to_chat(user, span_warning("You can't seem to find a way to hand-prime this mech grenade."))
	return FALSE

/obj/item/grenade/chem_grenade/solfed/teargas
	name = "tear gas grenade"
	desc = "A non-lethal crowd control device that releases a cloud of irritating gas upon detonation. Used to disperse hostile gatherings and subdue uncooperative individuals."
	base_icon_state = "teargas"
	stage = GRENADE_READY
	post_detonation_icon_state = "teargas_spent"

//Ammount of chem divided by two compared to normal teargas for balance
/obj/item/grenade/chem_grenade/solfed/teargas/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/cup/beaker/large/beaker_one = new(src)
	var/obj/item/reagent_containers/cup/beaker/large/beaker_two = new(src)

	beaker_one.reagents.add_reagent(/datum/reagent/consumable/condensedcapsaicin, 30)
	beaker_one.reagents.add_reagent(/datum/reagent/potassium, 20)
	beaker_two.reagents.add_reagent(/datum/reagent/phosphorus, 20)
	beaker_two.reagents.add_reagent(/datum/reagent/consumable/sugar, 20)

	beakers += beaker_one
	beakers += beaker_two

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/solfed_teargas/proj_init(obj/item/grenade/chem_grenade/teargas/grenade)
	var/turf/tar_turf = get_turf(src)
	message_admins("[ADMIN_LOOKUPFLW(usr)] fired a [grenade] in [ADMIN_VERBOSEJMP(tar_turf)]")
	usr.log_message("fired a [grenade] in [AREACOORD(tar_turf)].", LOG_GAME)
	usr.log_message("fired a [grenade] in [AREACOORD(tar_turf)].", LOG_ATTACK)
	addtimer(CALLBACK(grenade, TYPE_PROC_REF(/obj/item/grenade/chem_grenade/solfed/teargas, detonate)), det_time, TIMER_STOPPABLE | TIMER_DELETE_ME)

/obj/item/grenade/chem_grenade/solfed/teargas/detonate(mob/living/lanced_by)
	. = ..()
	set_post_detonation_icon()

///Updates the grenades icon after detonation.
/obj/item/grenade/chem_grenade/solfed/proc/set_post_detonation_icon()
	if(post_detonation_icon_state)
		icon_state = post_detonation_icon_state
		detonated = TRUE

/obj/item/grenade/chem_grenade/solfed/napalm
	name = "napalm grenade"
	base_icon_state = "napalm"
	desc = "A high-temperature incendiary device. Spreads gel-based compound that clings to surfaces and burns intensely. Handle with extreme caution."
	stage = GRENADE_READY
	post_detonation_icon_state = "napalm_spent"
	///Amount of sparks made by the grenade, used to light the napalm on fire.
	var/spark_amount = 3

/obj/item/grenade/chem_grenade/solfed/napalm/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/cup/beaker/large/beaker_one = new(src)
	var/obj/item/reagent_containers/cup/beaker/large/beaker_two = new(src)

	beaker_one.reagents.add_reagent(/datum/reagent/napalm, 30)
	beaker_two.reagents.add_reagent(/datum/reagent/napalm, 30)

	beakers += beaker_one
	beakers += beaker_two

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/solfed_napalm
	name = "\improper VX-13 \"Ashmaker\" Incendiary Mortar"
	desc = "A short-range mortar system mounted on Prometheus-class breach mechs. Fires incendiary gel shells engineered to cling, burn and flush entrenched targets without compromising hull integrity."
	icon_state = "mecha_grenadelnchr"
	projectile = /obj/item/grenade/chem_grenade/solfed/napalm
	fire_sound = 'sound/items/weapons/gun/general/grenade_launch.ogg'
	projectiles = 6
	projectiles_cache = 6
	projectiles_cache_max = 24
	missile_speed = 1.5
	equip_cooldown = 6 SECONDS
	ammo_type = MECHA_AMMO_NAPALM
	detachable = FALSE
	///Time between firing the grenade and it exploding.
	var/det_time = 1 SECONDS

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/solfed_napalm/proj_init(obj/item/grenade/chem_grenade/solfed/napalm/grenade)
	var/turf/tar_turf = get_turf(src)
	message_admins("[ADMIN_LOOKUPFLW(usr)] fired a [grenade] in [ADMIN_VERBOSEJMP(tar_turf)]")
	usr.log_message("fired a [grenade] in [AREACOORD(tar_turf)].", LOG_GAME)
	usr.log_message("fired a [grenade] in [AREACOORD(tar_turf)].", LOG_ATTACK)
	update_icon_state()
	addtimer(CALLBACK(grenade, TYPE_PROC_REF(/obj/item/grenade/chem_grenade/solfed/napalm, detonate)), det_time, TIMER_STOPPABLE | TIMER_DELETE_ME)

/obj/item/grenade/chem_grenade/solfed/napalm/detonate(mob/living/lanced_by)
	. = ..()
	set_post_detonation_icon()
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/grenade/chem_grenade/solfed/napalm, ignite_napalm_pool)), 1 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME)

///Create an amount of sparks from the grenade.
/obj/item/grenade/chem_grenade/solfed/napalm/proc/ignite_napalm_pool()
	do_sparks(spark_amount, FALSE, src)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/turret/solfed_minigun
	name = "\improper VX-2 \"Scythe\" Rotary Turret"
	desc = "A twin-barrel rotary turret mounted on the Thanatos-class breacher. Fires alternating bursts of .40 Sol Long rounds for suppression and anti-personnel engagement."
	icon = 'modular_nova/modules/solfed_mechs/icons/mecha_equipment.dmi'
	icon_state = "rotary"
	equip_cooldown = 0.3 SECONDS
	projectile = /obj/projectile/bullet/c40sol
	projectiles = 300
	projectiles_cache = 300
	projectiles_cache_max = 1200
	projectiles_per_shot = 4
	variance = 4
	randomspread = 1
	projectile_delay = 0.5
	harmful = TRUE
	ammo_type = MECHA_AMMO_LMG
	fire_sound = 'sound/items/weapons/gun/hmg/hmg.ogg'
	detachable = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_emp_cannon
	name = "\improper EMC-2521 EMP Cannon"
	desc = "An advanced electromagnetic pulse cannon developed for Hermes-class recon mechs. Fires precision EMP bursts capable of disabling electronics and lightly shielded systems."
	icon_state = "mecha_ion"
	equip_cooldown = 2 SECONDS
	projectile = /obj/projectile/ion/small
	projectiles = 12
	projectiles_cache = 12
	projectiles_cache_max = 48
	projectile_delay = 0
	variance = 2
	harmful = TRUE
	ammo_type = MECHA_AMMO_EMP
	fire_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	detachable = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_carbine
	name = "\improper MMR-2543A \"Qarad\" Light Machinegun"
	desc = "A mech-mounted adaptation of the Qarad Light Machine Gun, chambered in .40 Sol Long. Designed for Hermes-class recon mechs to deliver precise semi-automatic bursts."
	icon_state = "mecha_carbine"
	equip_cooldown = 0.6 SECONDS
	projectile = /obj/projectile/bullet/c40sol
	projectiles = 30
	projectiles_cache = 30
	projectiles_cache_max = 120
	projectile_delay = 1
	projectiles_per_shot = 2
	variance = 3
	harmful = TRUE
	ammo_type = MECHA_AMMO_LMG
	fire_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	detachable = FALSE

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/solfed
	name = "S-MBG 'Aegis' medical beamgun"
	desc = "A SolFed-engineered medical beamgun designed for field deployment in hostile environments. Emits stabilized nanite pulses for rapid triage and wound closure."
	detachable = FALSE
	energy_drain = 12	//Slightly higher than NT, assuming NT tech is a bit better here.

/obj/item/weldingtool/electric/arc_welder/mech_mounted
	name = "Atlas-mounted torch"
	light_system = NO_LIGHT_SUPPORT
	light_range = 0

// mounted subtype that deletes its tool flash element on init
/obj/item/weldingtool/electric/arc_welder/mech_mounted/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/tool_flash)

/obj/item/mecha_parts/mecha_equipment/solfed_welder
	name = "Atlas Engineering Torch"
	desc = "A SolFed-engineered torch for field repairs, structural welding, and tactical deconstruction."
	icon_state = "mecha_wholegen"
	equip_cooldown = 1 SECONDS
	force = 15
	damtype = BURN
	hitsound = 'sound/items/tools/welder.ogg'
	energy_drain = 10
	detachable = FALSE
	///The actual welding tool used for the welding actions.
	var/obj/item/weldingtool/electric/arc_welder/mech_mounted/welding_tool
	///Switch between main and alternate welder action.
	var/welding = FALSE

/obj/item/mecha_parts/mecha_equipment/solfed_welder/Initialize(mapload)
	. = ..()
	welding_tool = new /obj/item/weldingtool/electric/arc_welder/mech_mounted(src)
	welding_tool.welding = TRUE
	welding_tool.force = 15
	welding_tool.damtype = BURN
	welding_tool.hitsound = 'sound/items/tools/welder.ogg'

/obj/item/mecha_parts/mecha_equipment/solfed_welder/action(mob/living/source, atom/target, list/modifiers)
	if(!action_checks(target))
		return FALSE

	if(source.combat_mode)
		welding_tool.melee_attack_chain(source, target)
	else if(welding)
		target.welder_act_secondary(source, welding_tool)
	else
		target.welder_act(source, welding_tool)

	TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_EQUIPMENT(type), equip_cooldown)
	SEND_SIGNAL(source, COMSIG_MOB_USED_MECH_EQUIPMENT, chassis)
	chassis.use_energy(energy_drain)

	return TRUE

/obj/item/mecha_parts/mecha_equipment/solfed_welder/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_toggle_welding, VEHICLE_CONTROL_SETTINGS)

/obj/item/mecha_parts/mecha_equipment/solfed_welder/detach(atom/moveto)
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_toggle_welding, VEHICLE_CONTROL_SETTINGS)
	return ..()

/obj/item/mecha_parts/mecha_equipment/solfed_welder/Destroy()
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_toggle_welding, VEHICLE_CONTROL_SETTINGS)
	return ..()

/datum/action/vehicle/sealed/mecha/solfed_toggle_welding
	name = "Toggle Welder Mode"
	button_icon = 'modular_nova/modules/solfed_mechs/icons/action_mecha.dmi'
	button_icon_state = "welder_off"
	desc = "Switches between main and alternate welding modes."

/datum/action/vehicle/sealed/mecha/solfed_toggle_welding/Trigger(mob/clicker, trigger_flags)
	var/obj/item/mecha_parts/mecha_equipment/solfed_welder/welder = locate(/obj/item/mecha_parts/mecha_equipment/solfed_welder) in chassis.contents
	welder.welding = !welder.welding
	if(welder.welding)
		button_icon_state = "welder_on"
	else
		button_icon_state = "welder_off"
	build_all_button_icons()
	to_chat(clicker, "Welder mode toggled: [welder.welding ? "Alternate mode" : "Main mode"].")
