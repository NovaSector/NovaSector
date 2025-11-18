/obj/item/clothing/head/bio_hood/Initialize(mapload)
	. = ..()
	qdel(GetComponent(/datum/component/clothing_fov_visor))
