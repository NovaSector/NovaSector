/// Random xenoarch exosuit spawner
/// Basically customly painted exosuits with some interesting(or not) equipment
/obj/effect/spawner/random/artifact_exosuit
	name = "xenoarchaeology artifact exosuit loot spawner"
	desc = "Just an old junk."
	icon_state = "ripley"
	loot = list(
		/obj/vehicle/sealed/mecha/reticence/artifact,
		/obj/vehicle/sealed/mecha/odysseus/artifact,
		/obj/vehicle/sealed/mecha/savannah_ivanov/artifact,
		/obj/vehicle/sealed/mecha/durand/artifact,
	)

/// Shitty cell used in artifact mechs
/obj/item/stock_parts/power_store/cell/artifact_crap
	name = "\improper Dying old Nanotrasen bluespace cell"
	desc = "A rechargeable transdimensional power cell. This one is almost dead, barely keeping any charge. What happened to it?"
	icon_state = "bscell"
	maxcharge = STANDARD_CELL_CHARGE * 0.3

/// Reticence with shit battery and rusted gun/rcd.
/obj/vehicle/sealed/mecha/reticence/artifact
	desc = "A silent, fast, and nigh-invisible exosuit. Dust covers it from the bottom to the top. It has seen better days. \
			The legs looks like they were scratched by animals and the cockpit was probably used as a nest. \
			Interestigly, looks like there are personal belongins inside. There is a voodoo doll glued tightly to a side of a chair and \
			a dream catcher hanging from the top of the cabin. Suprisingly, they are untouched."
	name = "\improper Phantom"
	wreckage = /obj/structure/mecha_wreckage/reticence/artifact
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/silenced/artifact,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/artifact_psionic,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(),
	)

/obj/structure/mecha_wreckage/reticence/artifact
	name = "\improper Phantom wreckage"
	icon_state = "phantom-broken"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/mecha.dmi'
	desc = "You almost get phantom pain from looking at this."
	welder_salvage = list(/obj/item/computer_disk/virus/mime, /obj/item/clothing/head/beret)

/obj/vehicle/sealed/mecha/reticence/artifact/Initialize(mapload)
	. = ..()
	take_damage(max_integrity * 0.5, sound_effect=FALSE) // Start half health

/obj/vehicle/sealed/mecha/reticence/artifact/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/artifact_crap(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/silenced/artifact
	name = "\improper Jammed S.H.H. \"Quietus\" Carbine"
	desc = "A weapon for combat exosuits. A mime invention, field tests have shown that targets cannot even scream before going down. \
			This copy is heavily rusted and needs to be reloaded every single shot."
	projectiles = 1

// Same as clown honker, but screams instead
/obj/item/mecha_parts/mecha_equipment/weapon/artifact_psionic
	name = "\improper Psionic Temporary Scream Desensetizer 2500"
	desc = "Emits psionic wavefront which stuns nearby organic lifeforms. To human ear sounds like a horrible scream."
	icon_state = "mecha_honker"
	mech_flags = EXOSUIT_MODULE_RETICENCE
	energy_drain = 200
	equip_cooldown = 15 SECONDS
	range = MECHA_MELEE|MECHA_RANGED
	kickback = FALSE

// Sadly, have to copy from honker, since the sound is hardcoded
/obj/item/mecha_parts/mecha_equipment/weapon/artifact_psionic/action(mob/source, atom/target, list/modifiers)
	if(!action_checks(target))
		return
	playsound(chassis, 'sound/hallucinations/wail.ogg', 100, TRUE)
	to_chat(source, "[icon2html(src, source)]<font color='red' size='5'>AAAAAAAAAH</font>")
	for(var/mob/living/carbon/M in ohearers(6, chassis))
		if(!M.can_hear())
			continue
		var/turf/turf_check = get_turf(M)
		if(isspaceturf(turf_check) && !turf_check.Adjacent(src)) //in space nobody can hear you scream.
			continue
		to_chat(M, "<font color='red' size='7'>AAAAAAH</font>")
		M.SetSleeping(0)
		M.adjust_stutter(40 SECONDS)
		var/obj/item/organ/internal/ears/ears = M.get_organ_slot(ORGAN_SLOT_EARS)
		if(ears)
			ears.adjustEarDamage(0, 30)
		M.Paralyze(60)
		if(prob(30))
			M.Stun(200)
			M.Unconscious(80)
		else
			M.set_jitter_if_lower(1000 SECONDS)
	return ..()

	log_message("Screamed from [src.name]. Scary!", LOG_MECHA)
	var/turf/T = get_turf(src)
	message_admins("[ADMIN_LOOKUPFLW(source)] used a PTSD in [ADMIN_VERBOSEJMP(T)]")
	source.log_message("used a PTSD at [AREACOORD(T)].", LOG_GAME)
	source.log_message("used a PTSD at [AREACOORD(T)].", LOG_ATTACK)

/// Just an Odysseus. But hey! Free mech.
/obj/vehicle/sealed/mecha/odysseus/artifact
	desc = "An exosuit designed(repurposed?) to evacuate wounded soliders from the heat of the battle. \
			An outer shell is coated with black/blue paint, strong enough to survive all that time in the rock. \
			Seen better days, but, if treated properly, this example might help you once more."
	name = "\improper Medivac"
	icon_state = "medivac"
	base_icon_state = "medivac"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/mecha.dmi'
	wreckage = /obj/structure/mecha_wreckage/odysseus/artifact
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/medical/sleeper,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/artifact,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank, /obj/item/mecha_parts/mecha_equipment/thrusters/ion),
	)

