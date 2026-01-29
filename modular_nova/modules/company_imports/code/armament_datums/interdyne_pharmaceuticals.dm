/datum/supply_pack/companies/medical/interdyne
	access = ACCESS_SYNDICATE
	access_view = ACCESS_SYNDICATE
	express_lock = FALSE
	order_flags = ORDER_GOODY
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE
	console_flag = CARGO_CONSOLE_INTERDYNE
	crate_type = /obj/structure/closet/crate/secure/syndicate/interdyne
	auto_name = FALSE
	crate_name = "Interdyne Medical Crate"

/datum/supply_pack/companies/medical/interdyne/defibrillators
	name = "Interdyne Defibrillator Crate"
	desc = "Specially made Interdyne Pharmaceuticals Defibrillators, Designed to shock even through modsuits with enough voltages to bring patients \
		back from the dead."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/defibrillator/compact/combat/loaded/interdyne)

/datum/supply_pack/companies/medical/interdyne/hypospray_kit
	name = "Interdyne Hypospray Kit"
	desc = "A specially made hypospray kit, designed with proprietary technology and the patient first, this kit will make any doctor and patient happy!"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/storage/hypospraykit/interdyne)

/datum/supply_pack/companies/medical/interdyne/hypospray_kit_bulk
	name = "Multi Pack of Interdyne Hypospray Kits"
	desc = "Multi pack of Specially made interdyne hypospray kits, designed with proprietary technology and the patient first, this set of hyposprays will \
	make any doctor and patient happy!"
	cost = CARGO_CRATE_VALUE * 11.5
	contains = list(/obj/item/storage/hypospraykit/interdyne = 3)

/datum/supply_pack/companies/medical/interdyne/premium_meds
	name = "Interdyne Premium Medicines"
	desc = "A specially curated box of various advanced medicines designed for frontier activity, by doctors for doctors!"
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/storage/box/evilmeds/interdyne)

/datum/supply_pack/companies/medical/interdyne/premium_meds_bulk
	name = "Multi Pack of Interdyne Premium Medicines"
	desc = "A set of specially curated box of various advanced medicines designed for frontier activity, by doctors for doctors!"
	contains = list(/obj/item/storage/box/evilmeds/interdyne = 3)
	cost = CARGO_CRATE_VALUE * 22

/datum/supply_pack/companies/medical/interdyne/nvg_medhugs
	name = "Night Vision Medhuds Crate"
	desc = "A box of state of the art medical night vision goggles, designed to assure medical staff can operate and see IN THE DARK!"
	contains = list(/obj/item/clothing/glasses/hud/health/night/science = 3)
	cost = CARGO_CRATE_VALUE * 10

/datum/supply_pack/companies/medical/interdyne/emptysmallkit
	name = "Empty Small Interdyne Kits"
	desc = "Ever needed a few empty kits? Not sure why you would, but we're here for it!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/empty = 3,)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/interdyne/emptymediumkit
	name = "Empty Interdyne Kits"
	desc = "Ever needed a few empty kits? Not sure why you would, but we're here for it!"
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/medium/empty = 3,)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/interdyne/emptylargekit
	name = "Empty Large Interdyne Kits"
	desc = "Ever needed a few empty kits? Not sure why you would, but we're here for it!"
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/empty = 3,)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/interdyne/doctorkit
	name = "Interdyne Doctor Kit"
	desc = "A surgical kit designed for surgical aid, made by doctors for doctors!"
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne )
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/companies/medical/interdyne/doctorkit_bulk
	name = "Multi Pack of Interdyne Doctor Kits"
	desc = "Multiple surgical trauma kits, made by doctors, for doctors."
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne = 3 )
	cost = CARGO_CRATE_VALUE * 13.5

/datum/supply_pack/companies/medical/interdyne/large_traumakit
	name = "Interdyne Large Trauma Kits"
	desc = "A trauma kit designed for immediate medical aid, made by doctors for doctors!"
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne )
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/companies/medical/interdyne/large_traumakit_bulk
	name = "Multi Pack of Interdyne Large Trauma Kits"
	desc = "A pack of trauma kits designed for immediate medical aid, made by doctors for doctors!"
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne = 3 )
	cost = CARGO_CRATE_VALUE * 13.5

/datum/supply_pack/companies/medical/interdyne/medium_kit
	name = "Interdyne Medical Kit"
	desc = "A standard medical kit designed around various traumas, made by doctors, for doctors."
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/medium)
	cost = CARGO_CRATE_VALUE * 3.5

/datum/supply_pack/companies/medical/interdyne/medium_kit_bulk
	name = "Multi Pack of Interdyne Medical Kit"
	desc = "A pack of standard medical kit designed around various traumas, made by doctors, for doctors."
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/medium = 3)
	cost = CARGO_CRATE_VALUE * 9

/datum/supply_pack/companies/medical/interdyne/medium_kit_surgical
	name = "Interdyne Surgical Kit"
	desc = "A surgical kit, made by doctors, for doctors."
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/medium/surgical)
	cost = CARGO_CRATE_VALUE * 3.5

