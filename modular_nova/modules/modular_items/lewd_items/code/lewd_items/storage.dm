/obj/item/storage/box/erp
	name = "box of love"
	desc = "A discrete box full of mysteries."
	icon_state = "hugbox"
	illustration = "heart"
	foldable_result = /obj/item/stack/sheet/cardboard
	storage_type = /datum/storage/box/erp

/datum/storage/box/erp
	max_specific_storage = WEIGHT_CLASS_NORMAL

/datum/storage/box/erp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/clothing/sextoy,
		/obj/item/assembly/signaler,
		/obj/item/clothing/strapon,
		/obj/item/kinky_shocker,
		/obj/item/clothing/mask/leatherwhip,
		/obj/item/bdsm_candle,
		/obj/item/spanking_pad,
		/obj/item/tickle_feather,
		/obj/item/borg/upgrade/dominatrixmodule,
		/obj/item/holosign_creator/privacy,
		/obj/item/restraints/handcuffs/lewd,
		/obj/item/stack/shibari_rope,
		/obj/item/clothing/mask/muzzle/ballgag,
		/obj/item/clothing/mask/muzzle/ring,
		/obj/item/clothing/head/deprivation_helmet,
		/obj/item/clothing/glasses/blindfold/dorms,
		/obj/item/clothing/ears/dorms_headphones,
		/obj/item/reagent_containers/cup/lewd_filter,
		/obj/item/clothing/glasses/hypno,
		/obj/item/clothing/erp_leash,
		/obj/item/clothing/gloves/ball_mittens,
		/obj/item/electropack/shockcollar,
		/obj/item/clothing/neck/mind_collar,
		/obj/item/clothing/neck/size_collar,
		/obj/item/key/collar,
		/obj/item/clothing/suit/straight_jacket/latex_straight_jacket,
		/obj/item/clothing/suit/straight_jacket/shackles,
		/obj/item/clothing/suit/straight_jacket/kinky_sleepbag,
		/obj/item/disk/nifsoft_uploader/dorms/contract,
		/obj/item/condom_pack,
		/obj/item/serviette_pack,
		/obj/item/fancy_pillow,
		/obj/item/reagent_containers/cup/bottle/crocin,
		/obj/item/reagent_containers/cup/bottle/camphor,
		/obj/item/reagent_containers/cup/bottle/hexacrocin,
		/obj/item/reagent_containers/cup/bottle/pentacamphor,
		/obj/item/reagent_containers/applicator/pill/crocin,
		/obj/item/reagent_containers/applicator/pill/camphor,
		/obj/item/reagent_containers/applicator/pill/hexacrocin,
		/obj/item/reagent_containers/applicator/pill/pentacamphor,
		/obj/item/reagent_containers/cup/bottle/succubus_milk,
		/obj/item/reagent_containers/cup/bottle/incubus_draft,
		/obj/item/disk/neuroware/crocin,
		/obj/item/disk/neuroware/hexacrocin,
		/obj/item/disk/neuroware/camphor,
		/obj/item/disk/neuroware/pentacamphor,
	))
