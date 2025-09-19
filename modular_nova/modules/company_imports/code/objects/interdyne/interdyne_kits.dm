/*
/// Medkits
*/

/obj/item/defibrillator/compact/combat/loaded/interdyne
	name = "\improper Interdyne rapid combative defibrillator"
	desc = "A belt-equipped combative defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, however due to legal concerns these defibrillators have been installed with a safeline. \
	safeline, heartbeat detector preventing malpractice with the defibrillators"
	icon = 'modular_nova/master_files/icons/obj/medical/defib.dmi'
	icon_state = "defibip"
	inhand_icon_state = null
	worn_icon_state = "defibip"
	paddle_state = "defibip-paddles"
	paddle_type = /obj/item/shockpaddles/interdyne
	safety = TRUE

/obj/item/shockpaddles/interdyne
	name = "interdyne defibrillator paddles"
	desc = "A pair of paddles used to revive deceased operatives. They possess the ability to penetrate armor."
	combat = TRUE
	icon = 'modular_nova/master_files/icons/obj/medical/defib.dmi'
	icon_state = "ippaddles0"
	inhand_icon_state = "ippaddles0"
	base_icon_state = "ippaddles"

/obj/item/storage/medkit/tactical/premium/interdyne
	name = "\improper Interdyne Premium Doctor's Kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools."
	icon_state = "interdyne_premium_surgical"
	icon = 'modular_nova/master_files/icons/obj/storage/medkit.dmi'
	inhand_icon_state = "medkit-tactical-premium"
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/equipment/medical_righthand.dmi'
	storage_type = /datum/storage/duffel/deforest_big_surgery
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Default" = "interdyne_premium_surgical",
		"Corpse" = "interdyne_premium_corpse",
		"Burn" = "interdyne_premium_burn",
		"Brute" = "interdyne_premium_brute",
		"Toxin" = "interdyne_premium_toxin",
		"Oxy" = "interdyne_premium_oxy",
		"Tactical" = "interdyne_premium",
	)

/obj/item/storage/medkit/tactical/premium/interdyne/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/cautery/advanced = 1,
		/obj/item/defibrillator/compact/combat/loaded/interdyne = 1,
		/obj/item/circular_saw/field_medic/lowforce = 1,
		/obj/item/bonesetter = 1,
		/obj/item/stack/sticky_tape/surgical = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/stack/medical/bone_gel = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/empty
	name = "\improper Interdyne Trauma Kit"

/obj/item/storage/medkit/tactical/premium/interdyne/empty/PopulateContents()
	var/static/list/items_inside = list()
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/trauma
	name = "\improper Interdyne Premium Trauma Kit"
	desc = "A large emergency medical kit loaded with supplies to fit many emergencies and provide aid."
	icon_state = "interdyne_premium"

/obj/item/storage/medkit/tactical/premium/interdyne/trauma/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 4,
		/obj/item/stack/medical/mesh/advanced = 4,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 2,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 1,
	)
	generate_items_inside(items_inside,src)

/*
/// Medium Medkits
*/

/obj/item/storage/medkit/tactical/premium/interdyne/medium
	name = "\improper Interdyne Trauma Kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools."
	icon_state = "interdyne_surgical"
	inhand_icon_state = "medkit-tactical"
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/equipment/medical_righthand.dmi'
	storage_type = /datum/storage/duffel/deforest_paramedic
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Default" = "interdyne_surgical",
		"Corpse" = "interdyne_coroner",
		"Burn" = "interdyne_burn",
		"Brute" = "interdyne_brute",
		"Toxin" = "interdyne_toxin",
		"Oxy" = "interdyne_oxy",
		"Tactical" = "interdyne_tactical",
	)

/obj/item/storage/medkit/tactical/premium/interdyne/medium/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/storage/box/bandages/interdyne = 1,
		/obj/item/storage/box/bandages/interdyne/burn = 1,
		/obj/item/reagent_containers/hypospray/medipen/morphine = 2,
		/obj/item/reagent_containers/hypospray/medipen = 2,
		/obj/item/storage/hypospraykit/interdyne = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_brutemix = 2,
		/obj/item/reagent_containers/cup/beaker/dyne_burnmix= 2,
		/obj/item/reagent_containers/spray/hercuri = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/medium/empty
	name = "\improper Interdyne Trauma Kit"

/obj/item/storage/medkit/tactical/premium/interdyne/medium/empty/PopulateContents()
	var/static/list/items_inside = list()
	generate_items_inside(items_inside,src)


/obj/item/storage/medkit/tactical/premium/interdyne/medium/Tox_Oxy
	name = "\improper Interdyne Critical Burn-Brute Kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools. Meant for treating critical bruises"
	icon_state = "interdyne_brute"

