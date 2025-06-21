/datum/quirk/visitor
	name = "Visitor ID"
	desc = "As assistant, you're given a visitor ID with limited background information. Your records will be sparse and require filling out during the shift."
	icon = FA_ICON_PERSON_CIRCLE_QUESTION
	value = -2
	medical_record_text = "Patient is a guest aboard the station, and has been issued a visitor's ID."
	gain_text = span_notice("As a guest aboard the station, you've been given a special visitor ID!")
	lose_text = span_danger("Your visitation rights have been revoked...")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	///holder of a copy of the user's old id
	var/obj/item/card/id/advanced/old_id
	///holder of the modified id
	var/obj/item/card/id/advanced/visitor_id

/datum/quirk/visitor/add_unique(client/client_source)
	if(!can_run())
		return
	preserve_old_id(get_id())
	build_new_id(get_id())
	// apply alt-title
	visitor_id.assignment = client_source.prefs.alt_job_titles[visitor_id.assignment] || visitor_id.assignment
	visitor_id.update_label()

/datum/quirk/visitor/post_add()
	if(!can_run())
		return
	tweak_manifest()
	var/mob/living/carbon/human/quirk_human = quirk_holder
	quirk_human.mind.assigned_role.job_flags &= ~(JOB_CREW_MANIFEST|JOB_ANNOUNCE_ARRIVAL)
	quirk_human.sec_hud_set_ID()

/datum/quirk/visitor/remove(return_id = TRUE, erase_new = TRUE) //these flags are for VV
	if(QDELING(quirk_holder) || istype(quirk_holder, /mob/living/carbon/human/consistent))
		return
	if(return_id)
		var/mob/living/carbon/human/quirk_human = quirk_holder
		old_id.equip_to_best_slot(quirk_human)
		quirk_human.sec_hud_set_ID()
	old_id = null //idk if this is necessary
	if(erase_new)
		QDEL_NULL(visitor_id)

/datum/quirk/visitor/proc/can_run()
	if(is_assistant_job(quirk_holder.mind?.assigned_role))
		return TRUE
	else
		return FALSE

//manifest proc
/datum/quirk/visitor/proc/tweak_manifest()
	var/datum/record/crew/our_record = find_record(quirk_holder.real_name)
	if(our_record)
		//remove the old file, we don't use remove() because we also replace the locked file
		GLOB.manifest.general -= our_record
		GLOB.manifest.locked -= our_record
		qdel(our_record)

	GLOB.manifest.inject_guest(quirk_holder, quirk_holder.client) //add new file

//id procs
/datum/quirk/visitor/proc/get_id()
	if(istype(quirk_holder.get_item_by_slot(ITEM_SLOT_ID), /obj/item/storage/wallet))
		var/obj/item/storage/wallet/wallet = quirk_holder.get_item_by_slot(ITEM_SLOT_ID)
		return wallet.front_id
	else
		return quirk_holder.get_item_by_slot(ITEM_SLOT_ID)

/datum/quirk/visitor/proc/preserve_old_id(obj/item/card/id/advanced/preserved_id)
	if(!preserved_id)
		return
	old_id = duplicate_object(preserved_id, get_turf(quirk_holder))
	old_id.moveToNullspace()
	SSid_access.apply_trim_to_card(old_id, /datum/id_trim/job/assistant) //otherwise gets lost when duplicated. don't know why
	old_id.registered_account = SSeconomy.bank_accounts_by_id["[preserved_id.registered_account.account_id]"] //the bank account too
	old_id.registered_account.bank_cards += old_id

/datum/quirk/visitor/proc/build_new_id(obj/item/card/id/advanced/new_id)
	if(!new_id)
		return
	new_id.icon_state = /obj/item/card/id/advanced/visitor::icon_state
	new_id.icon = /obj/item/card/id/advanced/visitor::icon
	new_id.assigned_icon_state = /obj/item/card/id/advanced/visitor::assigned_icon_state
	new_id.desc = /obj/item/card/id/advanced/visitor::desc
	SSid_access.apply_trim_to_card(new_id, /datum/id_trim/job/assistant/visitor)
	new_id.update_icon()
	//here's your new id sir or ma'am :)
	visitor_id = new_id
