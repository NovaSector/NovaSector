//! Contains admin and CC varianted robot models
// Admin Cyborg Models.
// TODO: player usable cc model, admin cc model, subspace borg, administrative (like literally about paperwork and shit)
// TODO: modules

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
// TODO: Explore more borg hands? How many hands can a borg reasonably have?
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
	model_select_icon = "malf"
	hat_offset = INFINITY
	breakable_modules = FALSE
//	interaction_range = INFINITY
	borg_skins = list(
		/// 32x32 Skins
		"Walker Tank" = list(SKIN_ICON_STATE = "tachi", SKIN_ICON = 'modular_nova/modules/admin_tech/icons/admin_robots.dmi'),
	)
	// This is where we begin the setup of the special features on the admin borgs themselves
	var/datum/weakref/thermal_vision_ref
	var/datum/weakref/disguise_action_ref
	var/datum/weakref/xray_vision_ref

// Destroys tailing references on admin borg destruction
/obj/item/robot_model/admin/Destroy(force)
	QDEL_NULL(thermal_vision_ref)
	QDEL_NULL(disguise_action_ref)
	QDEL_NULL(xray_vision_ref)
	return ..()

// Handles the setup of the cyborg. This is run at the cyborg being built and is part of the stall on interacting during spawn.
/obj/item/robot_model/admin/be_transformed_to(obj/item/robot_model/old_model, forced = FALSE)
	var/datum/action/cooldown/borg_thermal/thermal_vision = new(loc)
	var/datum/action/cooldown/borg_disguise/disguise = new(loc)
	var/datum/action/cooldown/borg_xray/xray_vision = new(loc)
	. = ..()
	if(!.)
		return
	thermal_vision.Grant(loc)
	thermal_vision_ref = WEAKREF(thermal_vision)
	disguise.Grant(loc)
	disguise_action_ref = WEAKREF(disguise)
	xray_vision.Grant(loc)
	xray_vision_ref = WEAKREF(xray_vision)
	var/mob/living/silicon/robot/borg = loc
	borg.sight_mode |= BORGXRAY
	borg.update_sight()

// Sets up a new action to divorce the shapeshifter item into a hard function, so admin borgs can remain stealthed as whatever regardless what they are doing.
// This does use a lot of the original item code. I don't know if this can be done better.
/datum/action/cooldown/borg_disguise
	name = "Change Appearance"
	desc = "Reversibly change your outward model appearance. Unlike the standard chameleon projector module, this cannot be disrupted by force."
	button_icon = 'icons/obj/devices/syndie_gadget.dmi'
	button_icon_state = "shield0"
	cooldown_time = 0.5 SECONDS
	var/active = FALSE
	var/saved_icon
	var/saved_icon_override
	var/saved_name
	var/saved_model_features
	var/saved_special_light_key
	var/saved_hat_offset
	var/saved_bubble_icon

// Main disguise application and removal loop
/datum/action/cooldown/borg_disguise/Activate()
	var/mob/living/silicon/robot/borg = owner
	if(!istype(borg))
		return
	if(active)
		revert_disguise(borg)
		return
	apply_disguise(borg)

// Sanity catches
/datum/action/cooldown/borg_disguise/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

// This should really be kept in parity with the original list, but really who cares if admin tools decay past what the public uses.
/datum/action/cooldown/borg_disguise/proc/apply_disguise(mob/living/silicon/robot/borg)
	var/static/list/model_icons = sort_list(list(
		"Medical" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "medical"),
		"Cargo" = image(icon = CYBORG_ICON_CARGO, icon_state = "cargoborg"),
		"Engineer" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "engineer"),
		"Security" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "sec"),
		"Service" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "service_f"),
		"Janitor" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "janitor"),
		"Miner" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "miner"),
		"Peacekeeper" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "peace"),
		"Clown" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "clown"),
		"Syndicate" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "synd_sec"),
		"Spider Clan" = image(icon = CYBORG_ICON_NINJA, icon_state = "ninja_engi"),
	))
	var/model_selection = show_radial_menu(borg, borg, model_icons, custom_check = CALLBACK(src, PROC_REF(check_menu), borg), radius = 42, require_near = TRUE)
	if(!model_selection)
		return
