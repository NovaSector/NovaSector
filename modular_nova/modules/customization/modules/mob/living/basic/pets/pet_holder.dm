/obj/item/clothing/head/mob_holder/pet
	var/mob/living/starting_pet
	var/initialized_pet = FALSE
	var/renamed = FALSE
	var/redescribed = FALSE

/obj/item/clothing/head/mob_holder/pet/Initialize(mapload, mob/living/M, worn_state, head_icon, lh_icon, rh_icon, worn_slot_flags = NONE)
	if(initialized_pet == FALSE)
		initialized_pet = TRUE
		held_mob = new starting_pet(src)
		if(renamed)
			held_mob.name = name
		if(redescribed)
			held_mob.desc = desc
		. = ..(get_turf(src), held_mob, held_mob.held_state, held_mob.head_icon, held_mob.held_lh, held_mob.held_rh, held_mob.worn_slot_flags)

/obj/item/clothing/head/mob_holder/pet/on_loadout_custom_named()
	. = ..()
	renamed = TRUE
	if(held_mob != null)
		held_mob.name = name

/obj/item/clothing/head/mob_holder/pet/on_loadout_custom_described()
	. = ..()
	redescribed = TRUE
	if(held_mob != null)
		held_mob.desc = desc
