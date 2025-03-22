/obj/item/storage/belt/thigh_satchel
	name = "thigh satchel"
	desc = "A little satchel that goes on your thigh! Aesthetically holds a few adult toys."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	lefthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	greyscale_colors = "#383840#383840#d1d3e0"
	greyscale_config = /datum/greyscale_config/thighsatchel
	greyscale_config_worn = /datum/greyscale_config/thighsatchel/worn
	icon_state = "thighsatchel"
	inhand_icon_state = "erpbelt"
	worn_icon_state = "thighsatchel"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/storage/belt/thigh_satchel/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 21
	atom_storage.set_holdable(list(
						//toys
						/obj/item/clothing/sextoy/eggvib/signalvib,
						/obj/item/clothing/sextoy/buttplug,
						/obj/item/clothing/sextoy/nipple_clamps,
						/obj/item/clothing/sextoy/eggvib,
						/obj/item/clothing/sextoy/dildo/double_dildo,
						/obj/item/clothing/sextoy/vibroring,
						/obj/item/clothing/sextoy/condom,
						/obj/item/condom_pack,
						/obj/item/clothing/sextoy/dildo,
						/obj/item/clothing/sextoy/dildo/custom_dildo,
						/obj/item/tickle_feather,
						/obj/item/clothing/sextoy/fleshlight,
						/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/clothing/sextoy/magic_wand,
						/obj/item/bdsm_candle,
						/obj/item/spanking_pad,
						/obj/item/clothing/sextoy/vibrator,
						/obj/item/restraints/handcuffs/lewd,
						/obj/item/reagent_containers/cup/lewd_filter,
						/obj/item/assembly/signaler, //because it's used for several toys

						//clothing
						/obj/item/clothing/mask/ballgag,
						/obj/item/clothing/mask/ballgag/choking,
						/obj/item/clothing/head/domina_cap,
						/obj/item/clothing/head/costume/nova/maid,
						/obj/item/clothing/glasses/blindfold/dorms,
						/obj/item/clothing/ears/dorms_headphones,
						/obj/item/clothing/suit/straight_jacket/latex_straight_jacket,
						/obj/item/clothing/mask/gas/bdsm_mask,
						/obj/item/clothing/head/deprivation_helmet,
						/obj/item/clothing/glasses/hypno,

						//neck
						/obj/item/clothing/neck/collar,
						/obj/item/clothing/neck/mind_collar,
						/obj/item/electropack/shockcollar,

						//torso clothing
						/obj/item/clothing/suit/corset,
						/obj/item/clothing/under/misc/latex_catsuit,
						/obj/item/clothing/under/rank/civilian/janitor/maid,
						/obj/item/clothing/under/costume/lewdmaid,
						/obj/item/clothing/suit/straight_jacket/shackles,
						/obj/item/clothing/under/tearaway_garments,
						/obj/item/clothing/under/misc/nova/gear_harness,

						//hands
						/obj/item/clothing/gloves/ball_mittens,
						/obj/item/clothing/gloves/long_gloves,
						/obj/item/clothing/gloves/evening,

						//legs
						/obj/item/clothing/shoes/latex_socks,
						/obj/item/clothing/shoes/ballet_heels,
						/obj/item/clothing/shoes/ballet_heels/domina_heels,

						//belt
						/obj/item/clothing/strapon,

						//chems
						/obj/item/reagent_containers/applicator/pill/crocin,
						/obj/item/reagent_containers/applicator/pill/camphor,
						/obj/item/reagent_containers/cup/bottle/succubus_milk,
						/obj/item/reagent_containers/cup/bottle/incubus_draft,
						/obj/item/reagent_containers/applicator/pill/hexacrocin,
						/obj/item/reagent_containers/applicator/pill/pentacamphor,
						/obj/item/reagent_containers/cup/bottle/hexacrocin,
						/obj/item/reagent_containers/cup/bottle/pentacamphor))
