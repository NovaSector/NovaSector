/datum/orderable_item/mining/survival_bodybag
	purchase_path = /obj/item/bodybag/environmental
	cost_per_order = 500

/datum/orderable_item/mining/suit_voucher
	purchase_path = /obj/item/suit_voucher
	cost_per_order = 2000

/datum/orderable_item/consumables/robo_medkit
	purchase_path = /obj/item/storage/medkit/robotic_repair/stocked
	cost_per_order = 650 // I set this at this slightly-higher-than-normal value because the robot medkits heal brute, burn, and have a coagulent equivalent in them

/obj/item/kinetic_crusher
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Crusher" = list(
			RESKIN_ICON = 'icons/obj/mining.dmi',
			RESKIN_ICON_STATE = "crusher",
			RESKIN_INHAND_L = 'icons/mob/inhands/weapons/hammers_lefthand.dmi',
			RESKIN_INHAND_R = 'icons/mob/inhands/weapons/hammers_righthand.dmi',
			RESKIN_INHAND_STATE = "crusher0",
		),
		"Glaive" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/kinetic_glaive.dmi',
			RESKIN_ICON_STATE = "crusher-glaive",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "crusher-glaive",
			RESKIN_INHAND_L = 'modular_nova/master_files/icons/mob/64x64_lefthand.dmi',
			RESKIN_INHAND_R = 'modular_nova/master_files/icons/mob/64x64_righthand.dmi',
		),
	)

/obj/item/kinetic_crusher/post_reskin(mob/our_mob)
	if(icon_state == "crusher-glaive")
		name = "proto-kinetic glaive"
		desc = "A modified proto-kinetic crusher, it is still little more than various mining tools cobbled together \
			into a high-tech knife on a stick with a handguard and goliath-leather grip. While equally as effective as its unmodified compatriots, \
		it still does little to aid any but the most skilled - or suicidal."
		attack_verb_continuous = list("slices", "slashes", "cleaves", "chops", "stabs")
		attack_verb_simple = list("slice", "slash", "cleave", "chop", "stab")
		inhand_x_dimension = 64
		inhand_y_dimension = 64
		our_mob.update_held_items()

/datum/orderable_item/interdyne
	category_index = CATEGORY_INTERDYNE

/datum/orderable_item/interdyne/adv_plasmacutter
	purchase_path = /obj/item/gun/energy/plasmacutter/adv
	cost_per_order = 500

/datum/orderable_item/interdyne/mining_AoE
	purchase_path = /obj/item/borg/upgrade/modkit/aoe/turfs
	cost_per_order = 750

/datum/orderable_item/interdyne/night_vision_health_meson
	purchase_path = /obj/item/clothing/glasses/hud/health/night/meson
	cost_per_order = 2000

/datum/orderable_item/interdyne/prescription_meson
	purchase_path = /obj/item/clothing/glasses/meson/prescription
	cost_per_order = 325

/datum/orderable_item/mining/crusher/spear
	purchase_path = /obj/item/kinetic_crusher/spear
	cost_per_order = 1250

/datum/orderable_item/mining/crusher/hammer
	purchase_path = /obj/item/kinetic_crusher/hammer
	cost_per_order = 1250

/datum/orderable_item/mining/crusher/machete
	purchase_path = /obj/item/kinetic_crusher/machete
	cost_per_order = 1250

/datum/orderable_item/mining/crusher/claw
	purchase_path = /obj/item/kinetic_crusher/claw
	cost_per_order = 1250

/datum/orderable_item/accelerator/gun/repeater
	purchase_path = /obj/item/gun/energy/recharge/kinetic_accelerator/variant/repeater
	cost_per_order = 1250

/datum/orderable_item/accelerator/gun/shotgun
	purchase_path = /obj/item/gun/energy/recharge/kinetic_accelerator/variant/shotgun
	cost_per_order = 1250

/datum/orderable_item/accelerator/gun/shockwave
	purchase_path = /obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave
	cost_per_order = 1250

/datum/orderable_item/accelerator/gun/glock
	purchase_path = /obj/item/gun/energy/recharge/kinetic_accelerator/variant/glock
	cost_per_order = 1250

/datum/orderable_item/accelerator/gun/railgun
	purchase_path = /obj/item/gun/energy/recharge/kinetic_accelerator/variant/railgun
	cost_per_order = 1250

/datum/orderable_item/accelerator/gun/m79
	purchase_path = /obj/item/gun/energy/recharge/kinetic_accelerator/variant/nomod/m79
	cost_per_order = 1250
