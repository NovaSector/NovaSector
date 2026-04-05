//literally using this for one ability :skull:

//defines
#define NABBER_OVERLAY_LAYER 21.1 //float layer lmao

/datum/species //need this for colored blades (i think?)
	var/held_accessory //neccessary for nabbers having cool shit
	var/held_accessory_path // should not exist unless you're using things like custom arm overlays

/mob/living/carbon/human/proc/modify_accessory_overlay(var/accessory) //Repurposing this to be for all accessories/mods that need a spare layer.
	var/mob/living/carbon/human/human_wearer = src
	var/wanted_accessory = accessory
	var/image/held_overlay
	remove_overlay(NABBER_OVERLAY_LAYER) //begone
	// handle custom overlay via grabbing the icon
	if(human_wearer.dna.species.held_accessory_path)
		var/icon/custom_accessory_icon_path = human_wearer.dna.species.held_accessory_path
		held_overlay = image(icon=custom_accessory_icon_path,icon_state=wanted_accessory) //Grab the image in question
		overlays_standing[NABBER_OVERLAY_LAYER] = held_overlay
	apply_overlay(NABBER_OVERLAY_LAYER)
