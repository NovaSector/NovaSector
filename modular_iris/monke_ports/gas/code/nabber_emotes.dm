/datum/species/nabber/get_scream_sound(mob/living/carbon/human/nabber)
	return 'modular_iris/monke_ports/gas/sounds/nabberscream.ogg'

/datum/species/nabber/get_laugh_sound(mob/living/carbon/human/nabber)
	return 'modular_iris/monke_ports/gas/sounds/nabberlaugh.ogg'

//something is overriding these? checked upstream races

/datum/species/nabber/get_cough_sound(mob/living/carbon/human/nabber)
	if(nabber.physique == FEMALE)
		return 'modular_iris/monke_ports/gas/sounds/nabbercough.ogg'

	return 'modular_iris/monke_ports/gas/sounds/nabbercough.ogg'

/datum/species/nabber/get_sneeze_sound(mob/living/carbon/human/nabber)
	if(nabber.physique == FEMALE)
		return 'modular_iris/monke_ports/gas/sounds/nabbersneeze.ogg'

	return 'modular_iris/monke_ports/gas/sounds/nabbersneeze.ogg'
