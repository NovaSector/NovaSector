//antag
/datum/antagonist/traitor/marauder
	name = "Marauder"
	job_rank = ROLE_MARAUDER
	roundend_category = "Marauders"
	preview_outfit = /datum/outfit/marauder_preview
	show_to_ghosts = TRUE
	give_uplink = FALSE
	should_give_codewords = FALSE
	/// Identifying number of the traitor
	var/marauder_no
	/// The turf inside the lazy_template marked as this antag's spawn
	var/turf/spawnpoint

/datum/outfit/marauder_preview
	name = "Marauder (Preview only)"
	glasses = /obj/item/clothing/glasses/eyepatch
	uniform = /obj/item/clothing/under/dress/skirt/nova/lone_skirt
	belt = /obj/item/storage/belt/military

/datum/antagonist/traitor/marauder/render_preview_outfit(datum/outfit/outfit, mob/living/carbon/human/dummy)
	//yes this is an OC, but she is canonically dead so its ok. such is the fate of a gorlex marauder
	dummy = dummy || new /mob/living/carbon/human/dummy/consistent
//	dummy.set_species(/datum/species/mermaid, icon_update = FALSE)
	var/obj/item/bodypart/lame_flesh_arm = dummy.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/cool_robot_arm = new /obj/item/bodypart/arm/right/robot()
	cool_robot_arm.set_icon_static('modular_nova/master_files/icons/mob/augmentation/sgmipc.dmi')
	cool_robot_arm.current_style = "Shellguard Munitions Standard Series"
	cool_robot_arm.replace_limb(dummy, TRUE)
	qdel(lame_flesh_arm)
	dummy.equipOutfit(outfit, visuals_only = TRUE)
	dummy.underwear = "Striped Boxers"
	dummy.underwear_color = "#5f534a"
	dummy.hair_color = "#ffffff"
	dummy.grad_color[1] = "#bcb4e7"
	dummy.grad_style[1] = "Fade Up"
	dummy.hairstyle = "Sideways ponytail"

	dummy.update_body(TRUE)
	var/icon = getFlatIcon(dummy)
	SSatoms.prepare_deletion(dummy)
	return icon

/datum/antagonist/traitor/marauder/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()
	holder.grant_language(/datum/language/codespeak, source = LANGUAGE_MIND)
	owner_mob.faction |= ROLE_SYNDICATE
	owner_mob.faction &= FACTION_NEUTRAL

/datum/antagonist/traitor/marauder/remove_innate_effects(mob/living/mob_override)
	var/mob/living/owner_mob = mob_override || owner.current
	if(owner_mob)
		owner_mob.remove_language(/datum/language/codespeak, source = LANGUAGE_MIND)
		owner_mob.faction &= ROLE_SYNDICATE
		owner_mob.faction |= FACTION_NEUTRAL

/// Removes NT from being the possible employer, because that would be weird
/datum/antagonist/traitor/marauder/pick_employer()

	if(!employer)
		var/list/possible_employers = list()
		possible_employers.Add(GLOB.syndicate_employers)
		possible_employers.Remove(GLOB.nanotrasen_employers)
		if(istype(ending_objective, /datum/objective/hijack))
			possible_employers -= GLOB.normal_employers
		else
			possible_employers -= GLOB.hijack_employers

		employer = pick(possible_employers)
	traitor_flavor = strings(TRAITOR_FLAVOR_FILE, employer)

/// Changes the 'escape' ending objective to a generic 'survive' requirement
/datum/antagonist/traitor/marauder/forge_ending_objective()
	ending_objective = new /datum/objective/survive
	ending_objective.owner = owner
	objectives += ending_objective

/datum/antagonist/traitor/marauder/on_gain()
	. = ..()
	//load the map, if its the first time running don't force
	if(marauder_no == 1)
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_MIDROUND_TRAITOR)
	else
		SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_MIDROUND_TRAITOR, TRUE)
	//load the shuttle, we don't trust lazy_load with this
	load_shuttle(marauder_no)
	//set up our guy
	set_assignment(owner.current)
	grant_equipment(owner.current)
	//load personalized items
	load_personal_items(owner.current)
	move_to_spawnpoint(owner.current, marauder_no)

/datum/antagonist/traitor/marauder/proc/load_shuttle(marauder_no)
	var/is_first = FALSE
	if(marauder_no == 1)
		is_first = TRUE

	var/datum/map_template/shuttle/marauder_shuttle = SSmapping.shuttle_templates["traitor_default"]
	var/x = (world.maxx - TRANSITIONEDGE - marauder_shuttle.width - (marauder_no * 10))
	var/y = (world.maxy - TRANSITIONEDGE - marauder_shuttle.height)
	var/z
	if(SSmapping.empty_space)
		z = SSmapping.empty_space.z_value
	else
		//no space level, lets go for the safest next option
		//lets find a transit z, we will claim the top right corner
		for(var/datum/space_level/z_level as anything in SSmapping.z_list)
			if(z_level.traits.Find(ZTRAIT_RESERVED))
				z = z_level.z_value
				break

	var/turf/turf = locate(x,y,z)
	if(!turf)
		CRASH("[src] found no turf to load its shuttle in")
	if(!marauder_shuttle.load(turf))
		CRASH("Loading [marauder_shuttle] failed!")
	//dock at our port
	var/obj/docking_port/mobile/mobile_port = is_first ? SSshuttle.getShuttle("traitor") : SSshuttle.getShuttle("traitor_[marauder_no]")
	mobile_port.destination = is_first ? SSshuttle.getDock("traitor") : SSshuttle.getDock("traitor_[marauder_no]")
	mobile_port.mode = SHUTTLE_IGNITING
	mobile_port.setTimer(mobile_port.ignitionTime)

