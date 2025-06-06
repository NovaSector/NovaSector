/datum/quirk/visitor
	name = "Visitor ID"
	desc = "Whenever you are an assistant, you're given a visitor ID without maintenance access, nor an entry on the crew manifest."
	icon = FA_ICON_PERSON_CIRCLE_QUESTION
	value = -2
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

/datum/quirk/visitor/post_add()
	if(!can_run())
		return
	if(SSticker.HasRoundStarted())
		quirk_holder.mind.assigned_role.job_flags &= ~JOB_CREW_MANIFEST //latejoin crew load quirks before manifest injection
	GLOB.manifest.remove(quirk_holder.real_name) //roundstart crew load quirks after manifest injection
	//update sechud
	var/mob/living/carbon/human/quirk_human = quirk_holder
	quirk_human.sec_hud_set_ID()

/datum/quirk/visitor/remove(erase_new = TRUE, return_id = TRUE, inject_into_manifest = TRUE)
	var/mob/living/carbon/human/quirk_human = quirk_holder
	if(erase_new)
		QDEL_NULL(visitor_id)
	if(return_id)
		old_id.equip_to_best_slot(quirk_human)
		quirk_human.sec_hud_set_ID()
	if(inject_into_manifest)
		GLOB.manifest.inject(quirk_human, quirk_human.appearance, quirk_holder.client)
	old_id = null //idk if this is necessary

/datum/quirk/visitor/proc/can_run()
	if(!istype(quirk_holder.mind.assigned_role, SSjob.get_job_type(/datum/job/assistant)))
		return FALSE
	if(istype(quirk_holder.get_item_by_slot(ITEM_SLOT_ID), /obj/item/card/id/advanced) || istype(quirk_holder.get_item_by_slot(ITEM_SLOT_ID), /obj/item/storage/wallet))
		return TRUE
	else
		return FALSE

/datum/quirk/visitor/proc/get_id()
	if(istype(quirk_holder.get_item_by_slot(ITEM_SLOT_ID), /obj/item/storage/wallet))
		var/obj/item/storage/wallet/wallet = quirk_holder.get_item_by_slot(ITEM_SLOT_ID)
		return wallet.front_id
	else
		return quirk_holder.get_item_by_slot(ITEM_SLOT_ID)

/datum/quirk/visitor/proc/preserve_old_id(obj/item/card/id/advanced/preserved_id)
	old_id = duplicate_object(preserved_id, get_turf(quirk_holder))
	old_id.moveToNullspace()
	SSid_access.apply_trim_to_card(old_id, /datum/id_trim/job/assistant, TRUE) //otherwise gets lost when duplicated. don't know why
	old_id.registered_account = SSeconomy.bank_accounts_by_id["[preserved_id.registered_account.account_id]"] //the bank account too
	old_id.registered_account.bank_cards += old_id

/datum/quirk/visitor/proc/build_new_id(obj/item/card/id/advanced/new_id)
	new_id.icon_state = /obj/item/card/id/advanced/visitor::icon_state
	new_id.icon = /obj/item/card/id/advanced/visitor::icon
	new_id.assigned_icon_state = /obj/item/card/id/advanced/visitor::assigned_icon_state
	new_id.desc = /obj/item/card/id/advanced/visitor::desc
	SSid_access.apply_trim_to_card(new_id, /datum/id_trim/job/assistant/visitor, FALSE)
	new_id.update_icon()
	//here's your new id sir or ma'am :)
	visitor_id = new_id

/obj/item/card/id/advanced/visitor //this exists so agent id's can disguise as it
	name = "Visitor's ID"
	icon_state = "visitor"
	icon = 'modular_nova/master_files/code/datums/quirks/negative_quirks/visitor/icons/card.dmi'
	assigned_icon_state = null
	desc = "An ID card to be issued to visitors of the station. Its appearance leaves much to be desired, making it glaringly obvious you weren't worth the beaurocratic effort."
	trim = /datum/id_trim/job/assistant/visitor

/datum/id_trim/job/assistant/visitor
	trim_state = "trim_visitor"
	trim_icon = 'modular_nova/master_files/code/datums/quirks/negative_quirks/visitor/icons/card.dmi'
	sechud_icon_state = SECHUD_UNKNOWN
	extra_access = list() //sorry nothing
