/obj/item/circuitboard/computer/med_data/laptop
	name = "Medical Records Laptop"
	build_path = /obj/machinery/computer/records/medical/laptop

/obj/item/circuitboard/computer/med_data/screwdriver_act(mob/living/user, obj/item/tool)
	if(build_path == /obj/machinery/computer/libraryconsole/laptop)
		name = "Medical Records Console"
		build_path = /obj/machinery/computer/records/medical
		to_chat(user, span_notice("Reverting to full-size model."))
	else
		name = "Medical Records Laptop"
		build_path = /obj/machinery/computer/records/medical/laptop
		to_chat(user, span_notice("Lightweight model selected."))
	return TRUE
