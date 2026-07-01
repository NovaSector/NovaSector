//! Contains admin and CC varianted robot models
// Admin Cyborg Models.
// TODO: player usable cc model, admin cc model, subspace borg, administrative (like literally about paperwork and shit)
// TODO: modules
// Baseline CC model, total generalist. Can do a bit of everything but lacks specialized tools.
// code\modules\mob\living\silicon\robot\robot.dm:L152 absolutely unholy shit going on here.
/* A solution that is not a solution. The glob is made inside the proc. I am in misery.
		if(!client?.holder)
			GLOB.cyborg_model_list += list(
			"Admin" = /obj/item/robot_model/admin,
			"CC Frontline" = /obj/item/robot_model/admin/frontline,
			"CC Backline" = /obj/item/robot_model/admin/backline,
			"CC Engineer" = /obj/item/robot_model/admin/engineer,
		)
*/
// Currently looks like you'll only be able to directly create these borgs and not have a switchable selector, until I can figure out a way to run a holder check to expand that list. But then its updating a glob, which is for everyone.
// Someone smarter than me will have to fix this one
//
// TODO: Needs custom icons
// TODO: Item list revists
// TODO: Admin Borg Shapeshifter action, unpaired from the shapeshifter icon
// TODO: Explore more borg hands? How many hands can a borg reasonably have?
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
	model_select_icon = "malf"
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
	bubble_icon = "guardian"
	req_access = list(ACCESS_CENT_GENERAL)
	lawupdate = FALSE
	scrambledcodes = FALSE
	ionpulse = TRUE
	set_model = /obj/item/robot_model/admin
	cell = /obj/item/stock_parts/power_store/cell/infinite
	radio = /obj/item/radio/borg/syndicate

// Admin Borg, Bluespace-tech Equivalent.
// Just a placeholder for the moment
/obj/item/robot_model/admin/subspace
	name = "Bluespace Walker"

/mob/living/silicon/robot/model/admin/subspace
	set_model = /obj/item/robot_model/admin/subspace
	icon_state = "tachi"

// Assault / Frontline Establishment
/obj/item/robot_model/admin/frontline
	name = "Frontline Walker"
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

/mob/living/silicon/robot/model/admin/frontline
	set_model = /obj/item/robot_model/admin/frontline
	icon_state = "tachi"

// Backline Support
/obj/item/robot_model/admin/backline
	name = "Backline Walker"
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

/mob/living/silicon/robot/model/admin/backline
	set_model = /obj/item/robot_model/admin/backline
	icon_state = "tachi"

// Engineering Generalist
/obj/item/robot_model/admin/engineer
	name = "Technical Walker"
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

/mob/living/silicon/robot/model/admin/engineer
	set_model = /obj/item/robot_model/admin/engineer
	icon_state = "tachi"

// Modules to transform pre-existing borgs into an admin borg
/obj/item/borg/upgrade/transform/admin
	name = "borg module picker (Central Command Administrative Walker)"
	desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/admin

/obj/item/borg/upgrade/transform/admin/backline
	name = "borg module picker (Central Command Backline Walker)"
	desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/admin/backline

/obj/item/borg/upgrade/transform/admin/frontline
	name = "borg module picker (Central Command Frontline Walker)"
	desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/admin/frontline

/obj/item/borg/upgrade/transform/admin/engineer
	name = "borg module picker (Central Command Engineer Walker)"
	desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/admin/engineer