/obj/item/storage/medkit/tactical/premium/interdyne/medium/Tox_Oxy/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/storage/box/bandages/interdyne = 1,
		/obj/item/storage/box/bandages/interdyne/burn = 1,
		/obj/item/reagent_containers/hypospray/medipen/morphine = 2,
		/obj/item/reagent_containers/hypospray/medipen = 2,
		/obj/item/storage/hypospraykit/interdyne = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_brutemix = 2,
		/obj/item/reagent_containers/cup/beaker/dyne_burnmix= 2,
		/obj/item/reagent_containers/spray/hercuri = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/medium/surgical
	name = "\improper Interdyne Field Surgical Kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools. Meant for fielld surgeries."
	icon_state = "interdyne_surgical"

/obj/item/storage/medkit/tactical/premium/interdyne/medium/surgical/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/cautery/advanced = 1,
		/obj/item/bonesetter = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/reagent_containers/hypospray/medipen/morphine = 2,
		/obj/item/stack/sticky_tape/surgical = 3,
		/obj/item/stack/medical/bone_gel = 3,
		/obj/item/storage/pill_bottle/painkiller = 2,
		/obj/item/reagent_containers/medigel/sterilizine = 2,
		/obj/item/stack/medical/gauze/sterilized = 3,
	)
	generate_items_inside(items_inside,src)

/*
/// Small Medkits
*/

/obj/item/storage/pouch/medical/firstaid/interdyne
	name = "\improper Interdyne Emergency Trauma Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon = 'modular_nova/master_files/icons/obj/storage/medkit.dmi'
	icon_state = "interdyne_lite"
	inhand_icon_state = "medkit-tactical-lite"
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/equipment/medical_righthand.dmi'
	storage_type = /datum/storage/pouch/medical/small
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Default" = "interdyne_lite",
		"Corpse" = "interdyne_lite_corpse",
		"Burn" = "interdyne_lite_burn",
		"Brute" = "interdyne_lite_brute",
		"Toxin" = "interdyne_lite_toxin",
		"Oxy" = "interdyne_lite_oxy",
		"Surgical" = "interdyne_lite_surgical",
	)

/obj/item/storage/pouch/medical/firstaid/interdyne/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 1,
		/obj/item/stack/medical/mesh/advanced = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/empty
	name = "\improper Interdyne Trauma Kit"

/obj/item/storage/pouch/medical/firstaid/interdyne/empty/PopulateContents()
	var/static/list/items_inside = list()
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/brute
	name = "\improper Interdyne Emergency Brute Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon_state = "interdyne_lite_brute"

/obj/item/storage/pouch/medical/firstaid/interdyne/brute/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/reagent_containers/cup/bottle/epinephrine = 2,
		/obj/item/storage/box/bandages/interdyne = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/burn
	name = "\improper Interdyne Emergency Burn Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon_state = "interdyne_lite_burn"

/obj/item/storage/pouch/medical/firstaid/interdyne/burn/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/storage/box/bandages/interdyne/burn = 1,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 1,
		/obj/item/reagent_containers/hypospray/medipen = 2,
		/obj/item/reagent_containers/spray/hercuri = 1,
	)
	generate_items_inside(items_inside,src)


/obj/item/storage/pouch/medical/firstaid/interdyne/toxin
	name = "\improper Interdyne Emergency Toxins Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon_state = "interdyne_lite_toxin"

/obj/item/storage/pouch/medical/firstaid/interdyne/toxin/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/storage/pill_bottle/multiver = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 1,
		/obj/item/reagent_containers/syringe/syriniver = 1,
		/obj/item/storage/box/bandages/interdyne/toxin = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/oxygen
	name = "\improper Interdyne Emergency Oxyloss Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon_state = "interdyne_lite_oxy"

/obj/item/storage/pouch/medical/firstaid/interdyne/oxygen/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/storage/box/bandages/interdyne/oxygen = 1,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 2,
		/obj/item/reagent_containers/hypospray/medipen = 2,
	)
	generate_items_inside(items_inside,src)

/*
/// Duffel Bags Past this point
*/

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing
	name = "\improper tactical maid kit"
	desc = "Only carries one tactical maid set."

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing/PopulateContents()
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)

/obj/item/storage/box/evilmeds/interdyne
	name = "\improper box of Interdyne Medicines"
	desc = "Contains a large number of beakers filled with premium medical supplies. Straight from Interdyne Pharmaceutics!"
	icon_state = "syndiebox"
	illustration = "beaker"

/obj/item/storage/box/evilmeds/interdyne/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/reagent_containers/cup/beaker/dyne_brutemix = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_burnmix = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_oxytox = 1,
		/obj/item/reagent_containers/cup/beaker/rezadone/less = 1,
		/obj/item/paper/fluff/interdyne/medicines = 1,
	)
	generate_items_inside(items_inside,src)