// The list of skins
	var/obj/item/robot_model/model
	switch(model_selection)
		if("Medical")
			model = new /obj/item/robot_model/medical
		if("Cargo")
			model = new /obj/item/robot_model/cargo
		if("Engineer")
			model = new /obj/item/robot_model/engineering
		if("Security")
			model = new /obj/item/robot_model/security
		if("Service")
			model = new /obj/item/robot_model/service
		if("Janitor")
			model = new /obj/item/robot_model/janitor
		if("Miner")
			model = new /obj/item/robot_model/miner
		if("Peacekeeper")
			model = new /obj/item/robot_model/peacekeeper
		if("Clown")
			model = new /obj/item/robot_model/clown
		if("Syndicate")
			model = new /obj/item/robot_model/syndicatejack
		if("Spider Clan")
			model = new /obj/item/robot_model/ninja
		else
			return
// Handles the icon conversions
	var/list/reskin_icons = list()
	for(var/skin in model.borg_skins)
		var/list/details = model.borg_skins[skin]
		var/image/reskin = image(icon = details[SKIN_ICON] || 'icons/mob/silicon/robots.dmi', icon_state = details[SKIN_ICON_STATE])
		if(!isnull(details[SKIN_FEATURES]) && (TRAIT_R_WIDE in details[SKIN_FEATURES]))
			reskin.pixel_x -= 16
		reskin_icons[skin] = reskin
	var/borg_skin = show_radial_menu(borg, borg, reskin_icons, custom_check = CALLBACK(src, PROC_REF(check_menu), borg), radius = 38, require_near = TRUE)
	if(!borg_skin)
		qdel(model)
		return

	var/list/details = model.borg_skins[borg_skin]
	var/disguise_icon_state = details[SKIN_ICON_STATE]
	var/disguise_icon_override = details[SKIN_ICON]
	var/disguise_special_light_key = details[SKIN_LIGHT_KEY]
	var/disguise_model_features = details[SKIN_FEATURES]
	var/picked_name = model.name
	qdel(model)

	if(!active)
		saved_icon = borg.model.cyborg_base_icon
		saved_bubble_icon = borg.bubble_icon
		saved_icon_override = borg.model.cyborg_icon_override
		saved_name = borg.model.name
		saved_model_features = borg.model.model_features
		saved_special_light_key = borg.model.special_light_key
		saved_hat_offset = borg.model.hat_offset

	borg.model.name = picked_name
	borg.model.cyborg_base_icon = disguise_icon_state
	borg.model.cyborg_icon_override = disguise_icon_override
	borg.model.model_features = disguise_model_features
	borg.model.special_light_key = disguise_special_light_key
	borg.bubble_icon = "robot"
	active = TRUE
	to_chat(borg, span_notice("You are now disguised as [picked_name]."))// Successful function tochat
	borg.update_icons()
	borg.model.update_quadborg()
	borg.model.update_tallborg()
	build_all_button_icons()// Finalizes rebuild

// Reverting to Tachi.
/datum/action/cooldown/borg_disguise/proc/revert_disguise(mob/living/silicon/robot/borg)
	borg.model.name = saved_name
	borg.model.cyborg_base_icon = saved_icon
	borg.model.cyborg_icon_override = saved_icon_override
	borg.model.model_features = saved_model_features
	borg.model.special_light_key = saved_special_light_key
	borg.model.hat_offset = saved_hat_offset
	borg.bubble_icon = saved_bubble_icon
	active = FALSE
	to_chat(borg, span_notice("You revert to your true appearance."))
	borg.update_icons()
	borg.model.update_quadborg()
	borg.model.update_tallborg()
	build_all_button_icons()

