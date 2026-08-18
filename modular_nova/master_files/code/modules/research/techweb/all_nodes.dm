
// NEW NODES

/datum/techweb_node/adv_vision
	display_name = "Combat Cybernetic Eyes"
	description = "Military grade combat implants to improve vision."
	prerequisite_nodes = list(/datum/techweb_node/cyber/combat_implants, /datum/techweb_node/alien/surgery)
	unlocked_designs = list(
		/datum/design/cyberimp_thermals,
		/datum/design/cyberimp_xray,
		/datum/design/cyberimp_thermals/moth,
		/datum/design/cyberimp_xray/moth,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE, RADIO_CHANNEL_MEDICAL)

/datum/techweb_node/borg_shapeshifter
	display_name = "Illegal Cyborg Addition"
	description = "Some sort of experimental tool that was once used by an rival company."
	prerequisite_nodes = list(/datum/techweb_node/syndicate_basic)
	unlocked_designs = list(/datum/design/borg_shapeshifter_module)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/android_chassis
	node_flags = TECHWEB_NODE_STARTER | TECHWEB_NODE_WIKI
	display_name = "Android Technology"
	description = "Shiny parts for your shiny friends!"
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/synth_head,
		/datum/design/synth_chest,
		/datum/design/synth_l_arm,
		/datum/design/synth_r_arm,
		/datum/design/synth_l_leg,
		/datum/design/synth_r_leg,
		/datum/design/synth_l_d_leg,
		/datum/design/synth_r_d_leg,
		/datum/design/synth_diy,
	)

/datum/techweb_node/android_organs
	node_flags = TECHWEB_NODE_STARTER | TECHWEB_NODE_WIKI
	display_name = "Android Organs"
	description = "Internal Mechanisms for Synthetics and IPC's."
	prerequisite_nodes = list(/datum/techweb_node/robotics)
	unlocked_designs = list(
		/datum/design/synth_posi,
		/datum/design/synth_eyes,
		/datum/design/synth_tongue,
		/datum/design/synth_liver,
		/datum/design/synth_heatsink,
		/datum/design/synth_stomach,
		/datum/design/synth_charger,
		/datum/design/synth_ears,
		/datum/design/synth_heart,
	)

// MODULAR ADDITIONS AND REMOVALS

//Base Nodes
/datum/techweb_node/atmos/New()
	unlocked_designs += list(
		/datum/design/vox_gas_filter,
		/datum/design/vaporizer,
	)
	return ..()

/datum/techweb_node/construction/New()
	unlocked_designs += list(
		/datum/design/polarizer,
		/datum/design/airbag,
	)
	return ..()

/datum/techweb_node/office_equip/New()
	unlocked_designs += list(
		/datum/design/board/gbp_machine,
		/datum/design/pen,
		/datum/design/d2,
		/datum/design/d4,
		/datum/design/d6,
		/datum/design/d8,
		/datum/design/d10,
		/datum/design/d00,
		/datum/design/d12,
		/datum/design/d20,
		/datum/design/d100,
		/datum/design/fudge,
	)
	return ..()

/datum/techweb_node/augmentation/New()
	unlocked_designs += list(
		/datum/design/affection_module,
	)
	return ..()

/datum/techweb_node/medbay_equip/New()
	unlocked_designs += list(
		/datum/design/surgical_gown,
		/datum/design/anesthetic_machine,
		/datum/design/smartdartgun,
		/datum/design/cone_of_shame,
		/datum/design/defibrillator,
		/datum/design/medkit,
	)
	return ..()

/datum/techweb_node/material_processing/New()
	unlocked_designs += list(
		/datum/design/spaceship_plates,
		/datum/design/spaceship_glass,
	)
	return ..()

/////////////////////////Biotech/////////////////////////

/datum/techweb_node/medbay_equip_adv/New()
	unlocked_designs += list(
		/datum/design/monkey_helmet,
		/datum/design/medicell/brute2,
		/datum/design/medicell/burn2,
		/datum/design/medicell/toxin2,
		/datum/design/medicell/oxy2,
		/datum/design/medicell/utility/relocation,
		/datum/design/medicell/utility/temp,
		/datum/design/medicell/utility/body,
		/datum/design/medicell/utility/clot,
	)
	return ..()

/////////////////////////EMP tech/////////////////////////

/datum/techweb_node/energy_manipulation/New()
	unlocked_designs += list(
		/datum/design/medicell/utility/gown,
		/datum/design/medicell/utility/bed,
		/datum/design/tray_goggles_prescription,
	)
	return ..()

