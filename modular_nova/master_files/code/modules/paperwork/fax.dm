//DS-2 override for Syndicate centcom fax
/obj/machinery/fax/Initialize(mapload)
	special_networks["syndicate"]["fax_name"] = "Syndicate Sectorial Command"
	return ..()
