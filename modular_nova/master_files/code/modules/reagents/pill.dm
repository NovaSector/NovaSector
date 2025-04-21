/obj/item/reagent_containers/applicator/pill/lsdpsych/quirk
	list_reagents = list(/datum/reagent/toxin/mindbreaker = 15)

/obj/item/storage/pill_bottle/lsdpsych/quirk
	name = "antipsychotic pill"

/obj/item/storage/pill_bottle/lsdpsych/quirk/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/applicator/pill/lsdpsych/quirk(src)
