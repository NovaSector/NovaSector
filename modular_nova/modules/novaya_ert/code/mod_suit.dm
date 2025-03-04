/datum/mod_theme/voskhod
	name = "refitted voskhod"
	desc = "A Heliostatic Coalition standard-issue heavy duty suit, designed for fortified positions operation and humanitarian aid."
	extended_desc = "A more expensive, yet more versatile replacement of the dated Voskhod powered armor, designed by the Magellanic Economic Corporate Union researchers \
	in collaboration with and for the needs of the Heliostatic Coalition. An efficient implementation of mixed exoskeletons in between and underneath its armor plating \
	allowed for an unprecedented level of protection through an overly abundant use of durathread-backed plasteel plating; and the remnant materials of its predecessor allow for \
	a dubiously efficient dissipation of any stray photon ray or a concentrated laser, were one to get hit by them. The suit's infamous autoparamedical systems \
	are also fully present - or their chemical synthesizing part, consisting of a thin web of subdermal autoinjectors, reaction cameras and tubes lined through the \
	insulation material - leading into its control unit where the relevant synthesis proceeds, mainly out of raw materials of the pharmaceutical industry; \
	omnizine's older brother, protozine. The sight of a white-and-green juggernaut is the one that instills many fears into numerous pirates; earning it the reputation of a peacekeeper \
	and a niche amongst the rimworld population."
	default_skin = "voskhod"
	armor_type = /datum/armor/mod_theme_voskhod
	complexity_max = DEFAULT_MAX_COMPLEXITY //Five of which is occupied by the in-builts, thus it's closer to 10
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	inbuilt_modules = list(
		/obj/item/mod/module/status_readout/operational/voskhod,
		/obj/item/mod/module/auto_doc,
	)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"voskhod" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_voskhod
	melee = 30
	bullet = 40
	laser = 20
	energy = 30
	bomb = 30
	bio = 30
	fire = 80
	acid = 85
	wound = 20

/obj/item/mod/control/pre_equipped/voskhod
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	theme = /datum/mod_theme/voskhod
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)
	default_pins = list(
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/auto_doc,
	)

/obj/item/mod/control/pre_equipped/voskhod/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/mouthhole,
	)
	default_pins = list(
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/thermal_regulator,
	)

/datum/mod_theme/policing
	name = "policing"
	desc = "A Novaya Rossiyskaya Imperiya Internal Affairs Collegia general purpose protective suit, designed for coreworld patrols."
	extended_desc = "An Apadyne Technologies outsourced, then modified for frontier use by the responding imperial police precinct, MODsuit model, \
		designed for reassuring panicking civilians than participating in active combat. The suit's thin plastitanium armor plating is durable against environment and projectiles, \
		and comes with a built-in miniature power redistribution system to protect against energy weaponry; albeit ineffectively. \
		Thanks to the modifications of the local police, additional armoring has been added to its legs and arms, at the cost of an increased system load."
	default_skin = "policing"
	armor_type = /datum/armor/mod_theme_policing
	complexity_max = DEFAULT_MAX_COMPLEXITY - 1
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.25
	slowdown_deployed = 0.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"policing" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_policing
	melee = 40
	bullet = 50
	laser = 30
	energy = 30
	bomb = 60
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/obj/item/mod/control/pre_equipped/policing
	theme = /datum/mod_theme/policing
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/magnetic_harness
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/magboot,
	)

/obj/item/mod/control/pre_equipped/policing/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/mod/module/status_readout/operational
	name = "MOD operational status readout module"
	desc = "A once-common module, this technology unfortunately went out of fashion in the safer regions of space; \
		however, it remained in use everywhere else. This particular unit hooks into the suit's spine, \
		capable of capturing and displaying all possible biometric data of the wearer; sleep, nutrition, fitness, fingerprints, \
		and even useful information such as their overall health and wellness. The vitals monitor also comes with a speaker, loud enough \
		to alert anyone nearby that someone has, in fact, died. This specific unit has a clock and operational ID readout."
	display_time = TRUE
	death_sound = 'modular_nova/modules/novaya_ert/sound/flatline.ogg'

/obj/item/mod/module/status_readout/operational/voskhod
	removable = FALSE

