// USED FOR THE MIDROUND
/datum/antagonist/contractor
	name = "Drifting Contractor"
	antagpanel_category = "DriftingContractor"
	preview_outfit = /datum/outfit/contractor_preview
	pref_flag = ROLE_DRIFTING_CONTRACTOR
	hud_icon = 'modular_nova/modules/contractor/icons/hud_icon.dmi'
	antag_hud_name = "contractor"
	antagpanel_category = ANTAG_GROUP_SYNDICATE
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = TRUE
	suicide_cry = "FOR THE CONTRACTS!!"
	view_exploitables = TRUE
	/// The outfit the contractor is equipped with
	var/contractor_outfit = /datum/outfit/contractor
	// taken from traitor datum
	/// The uplink handler that this contractor belongs to.
	var/datum/uplink_handler/uplink_handler
	/// Minimum discounted items they can have
	var/uplink_sales_min = 4
	/// Maximum discounted items they can have
	var/uplink_sales_max = 6

/datum/antagonist/contractor/proc/equip_guy()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/person = owner.current
	SSquirks.AssignQuirks(person, person.client)
	person.equipOutfit(/datum/outfit/contractor)
	return TRUE

/datum/antagonist/contractor/on_gain()
	forge_objectives()
	. = ..()
	equip_guy()
	var/datum/component/uplink/uplink = owner.find_syndicate_uplink()
	uplink_handler = uplink.uplink_handler

	var/list/uplink_items = list()
	for(var/datum/uplink_item/item as anything in SStraitor.uplink_items)
		if(!item.item || item.cant_discount)
			continue
		if(!(item.purchasable_from & uplink_handler.uplink_flag))
			continue
		if(item.cost < TRAITOR_DISCOUNT_MIN_PRICE)
			continue
		if(length(item.restricted_roles) || length(item.restricted_species))
			if(!(uplink_handler.assigned_role in item.restricted_roles) && !(uplink_handler.assigned_species in item.restricted_species))
				continue
		uplink_items += item

	uplink_handler.extra_purchasable += create_uplink_sales(num = rand(uplink_sales_min, uplink_sales_max), category = /datum/uplink_category/discounts, limited_stock = -1, sale_items = uplink_items)

/datum/antagonist/contractor/forge_objectives()
	var/datum/objective/contractor_total/contract_objectives = new
	contract_objectives.owner = owner
	objectives += contract_objectives

/datum/antagonist/contractor/roundend_report()
	var/list/report = list()

	if(!owner)
		CRASH("antagonist datum without owner")

	report += "<b>[printplayer(owner)]</b>"

	var/objectives_complete = TRUE
	if(length(objectives))
		report += printobjectives(objectives)
		for(var/datum/objective/objective as anything in objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	report += owner.opposing_force.contractor_round_end()

	if(!length(objectives) || objectives_complete)
		report += "<span class='greentext big'>The [name] was successful!</span>"
	else
		report += "<span class='redtext big'>The [name] has failed!</span>"

	return report.Join("<br>")

/datum/job/drifting_contractor
	title = ROLE_DRIFTING_CONTRACTOR
