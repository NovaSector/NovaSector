/obj/machinery/chem_dispenser
	/// Used for custom transfer amounts
	var/list/transferAmounts = list()
	/// The custom transfer amount
	var/customTransferAmount

// Remove all custom chemical reagents from children subtypes (just manganese at the time of commiting)

/obj/machinery/chem_dispenser/drinks/Initialize(mapload)
	. = ..()
	dispensable_reagents -= default_dispensable_reagents_nova

/obj/machinery/chem_dispenser/mutagen/Initialize(mapload)
	. = ..()
	dispensable_reagents -= default_dispensable_reagents_nova

/obj/machinery/chem_dispenser/mutagensaltpeter/Initialize(mapload)
	. = ..()
	dispensable_reagents -= default_dispensable_reagents_nova