/obj/item/mod/module/auto_doc
	name = "MOD automatic paramedical module"
	desc = "The reverse-engineered and redesigned medical assistance system, previously used by the now decommissioned Voskhod combat armor. \
		The technology it uses is very similar to the one of the N-URSEI suites, yet miniaturised and lacking self-synthesis capabilities. \
		Using a built-in storage of chemical compounds and a miniature chemical mixer, it's capable of injecting its user with a plethora of drugs, \
		assisting them with their restoration. However, this system heavily relies on some rarely combat-available chemical compounds to prepare its injections, \
		mainly Protozine, which appear in the user's bloodstream from time to time, and its trivial damage assessment systems are prone to kicking in only when you're moderately wounded."
	icon_state = "adrenaline_boost"
	module_type = MODULE_TOGGLE
	incompatible_modules = list(
		/obj/item/mod/module/adrenaline_boost,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/pepper_shoulders,
		/obj/item/mod/module/criminalcapture,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/drill,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/health_analyzer,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/constructor,
		/obj/item/mod/module/injector,
		/obj/item/mod/module/organizer,
		/obj/item/mod/module/criminalcapture/patienttransport,
		/obj/item/mod/module/thread_ripper,
		/obj/item/mod/module/surgical_processor,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/ash_accretion,
	)
	complexity = 4
	removable = FALSE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 20
	/// Reagent used as 'fuel'
	var/reagent_required = /datum/reagent/medicine/omnizine/protozine
	/// How much of a reagent we need to refill a single boost.
	var/reagent_required_amount = 20
	/// Maximum amount of reagents this module can hold.
	var/reagent_max_amount = 120
	/// Flat health threshold above which the module won't heal.
	var/health_threshold = 65
	/// Cooldown betwen each treatment.
	var/general_cooldown = 25 SECONDS

	/// Timer for the healing cooldown.
	COOLDOWN_DECLARE(heal_timer)
	/// Timer for the stamina damage cooldown.
	COOLDOWN_DECLARE(stamina_timer)
	/// Timer for the blood-refilling cooldown.
	COOLDOWN_DECLARE(blood_timer)

/obj/item/mod/module/auto_doc/Initialize(mapload)
	. = ..()
	create_reagents(reagent_max_amount)

/obj/item/mod/module/auto_doc/on_active_process(seconds_per_tick)
	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "not enough chems!")
		deactivate()
		return FALSE

	var/new_oxyloss = mod.wearer.getOxyLoss()
	var/new_bruteloss = mod.wearer.getBruteLoss()
	var/new_fireloss = mod.wearer.getFireLoss()
	var/new_stamloss = mod.wearer.getStaminaLoss()
	var/new_toxloss = mod.wearer.getToxLoss()

	if(mod.wearer.blood_volume < BLOOD_VOLUME_OKAY && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
		if(!COOLDOWN_FINISHED(src, blood_timer))
			return FALSE
		mod.wearer.reagents.add_reagent(/datum/reagent/blood, 25, list("viruses"=null,"blood_DNA"=null,"blood_type"=mod.wearer.dna.blood_type,"resistances"=null,"trace_chem"=null))
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/coagulant, 2.5 * seconds_per_tick)
		mod.wearer.playsound_local(mod, 'sound/items/hypospray.ogg', 25, TRUE)
		reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
		to_chat(mod.wearer, span_warning("Blood infused."))
		drain_power(use_energy_cost * 10 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS, TIMER_STOPPABLE|TIMER_DELETE_ME)
		COOLDOWN_START(src, blood_timer, general_cooldown)

	if(mod.wearer.health < health_threshold)
		if(!COOLDOWN_FINISHED(src, heal_timer))
			return FALSE
		if(new_oxyloss && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/items/internals/internals_on.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Blood oxygen saturated."))
		if(new_bruteloss && reagents.total_volume >= reagent_required_amount * 1 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 1 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Wound treatment administered."))
		if(new_fireloss && reagents.total_volume >= reagent_required_amount * 1 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 1 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Ointment applied."))
		if(new_toxloss && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/items/hypospray.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("Antitoxin administered."))
		drain_power(use_energy_cost * 15 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS)
		COOLDOWN_START(src, heal_timer, general_cooldown)

	if(new_stamloss > health_threshold && reagents.total_volume >= reagent_required_amount * 0.25 * seconds_per_tick)
		if(!COOLDOWN_FINISHED(src, stamina_timer))
			return FALSE
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/morphine, 2.5 * seconds_per_tick)
		mod.wearer.reagents.add_reagent(/datum/reagent/drug/cocaine, 2.5 * seconds_per_tick)
		mod.wearer.playsound_local(mod, 'sound/items/hypospray.ogg', 25, TRUE)
		reagents.remove_reagent(reagent_required, reagent_required_amount * 0.25 * seconds_per_tick)
		to_chat(mod.wearer, span_warning("Stimdose administered."))
		drain_power(use_energy_cost * 5 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS, TIMER_STOPPABLE|TIMER_DELETE_ME)
		COOLDOWN_START(src, stamina_timer, general_cooldown)

/obj/item/mod/module/auto_doc/emp_act(severity)
	. = ..()
	on_emp(src, severity, .)

/obj/item/mod/module/auto_doc/proc/on_emp(datum/source, severity, protection)
	SIGNAL_HANDLER
	if(protection & EMP_PROTECT_SELF)
		return
	heal_aftereffects(mod.wearer, TRUE)

/// Refills the module with needed chemicals, assuming the container isn't closed or the module isn't full.
/obj/item/mod/module/auto_doc/proc/charge_boost(obj/item/attacking_item, mob/user)
	if(!attacking_item.is_open_container())
		return FALSE
	if(reagents.has_reagent(reagent_required, reagent_max_amount))
		balloon_alert(mod.wearer, "already full!")
		return FALSE
	if(!attacking_item.reagents.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
	balloon_alert(mod.wearer, "charge reloaded!")
	return TRUE

/obj/item/mod/module/auto_doc/on_install()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_refill))
	RegisterSignal(mod, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp))

