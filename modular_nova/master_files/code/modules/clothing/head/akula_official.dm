/obj/item/clothing/head/hats/caphat/azulean
	icon_state = "oldbloodcap"
	icon = 'modular_nova/master_files/icons/obj/clothing/head/akula_official.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/akula_official.dmi'

/obj/item/clothing/head/hats/caphat/azulean/old_blood
	name = "\improper Oldblood's royal cap"
	desc = "A peaked cap typically seen on nobles and high-rankers of the Agurkrral Royal Navy, this service hat has a long history in the Old Principalities. \
		Comfortable and lightweight, the purpose of this cap has gradually shifted to becoming yet another method to flex rank. \n\n\
		Threaded gold is often seen in the campaign cords attached to it, and the emblems on them grow more and more complex based on ranking; \
		and of course, importance to the King."
	icon_state = "oldbloodcap"

/obj/item/clothing/head/hats/caphat/azulean/upstart
	name = "\improper Upstart's noble cap"
	desc = "A peaked cap widely seen across the New Principalities. \n\
		Combining ideas from both the uncertain human factions and the Old Principalities, this cloneleather cap was made to be both inexpensive and easier to maintain than the elaborate headpieces worn by the older nobility. \
		Border princes of all make and model are known to put their own personal emblems on these instead of any coherent ranking system, \
		and the cap features a wider brim in order to shield Azulean eyes from the alien suns they intend to grasp."
	icon_state = "upstartcap"

/obj/item/clothing/head/helmet/space/akula_wetsuit
	name = "\improper Shoredress helm"
	desc = "Known simply as a 'Glass' throughout Azulean society as a whole, these spheroidal helmets are often the main source of comfort for workers on land; domestic and abroad. \
		More advanced than humans would ever give them credit for, a Shoredress's Glass is a piece of technology unto itself. \n\n\
		These helmets employ a near-invisible system of cameras and sensors to prevent refraction from the water kept inside. \
		The 'flexiglass' comprising the unit is chemically strengthened to be thin, light, and damage-resistant, but capable of bending even in half without shattering; all to allow you to touch your face. \n\
		Some have taken to putting electronic displays around the face to help express emotion, or to signal nonverbally. \
		These helms are normally attached to Shoredresses or Stardresses, but comes with a fitted neoprene collar to allow wear on essentially anything."
	icon = 'modular_nova/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/akula.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	strip_delay = 6 SECONDS
	armor_type = /datum/armor/wetsuit_helmet
	resistance_flags = FIRE_PROOF
	flags_inv = null
	flags_cover = HEADCOVERSMOUTH | PEPPERPROOF
	/// Variable for storing hats which are worn inside the bubble helmet
	var/obj/item/clothing/head/attached_hat

/// Helmet armor
/datum/armor/wetsuit_helmet
	bio = 100
	fire = 100

/obj/item/clothing/head/helmet/space/akula_wetsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/Destroy(force)
	var/turf/drop_loc = drop_location()
	if(!istype(drop_loc))
		QDEL_NULL(attached_hat)
		return ..()

	if(attached_hat)
		attached_hat.forceMove(drop_loc)
		attached_hat = null

	return ..()

// Wearing hats inside the wetworks helmet
/obj/item/clothing/head/helmet/space/akula_wetsuit/examine()
	. = ..()
	if(attached_hat)
		. += span_notice("There's \a [attached_hat] placed in the helmet.")
		. += span_bold("Right-click to remove it.")
	else
		. += span_notice("There's nothing placed in the helmet.")

/obj/item/clothing/head/helmet/space/akula_wetsuit/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE
	if(!istype(tool, /obj/item/clothing/head))
		return
	var/obj/item/clothing/hitting_hat = tool
	if(hitting_hat.clothing_flags & STACKABLE_HELMET_EXEMPT)
		balloon_alert(user, "doesn't fit!")
		return ITEM_INTERACT_BLOCKING
	if(attached_hat)
		balloon_alert(user, "already something inside!")
		return ITEM_INTERACT_BLOCKING

	attached_hat = hitting_hat
	balloon_alert(user, "[hitting_hat] put inside")
	hitting_hat.forceMove(src)
	icon_state = "empty"
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/head/helmet/space/akula_wetsuit/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!attached_hat || isinhands)
		return

	var/mutable_appearance/attached_hat_appearance = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
	attached_hat_appearance.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
	. += attached_hat_appearance

/obj/item/clothing/head/helmet/space/akula_wetsuit/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(!attached_hat)
		return NONE

	user.put_in_active_hand(attached_hat)
	balloon_alert(user, "[attached_hat] removed")
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
	return ITEM_INTERACT_SUCCESS
