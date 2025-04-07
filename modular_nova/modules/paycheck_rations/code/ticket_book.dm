/obj/item/storage/ration_ticket_book
	name = "ration ticket book"
	desc = "A small booklet able to hold all your ration tickets. More will be available here as your paychecks come in."
	icon = 'modular_nova/modules/paycheck_rations/icons/tickets.dmi'
	icon_state = "ticket_book"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/ration_ticket_book/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 4
	atom_storage.set_holdable(/obj/item/paper/paperslip/ration_ticket)
