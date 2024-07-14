/obj/item/clothing/head/bio_hood/Initialize(mapload)
	. = ..()
	qdel(GetComponent(/datum/component/clothing_fov_visor))

/obj/item/clothing/mask/gas/
	has_fov = FALSE
