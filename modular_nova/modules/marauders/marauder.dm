//antag
/datum/antagonist/traitor/marauder
	name = "Marauder"
	pref_flag = ROLE_MARAUDER
	roundend_category = "Marauders"
	preview_outfit = /datum/outfit/marauder_preview
	show_to_ghosts = TRUE
	give_uplink = FALSE

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
	dummy.set_hair_gradient_color("#bcb4e7")
	dummy.set_hair_gradient_style("Fade Up")
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
	//set up our guy
	set_assignment(owner.current)
	grant_equipment(owner.current)

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
		player.increment_scar_slot()
		player.load_persistent_scars()
		SSpersistence.load_modular_persistence(player.get_organ_slot(ORGAN_SLOT_BRAIN))

/datum/outfit/marauder/proc/turn_off_sensors(obj/item/clothing/under/uniform)
	if(!uniform)
		return
	if(!uniform.has_sensor)
		return
	uniform.set_sensor_mode(SENSOR_OFF)

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
