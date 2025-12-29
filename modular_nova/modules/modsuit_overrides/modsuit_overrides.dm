/obj/item/mod/control/pre_equipped/security/Initialize(mapload, new_theme, new_skin, new_core)
	applied_modules -= /obj/item/mod/module/pepper_shoulders
	. = ..()

/obj/item/mod/control/pre_equipped/safeguard/Initialize(mapload, new_theme, new_skin, new_core)
	applied_modules -= /obj/item/mod/module/pepper_shoulders
	. = ..()
