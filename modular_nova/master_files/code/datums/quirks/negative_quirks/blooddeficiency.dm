// Override of Blood Deficiency quirk for robotic/synthetic species.
/datum/quirk/blooddeficiency/add(client/client_source)
	if(issynthetic(quirk_holder))
		name = "Hydraulic Leak"
		desc = "Your body's hydraulic fluids are leaking through their seals."
		medical_record_text = "Patient requires regular treatment for hydraulic fluid loss."
		mail_goodies = list(/obj/item/reagent_containers/blood/oil)
	return ..()
