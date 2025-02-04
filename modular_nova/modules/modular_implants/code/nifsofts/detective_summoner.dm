/obj/item/disk/nifsoft_uploader/summoner/detective
	name = "Grimoire Vacholiere"
	loaded_nifsoft = /datum/nifsoft/summoner/detective

/datum/nifsoft/summoner/detective
	name = "Grimoire Vacholiere"
	program_desc = "Grimoire Vacholiere is a fork of the Grimoire Caeruleam NIFSoft commissioned by numerous Zvirdnyan Colonial Militia officers. \
	Its entirely functional aspect and high requirement for fidelity makes it more expensive than many other Grimoires."
	summonable_items = list(
		/obj/item/detective_scanner/nanite,
		/obj/item/folder/yellow/nanite,
		/obj/item/binoculars/nanite,
		/obj/item/toy/crayon/white/nanite,
	)
	max_summoned_items = 2
	activation_cost = 100
	purchase_price = 350
	name_tag = "vacholiere-"
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = FA_ICON_MAGNIFYING_GLASS
	able_to_keep = FALSE

/obj/item/detective_scanner/nanite
	name = "regular forensic tool"
	desc = "blahblahblahblah"
	range = 4

/obj/item/folder/yellow/nanite
	name = "folder of oblivion"
	desc = "blahblahblahblah"

/obj/item/binoculars/nanite
	name = "searchlight divisioner"
	desc = "blahblahblahblah"

/obj/item/toy/crayon/white/nanite
	name = "actual asphalt grafitter"
	desc = "blahblahblahblah"
	charges = -1
	edible = FALSE
