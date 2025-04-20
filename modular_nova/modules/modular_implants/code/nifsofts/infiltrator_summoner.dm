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

/obj/item/screwdriver/omni_drill
	name = "powered driver"
	desc = "The ultimate in multi purpose construction tools. With heads for wire cutting, bolt driving, and driving \
		screws, what's not to love? Well, the slow speed. Compared to other power drills these tend to be \
		<b>not much quicker than unpowered tools</b>."
	icon = 'modular_nova/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "drill"
	inside_belt_icon_state = null
	inhand_icon_state = "drill"
	worn_icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	force = 10
	throwforce = 8
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("drills", "screws", "jabs", "whacks")
	attack_verb_simple = list("drill", "screw", "jab", "whack")
	hitsound = 'sound/items/tools/drill_hit.ogg'
	usesound = 'sound/items/tools/drill_use.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 1
	random_color = FALSE
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	/// Used on Initialize, how much time to cut cable restraints and zipties.
	var/snap_time_weak_handcuffs = 0 SECONDS
	/// Used on Initialize, how much time to cut real handcuffs. Null means it can't.
	var/snap_time_strong_handcuffs = null

/obj/item/screwdriver/omni_drill/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/screwdriver/omni_drill/get_all_tool_behaviours()
	return list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER, TOOL_WRENCH)

/obj/item/screwdriver/omni_drill/examine(mob/user)
	. = ..()
	. += span_notice("Use <b>in hand</b> to switch configuration.\n")
	. += span_notice("It functions as a <b>[tool_behaviour]</b> tool.")

/obj/item/screwdriver/omni_drill/update_icon_state()
	. = ..()
	switch(tool_behaviour)
		if(TOOL_SCREWDRIVER)
			icon_state = initial(icon_state)
		if(TOOL_WRENCH)
			icon_state = "[initial(icon_state)]_bolt"
		if(TOOL_WIRECUTTER)
			icon_state = "[initial(icon_state)]_cut"

/obj/item/screwdriver/omni_drill/attack_self(mob/user, modifiers)
	. = ..()
	if(!user)
		return
	var/list/tool_list = list(
		"Screwdriver" = image(icon = icon, icon_state = "drill"),
		"Wrench" = image(icon = icon, icon_state = "drill_bolt"),
		"Wirecutters" = image(icon = icon, icon_state = "drill_cut"),
	)
	var/tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user) || !tool_result)
		return
	RemoveElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
	switch(tool_result)
		if("Wrench")
			tool_behaviour = TOOL_WRENCH
			sharpness = NONE
		if("Wirecutters")
			tool_behaviour = TOOL_WIRECUTTER
			sharpness = NONE
			AddElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		if("Screwdriver")
			tool_behaviour = TOOL_SCREWDRIVER
			sharpness = SHARP_POINTY
	playsound(src, 'sound/items/tools/change_drill.ogg', 50, vary = TRUE)
	update_appearance(UPDATE_ICON)

/obj/item/screwdriver/omni_drill/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE
