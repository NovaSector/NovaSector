//Azulean Pirate
/datum/outfit/deathmatch_loadout/azulean
	name = "DM: Azulean Boarder"
	display_name = "Azulean Boarder"
	desc = "The most feared pirates within the sector, engaging combat with them in space is nothing more than a deathwish."

	r_hand = /obj/item/knife/combat
	uniform = /obj/item/clothing/under/skinsuit
	head = /obj/item/clothing/head/helmet/space/skinsuit_helmet
	suit = /obj/item/clothing/suit/armor/riot/skinsuit_armor
	suit_store = /obj/item/tank/internals/oxygen/yellow
	internals_slot = ITEM_SLOT_SUITSTORE
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	back = /obj/item/tank/jetpack/void
	id = /obj/item/card/id/advanced/chameleon

///force the akula species onto the player
/datum/outfit/deathmatch_loadout/azulean/pre_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	. = ..()
	//generate our mutable colors
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#1CD3E5"
			secondary_color = "#6AF1D6"
			tertiary_color = "#CCF6E2"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"

	var/list/features = list()
	features["mcolor"] = main_color
	features["mcolor2"] = secondary_color
	features["mcolor3"] = tertiary_color
	//clear mutant parts
	for(var/feature in user.dna.mutant_bodyparts)
		if(feature == "tail")
			user.dna.mutant_bodyparts[feature] = list(MUTANT_INDEX_NAME = "Akula", MUTANT_INDEX_COLOR_LIST = list(features["mcolor"], features["mcolor2"], features["mcolor3"]))
			continue
		user.dna.mutant_bodyparts[feature] = null
	//generate the species
	user.set_species(/datum/species/akula, icon_update = FALSE, pref_load = FALSE)
	user.set_hairstyle("Bald", update = FALSE)
	user.hardset_dna(newfeatures = features)
	user.dna.species.body_markings = assemble_body_markings_from_set(GLOB.body_marking_sets["Akula"], features, /datum/species/akula)
	user.dna.features["legs"] = "Normal Legs"
	user.dna.species.regenerate_organs(user, /datum/species/akula, visual_only = FALSE)
	user.update_body(TRUE)


//Space Syndie
/datum/outfit/deathmatch_loadout/syndicate_space
	name = "DM: Syndicate Spaceman"
	display_name = "Syndicate Spaceman"
	desc = "A syndicate operative suited up for some space reconnaissance."

	r_hand = /obj/item/knife/combat/survival
	uniform = /obj/item/clothing/under/syndicate/coldres
	belt = /obj/item/storage/belt/military
	mask = /obj/item/clothing/mask/gas/syndicate
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	internals_slot = ITEM_SLOT_RPOCKET
	shoes = /obj/item/clothing/shoes/combat/coldres
	gloves = /obj/item/clothing/gloves/tackler/combat
	back = /obj/item/tank/jetpack/oxygen/harness
	id = /obj/item/card/id/advanced/chameleon

/datum/outfit/deathmatch_loadout/syndicate_space/pre_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	if(user.jumpsuit_style == PREF_SKIRT)
		uniform = /obj/item/clothing/under/syndicate/skirt/coldres

	switch(pick(list("red", "green", "dgreen", "blue", "orange", "black")))
		if("green")
			head = /obj/item/clothing/head/helmet/space/syndicate/green
			suit = /obj/item/clothing/suit/space/syndicate/green
		if("dgreen")
			head = /obj/item/clothing/head/helmet/space/syndicate/green/dark
			suit = /obj/item/clothing/suit/space/syndicate/green/dark
		if("blue")
			head = /obj/item/clothing/head/helmet/space/syndicate/blue
			suit = /obj/item/clothing/suit/space/syndicate/blue
		if("red")
			head = /obj/item/clothing/head/helmet/space/syndicate
			suit = /obj/item/clothing/suit/space/syndicate
		if("orange")
			head = /obj/item/clothing/head/helmet/space/syndicate/orange
			suit = /obj/item/clothing/suit/space/syndicate/orange
		if("black")
			head = /obj/item/clothing/head/helmet/space/syndicate/black
			suit = /obj/item/clothing/suit/space/syndicate/black


//Drifting assistant
/datum/outfit/deathmatch_loadout/assistant_space
	name = "DM: Assistant (Spaceworthy)"
	display_name = "Assistant (Spaceworthy)"
	desc = "An assistant who just happened to drift by."

	r_hand = /obj/item/knife
	l_hand = /obj/item/extinguisher
	uniform = /obj/item/clothing/under/color/grey
	belt = /obj/item/crowbar/large/emergency
	suit = /obj/item/clothing/suit/utility/fire/firefighter
	head = /obj/item/clothing/head/utility/hardhat/red
	mask = /obj/item/clothing/mask/gas/alt
	r_pocket = /obj/item/reagent_containers/cup/glass/coffee
	l_pocket = /obj/item/reagent_containers/hypospray/medipen
	internals_slot = ITEM_SLOT_BACK
	shoes = /obj/item/clothing/shoes/sneakers
	gloves = /obj/item/clothing/gloves/tackler/offbrand
	back = /obj/item/tank/internals/oxygen/red
	id = /obj/item/card/id/advanced/chameleon

/datum/outfit/deathmatch_loadout/assistant_space/pre_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	if(user.jumpsuit_style == PREF_SKIRT)
		uniform = /obj/item/clothing/under/color/jumpskirt/grey
