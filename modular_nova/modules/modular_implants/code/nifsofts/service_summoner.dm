/obj/item/disk/nifsoft_uploader/summoner/service
	name = "Grimoire Hestia"
	loaded_nifsoft = /datum/nifsoft/summoner/service

/datum/nifsoft/summoner/service
	name = "Grimoire Hestia"
	program_desc = "Grimoire Hestia is a fork of the Grimoire Caeruleam NIFSoft commissioned by numerous Zvirdnyan Colonial Militia officers. \
	Its entirely functional aspect and high requirement for fidelity makes it more expensive than many other Grimoires."
	summonable_items = list(
		/obj/item/storage/bag/tray/nanite,
		/obj/item/reagent_containers/cup/glass/shaker/nanite,
		/obj/item/reagent_containers/cup/rag/nanite,
		/obj/item/knife/kitchen/nanite,
		/obj/item/kitchen/rollingpin/nanite,
		/obj/item/cultivator/nanite,
		/obj/item/geneshears/nanite,
		/obj/item/secateurs/nanite,
		/obj/item/shovel/spade/nanite,
		/obj/item/hatchet/nanite,
		/obj/item/mop/nanite,
	)
	max_summoned_items = 3
	activation_cost = 100
	purchase_price = 350
	name_tag = "hestial "
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = FA_ICON_KITCHEN_SET
	able_to_keep = FALSE

/obj/item/storage/bag/tray/nanite
	force = 0
	throwforce = 0

/obj/item/reagent_containers/cup/glass/shaker/nanite

/obj/item/reagent_containers/cup/rag/nanite

/obj/item/knife/kitchen/nanite
	force = 0
	throwforce = 0
	wound_bonus = 0
	bare_wound_bonus = 0

/obj/item/kitchen/rollingpin/nanite
	force = 0
	throwforce = 0
	resistance_flags = null

/obj/item/cultivator/nanite
	force = 0
	throwforce = 0

/obj/item/geneshears/nanite
	force = 0
	throwforce = 0

/obj/item/secateurs/nanite
	force = 0
	throwforce = 0

/obj/item/shovel/spade/nanite
	force = 0
	throwforce = 0

/obj/item/hatchet/nanite
	force = 0
	throwforce = 0

/obj/item/mop/nanite
	force = 0
	throwforce = 0