////////////////////////Computer tech////////////////////////

/datum/techweb_node/consoles/New()
	unlocked_designs += list(
		/datum/design/nif_service_tools,
		/datum/design/id/visitor,
	)
	return ..()


/datum/techweb_node/hud/New()
	unlocked_designs += list(
		/datum/design/health_hud_prescription,
		/datum/design/security_hud_prescription,
		/datum/design/diagnostic_hud_prescription,
		/datum/design/science_hud_prescription,
		/datum/design/health_hud_aviator,
		/datum/design/security_hud_aviator,
		/datum/design/diagnostic_hud_aviator,
		/datum/design/meson_hud_aviator,
		/datum/design/science_hud_aviator,
		/datum/design/health_hud_projector,
		/datum/design/security_hud_projector,
		/datum/design/diagnostic_hud_projector,
		/datum/design/meson_hud_projector,
		/datum/design/science_hud_projector,
		/datum/design/permit_hud,
		/datum/design/nifsoft_money_sense,
		/datum/design/nif_hud_kit,
		/datum/design/nifsoft_hud/science,
		/datum/design/nifsoft_hud/meson,
		/datum/design/nifsoft_hud/medical,
		/datum/design/nifsoft_hud/security,
		/datum/design/nifsoft_hud/diagnostic,
		/datum/design/nifsoft_hud/cargo,
	)
	return ..()

////////////////////////Medical////////////////////////
/datum/techweb_node/surgery/New()
	unlocked_designs += list(
		/datum/design/nif_surgery_tools,
	)
	return ..()

/datum/techweb_node/medbay_equip_adv/New()
	unlocked_designs += list(
		/datum/design/board/self_actualization_device,
	)
	return ..()

/datum/techweb_node/cyber/cyber_organs/New()
	unlocked_designs += list(
		/datum/design/cybernetic_tongue,
		/datum/design/cybernetic_tongue/lizard,
	)
	return ..()

// Modularly removes x-ray and thermals from here, it's in adv_vision instead
/datum/techweb_node/cyber/cyber_organs_adv/New()
	unlocked_designs -= list(
		/datum/design/cyberimp_thermals,
		/datum/design/cyberimp_xray,
		/datum/design/cyberimp_thermals/moth,
		/datum/design/cyberimp_xray/moth,
	)
	return ..()

////////////////////////Tools////////////////////////

/datum/techweb_node/hydroponics/New()
	unlocked_designs += list(
		/datum/design/medicell/utility/salve,
	)
	return ..()

/datum/techweb_node/sec_equip/New()
	unlocked_designs += list(
		/datum/design/nifsoft_remover,
		/datum/design/nif_detective_tools,

	)
	return ..()

/////////////////////////weaponry tech/////////////////////////

/datum/techweb_node/basic_arms/New()
	unlocked_designs += list(
		/datum/design/board/ammo_workbench,
	)
	return ..()

/datum/techweb_node/riot_supression/New()
	unlocked_designs += list(
		/datum/design/ammo_workbench_module_gimmick,
		/datum/design/pin_standard,
	)
	return ..()

/datum/techweb_node/electric_weapons/New()
	unlocked_designs += list(
		/datum/design/medigun_speedkit,
	)
	return ..()

/datum/techweb_node/exotic_ammo/New()
	unlocked_designs += list(
		/datum/design/c38_haywire,
		/datum/design/c38_haywire_mag,
		/datum/design/ammo_workbench_module_niche,
		/datum/design/shotgun_dart_pen,
	)
	return ..()

////////////////////////Alien technology////////////////////////

/datum/techweb_node/alien/surgery/New()
	unlocked_designs += list(
		/datum/design/medicell/brute3,
		/datum/design/medicell/burn3,
		/datum/design/medicell/oxy3,
		/datum/design/medicell/toxin3,
	)
	return ..()

/////////////////////////engineering tech/////////////////////////

/datum/techweb_node/parts_upg/New()
	unlocked_designs += list(
		/datum/design/nif_general_tools,
	)
	return ..()

/datum/techweb_node/fusion/New()
	unlocked_designs += list(
		/datum/design/engine_goggles_prescription,
	)
	return ..()

/datum/techweb_node/exp_tools/New()
	unlocked_designs += list(
		/datum/design/board/cell_charger_multi,
	)
	return ..()

