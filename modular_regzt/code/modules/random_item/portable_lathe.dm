/*
/obj/machinery/autolathe/portable
	name = "autolathe"
	desc = "It produces items using iron, glass, plastic and maybe some more."
	icon = 'icons/obj/machines/lathes.dmi'
	icon_state = "autolathe"
	density = TRUE
	anchored = TRUE
	circuit = null
	active_power_usage = null
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/autolathe_portable
	creation_efficiency = 3

/obj/machinery/autolathe/portable/Initialize(mapload)
	. = ..()
	// ИСПРАВЛЕНИЕ: правильная установка лимита материалов
	if(materials)
		materials.max_amount = 10 * SHEET_MATERIAL_AMOUNT  // 10 листов, не 0.01
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)

/obj/machinery/autolathe/portable/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/autolathe/portable/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/autolathe/portable/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

// ИСПРАВЛЕНИЕ: убираем синтаксическую ошибку с var/materials.max_amount
// (эта строка была удалена, вместо неё установка в Initialize)



//флет йоу
/obj/item/autolathe_portable
	name = "flat-packed rapid construction fabricator"
	desc = /obj/machinery/autolathe/portable::desc
	icon = 'modular_nova/modules/colony_fabricator/icons/packed_machines.dmi'
	icon_state = "colony_lathe_packed"
	w_class = WEIGHT_CLASS_NORMAL
	var/obj/type_to_deploy = /obj/machinery/autolathe/portable
	var/deploy_time = 5 SECONDS

/obj/item/autolathe_portable/Initialize(mapload)
	. = ..()
	give_deployable_component()

/obj/item/autolathe_portable/proc/give_deployable_component()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy)

/obj/item/autolathe_portable/ui_interact(mob/user, datum/tgui/ui)
	return
*/
