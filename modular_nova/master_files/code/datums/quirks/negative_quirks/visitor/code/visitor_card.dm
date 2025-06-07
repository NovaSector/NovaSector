//the card
/obj/item/card/id/advanced/visitor
	name = "visitor's ID"
	icon_state = "visitor"
	icon = 'modular_nova/master_files/code/datums/quirks/negative_quirks/visitor/icons/card.dmi'
	assigned_icon_state = null
	desc = "An ID card to be issued to visitors of the station. Its appearance leaves much to be desired, making it glaringly obvious you weren't worth the bureaucratic effort."
	trim = /datum/id_trim/job/assistant/visitor

/datum/id_trim/job/assistant/visitor
	trim_state = "trim_visitor"
	trim_icon = 'modular_nova/master_files/code/datums/quirks/negative_quirks/visitor/icons/card.dmi'
	sechud_icon_state = SECHUD_UNKNOWN

//design
/datum/design/id/visitor
	name = "Visitation ID Card"
	desc = "A card used to provide ID, particularly for guests aboard the station."
	id = "idcard_guest"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/card/id/advanced/visitor

//overwrites - will be removed pending upstream pdapainter proc refactor
/obj/machinery/pdapainter/attackby(obj/item/O, mob/living/user, list/modifiers)
	if(istype(O, /obj/item/card/id/advanced/visitor))
		to_chat(user, span_warning("The machine rejects your [O]. This ID card does not appear to be compatible with the PDA Painter."))
		return
	else
		. = ..()
