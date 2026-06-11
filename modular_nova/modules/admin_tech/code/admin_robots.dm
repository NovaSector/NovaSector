//! Contains admin and CC varianted robot models
// Admin Cyborg Models.
// TODO: player usable cc model, admin cc model, bluespace borg, subspace borg
// TODO: modules
//Baseline CC model
/obj/item/robot_model/admin
	name = "Syndicate"
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
	cyborg_base_icon = "synd_engi"
	model_select_icon = "malf"
	model_traits = list(TRAIT_NEGATES_GRAVITY, TRAIT_PUSHIMMUNE)
	hat_offset = INFINITY
	canDispose = TRUE
	borg_skins = list(
		/// 32x32 Skins
		"Saboteur" = list(SKIN_ICON_STATE = "synd_engi", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"Medical" = list(SKIN_ICON_STATE = "synd_medical", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"Assault" = list(SKIN_ICON_STATE = "synd_sec", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"ARACHNE" = list(SKIN_ICON_STATE = "arachne_syndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Heavy" = list(SKIN_ICON_STATE = "syndieheavy", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Miss M" = list(SKIN_ICON_STATE = "missm_syndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Spider" = list(SKIN_ICON_STATE = "spidersyndi", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Booty Striker" = list(SKIN_ICON_STATE = "bootynukie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Booty Syndicate" = list(SKIN_ICON_STATE = "bootysyndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Bird Syndicate" = list(SKIN_ICON_STATE = "bird_synd", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Male Booty Striker" = list(SKIN_ICON_STATE = "male_bootynukie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Male Booty Syndicate" = list(SKIN_ICON_STATE = "male_bootysyndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Mech" = list(SKIN_ICON_STATE = "chesty", SKIN_ICON = CYBORG_ICON_SYNDIE),
		/// 32x64 Skins
		"Meka" = list(SKIN_ICON_STATE = "mekasyndi", SKIN_ICON = CYBORG_ICON_SYNDIE_TALL, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), SKIN_HAT_OFFSET = list("north" = list(1, 15), "south" = list(1, 15), "east" = list(2, 15), "west" = list(-2, 15))),
		"K4T" = list(SKIN_ICON_STATE = "k4tsyndi", SKIN_ICON = CYBORG_ICON_SYNDIE_TALL, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), SKIN_HAT_OFFSET = list("north" = list(1, 15), "south" = list(1, 15), "east" = list(2, 15), "west" = list(-2, 15))),
		"NiKA" = list(SKIN_ICON_STATE = "fmekasyndi", SKIN_ICON = CYBORG_ICON_SYNDIE_TALL, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), SKIN_HAT_OFFSET = list("north" = list(1, 15), "south" = list(1, 15), "east" = list(2, 15), "west" = list(-2, 15))),
		"NiKO" = list(SKIN_ICON_STATE = "mmekasyndi", SKIN_ICON = CYBORG_ICON_SYNDIE_TALL, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL), SKIN_HAT_OFFSET = list("north" = list(1, 15), "south" = list(1, 15), "east" = list(2, 15), "west" = list(-2, 15))),
		"Dullahan" = list(SKIN_ICON_STATE = "dullahansyndi", SKIN_ICON = CYBORG_ICON_SYNDIE_TALL, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL, TRAIT_R_UNIQUEPANEL), SKIN_HAT_OFFSET = list("north" = list(1, 15), "south" = list(1, 15), "east" = list(2, 15), "west" = list(-2, 15))),
		"Dullahan (Taur)" = list(SKIN_ICON_STATE = "dullahantaursyndi", SKIN_ICON = CYBORG_ICON_SYNDIE_TALL, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_UNIQUETIP, TRAIT_R_TALL, TRAIT_R_UNIQUEPANEL), SKIN_HAT_OFFSET = list("north" = list(1, 15), "south" = list(1, 15), "east" = list(7, 15), "west" = list(-7, 15))),
		/// 64x32 Skins
		"SmolRaptor" = list(SKIN_ICON_STATE = "smolraptor", SKIN_ICON = CYBORG_ICON_SYNDIE_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL, TRAIT_R_WIDE), SKIN_HAT_OFFSET = list("north" = list(16, 0), "south" = list(16, -1), "east" = list(37, 0), "west" = list(-5, 0))),
	)
	/// Weakref to the thermal vision action
	var/datum/weakref/thermal_vision_ref

/obj/item/robot_model/syndicatejack/Destroy(force)
	QDEL_NULL(thermal_vision_ref)
	return ..()

/obj/item/robot_model/syndicatejack/be_transformed_to(obj/item/robot_model/old_model, forced = FALSE)
	var/datum/action/cooldown/borg_thermal/thermal_vision = new(loc)
	. = ..()
	if(!.)
		return
	thermal_vision.Grant(loc)
	thermal_vision_ref = WEAKREF(thermal_vision)

/obj/item/robot_model/syndicatejack/rebuild_modules()
	. = ..()
	var/mob/living/silicon/robot/syndicatejack = loc
	syndicatejack.scrambledcodes = TRUE // We're rouge now

/obj/item/robot_model/syndicatejack/remove_module(obj/item/removed_module)
	var/mob/living/silicon/robot/syndicatejack = loc
	syndicatejack.scrambledcodes = FALSE // Friends with the AI again
	return ..()

/obj/item/robot_model/syndicate
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
	cyborg_base_icon = "synd_sec"
	model_select_icon = "malf"
	model_traits = list(TRAIT_PUSHIMMUNE)
	hat_offset = list("north" = list(0, 3), "south" = list(0, 3), "east" = list(4, 3), "west" = list(-4, 3))

/obj/item/robot_model/syndicate/rebuild_modules()
	..()
	var/mob/living/silicon/robot/cyborg = loc
	cyborg.remove_faction(FACTION_SILICON) //ai turrets

/obj/item/robot_model/syndicate/remove_module(obj/item/removed_module)
	..()
	var/mob/living/silicon/robot/cyborg = loc
	cyborg.add_faction(FACTION_SILICON) //ai is your bff now!

/obj/item/robot_model/syndicate_medical
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
	cyborg_base_icon = "synd_medical"
	model_select_icon = "malf"
	model_traits = list(TRAIT_PUSHIMMUNE)
	hat_offset = list("north" = list(0, 3), "south" = list(0, 3), "east" = list(-1, 3), "west" = list(1, 3))

/obj/item/robot_model/saboteur
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
	cyborg_base_icon = "synd_engi"
	model_select_icon = "malf"
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NEGATES_GRAVITY)
	hat_offset = list("north" = list(0, -4), "south" = list(0, -4), "east" = list(4, -4), "west" = list(-4, -4))
	canDispose = TRUE
	var/datum/weakref/thermal_vision_ref


// Modules to transform pre-existing borgs into an admin borg
/obj/item/borg/upgrade/transform/syndicatejack