/obj/vehicle/sealed/mecha/odysseus/artifact/Initialize(mapload)
	. = ..()
	take_damage(max_integrity * 0.5, sound_effect=FALSE) // Start half health, once again

/obj/structure/mecha_wreckage/odysseus/artifact
	name = "\improper Medivac wreckage"
	desc = "A military surgeon, who did not come back from the last battle. May you rest in peace."
	icon_state = "medivac-broken"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/mecha.dmi'

/obj/vehicle/sealed/mecha/odysseus/artifact/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/artifact_crap(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/artifact
	name = "ancient exosuit medical beamgun"
	desc = "Equipment for medical exosuits. Generates a focused beam of medical nanites. \
			This model is heavily outdated and consumes exosuit power like a black hole."
	energy_drain = 250

/// Slower, but bulkier version of savannah_ivanov
/obj/vehicle/sealed/mecha/savannah_ivanov/artifact
	name = "\improper Red Sunday"
	desc = "An insanely overbulked mecha that handily crushes single-pilot opponents. The price is that you need two pilots to use it. \
			This one is painted red with a huge hammer and sickle emblem on it's back. Probably originates from the Third Soviet Union. \
			The servos seem to be rusted with no way to fix them, although the armor on this thing is pretty impressive."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/coop_mech.dmi'
	movedelay = 6 // Very slow
	max_integrity = 600 // But damn, this is a walking fortress
	wreckage = /obj/structure/mecha_wreckage/savannah_ivanov/artifact

/obj/vehicle/sealed/mecha/savannah_ivanov/artifact/Initialize(mapload)
	. = ..()
	take_damage(max_integrity * 0.8, sound_effect=FALSE) // Start 20% health, since it has a lot of hp

/obj/structure/mecha_wreckage/savannah_ivanov/artifact
	name = "\improper Red Sunday wreckage"
	desc = "A fallen comrade. Once the fourth Union rises to its power, you will be avenged."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/coop_mech.dmi'

/// Riot durand with disablers.
/obj/vehicle/sealed/mecha/durand/artifact
	desc = "Aged modified combat exosuit, designed to supress riots by non-lethal means. Since it was pretty costly to produce \
			this bad boy and teargas and stunbatons were doing just fine, the project was abandoned. For an unknown reason, this one is camo painted."
	name = "\improper Peacemaker Unit 07"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/mecha.dmi'
	icon_state = "peacemaker"
	base_icon_state = "peacemaker"
	movedelay = 3 // Slightly faster than original
	max_integrity = 300 // Lower integrity than original
	force = 5 // Nuh uh.
	wreckage = /obj/structure/mecha_wreckage/durand/artifact
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/disabler/artifact,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/disabler/artifact,
	)

/obj/vehicle/sealed/mecha/durand/artifact/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/artifact_crap(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/vehicle/sealed/mecha/durand/artifact/Initialize(mapload)
	. = ..()
	take_damage(max_integrity * 0.5, sound_effect=FALSE) // Start half health

/obj/structure/mecha_wreckage/durand/artifact
	name = "\improper Peacemaker wreckage"
	desc = "A law has fallen today."
	icon_state = "peacemaker-broken"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/mecha.dmi'

/obj/item/mecha_parts/mecha_equipment/weapon/energy/disabler/artifact
	equip_cooldown = 0 SECONDS // SPRAY AND PRAY
	name = "\improper MG-DS \"Forced Treatment\" disabler rotory gun"
	desc = "A prototype non-lethal weapon, designed to supress riots. Never got to be mass-produced."
	energy_drain = 25
	projectile = /obj/projectile/beam/disabler/weak/artifact_weaker
	variance = 0
	projectiles_per_shot = 1

/obj/projectile/beam/disabler/weak/artifact_weaker
	damage = 10

