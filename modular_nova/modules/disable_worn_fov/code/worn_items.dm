/obj/item/clothing/head/costume/tv_head
	has_fov = FALSE

/obj/item/clothing/head/bio_hood/Initialize(mapload)
	. = ..()
	qdel(GetComponent(/datum/component/clothing_fov_visor))

/obj/item/clothing/mask/gas/
	has_fov = FALSE
