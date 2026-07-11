// medicine used for self surgery, it removes the need for a heart or liver
/obj/item/storage/pill_bottle/cordiolis_hepatico
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/cordiolis_hepatico

/obj/item/reagent_containers/applicator/pill/cordiolis_hepatico
	name = "cordiolis hepatico pill"
	desc = "A highly advanced and classified chemical agent which temporarily removes the need for a functional heart or liver. They would prefer you knew less about it."
	icon_state = "pill21"
	list_reagents = list(
		/datum/reagent/medicine/cordiolis_hepatico = 10,
		/datum/reagent/consumable/sugar = 5,
	)
