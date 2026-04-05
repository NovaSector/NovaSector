/obj/item/radio/intercom/command/unscrewed
	unscrewed = TRUE

/obj/item/wallframe/intercom/command
	name = "command intercom frame"
	result_path = /obj/item/radio/intercom/command/unscrewed

/obj/item/radio/intercom/command/atom_deconstruct(disassembled)
	new/obj/item/wallframe/intercom/command(get_turf(src))

/obj/structure/closet/secure_closet/bridge_officer/PopulateContents()
	..()
	new /obj/item/wallframe/intercom/command(src)
	new /obj/item/paper/fluff/jobs/engineering/frequencies(src)