/datum/supply_pack/companies/medical/interdyne/medium_kit_surgical_bulk
	name = "Multi Pack of Interdyne Surgical Kit"
	desc = "Multiple surgical kits, made by doctors, for doctors."
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/medium/surgical = 3)
	cost = CARGO_CRATE_VALUE * 9

/datum/supply_pack/companies/medical/interdyne/medium_kit_oxytoxloss
	name = "Interdyne OxyTox Trauma Kit"
	desc = "A kit filled with oxygen and toxins related ailments, made by doctors, for doctors."
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/medium/Tox_Oxy)
	cost = CARGO_CRATE_VALUE * 3.5

/datum/supply_pack/companies/medical/interdyne/medium_kit_oxytoxloss_bulk
	name = "Multi Pack of Interdyne OxyTox Trauma Kit"
	desc = "Multiple trauma kits filled with oxygen and toxins related ailments, made by doctors, for doctors."
	contains = list(/obj/item/storage/medkit/tactical/premium/interdyne/medium/Tox_Oxy = 3)
	cost = CARGO_CRATE_VALUE * 9

/datum/supply_pack/companies/medical/interdyne/firstaidkit
	name = "Interdyne First Aid Kit"
	desc = "A first aid kit designed for a variety of traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne)
	cost = CARGO_CRATE_VALUE * 2.75

/datum/supply_pack/companies/medical/interdyne/firstaidkit_bulk
	name = "Multi Pack of Interdyne First Aid Kit"
	desc = "A pack of first aid kits designed for various traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne = 3)
	cost = CARGO_CRATE_VALUE * 8

/datum/supply_pack/companies/medical/interdyne/firstaidburnkit
	name = "Interdyne First Aid Kit (Burn)"
	desc = "A first aid kit designed for burn related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/burn)
	cost = CARGO_CRATE_VALUE * 2.75

/datum/supply_pack/companies/medical/interdyne/firstaidburnkit_bulk
	name = "Multi Pack of Interdyne First Aid Kit (Burn)"
	desc = "A pack of first aid kits designed for burn related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/burn = 3)
	cost = CARGO_CRATE_VALUE * 8

/datum/supply_pack/companies/medical/interdyne/firstaidbrutekit
	name = "Interdyne First Aid Kit (Brute)"
	desc = "A first aid kit designed for brute related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/brute)
	cost = CARGO_CRATE_VALUE * 2.75

/datum/supply_pack/companies/medical/interdyne/firstaidbrutekit_bulk
	name = "Multi Pack of Interdyne First Aid Kit (Brute)"
	desc = "A pack of first aid kits designed for brute related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/brute = 3)
	cost = CARGO_CRATE_VALUE * 8

/datum/supply_pack/companies/medical/interdyne/firstaidtoxinkit
	name = "Interdyne First Aid Kit (Toxin)"
	desc = "A first aid kit designed for toxin related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/toxin)
	cost = CARGO_CRATE_VALUE * 2.75

/datum/supply_pack/companies/medical/interdyne/firstaidtoxinkit_bulk
	name = "Multi Pack of Interdyne First Aid Kit (Toxin)"
	desc = "A pack of first aid kits designed for toxin related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/toxin = 3)
	cost = CARGO_CRATE_VALUE * 8

/datum/supply_pack/companies/medical/interdyne/firstaidoxykit
	name = "Interdyne First Aid Kit (Oxygen)"
	desc = "A first aid kit designed for oxygen related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/oxygen)
	cost = CARGO_CRATE_VALUE * 2.75

/datum/supply_pack/companies/medical/interdyne/firstaidoxykit_bulk
	name = "Multi Pack of Interdyne First Aid Kit (Oxygen)"
	desc = "A pack of first aid kits designed for oxygen related traumas!"
	contains = list(/obj/item/storage/pouch/medical/firstaid/interdyne/oxygen = 3)
	cost = CARGO_CRATE_VALUE * 8

/datum/supply_pack/companies/medical/interdyne/biohazard_box
	name = "Interdyne Biohazard Response Box"
	desc = "Multiple surgical trauma kits, made by doctors, for doctors."
	contains = list(
		/obj/item/clothing/suit/bio_suit/interdyne = 3,
		/obj/item/clothing/head/bio_hood/interdyne = 3,
		/obj/item/reagent_containers/cup/jerrycan/space_cleaner = 2,
		/obj/item/reagent_containers/spray/cleaner = 3,
		/obj/item/tank/internals/oxygen = 3,
		/obj/item/storage/bag/bio,
		/obj/item/reagent_containers/syringe/antiviral = 3,
		/obj/item/clothing/gloves/latex/nitrile = 3,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/gloves,
		)
	cost = CARGO_CRATE_VALUE * 10
	crate_name = "Interdyne Biohazard Response Crate"



/*
	Apparrel & Storages
	"Its a crime to look this good."
*/

