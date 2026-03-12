/obj/machinery/computer
	///Determines if the computer can connect to other computers (no arcades, etc.)
	var/connectable = TRUE

/obj/machinery/computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	if(connectable)
		AddComponent(/datum/component/connectable_computer)

/obj/machinery/modular_computer
	///Determines if the computer can connect to other computers (no time clock, etc.)
	var/connectable = TRUE

/obj/machinery/modular_computer/Initialize(mapload)
	. = ..()

	if(connectable)
		AddComponent(/datum/component/connectable_computer)