/obj/item/mod/module/auto_doc/on_uninstall(deleting)
	UnregisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION)
	UnregisterSignal(mod, COMSIG_ATOM_EMP_ACT)

/obj/item/mod/module/auto_doc/proc/try_refill(source, mob/user, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(charge_boost(attacking_item))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/// With a certain chance, triggers a spontaneous injection of protozine into the user's bloodstream; suit design's rather ancient and prone to mishaps.
/obj/item/mod/module/auto_doc/proc/heal_aftereffects(mob/affected_mob, var/forced)
	if(!affected_mob)
		return
	var/fault_chance = (reagents.maximum_volume/(reagents.total_volume ? reagents.total_volume : 20))*5 // 5% at max protozine, 20% at low-to-none protozine
	if(prob(fault_chance) || forced == TRUE)
		reagents.trans_to(affected_mob, min(15,reagents.total_volume))
		balloon_alert(affected_mob, "protozine leak!")
		affected_mob.playsound_local(mod, 'sound/effects/spray3.ogg', 25, TRUE)

/obj/item/reagent_containers/cup/glass/waterbottle/large/protozine
	name = "bottle of protozine"
	desc = "Nothing screams 'Budget cuts' like a plastic bottle of autodoc refills."
	list_reagents = list(/datum/reagent/medicine/omnizine/protozine = 100)

/obj/item/crafting_conversion_kit/voskhod_refit
	name = "\improper Voskhod depowered armor MOD refit kit"
	desc = "A metallic case of various tubes, sensors and spare materials required to reuse Voskhod's components in the making of a next-generation MODed version."
	force = 10
	icon = 'modular_nova/modules/novaya_ert/icons/refit_kit.dmi'
	icon_state = "refit_kit"

/datum/crafting_recipe/voskhod_to_mod
	name = "Depowered Voskhod-To-Refurbished Voskhod MOD Conversion"
	desc = "While this is usually done on a specialised automated workbench, you can tinker with the suit manually for a longer while to achieve the same result."
	result = /obj/effect/spawner/random/voskhod_refit
	reqs = list(
		/obj/item/clothing/suit/space/voskhod = 1,
		/obj/item/clothing/head/helmet/space/voskhod = 1,
		/obj/item/crafting_conversion_kit/voskhod_refit = 1,
		/obj/item/storage/backpack/industrial/cin_surplus = 1,
		/obj/item/mod/core = 1,
		/obj/item/stock_parts/power_store/cell/high = 1,
		/obj/item/stack/sheet/plasteel = 10,
		/obj/item/stack/cable_coil = 15,
		/obj/item/assembly/health = 1,
	)
	tool_behaviors = list(TOOL_WELDER, TOOL_MULTITOOL)
	time = 30 SECONDS
	category = CAT_CLOTHING

/obj/effect/spawner/random/voskhod_refit
	name = "converted MODskhod spaner"
	icon = 'modular_nova/modules/novaya_ert/icons/mod.dmi'
	icon_state = "voskhod-chestplate-sealed"
	spawn_all_loot = TRUE
	spawn_loot_count = 1
	loot = list(/obj/item/mod/control/pre_equipped/voskhod)
