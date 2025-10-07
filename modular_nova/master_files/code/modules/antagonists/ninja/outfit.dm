/datum/outfit/ninja
	uniform = /obj/item/clothing/under/syndicate/ninja
	suit_store = /obj/item/energy_katana
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/ninja
	ears = /obj/item/radio/headset/ninja
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/storage/medkit/civil_defense // remove big explosion charge, replace it with a small medkit
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/storage/belt/webbing/pilot/ninja
	back = /obj/item/mod/control/pre_equipped/ninja
	box = /obj/item/storage/box/survival
	implants  = list(/obj/item/implant/smoke) // remove explosive implant, change it to smoke implant
	skillchips = list(/obj/item/skillchip/matrix_taunt)

/datum/outfit/ninja/pre_equip(mob/living/carbon/human/ninja, visuals_only)
	. = ..()
	var/obj/item/storage/medkit/suitable_medkit = /obj/item/storage/medkit/tactical_lite
	var/cyber_limb_amount = 0
	for(var/obj/item/bodypart/limb as anything in ninja.bodyparts)
		if(limb.bodytype & BODYTYPE_ROBOTIC)
			cyber_limb_amount += 1
	if(issynthetic(ninja) || cyber_limb_amount >= 3)
		suitable_medkit = /obj/item/storage/medkit/robotic_repair/preemo/stocked
	//set the backpack contents
	backpack_contents = list(
		suitable_medkit,
		/obj/item/jammer,
		/obj/item/pinpointer/crew, //keep last for quick keys
	)

/datum/outfit/ninja/post_equip(mob/living/carbon/human/ninja)
	. = ..()
	var/obj/item/card/id/id_card = locate() in ninja.belt
	var/obj/item/storage/penkit = ninja.get_item_by_slot(ITEM_SLOT_LPOCKET)
	if(id_card)
		SSid_access.apply_trim_to_card(id_card, /datum/id_trim/job/assistant/visitor)
		id_card.registered_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"
		id_card.update_label()
		id_card.update_appearance()
	if(penkit)
		if(rand(1, 10) == 1)
			new /obj/item/food/cheese/wedge(penkit)
		new /obj/item/reagent_containers/hypospray/medipen/deforest/psifinil(penkit)
		new /obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline(penkit)
		new /obj/item/reagent_containers/hypospray/medipen/deforest/synephrine(penkit) //keep last for quick keys

/datum/mod_theme/ninja
	allowed_suit_storage = list(
		/obj/item/energy_katana,
		/obj/item/katana,
		/obj/item/melee/baton,
		/obj/item/melee/energy,
		/obj/item/melee/sabre,
		/obj/item/forging/reagent_weapon,
		/obj/item/gun,
		/obj/item/storage/medkit,
	)

/obj/item/energy_katana
	worn_icon = 'icons/mob/clothing/belt.dmi' //makes the sword's suit-storage appearance work

/obj/item/storage/belt/webbing/pilot/ninja
	name = "storage webbing"
	desc = "Sleek and discrete storage solutions."
	unique_reskin = NONE

/obj/item/storage/belt/webbing/pilot/ninja/PopulateContents()
	new /obj/item/food/rationpack(src)
	new /obj/item/reagent_containers/cup/glass/flask/sake(src)
	new /obj/item/reagent_containers/cup/glass/waterbottle/tea/strawberry(src)
	new /obj/item/food/vendor_snacks/rice_crackers(src)
	new /obj/item/stock_parts/power_store/cell/hyper(src)
	new /obj/item/stack/spacecash/c200(src)
	new /obj/item/card/id/advanced/visitor(src) //keep last for quick keys

/obj/item/radio/headset/ninja
	name = "\improper Spider-Clan radio headset"
	desc = "A Spider-Clan labeled headset that can be used to hear from the command radio frequency. Protects ears from flashbangs."
	icon = 'modular_nova/master_files/icons/obj/clothing/headsets.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/ears.dmi'
	icon_state = "ninja_headset"
	worn_icon_state = "ninja_headset"
	keyslot = /obj/item/encryptionkey/headset_com

/obj/item/radio/headset/ninja/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/reagent_containers/cup/glass/flask/sake
	list_reagents = list(/datum/reagent/consumable/ethanol/sake = 60)
