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
	name = "Lent/Oxan Beaker (BURN)"
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

/obj/item/reagent_containers/cup/beaker/rezadone
	name = "Rezadone Beaker"
	list_reagents = list(/datum/reagent/medicine/rezadone = 60)

/obj/item/reagent_containers/cup/beaker/rezadone/less
	list_reagents = list(/datum/reagent/medicine/rezadone = 30)

/*
* Patches
*/

/obj/item/reagent_containers/applicator/patch/pen_acid
	name = "\improper Pentetic Acid Patch"
	icon_state = "bandaid_toxin"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 10)
	list_reagents_purity = 1

/obj/item/reagent_containers/applicator/patch/oxandrolone
	name = "\improper Oxandrolone Patch"
	icon_state = "bandaid_burn_2"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 10)
	list_reagents_purity = 1

/obj/item/reagent_containers/applicator/patch/salbutamol
	name = "\improper Salbutamol Patch"
	icon_state = "bandaid_suffocation_2"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10)
	list_reagents_purity = 1

/obj/item/reagent_containers/applicator/patch/sal_acid
	name = "\improper Salicylic Acid Patch"
	icon_state = "bandaid_brute"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 10)
	list_reagents_purity = 1

/*
* Fluff
*/

/obj/item/paper/fluff/interdyne/medicines
	name = "Note From Corporate"
	default_raw_text = "Please rememember to heat up your siever oxy/tox mix for maximum effectiveness elsewise we may have a lawsuit.\n\n \
		Interdyne leadership is not to be held responsible for the malpractice of the individual doctor."

/*
* Bandages
*/

/obj/item/storage/box/bandages/interdyne
	name = "\improper interdyne brute bandage box"
	desc = "An Interdyne box filled with first aid medical patches, produced for brute purposes"
	icon_state = "dynebox"
	base_icon_state = "dynebox"
	icon = 'modular_nova/master_files/icons/obj/storage/medkit.dmi'

/obj/item/storage/box/bandages/interdyne/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/applicator/patch/sal_acid(src)

/obj/item/storage/box/bandages/interdyne/burn
	name = "\improper interdyne burn bandage box"
	desc = "An Interdyne box filled with first aid medical patches, produced for burn purposes"

/obj/item/storage/box/bandages/interdyne/burn/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/applicator/patch/oxandrolone(src)

/obj/item/storage/box/bandages/interdyne/synthflesh
	name = "\improper interdyne burn synthflesh box"
	desc = "An Interdyne box filled with first aid medical patches, produced for burn and brute purposes"

/obj/item/storage/box/bandages/interdyne/synthflesh/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/applicator/patch/synthflesh(src)

/obj/item/storage/box/bandages/interdyne/toxin
	name = "\improper interdyne toxins bandage box"
	desc = "An Interdyne box filled with first aid medical patches, produced for toxins purposes"

/obj/item/storage/box/bandages/interdyne/toxin/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/applicator/patch/pen_acid(src)

/obj/item/storage/box/bandages/interdyne/oxygen
	name = "\improper interdyne oxygen bandage box"
	desc = "An Interdyne box filled with first aid medical patches, produced for oxy-loss purposes"

/obj/item/storage/box/bandages/interdyne/toxin/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/applicator/patch/salbutamol(src)
