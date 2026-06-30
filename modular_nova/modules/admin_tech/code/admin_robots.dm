//! Contains admin and CC varianted robot models
// Admin Cyborg Models.
// TODO: player usable cc model, admin cc model, subspace borg, administrative (like literally about paperwork and shit)
// TODO: modules
// Baseline CC model, total generalist. Can do a bit of everything but lacks specialized tools.
// When you need a general ERT or CC Borg, pick this.
/obj/item/robot_model/admin
	name = "Central Command"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/multitool/cyborg,
		/obj/item/crowbar/cyborg/power,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/construction/rcd/borg/syndicate,
		/obj/item/lightreplacer,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/iron,
		/obj/item/stack/cable_coil,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/stack/medical/wrap/gauze,
		/obj/item/shockpaddles/cyborg,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/gun/medbeam,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/borg/lollipop,
		/obj/item/holosign_creator/cyborg,
		/obj/item/stamp/chameleon,
		/obj/item/borg_shapeshifter,
		)
	model_traits = list(TRAIT_NEGATES_GRAVITY, TRAIT_PUSHIMMUNE)
	canDispose = TRUE
	cyborg_base_icon = "tachi"
	model_select_alternate_icon = 'modular_nova/modules/borgs/icons/screen_cyborg.dmi'
	model_select_icon = "lost"
	hat_offset = INFINITY
	breakable_modules = FALSE
//	interaction_range = INFINITY
	borg_skins = list(
		/// 32x32 Skins
		"Walker Tank" = list(SKIN_ICON_STATE = "tachi", SKIN_ICON = 'modular_nova/modules/admin_tech/icons/mob/admin_robots.dmi'),
	)
	var/datum/weakref/thermal_vision_ref

/obj/item/robot_model/admin/Destroy(force)
	QDEL_NULL(thermal_vision_ref)
	return ..()

/obj/item/robot_model/admin/be_transformed_to(obj/item/robot_model/old_model, forced = FALSE)
	var/datum/action/cooldown/borg_thermal/thermal_vision = new(loc)
	. = ..()
	if(!.)
		return
	thermal_vision.Grant(loc)
	thermal_vision_ref = WEAKREF(thermal_vision)

// Spawnable Mob for the base model + additional config and benefits
/mob/living/silicon/robot/model/admin
	icon = 'modular_nova/modules/admin_tech/icons/mob/admin_robots.dmi'
	icon_state = "tachi"
	designation = "CC"
	faction = list(FACTION_ERT)
	bubble_icon = "tachi"
	req_access = list(ACCESS_CENT_GENERAL)
	lawupdate = FALSE
	scrambledcodes = FALSE
	ionpulse = TRUE
	var/playstyle_string = "<span class='big bold'>You are a Syndicate assault cyborg!</span><br>\
		<b>You are armed with powerful offensive tools to aid you in your mission: help the operatives secure the nuclear authentication disk. \
		Your cyborg LMG will slowly produce ammunition from your power supply, and your operative pinpointer will find and locate fellow nuclear operatives. \
		<i>Help the operatives secure the disk at all costs!</i></b>"
	set_model = /obj/item/robot_model/admin
	cell = /obj/item/stock_parts/power_store/cell/infinite
	radio = /obj/item/radio/borg/syndicate

// Admin Borg, Bluespace-tech Equivalent.
// Just a placeholder for the moment
/obj/item/robot_model/admin/subspace

// Assault / Frontline Establishment
/obj/item/robot_model/admin/frontline
	name = "Syndicate Assault"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/melee/energy/sword/cyborg,
		/obj/item/gun/energy/printer,
		/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg,
		/obj/item/card/emag,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/pinpointer/syndicate_cyborg,
	)

// Backline Support
/obj/item/robot_model/admin/backline
	name = "Syndicate Medical"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/shockpaddles/syndicate/cyborg,
		/obj/item/healthanalyzer,
		/obj/item/borg/cyborg_omnitool/medical,
		/obj/item/borg/cyborg_omnitool/medical,
		/obj/item/blood_filter,
		/obj/item/melee/energy/sword/cyborg/saw,
		/obj/item/emergency_bed/silicon,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/pinpointer/syndicate_cyborg,
		/obj/item/stack/medical/wrap/gauze,
		/obj/item/stack/medical/bone_gel,
		/obj/item/gun/medbeam,
		/obj/item/borg/apparatus/organ_storage,
		/obj/item/storage/bag/chemistry,
	)

// Engineering Generalist
/obj/item/robot_model/admin/engineer
	name = "Syndicate Saboteur"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/construction/rcd/borg/syndicate,
		/obj/item/pipe_dispenser,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/extinguisher,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/analyzer,
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/stack/rods/cyborg,
		/obj/item/construction/rtd/borg,
		/obj/item/airlock_painter/decal/cyborg,
		/obj/item/dest_tagger/borg,
		/obj/item/stack/cable_coil,
		/obj/item/pinpointer/syndicate_cyborg,
		/obj/item/borg_chameleon,
		/obj/item/card/emag,
	)

// Modules to transform pre-existing borgs into an admin borg
/obj/item/borg/upgrade/transform/syndicatejack
