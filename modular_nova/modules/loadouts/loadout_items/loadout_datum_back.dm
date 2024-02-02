/*
*	LOADOUT ITEM DATUMS FOR THE BACK SLOT
*/

/// Back Slot Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_back, generate_loadout_items(/datum/loadout_item/back))

/datum/loadout_item/back
	category = LOADOUT_ITEM_BACK

/datum/loadout_item/back/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.back))
		.. ()
		return TRUE

/datum/loadout_item/back/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.back)
			LAZYADD(outfit.backpack_contents, outfit.back)
		outfit.back = item_path
	else
		outfit.back = item_path

/*
*	Backpacks
*/

/datum/loadout_item/back/frontierbackpack
	name = "Frontier Backpack"
	item_path = /obj/item/storage/backpack/industrial/frontier_colonist
	additional_tooltip_contents = list("Can only be used with Place All in Case.")

/datum/loadout_item/back/frontiersatchel
	name = "Frontier Satchel"
	item_path = /obj/item/storage/backpack/industrial/frontier_colonist/satchel
	additional_tooltip_contents = list("Can only be used with Place All in Case.")

/datum/loadout_item/back/frontiermessenger
	name = "Frontier Messenger Bag"
	item_path = /obj/item/storage/backpack/industrial/frontier_colonist/messenger
	additional_tooltip_contents = list("Can only be used with Place All in Case.")

/*
*	MODSuits
*/

/datum/loadout_item/back/standardmod
	name = "Standard MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/standard/load
	additional_tooltip_contents = list("NON-STANDARD. This item is not the same as its standard configuration.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/civilianmod
	name = "Civilian MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/standard/civilian/load
	additional_tooltip_contents = list("NON-STANDARD. This item is not the same as its standard configuration.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/protomod
	name = "Prototype MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/prototype/load
	additional_tooltip_contents = list("NON-STANDARD. This item is not the same as its standard configuration.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/colomod
	name = "Colonist MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/frontier_colonist/load
	additional_tooltip_contents = list("NON-STANDARD. This item is not the same as its standard configuration.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/engimod
	name = "Engineer MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/engineering
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ENGINEERING_GUARD)

/datum/loadout_item/back/atmosmod
	name = "Atmospheric MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/atmospheric
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/back/loadermod
	name = "Loader MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/loader
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_CUSTOMS_AGENT)

/datum/loadout_item/back/medmod
	name = "Medical MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/medical
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_ORDERLY)

/datum/loadout_item/back/secmod
	name = "Security MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/security
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER)

/datum/loadout_item/back/clownmod
	name = "Cosmohonk MOD Control Unit"
	item_path = /obj/item/mod/control/pre_equipped/cosmohonk
	restricted_roles = list(JOB_CLOWN, JOB_MIME)
