/// Assures no matter how the antag is loaded the SolFed faction is always applied
/datum/antagonist/ert/solfed/on_gain()
	owner?.current.faction |= FACTION_SOLFED
	. = ..()

/// Base outfit (Emergency Responders)
/datum/outfit/solfed
	name = "SolFed Base Uniform"
	uniform = /obj/item/clothing/under/solfed/officer
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/jackboots
	neck = /obj/item/clothing/neck/mantle/solfed
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/headset_solfed/officials
	id = /obj/item/card/id/advanced/solfed
	r_hand = /obj/item/clipboard
	backpack_contents = list(
		/obj/item/stamp/solfed,
		/obj/item/stamp/denied,
		/obj/item/stamp,
	)
	id_trim = /datum/id_trim/solfed/official

/datum/outfit/solfed/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/Radio = person.ears
	Radio.set_frequency(FREQ_SOLFED)
	Radio.freqlock = TRUE
	var/obj/item/card/id/ID = person.wear_id
	ID.registered_name = person.real_name
	ID.update_label()
	..()

/// Solfed Officials (government/highcom/etc)
/datum/outfit/solfed/official
	name = "Solfed Base Official Uniform"
	uniform = /obj/item/clothing/under/solfed/official_social
	r_hand = /obj/item/advanced_choice_beacon/solfed
	id = /obj/item/card/id/advanced/solfed/official
	id_trim = /datum/id_trim/solfed/official
	ears = /obj/item/radio/headset/headset_solfed/officials

/datum/outfit/solfed/official/gold
	name = "SolFed Official Uniform (Gold Trim)"
	uniform = /obj/item/clothing/under/solfed/official_social
	id_trim = /datum/id_trim/solfed/official/gold

/datum/outfit/solfed/official/ensign
	name = "SolFed Ensign"
	uniform = /obj/item/clothing/under/solfed/official_social
	id_trim = /datum/id_trim/solfed/official/ensign

/datum/outfit/solfed/official/lieutenant
	name = "SolFed Lieutenant"
	id_trim = /datum/id_trim/solfed/official/lieutenant

/datum/outfit/solfed/official/commander
	name = "SolFed Commander"
	id_trim = /datum/id_trim/solfed/official/commander

/datum/outfit/solfed/official/captain
	name = "SolFed Captain"
	id_trim = /datum/id_trim/solfed/official/captain

/datum/outfit/solfed/official/admiral
	name = "SolFed Admiral"
	id_trim = /datum/id_trim/solfed/official/admiral

/datum/outfit/solfed/lowrank
	name = "SolFed Official (Low Rank)"
	uniform = /obj/item/clothing/under/solfed/officer_lowrnk
	accessory = /obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official

/datum/outfit/solfed/civil
	name = "SolFed Official (Civil Services)"
	uniform = /obj/item/clothing/under/solfed/official_civil
	accessory = /obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official

/datum/outfit/solfed/social
	name = "SolFed Official (Social Services)"
	uniform = /obj/item/clothing/under/solfed/official_social
	accessory = /obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official

/// Base military uniform
/datum/outfit/solfed/military
	name = "Solfed Base Military Uniform"
	uniform = /obj/item/clothing/under/solfed/marines
	r_hand = /obj/item/advanced_choice_beacon/solfed
	id = /obj/item/card/id/advanced/solfed/military
	id_trim = /datum/id_trim/solfed/espatier
	ears = /obj/item/radio/headset/headset_solfed/espatier

/datum/outfit/solfed/military/espatiers
	name = "SolFed Espatier"
	ears = /obj/item/radio/headset/headset_solfed/espatier
	r_pocket = /obj/item/advanced_choice_beacon/solfed

/datum/outfit/solfed/military/espatier/grand
	name = "Solfed Grand Response Espatier"

/datum/outfit/solfed/military/espatier/corpsman
	name = "SolFed Espatier (Corpsman)"
	ears = /obj/item/radio/headset/headset_solfed/espatier/corpsman
	r_pocket = /obj/item/advanced_choice_beacon/solfed/corpsman
	id_trim = /datum/id_trim/solfed/espatier/corpsman

/datum/outfit/solfed/military/espatier/corpsman/grand
	name = "Solfed Grand Response Espatier (Corspman)"

/datum/outfit/solfed/military/espatier/engineer
	name = "SolFed Espatier (Combat Technician)"
	ears = /obj/item/radio/headset/headset_solfed/espatier/engineer
	r_pocket = /obj/item/advanced_choice_beacon/solfed/engineer
	id_trim = /datum/id_trim/solfed/espatier/engineer

/datum/outfit/solfed/military/espatier/engineer/grand
	name = "Solfed Grand Response Espatier (Combat Technician)"

/datum/outfit/solfed/military/espatier/squadleader
	name = "SolFed Espatier (Squad Leader)"
	ears = /obj/item/radio/headset/headset_solfed/espatier/squadleader
	r_pocket = /obj/item/advanced_choice_beacon/solfed/squadleader
	id_trim = /datum/id_trim/solfed/espatier/squadleader

/datum/outfit/solfed/military/espatier/squadleader/grand
	name = "Solfed Grand Response Espatier (Squad Leader)"

/// Only spawns on the second wave or grand response squad
/datum/outfit/solfed/military/specialist
	name = "SolFed Specialist"
	r_pocket = /obj/item/advanced_choice_beacon/solfed/specialist
	id_trim = /datum/id_trim/solfed/espatier/specialist
/// These guys are lightly equipped, more like cannon fodder, much more than marshals, but oddly more well equipped than a marshal.
/datum/outfit/solfed/military/odst
	name = "SolFed Orbital Drop Trooper"
	id_trim = /datum/id_trim/solfed/espatier/odst

/// When shit has gone TRULY WRONG (In reality these guys are not super strong equipment wise, but just meant to be versitille)
/datum/outfit/solfed/military/commando
	name = "SolFed Commando"
	id_trim = /datum/id_trim/solfed/espatier/commando
