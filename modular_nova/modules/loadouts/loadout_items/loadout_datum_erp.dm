/datum/loadout_category/erp
	category_name = "Erotic"
	category_ui_icon = FA_ICON_HEART
	erp_category = TRUE
	//	type_to_generate = /datum/loadout_item/erp
	tab_order = /datum/loadout_category/pocket::tab_order + 1
	VAR_PRIVATE/max_allowed = 7


/datum/loadout_category/erp/New()
	. = ..()
	category_info = "([max_allowed] allowed)"
