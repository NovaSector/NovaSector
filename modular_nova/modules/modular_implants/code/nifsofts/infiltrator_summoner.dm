/obj/item/disk/nifsoft_uploader/mil_grade/infiltrator
	name = "Catalogue Fisher"
	icon_state = "contract_mil_disk"
	loaded_nifsoft = /datum/nifsoft/summoner/combat/infiltrator

/obj/item/disk/nifsoft_uploader/mil_grade/infiltrator/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CYBERSUN)

/datum/nifsoft/summoner/combat/infiltrator
	name = "Catalogue Fisher"
	program_desc = "Catalogue Fisher is a limited access library of infiltration programs initially engineered by Cybersun Bitrunners to aid in data collection. \
	Despite it creating nothing more but largely bureaucratical tidbits, the high use cost is generated from running the forensic equipment in the background. <br>\
	Some inspectors could swear that uncertainly beneficial voices of suggestion and warning appear in their minds, after running Vacholieres for prolonged periods \
	of time - technically described as backlogs of data interfering with Soulcatchers."
	summonable_items = list(
		/obj/item/knife/combat/survival/nanite,
		/obj/item/melee/baton/security/stun_gun/nanite,
		/obj/item/binoculars/nanite,
		/obj/item/toy/crayon/white/nanite,
	)
	activation_cost = 200
	name_tag = ""
	ui_icon = FA_ICON_VEST
	able_to_keep = FALSE

/obj/item/knife/combat/survival/nanite

/obj/item/melee/baton/security/stun_gun/nanite
	preload_cell_type = /obj/item/stock_parts/power_store/cell/self_charge
	can_remove_cell = FALSE
