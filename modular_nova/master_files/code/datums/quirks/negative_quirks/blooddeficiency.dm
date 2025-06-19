// Override of Blood Deficiency quirk for jelly species.
/datum/quirk/blooddeficiency/add(client/client_source)
	if(isjellyperson(quirk_holder))
		name = "Jelly Desiccation"
		desc = "Your body can't produce enough jelly to sustain itself."
		medical_record_text = "Patient requires regular treatment for slime jelly loss."
		mail_goodies = list(/obj/item/reagent_containers/blood/toxin)
	return ..()
