/obj/machinery/trash_compactor
	name = "trash compactor"
	desc = "A machine that crushes and processes recyclable materials."
	icon = 'modular_nova/modules/trash_compactor/icons/trash_compactor.dmi'
	icon_state = "recycler"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 500
	circuit = /obj/item/circuitboard/machine/trash_compactor

	// Processing variables
	var/processing = FALSE
	var/processing_time = 30 // deciseconds
	var/processing_efficiency = 0.8 // 80% return rate

	// Storage
	var/datum/component/storage/consuming/hold
	var/max_items = 20

/obj/machinery/trash_compactor/Initialize(mapload)
	. = ..()
	hold = AddComponent(/datum/component/storage)
	hold.max_items = max_items

/obj/machinery/trash_compactor/attackby(obj/item/O, mob/user, params)
	if(hold.can_be_inserted(O, stop_messages = FALSE))
		hold.handle_item_insertion(O, user = user)
		return TRUE
	return ..()

/obj/machinery/trash_compactor/process()
	if(!processing && hold.contents.len > 0)
		start_processing()

/obj/machinery/trash_compactor/proc/start_processing()
	if(processing)
		return
	processing = TRUE
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(finish_processing)), processing_time)

/obj/machinery/trash_compactor/proc/finish_processing()
	if(!processing)
		return
	processing = FALSE
	update_appearance()

	// Process each item
	for(var/obj/item/I in hold.contents)
		process_item(I)

/obj/machinery/trash_compactor/proc/process_item(obj/item/I)
	// Convert items to materials
	var/material_amount = I.get_material_amount() * processing_efficiency
	if(material_amount > 0)
		var/material_type = I.get_material_type()
		if(material_type)
			new material_type(get_turf(src), material_amount)
	qdel(I)

/obj/machinery/trash_compactor/update_icon_state()
	if(processing)
		icon_state = "recycler-o"
	else
		icon_state = "recycler"
	return ..()

/obj/item/circuitboard/machine/trash_compactor
	name = "Trash Compactor (Machine Board)"
	build_path = /obj/machinery/trash_compactor
	req_components = list()
