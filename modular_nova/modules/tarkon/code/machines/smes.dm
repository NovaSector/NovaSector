/////////////////// Smes for roundstart Tarkon + Ship ///////////////////

/obj/machinery/power/smes/tarkon_backup
	charge = 50 * STANDARD_CELL_CHARGE
	outputting = FALSE //Functional turn off. Backup energy for when people join and need to get the basic APC's charged.
	output_attempt = FALSE //Turns it off on the button in UI.
	output_level = 100 KILO WATTS
	input_level = 90 KILO WATTS

/obj/machinery/power/smes/tarkon_driver
	charge = 50 * STANDARD_CELL_CHARGE
	inputting = FALSE //Functional turn off. Stops it from becoming the priority draw of the powernet.
	input_attempt = FALSE //Turns it off on the button in UI.
	input_level = 100 KILO WATTS
	output_level = 50 KILO WATTS
