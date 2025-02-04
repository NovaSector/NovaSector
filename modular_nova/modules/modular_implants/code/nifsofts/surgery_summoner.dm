/obj/item/disk/nifsoft_uploader/summoner/surgery
	name = "Grimoire Asclepius"
	loaded_nifsoft = /datum/nifsoft/summoner/surgery

/datum/nifsoft/summoner/surgery
	name = "Grimoire Asclepius"
	program_desc = "Grimoire Asclepius is a fork of the Grimoire Caeruleam NIFSoft blahblahblahblah. \
	blahblahblahblah."
	summonable_items = list(
		/obj/item/scalpel/nanite,
		/obj/item/retractor/nanite,
		/obj/item/hemostat/nanite,
		/obj/item/circular_saw/nanite,
		/obj/item/surgicaldrill/nanite,
		/obj/item/cautery/nanite,
		/obj/item/surgical_drapes/nanite,
		/obj/item/healthanalyzer/nanite,
		/obj/item/autopsy_scanner/nanite,
	)
	max_summoned_items = 2
	activation_cost = 100
	purchase_price = 350
	name_tag = "asclepic "
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = FA_ICON_CROSS
	able_to_keep = FALSE

/obj/item/scalpel/nanite

/obj/item/retractor/nanite

/obj/item/hemostat/nanite

/obj/item/circular_saw/nanite

/obj/item/surgicaldrill/nanite

/obj/item/cautery/nanite

/obj/item/surgical_drapes/nanite

/obj/item/healthanalyzer/nanite

/obj/item/autopsy_scanner/nanite
