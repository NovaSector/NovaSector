/obj/item/riding_saddle
	name = "generic riding sattle"
	desc = "someone spawned a basetype!"
	slot_flags = ITEM_SLOT_BACK // no storage

	icon = 'modular_nova/modules/customization/modules/taur_rework/sprites/saddles.dmi'
	worn_icon = 'modular_nova/modules/customization/modules/taur_rework/sprites/saddles.dmi'
	worn_icon_taur_snake = 'modular_nova/modules/customization/modules/taur_rework/sprites/saddles.dmi'

/obj/item/riding_saddle/mob_can_equip(mob/living/M, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if (!iscarbon(M))
		return FALSE
	var/mob/living/carbon/target_carbon = M

	var/obj/item/organ/external/taur_body/taur_body = locate(/obj/item/organ/external/taur_body) in target_carbon.organs // hardcoded for now, we can do a better job later
	if (!taur_body?.can_use_saddle)
		return FALSE
	
	return ..()

/obj/item/riding_saddle/leather
	name = "riding saddle"
	desc = "A thick leather riding sattle. Typically used for animals, this one has been designed for use by the taurs of the galaxy. \n\
	This saddle has specialized footrests that will allow a rider to use both their hands while riding."

	icon_state = "saddle_leather"

/obj/item/riding_saddle/leather/Initialize(mapload)
	. = ..()
	
	AddComponent(/datum/component/carbon_saddle, RIDING_TAUR) // FREE HANDS

/obj/item/riding_saddle/leather/peacekeeper
	name = "peacekeeper saddle"

	icon_state = "saddle_peacekeeper"

/obj/item/riding_saddle/leather/peacekeeper/Initialize(mapload)
	. = ..()
	
	desc += " This one is painted in peacekeeper livery."