/// this is where we load the personalized note and loadout equipped mannequin
/datum/antagonist/traitor/marauder/proc/load_personal_items(mob/living/carbon/human/marauder)
	for(var/area/misc/operative_barracks/dorm/spawn_area in GLOB.areas)
		if(!marauder || !marauder.client)
			return
		for(var/turf/area_turf as anything in spawn_area.get_turfs_from_all_zlevels())
			var/obj/structure/mannequin/operative_barracks/loadout/mannequin = locate() in area_turf
			if(!mannequin)
				continue
			if(mannequin.loaded) //already loaded
				continue
			mannequin.load_items(marauder.client)
			mannequin.loaded = TRUE
			mannequin.update_appearance()
		for(var/turf/area_turf as anything in spawn_area.get_turfs_from_all_zlevels())
			var/obj/machinery/door/airlock/airlock = locate() in area_turf
			if(!airlock)
				continue
			if(airlock.note) //already loaded
				continue
			var/obj/item/paper/fluff/midround_traitor/greeting/note = new(airlock)
			airlock.note = note
			note.write_note(marauder.real_name)
			note.update_appearance()
			note.forceMove(airlock)
			airlock.update_appearance()

/// this is where we add the job datum and build a bank account based on it
/datum/antagonist/traitor/marauder/proc/set_assignment(mob/living/carbon/human/marauder)
	var/datum/bank_account/bank_account = new(marauder.name, /datum/job/marauder, marauder.dna.species.payday_modifier)
	owner.set_assigned_role(SSjob.get_job_type(/datum/job/marauder))
	bank_account.payday(5, TRUE) // STARTING_PAYCHECKS is way too high for us
	bank_account.account_job = SSjob.get_job_type(/datum/job/marauder)
	bank_account.replaceable = FALSE
	marauder.account_id = bank_account.account_id
	marauder.add_mob_memory(/datum/memory/key/account, remembered_id = marauder.account_id)

/// this is where we get our outfit, it runs after getting the assignment set so the pre_equip_species_outfit() proc can use it
/datum/antagonist/traitor/marauder/proc/grant_equipment(mob/living/carbon/human/marauder)
	if(isnull(marauder.dna.species.outfit_important_for_life))
		marauder.equipOutfit(/datum/outfit/marauder)
	else
		marauder.dna.species.pre_equip_species_outfit(marauder.mind?.assigned_role, marauder)

/// get our spawnpoint
/datum/antagonist/traitor/marauder/proc/set_spawnpoint(marauder_no)
	spawnpoint = GLOB.traitor_start[marauder_no]

/// move our guy
/datum/antagonist/traitor/marauder/proc/move_to_spawnpoint(mob/living/carbon/human/marauder, marauder_no)
	set_spawnpoint(marauder_no)
	marauder.forceMove(spawnpoint)
	var/obj/structure/bed/bed = locate(/obj/structure/bed) in spawnpoint.contents
	var/obj/item/bedsheet/bedsheet = locate(/obj/item/bedsheet) in spawnpoint.contents
	if(!bed || !bedsheet)
		return
	//put them in bed
	marauder.setDir(SOUTH)
	bed.buckle_mob(marauder)
	bedsheet.coverup(marauder)

//antag job
/datum/job/marauder
	title = ROLE_MARAUDER
	paycheck_department = ACCOUNT_DS2
	exclusive_mail_goodies = TRUE
	mail_goodies = list(/obj/item/stack/telecrystal/five)
	outfit = /datum/outfit/marauder
	plasmaman_outfit = /datum/outfit/marauder/plasmaman
	akula_outfit = /datum/outfit/marauder/akula
	vox_outfit = /datum/outfit/marauder/vox

/datum/outfit/marauder
	name = "Marauder"
	uniform = /obj/item/clothing/under/misc/pj/red
	head = /obj/item/clothing/head/costume/nightcap/red

/datum/outfit/marauder/post_equip(mob/living/carbon/human/player, visuals_only)
	. = ..()
	turn_off_sensors(player.w_uniform)
	var/client/player_client = player.client
	if(player_client)
		SSquirks.AssignQuirks(player, player.client)

/datum/outfit/marauder/proc/turn_off_sensors(obj/item/clothing/under/uniform)
	if(!uniform)
		return
	if(!uniform.has_sensor)
		return
	uniform.sensor_mode = NO_SENSORS

/datum/outfit/marauder/plasmaman
	name = "Marauder (Plasmaman)"
	head = /obj/item/clothing/head/helmet/space/plasmaman/syndie
	uniform = /obj/item/clothing/under/plasmaman/syndicate
	gloves = /obj/item/clothing/gloves/color/plasmaman/black
	belt = /obj/item/tank/internals/plasmaman/belt/full
	internals_slot = ITEM_SLOT_BELT

/datum/outfit/marauder/akula
	name = "Marauder (Akula)"
	r_pocket = /obj/item/clothing/accessory/vaporizer

/datum/outfit/marauder/vox
	name = "Marauder (Vox)"
	mask = /obj/item/clothing/mask/breath/vox
	belt = /obj/item/tank/internals/nitrogen/belt/full
	internals_slot = ITEM_SLOT_BELT