/datum/supply_pack/companies/apparel/interdyne
	access = ACCESS_SYNDICATE
	access_view = ACCESS_SYNDICATE
	express_lock = FALSE
	order_flags = ORDER_GOODY
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE
	console_flag = CARGO_CONSOLE_INTERDYNE
	crate_type = /obj/structure/closet/crate/secure/syndicate/interdyne
	auto_name = FALSE
	// This is so its ambiguous upon a glance.
	crate_name = "Interdyne Morale Support Crate"

/datum/supply_pack/companies/apparel/interdyne/guncasebig
	name = "Large Interdyne Guncase"
	desc = "A gun case for all your munitions based needs... Completely legal... I promise..."
	contains = list(/obj/item/storage/toolbox/guncase/nova/interdyne)
	cost = CARGO_CRATE_VALUE * 2

/datum/supply_pack/companies/apparel/interdyne/guncasesmall
	name = "Small Interdyne Guncase"
	desc = "A gun case for all your munitions based needs... Completely legal... I promise..."
	contains = list(/obj/item/storage/toolbox/guncase/nova/interdyne/pistol)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/apparel/interdyne/guncasebig_special
	name = "Large Interdyne Black Guncase"
	desc = "A gun case for all your munitions based needs... Completely legal... I promise..."
	contains = list(/obj/item/storage/toolbox/guncase/nova/interdynespec)
	cost = CARGO_CRATE_VALUE * 2

/datum/supply_pack/companies/apparel/interdyne/guncasesmall_special
	name = "Small Interdyne Black Guncase"
	desc = "A gun case for all your munitions based needs... Completely legal... I promise..."
	contains = list(/obj/item/storage/toolbox/guncase/nova/interdynespec/pistol)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/apparel/interdyne/maidset
	name = "Morale Boosting Maid Outfit"
	desc = "A morale boosting, kevlar lined, maid outfit, guarenteed to boost the morale of either you or your fellow personnel around you, SLIGHTLY!"
	contains = list(/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing)
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/companies/apparel/interdyne/maidset_bulk
	name = "Pack of Morale Boosting Maid Outfit"
	desc = "What's better than one morale boosting, kevlar lined, maid outfit, guarenteed to boost the morale of either you or your fellow personnel around you only SLIGHTLY? THREE OF THEM!"
	contains = list(/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing = 3)
	cost = CARGO_CRATE_VALUE * 14.5

/*
	SCIFI NERD CONTENT
*/

/datum/supply_pack/companies/modsuits/interdyne
	access = ACCESS_SYNDICATE
	access_view = ACCESS_SYNDICATE
	express_lock = FALSE
	order_flags = ORDER_GOODY
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE
	console_flag = CARGO_CONSOLE_INTERDYNE
	crate_type = /obj/structure/closet/crate/secure/syndicate/interdyne
	auto_name = FALSE
	crate_name = "Interdyne Modular Suit Technology Crate"

/datum/supply_pack/companies/modsuits/interdyne/modsuit
	name = "Interdyne Proprietary Frontier Modsuit"
	desc = "A proprietary Interdyne Modsuit, Built to be useful, carrying the Interdyne Pharmaceuticals branding gloriously."
	contains = list(/obj/item/mod/control/pre_equipped/interdyne/nerfed)
	cost = CARGO_CRATE_VALUE * 25

/datum/supply_pack/companies/modsuits/interdyne/surg_processor
	name = "Preloaded Surgical processor"
	desc = "A preloaded surgical processor, loaded with many different surgeries, built for areas without adequate scientific capabilities or studies!"
	contains = list(/obj/item/mod/module/surgical_processor/preloaded)
	cost = CARGO_CRATE_VALUE * 4

/datum/supply_pack/companies/modsuits/interdyne/surg_processor_bulks
	name = "Multi Pack of Preloaded Surgical processor"
	desc = "A set of preloaded surgical processors, each loaded with many different surgeries, built for areas without adequate scientific capabilities or studies!"
	contains = list(/obj/item/mod/module/surgical_processor/preloaded = 3)
	cost = CARGO_CRATE_VALUE * 10

/*
	Anything AI/Borg/Machine
*/
/datum/supply_pack/companies/machines/interdyne
	access = ACCESS_SYNDICATE
	access_view = ACCESS_SYNDICATE
	express_lock = FALSE
	order_flags = ORDER_GOODY
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE
	console_flag = CARGO_CONSOLE_INTERDYNE
	crate_type = /obj/structure/closet/crate/secure/syndicate/interdyne
	auto_name = FALSE
	crate_name = "Interdyne Technology Crate"

/datum/supply_pack/companies/machines/interdyne/mmi
	name = "Interdyne MMI Brain"
	desc = "A morally questionable device, that you can use to turn living brains into cyborgs!"
	contains = list(/obj/item/mmi/syndie/interdyne)
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/companies/machines/interdyne/posibrain
	name = "Interdyne Posi Brain"
	desc = "A less morally questionable device, useful in activating new cyborgs!"
	contains = list(/obj/item/mmi/posibrain/syndie/interdyne)
	cost = CARGO_CRATE_VALUE * 5
