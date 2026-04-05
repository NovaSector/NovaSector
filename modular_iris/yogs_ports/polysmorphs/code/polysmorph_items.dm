/datum/uplink_item/species_restricted/xeno_kit
	name = "Xenomorph Organ Kit"
	desc = "A kit containing some organs that were... 'donated' by your ancestors. Contains an autosurgeon, a plasma vessel, \
	 	a resin spinner, alongside both acid and neurotoxin glands."
	item = /obj/item/storage/box/syndie_kit/xeno_kit
	cost = 15
	restricted_species = list(SPECIES_POLYSMORPH)

/obj/item/storage/box/syndie_kit/xeno_kit
	name = "xenomorph organ kit"

/obj/item/storage/box/syndie_kit/xeno_kit/PopulateContents()
	new /obj/item/autosurgeon(src) //i imagine this thing will see the most usage lol
	new	/obj/item/organ/alien/plasmavessel/large(src) //needs decent regen for the abilities to be useful
	new /obj/item/organ/alien/resinspinner(src)
	new /obj/item/organ/alien/acid(src)
	new /obj/item/organ/alien/neurotoxin(src)

/datum/uplink_item/species_restricted/hive_starter
	name = "DIY Hive Set"
	desc = "We've recovered this set of organs from an abandoned Polysmorph colony which apparently used for establishing fresh colonies, this one was left unused. \
		These things are absolutely illegal following the abandonment of the Polysmorph project...but you aren't here for the legal stuff now are you? \
		Contains a reusable autosurgeon along with Xenomorph Queen organs."
	item = /obj/item/storage/box/syndie_kit/hive_starter
	cost = 30 //this is literally romerol but xenos
	population_minimum = TRAITOR_POPULATION_LOWPOP //that is over 20 people
	restricted_species = list(SPECIES_POLYSMORPH)

/obj/item/storage/box/syndie_kit/hive_starter
	name = "diy hive set"

/obj/item/storage/box/syndie_kit/hive_starter/PopulateContents()
	new /obj/item/autosurgeon(src)
	new	/obj/item/organ/alien/plasmavessel/large/queen(src)
	new /obj/item/organ/alien/resinspinner(src)
	new /obj/item/organ/alien/acid(src)
	new /obj/item/organ/alien/neurotoxin(src)
	new /obj/item/organ/alien/hivenode(src)
	new /obj/item/organ/alien/eggsac(src)
