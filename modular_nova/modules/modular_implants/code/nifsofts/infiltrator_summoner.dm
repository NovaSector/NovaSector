/obj/item/disk/nifsoft_uploader/mil_grade/infiltrator
	name = "Catalogue Fisher"
	icon_state = "contract_mil_disk"
	loaded_nifsoft = /datum/nifsoft/summoner/combat/infiltrator

/obj/item/disk/nifsoft_uploader/mil_grade/infiltrator/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CYBERSUN)

/datum/nifsoft/summoner/combat/infiltrator
	name = "Catalogue Fisher"
	program_desc = "Catalogue Fisher is a fork of the Grimoire Caeruleam NIFSoft commissioned by numerous Zvirdnyan Colonial Militia officers. \
	Despite it creating nothing more but largely bureaucratical tidbits, the high use cost is generated from running the forensic equipment in the background. <br>\
	Some inspectors could swear that uncertainly beneficial voices of suggestion and warning appear in their minds, after running Vacholieres for prolonged periods \
	of time - technically described as backlogs of data interfering with Soulcatchers."
	summonable_items = list(
		/obj/item/detective_scanner/nanite,
		/obj/item/folder/yellow/nanite,
		/obj/item/binoculars/nanite,
		/obj/item/toy/crayon/white/nanite,
	)
	activation_cost = 200
	name_tag = ""
	ui_icon = FA_ICON_VEST
	able_to_keep = FALSE