// Borg / drone vision.
/datum/action/cooldown/borg_xray
	name = "Toggle Perfect Vision"
	desc = "Toggles perfect vision - full sight regardless of lighting, plus the ability to see mobs through walls."
	button_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "meson"

// Processes the action and sets our sightmodes
/datum/action/cooldown/borg_xray/Activate()
	var/mob/living/silicon/robot/borg = owner
	if(!istype(borg))
		return
	if(borg.sight_mode & BORGXRAY)
		borg.sight_mode &= ~BORGXRAY
	else
		borg.sight_mode |= BORGXRAY
	borg.update_sight()

// Spawnable Mob for the base model + additional config and benefits
/mob/living/silicon/robot/model/admin
	icon = 'modular_nova/modules/admin_tech/icons/admin_robots.dmi'
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

// Bluespace Walker, a bluespace technician stand-alone.
/obj/item/robot_model/admin/bluespace
	name = "Bluespace Walker"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/crowbar/cyborg/power,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/multitool/cyborg,
		/obj/item/extinguisher,
		/obj/item/handheld_debug_chem_synth,
		/obj/item/gun/chem/admin,
		/obj/item/gun/magic/subspace/dagenblicky,
		/obj/item/pneumatic_cannon/subspace,
		/obj/item/melee/baseball_bat/admin,
		/obj/item/laser_pointer/admin,
		/obj/item/modular_computer/pda/admin,
		/obj/item/summon_beacon/vendors/debug,
		/obj/item/borg_shapeshifter,
	)

// The mob for the walker itself.
/mob/living/silicon/robot/model/admin/bluespace
	set_model = /obj/item/robot_model/admin/bluespace
	icon_state = "tachi"

// Subspace Walker - this is the flagship/showcase model for the subspace-tech-rework branch, so its kit doubles as a demo case for the admin_tech items themselves.
/obj/item/robot_model/admin/subspace
	name = "Subspace Walker"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/crowbar/cyborg/power,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/multitool/cyborg,
		/obj/item/extinguisher,
		/obj/item/handheld_debug_chem_synth,
		/obj/item/gun/chem/admin,
		/obj/item/gun/magic/subspace/dagenblicky,
		/obj/item/pneumatic_cannon/subspace,
		/obj/item/melee/baseball_bat/admin,
		/obj/item/laser_pointer/admin,
		/obj/item/modular_computer/pda/admin,
		/obj/item/summon_beacon/vendors/debug,
		/obj/item/borg_shapeshifter,
	)

// The mob for the walker itself.
/mob/living/silicon/robot/model/admin/subspace
	set_model = /obj/item/robot_model/admin/subspace
	icon_state = "tachi"

// Frontline Walker - the laser pointer needs a hitscan icon
/obj/item/robot_model/admin/frontline
	name = "Frontline Walker"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/melee/energy/sword/cyborg,
		/obj/item/melee/baseball_bat/admin,
		/obj/item/gun/energy/printer,
		/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg,
		/obj/item/laser_pointer/admin,
		/obj/item/card/emag,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/pinpointer/syndicate_cyborg,
	)

// The mob for the walker itself.
/mob/living/silicon/robot/model/admin/frontline
	set_model = /obj/item/robot_model/admin/frontline
	icon_state = "tachi"

// Backline Walker - the reagent gun carries this atm
/obj/item/robot_model/admin/backline
	name = "Backline Walker"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/gun/chem/admin,
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
		/obj/item/borg/apparatus/organ_storage,
		/obj/item/storage/bag/chemistry,
	)

// The mob for the walker itself.
/mob/living/silicon/robot/model/admin/backline
	set_model = /obj/item/robot_model/admin/backline
	icon_state = "tachi"

// Technical / Engie Walker
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

// The mob for the walker itself.
/mob/living/silicon/robot/model/admin/engineer
	set_model = /obj/item/robot_model/admin/engineer
	icon_state = "tachi"

/*
The Syndicate Jack does exist but ew. Clean paths for us please.
Modules to transform pre-existing borgs into an admin borg type
*/
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
