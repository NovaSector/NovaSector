/////////////////// Xenobio Cam + control ///////////////////

/obj/machinery/computer/camera_advanced/xenobio/tarkon
	name = "Tarkon Slime management console"
	desc = "A computer used for remotely handling slimes. Safety First."
	networks = list("tarkon_xenob")
	circuit = /obj/item/circuitboard/computer/xenobiology/tarkon

/obj/item/circuitboard/computer/xenobiology/tarkon
	name = "Tarkon Xenobiology Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/camera_advanced/xenobio/tarkon

/obj/machinery/camera/tarkon_xenob
	network = list("tarkon_xenob", "tarkon")
	dir = 4

/////////////////// Security Cam + control ///////////////////

/obj/machinery/computer/camera_advanced/tarkon_cam
	name = "Tarkon Camera Control Console"
	networks = list("tarkon")
	circuit = /obj/item/circuitboard/computer/tarkon_cam

/obj/item/circuitboard/computer/tarkon_cam
	name = "Tarkon Camera Control Console"
	build_path = /obj/machinery/computer/camera_advanced/tarkon_cam

/obj/machinery/camera/tarkon
	network = list("tarkon")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/camera/tarkon, 0)
