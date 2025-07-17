/*
	This file is here to stop bloating in other files, this is mainly to make smaller stuff or individual items able to be kept here
they get called in files like interdyne_crates.dm and interdyne_kits.dm
*/

/obj/item/reagent_containers/cup/beaker/omnizine
	name = "Omnizine Beaker"
	list_reagents = list(/datum/reagent/medicine/omnizine = 60)

/obj/item/reagent_containers/cup/beaker/sal_acid
	name = "Salicylic-Acid Beaker"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 60)

/obj/item/reagent_containers/cup/beaker/dyne_brutemix
	name = "Sal-Acid/Lib Beaker (BRUTE)"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 30, /datum/reagent/medicine/c2/libital = 30)

/obj/item/reagent_containers/cup/beaker/dyne_burnmix
	name = "Lent/Oxan Beaker (BRUTE)"
	list_reagents = list(/datum/reagent/medicine/c2/lenturi = 30, /datum/reagent/medicine/oxandrolone = 30)

/obj/item/reagent_containers/cup/beaker/dyne_oxytox
	name = "Con/Seiv Beaker (OXY/TOX)"
	list_reagents = list(/datum/reagent/medicine/c2/convermol = 30, /datum/reagent/medicine/c2/seiver = 30)

/obj/item/reagent_containers/cup/beaker/oxandrolone
	name = "Oxandrolone Beaker"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 60)

/obj/item/reagent_containers/cup/beaker/pen_acid
	name = "Pentetic Acid Beaker"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 60)

/obj/item/reagent_containers/cup/beaker/atropine
	name = "Atropine Beaker"
	list_reagents = list(/datum/reagent/medicine/atropine = 60)

/obj/item/reagent_containers/cup/beaker/salbutamol
	name = "Salbutamol Beaker"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 60)

/obj/item/reagent_containers/cup/beaker/rezadone/less
	name = "Rezadone Beaker"
	list_reagents = list(/datum/reagent/medicine/rezadone = 60)

/obj/item/reagent_containers/cup/beaker/rezadone/less
	list_reagents = list(/datum/reagent/medicine/rezadone = 30)

/obj/item/reagent_containers/cup/beaker/god_blood
	name = "God's Blood Beaker"
	list_reagents = list(/datum/reagent/medicine/omnizine/godblood = 30)

/obj/item/paper/fluff/interdyne/medicines
	name = "Note From Corporate"
	default_raw_text = {"Please rememember to heat up your siever oxy/tox mix for maximum effectiveness elsewise we may have a lawsuit.

	Interdyne leadership is not to be held responsible for the malpractice of the individual doctor."}