/datum/techweb_node/chem_synthesis/New()
	unlocked_designs += list(
		/datum/design/hypokit,
		/datum/design/hypomkii,
		/datum/design/hypovial/large,
		/datum/design/medipen/atropine,
		/datum/design/medipen/epinephrine,
		/datum/design/medipen/oxandrolone,
		/datum/design/medipen/penacid,
		/datum/design/medipen/salacid,
		/datum/design/medipen/salbutamol,
		/datum/design/medipen/universal,
		/datum/design/medipen/universal_lowpressure,
		/datum/design/plumbing_eng,
	)
	return ..()

/datum/techweb_node/mining/New()
	unlocked_designs += list(
		/datum/design/mesons_prescription,
		/datum/design/bsc_nt,
		/datum/design/board/lrm,
	)
	return ..()

/////////////////////////robotics tech/////////////////////////

/datum/techweb_node/robotics/New()
	unlocked_designs += list(
		/datum/design/borg_snack_dispenser,
		/datum/design/mini_soulcatcher,
	)
	return ..()

/datum/techweb_node/passive_implants/New()
	unlocked_designs += list(
		/datum/design/soulcatcher_device,
		/datum/design/rsd_interface,
		/datum/design/surgery/implant_phylactery,
		/datum/design/surgery/implant_phylactery/mechanic,
	)
	return ..()

/datum/techweb_node/borg_utility/New()
	unlocked_designs += list(
		/datum/design/borg_upgrade_clamp,
		/datum/design/borg_wirebrush,
		/datum/design/borg_upgrade_shrink,
		/datum/design/borg_upgrade_cargo_apparatus,
		/datum/design/borgteleporter,
	)
	return ..()

/datum/techweb_node/borg_engi/New()
	unlocked_designs += list(
		/datum/design/advanced_materials,
		/datum/design/borg_upgrade_welding,
		/datum/design/rld,
		/datum/design/borg_upgrade_brped,
	)
	return ..()

/datum/techweb_node/borg_medical/New()
	unlocked_designs += list(
		/datum/design/borg_upgrade_surgicaltools,
		/datum/design/borg_upgrade_autopsyscanner,
		/datum/design/borg_upgrade_chemistrygripper,
	)
	return ..()

///////////////////////// Applied Bluespace /////////////////////////

/datum/techweb_node/applied_bluespace/New()
	unlocked_designs += list(
		/datum/design/plantbag_of_holding,
	)
	return ..()

// modsuit stuff
/datum/techweb_node/mod_security/New()
	unlocked_designs += list(
		/datum/design/mod_plating/security,
		/datum/design/module/mod_tether_grounded,
	)
	return ..()

/datum/techweb_node/mod_equip/New()
	unlocked_designs += list(
		/datum/design/module/retract_plates,
		/datum/design/module/magnetic_deploy,
	)
	return ..()

/////// Roundstart Techweb/////////

/datum/techweb_node
	/// Whether this node starts unlocked if the enable_nova_techweb_starting_nodes config is ENABLED
	var/nova_starting_node = TRUE

// The node_flags application lives in /datum/techweb_node/New(), as a NOVA EDIT in
// code/modules/research/techweb/_techweb_node.dm - upstream now defines that proc itself.

// Nova stuff
/datum/techweb_node/adv_vision
	nova_starting_node = FALSE

/datum/techweb_node/borg_shapeshifter
	nova_starting_node = FALSE

// bepis stuff
/datum/techweb_node/light_apps
	nova_starting_node = FALSE

/datum/techweb_node/extreme_office
	nova_starting_node = FALSE

/datum/techweb_node/spec_eng
	nova_starting_node = FALSE

/datum/techweb_node/aus_security
	nova_starting_node = FALSE

/datum/techweb_node/interrogation
	nova_starting_node = FALSE

/datum/techweb_node/sticky_advanced
	nova_starting_node = FALSE

/datum/techweb_node/tackle_advanced
	nova_starting_node = FALSE

/datum/techweb_node/mod_experimental
	nova_starting_node = FALSE

/datum/techweb_node/posisphere
	nova_starting_node = FALSE

/datum/techweb_node/donk_shell
	nova_starting_node = FALSE

// Alien Stuff
/datum/techweb_node/alien
	nova_starting_node = FALSE

// Ilegal tech
/datum/techweb_node/syndicate_basic
	nova_starting_node = FALSE

/datum/techweb_node/unregulated_bluespace
	nova_starting_node = FALSE

// Tarkon
/datum/techweb_node/tarkon
	nova_starting_node = FALSE

/datum/techweb_node/tarkonturret
	nova_starting_node = FALSE
