/datum/augment_item/organ
	category = AUGMENT_CATEGORY_ORGANS

/datum/augment_item/organ/apply(mob/living/carbon/human/human_holder, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return

	var/obj/item/organ/organ_path = path // cast this to an organ so we can get the slot from it using initial()
	var/obj/item/organ/new_organ = new path()
	new_organ.copy_traits_from(human_holder.get_organ_slot(initial(organ_path.slot)))
	new_organ.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

//HEARTS
/datum/augment_item/organ/heart
	slot = AUGMENT_SLOT_HEART
	allowed_biotypes = MOB_ORGANIC | MOB_ROBOTIC

/datum/augment_item/organ/heart/normal
	name = "Organic heart"
	path = /obj/item/organ/heart

/datum/augment_item/organ/heart/cybernetic
	name = "Cybernetic heart"
	path = /obj/item/organ/heart/cybernetic

/datum/augment_item/organ/heart/synth
	name = "Hydraulic pump engine"
	path =/obj/item/organ/heart/synth

//LUNGS
/datum/augment_item/organ/lungs
	slot = AUGMENT_SLOT_LUNGS
	allowed_biotypes = MOB_ORGANIC | MOB_ROBOTIC

/datum/augment_item/organ/lungs/normal
	name = "Organic lungs"
	path = /obj/item/organ/lungs

/datum/augment_item/organ/lungs/hot
	name = "Lungs Adapted to Heat"
	path = /obj/item/organ/lungs/hot
	cost = 1

/datum/augment_item/organ/lungs/cold
	name = "Cold-Adapted Lungs"
	path = /obj/item/organ/lungs/cold
	cost = 1
/datum/augment_item/organ/lungs/toxin
	name = "Lungs Adapted to Toxins"
	path = /obj/item/organ/lungs/toxin
	cost = 1
/datum/augment_item/organ/lungs/oxy
	name = "Low-Pressure Adapted Lungs"
	path = /obj/item/organ/lungs/oxy
	cost = 1
/datum/augment_item/organ/lungs/cybernetic
	name = "Cybernetic lungs"
	path = /obj/item/organ/lungs/cybernetic

//LIVERS
/datum/augment_item/organ/liver
	slot = AUGMENT_SLOT_LIVER
	allowed_biotypes = MOB_ORGANIC | MOB_ROBOTIC

/datum/augment_item/organ/liver/normal
	name = "Organic Liver"
	path = /obj/item/organ/liver

/datum/augment_item/organ/liver/cybernetic
	name = "Cybernetic liver"
	path = /obj/item/organ/liver/cybernetic

/datum/augment_item/organ/liver/synth
	name = "Reagent processing unit"
	path = /obj/item/organ/liver/synth

//STOMACHES
/datum/augment_item/organ/stomach
	slot = AUGMENT_SLOT_STOMACH
	allowed_biotypes = MOB_ORGANIC | MOB_ROBOTIC

/datum/augment_item/organ/stomach/normal
	name = "Organic stomach"
	path = /obj/item/organ/stomach

/datum/augment_item/organ/stomach/cybernetic
	name = "Cybernetic stomach"
	path = /obj/item/organ/stomach/cybernetic

/datum/augment_item/organ/stomach/lithovore
	name = "Lithovore Stomach"
	path = /obj/item/organ/stomach/lithovore

/datum/augment_item/organ/stomach/lithovore/apply(mob/living/carbon/human/H, character_setup = FALSE, datum/preferences/prefs)
	if(prefs && ("Oversized" in prefs.all_quirks))
		path = /obj/item/organ/stomach/lithovore/oversized
	return ..()

//EYES
/datum/augment_item/organ/eyes
	slot = AUGMENT_SLOT_EYES
	allowed_biotypes = MOB_ORGANIC | MOB_ROBOTIC

/datum/augment_item/organ/eyes/normal
	name = "Organic eyes"
	path = /obj/item/organ/eyes

/datum/augment_item/organ/eyes/cybernetic
	name = "Cybernetic eyes"
	path = /obj/item/organ/eyes/robotic

/datum/augment_item/organ/eyes/cybernetic/moth
	name = "Cybernetic moth eyes"
	path = /obj/item/organ/eyes/robotic/moth

/datum/augment_item/organ/eyes/highlumi
	name = "High-luminosity eyes"
	path = /obj/item/organ/eyes/robotic/glow
	cost = 1

/datum/augment_item/organ/eyes/highlumi/moth
	name = "High Luminosity Moth Eyes"
	path = /obj/item/organ/eyes/robotic/glow/moth
	cost = 1

/datum/augment_item/organ/eyes/binoculars
	name = "Digital Magnification Optics (x3)"
	cost = 4
	path = /obj/item/organ/eyes/robotic/binoculars

//TONGUES
/datum/augment_item/organ/tongue
	slot = AUGMENT_SLOT_TONGUE
	allowed_biotypes = MOB_ORGANIC | MOB_ROBOTIC

/datum/augment_item/organ/tongue/normal
	name = "Organic tongue"
	path = /obj/item/organ/tongue/human

/datum/augment_item/organ/tongue/robo
	name = "Robotic voicebox"
	path = /obj/item/organ/tongue/robot

/datum/augment_item/organ/tongue/robo/forked
	name = "Robotic lizard voicebox"
	path = /obj/item/organ/tongue/lizard/robot

/datum/augment_item/organ/tongue/cybernetic
	name = "Cybernetic tongue"
	path = /obj/item/organ/tongue/cybernetic

/datum/augment_item/organ/tongue/cybernetic/forked
	name = "Forked cybernetic tongue"
	path = /obj/item/organ/tongue/lizard/cybernetic

/datum/augment_item/organ/tongue/forked
	name = "Forked tongue"
	path = /obj/item/organ/tongue/lizard

/datum/augment_item/organ/tongue/forked/filterless
	name = "Forked tongue (Without TTS Filter)"
	path = /obj/item/organ/tongue/lizard/filterless

//EARS
/datum/augment_item/organ/ears
	slot = AUGMENT_SLOT_EARS
	allowed_biotypes = MOB_ORGANIC | MOB_ROBOTIC

/datum/augment_item/organ/ears/normal
	name = "Organic ears"
	path = /obj/item/organ/ears

/datum/augment_item/organ/ears/cybernetic
	name = "Cybernetic ears"
	path = /obj/item/organ/ears/cybernetic
