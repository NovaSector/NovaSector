/*
*	LOADOUT ITEM DATUMS FOR SIGNATURE ITEMS
*/

///WEAPONS
GLOBAL_LIST_INIT(loadout_signature, generate_loadout_items(/datum/loadout_item/signature))

/datum/loadout_item/signature
	category = LOADOUT_ITEM_SIGNATURE

/datum/loadout_item/signature/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.r_hand) && initial(outfit_important_for_life.l_hand))
		if(!visuals_only)
			LAZYADD(outfit.backpack_contents, item_path)
		return TRUE

/datum/loadout_item/signature/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(outfit.l_hand && !outfit.r_hand)
		outfit.r_hand = item_path
	else
		if(outfit.l_hand)
			LAZYADD(outfit.backpack_contents, outfit.l_hand)
		outfit.l_hand = item_path

///MELEE
/datum/loadout_item/signature/bowie_sheath
	name = "Bowie Sheath"
	item_path = /obj/item/storage/belt/bowie_sheath

/datum/loadout_item/signature/sabre
	name = "Samshir Leather Sheath"
	item_path = /obj/item/storage/belt/sabre/cargo

/datum/loadout_item/signature/cleaver
	name = "Butcher's Cleaver"
	item_path = /obj/item/knife/butcher

/datum/loadout_item/signature/teknodachi
	name = "Teknodachi"
	item_path = /obj/item/katana/teknodachi

/datum/loadout_item/signature/highfrequencyblade
	name = "Vibrodachi"
	item_path = /obj/item/highfrequencyblade/vibrodachi

/datum/loadout_item/signature/crusher
	name = "Proto-Kinetic Crusher"
	item_path = /obj/item/kinetic_crusher

/datum/loadout_item/signature/metal_h2_axe
	name = "Metallic Hydrogen Axe"
	item_path = /obj/item/fireaxe/metal_h2_axe

/datum/loadout_item/signature/metalbat
	name = "Alloy Bat"
	item_path = /obj/item/melee/baseball_bat/ablative

/datum/loadout_item/signature/weaponized_mop
	name = "Weaponized Advanced Mop"
	item_path = /obj/item/mop/advanced/weaponized

///RANGED
/datum/loadout_item/signature/wespe
	name = "Wespe Pistol Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/wespe

/datum/loadout_item/signature/sol_smg
	name = "Carwo Sindano Submachine Gun Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano/evil

/datum/loadout_item/signature/bogseo
	name = "Xhihao Bogseo Personal Defense Weapon Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/xhihao_large_case/bogseo

/datum/loadout_item/signature/takbok
	name = "Trappiste Takbok Revolver Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/takbok

/datum/loadout_item/signature/renoster
	name = "Renoster Shotgun Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/opfor/renoster

/datum/loadout_item/signature/rebar_crossbow
	name = "Rebar Crossbow Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/opfor/rebar_crossbow

/datum/loadout_item/signature/amr
	name = "'Wyłom' AMR Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/opfor/amr

/datum/loadout_item/signature/modular_laser_rifle
	name = "Hyeseong Modular Laser Rifle"
	item_path = /obj/item/gun/energy/modular_laser_rifle

/datum/loadout_item/signature/modular_laser_carbine
	name = "Hoshi Modular Laser Carbine"
	item_path = /obj/item/gun/energy/modular_laser_rifle/carbine

/datum/loadout_item/signature/
	name = "'Słońce' Plasma Projector Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/plasma_pistol

/datum/loadout_item/signature/gwiazda
	name = "'Gwiazda' Plasma Sharpshooter Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/plasma_marksman

///IMPLANTS

/datum/loadout_item/signature/armblade
	name = "Mantis Blade Implant"
	item_path = /obj/item/autosurgeon/syndicate/armblade

/datum/loadout_item/signature/razorwire
	name = "Razorwire Implant"
	item_path = /obj/item/autosurgeon/syndicate/razorwire

/datum/loadout_item/signature/surgeon
	name = "Surgical Toolset Implant"
	item_path = /obj/item/autosurgeon/surgery

/datum/loadout_item/signature/toolset
	name = "Engineering Toolset Implant"
	item_path = /obj/item/autosurgeon/toolset

///MECH

/datum/loadout_item/signature/mecha_beacon
	name = "Exosuit Deployment Beacon"
	item_path = /obj/item/choice_beacon/mecha

///MODULES
/datum/loadout_item/signature/medbeammod
	name = "Medbeam Module"
	item_path = /obj/item/mod/module/medbeam

/datum/loadout_item/signature/retractableplatemod
	name = "Retractable Plates Module"
	item_path = /obj/item/mod/module/armor_booster/retractplates

/datum/loadout_item/signature/shurikenmod
	name = "Shuriken Dispenser Module"
	item_path = /obj/item/mod/module/dispenser/ninja

///UTILITY
/datum/loadout_item/signature/hypospray
	name = "Deluxe Hypospray Kit"
	item_path = /obj/item/storage/hypospraykit/cmo

/datum/loadout_item/signature/advanced_synth_kit
	name = "Advanced Synth Treatment Kit"
	item_path = /obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/advanced

/datum/loadout_item/signature/combat_surgeon_kit
	name = "Combat Surgeon Medical Kit"
	item_path = /obj/item/storage/medkit/combat_surgeon/stocked

/datum/loadout_item/signature/bsminer
	name = "Bluespace Miner Board"
	item_path = /obj/item/circuitboard/machine/bluespace_miner

/datum/loadout_item/signature/ircd
	name = "Improved RCD"
	item_path = /obj/item/construction/rcd/improved

/datum/loadout_item/signature/combat_wrench
	name = "Combat Wrench"
	item_path = /obj/item/wrench/combat
