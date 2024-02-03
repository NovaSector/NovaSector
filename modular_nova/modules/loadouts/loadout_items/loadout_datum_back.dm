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

/datum/loadout_item/back/smuggler
	name = "Smuggler's Satchel"
	item_path = /obj/item/storage/backpack/satchel/flat/empty
	additional_tooltip_contents = list("Can only be used with Place All in Case.")

/datum/loadout_item/back/cinpack
	name = "CIN Military Backpack"
	item_path = /obj/item/storage/backpack/industrial/cin_surplus
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/cinpackdes
	name = "CIN Desert Backpack"
	item_path = /obj/item/storage/backpack/industrial/cin_surplus/desert
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/cinpackfor
	name = "CIN Forest Backpack"
	item_path = /obj/item/storage/backpack/industrial/cin_surplus/forest
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/cinpackmar
	name = "CIN Marine Backpack"
	item_path = /obj/item/storage/backpack/industrial/cin_surplus/marine
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/exped
	name = "Expeditionary Corps Backpack"
	item_path = /obj/item/storage/backpack/duffelbag/expeditionary_corps
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/saddlepack
	name = "Saddlepack"
	item_path = /obj/item/storage/backpack/saddlepack
	additional_tooltip_contents = list("Can only be used with Place All in Case.")

/datum/loadout_item/back/ertpack
	name = "Responsory Backpack"
	item_path = /obj/item/storage/backpack/ert/odst
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/hecu
	name = "HECU Pack"
	item_path = /obj/item/storage/backpack/ert/odst/hecu
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/bunnybag
	name = "Easter Bunny Satchel"
	item_path = /obj/item/storage/backpack/satchel/bunnysatchel
	additional_tooltip_contents = list("Can only be used with Place All in Case.")

/datum/loadout_item/back/crusader
	name = "Crusader Bandolier"
	item_path = /obj/item/storage/backpack/satchel/crusader
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/surgery
	name = "First Responder Surgical Kit"
	item_path = /obj/item/storage/backpack/duffelbag/deforest_surgical
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/formed
	name = "Satchel Medical Kit"
	item_path = /obj/item/storage/backpack/duffelbag/deforest_medkit
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/*
*	Job Backpack
*/

/datum/loadout_item/back/botback
	name = "Botany Backpack"
	item_path = /obj/item/storage/backpack/botany
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/chemback
	name = "Chemistry Backpack"
	item_path = /obj/item/storage/backpack/chemistry
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/corback
	name = "Coroner Backpack"
	item_path = /obj/item/storage/backpack/coroner
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/expback
	name = "Explorer Backpack"
	item_path = /obj/item/storage/backpack/explorer
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/genback
	name = "Genetics Backpack"
	item_path = /obj/item/storage/backpack/genetics
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/engback
	name = "Industrial Backpack"
	item_path = /obj/item/storage/backpack/industrial
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/medback
	name = "Medical Backpack"
	item_path = /obj/item/storage/backpack/medic
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/robback
	name = "Robotics Backpack"
	item_path = /obj/item/storage/backpack/science/robo
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/sciback
	name = "Science Backpack"
	item_path = /obj/item/storage/backpack/science
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/secback
	name = "Security Backpack"
	item_path = /obj/item/storage/backpack/security
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/redsecback
	name = "Red Security Backpack"
	item_path = /obj/item/storage/backpack/security/redsec
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/virback
	name = "Virologist Backpack"
	item_path = /obj/item/storage/backpack/virology
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/*
*	Job Satchel
*/

/datum/loadout_item/back/botsat
	name = "Botany Satchel"
	item_path = /obj/item/storage/backpack/satchel/hyd
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/chemsat
	name = "Chemistry Satchel"
	item_path = /obj/item/storage/backpack/satchel/chem
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/corsat
	name = "Coroner Satchel"
	item_path = /obj/item/storage/backpack/satchel/coroner
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/expsat
	name = "Explorer Satchel"
	item_path = /obj/item/storage/backpack/satchel/explorer
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/gensat
	name = "Genetics Satchel"
	item_path = /obj/item/storage/backpack/satchel/gen
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/engsat
	name = "Industrial Satchel"
	item_path = /obj/item/storage/backpack/satchel/eng
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/medsat
	name = "Medical Satchel"
	item_path = /obj/item/storage/backpack/satchel/med
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/robsat
	name = "Robotics Satchel"
	item_path = /obj/item/storage/backpack/satchel/science/robo
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/scisat
	name = "Science Satchel"
	item_path = /obj/item/storage/backpack/satchel/science
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/secsat
	name = "Security Satchel"
	item_path = /obj/item/storage/backpack/satchel/sec
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/redsecsat
	name = "Red Security Satchel"
	item_path = /obj/item/storage/backpack/satchel/sec/redsec
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/virsat
	name = "Virologist Satchel"
	item_path = /obj/item/storage/backpack/satchel/vir
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/*
*	Job Duffelbag
*/

/datum/loadout_item/back/botduff
	name = "Botany Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/hydroponics
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/chemduff
	name = "Chemistry Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/chemistry
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/corduff
	name = "Coroner Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/coroner
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/expduff
	name = "Explorer Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/explorer
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/genduff
	name = "Genetics Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/genetics
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/engduff
	name = "Industrial Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/engineering
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/medduff
	name = "Medical Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/med
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/robduff
	name = "Robotics Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/science/robo
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/sciduff
	name = "Science Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/science
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/secduff
	name = "Security Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/sec
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/redsecduff
	name = "Red Security Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/sec/redsec
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/virduff
	name = "Virologist Duffelbag"
	item_path = /obj/item/storage/backpack/duffelbag/virology
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/*
*	Functional
*/

/datum/loadout_item/back/gravharness
	name = "Gravity Suspension Harness"
	item_path = /obj/item/gravity_harness
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/*
*	Non-Storage
*/

/datum/loadout_item/back/oxy
	name = "Oxygen Tank"
	item_path = /obj/item/tank/internals/oxygen
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/oxyyellow
	name = "Yellow Oxygen Tank"
	item_path = /obj/item/tank/internals/oxygen/yellow
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/back/oxyred
	name = "Red Oxygen Tank"
	item_path = /obj/item/tank/internals/oxygen/red
	additional_tooltip_contents = list("Can only be used with Place All in Case.")
	blacklisted_roles = list(JOB_PRISONER)

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
