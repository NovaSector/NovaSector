/obj/item/implant/radio/headset/dullahan
	name = "internal headset implant"
	radio_type = /obj/item/radio/headset/dullahan

// Sets things up for the second radio key. This is gross but until someone refactors radio code to be less stupid this will have to do.
/obj/item/implant/radio/headset/Initialize(mapload, radio_key, radio_key_2)
	if(radio_key)
		radio_key = radio_key

	. = ..()

	var/obj/item/radio/headset/headset = radio // cast as headset so we can access keyslot2 var

	radio.name = "internal headset"
	icon = 'icons/obj/clothing/headsets.dmi'
	icon_state = "headset"

	if(radio_key_2)
		headset.keyslot2 = new radio_key_2
	radio.recalculateChannels()

/obj/item/radio/headset/dullahan

/datum/outfit/dullahan // empty outfit, we are basically just making use of post_equip() in order to set them up with a headset

/datum/outfit/dullahan/post_equip(mob/living/carbon/human/user, visuals_only = FALSE)
	. = ..()
	if(visuals_only || isnull(user.mind))
		return

	var/obj/item/implant/radio/radio_head

	var/datum/job/dullahan_job = user.mind.assigned_role
	var/datum/outfit/work_outfit = dullahan_job.outfit
	var/obj/item/radio/headset/work_headset = work_outfit::ears

	if(isnull(work_headset)) // No headset in their work outfit, we probably shouldn't give them one
		return

	// Set up the right encryption keys from their job
	radio_head = new/obj/item/implant/radio/headset/dullahan(user, work_headset::keyslot, work_headset::keyslot2)

	// Implant it and then move it to the head loc
	radio_head.implant(user)
	var/obj/item/radio/headset/radio_item = radio_head.radio
	user.ears = radio_item
	radio_item.grant_headset_languages(user)
	radio_item.set_broadcasting(TRUE)
	var/datum/species/dullahan/dullahan_species = user.dna.species
	var/obj/item/dullahan_relay = dullahan_species.my_head
	radio_head.forceMove(dullahan_relay.loc)
