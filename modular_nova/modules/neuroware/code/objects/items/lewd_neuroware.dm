/obj/item/disk/neuroware/camphor
	name = "\improper AphroCalm neuroware"
	desc = "A neuroware chip containing AphroCalm, a basic \"anaphrodisiac\" emulator which causes a reduction in libido. This is not an aphrodisiac. Multi-user license included."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor/synth = 15)
	icon_state = "/obj/item/disk/neuroware/camphor"
	post_init_icon_state = "chip_nolewd"
	greyscale_colors = "#eeeeee"
	uses = 4
	is_lewd = TRUE

/obj/item/disk/neuroware/pentacamphor
	name = "\improper Nobido Xtreme neuroware"
	desc = "A neuroware chip containing Nobido Xtreme, a very powerful \"anaphrodisiac\" emulator which causes an extreme reduction in libido. Overloading may cause system corruption. Multi-user license included."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/synth = 15)
	icon_state = "/obj/item/disk/neuroware/pentacamphor"
	post_init_icon_state = "chip_nolewd"
	greyscale_colors = "#474747"
	uses = 4
	is_lewd = TRUE

/obj/item/disk/neuroware/crocin
	name = "\improper EroStim neuroware"
	desc = "A neuroware chip containing EroStim, a basic aphrodisiac emulator which increases libido. Multi-user license included."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin/synth = 15)
	icon_state = "/obj/item/disk/neuroware/crocin"
	post_init_icon_state = "chip_lewd"
	greyscale_colors = "#784abc"
	uses = 4
	is_lewd = TRUE

/obj/item/disk/neuroware/hexacrocin
	name = "\improper EroStim Deluxe neuroware"
	desc = "A neuroware chip containing EroStim Deluxe, which is an extremely powerful and addictive version of the EroStim aphrodisiac emulator. Addiction withdrawals or overloading may cause system corruption. Multi-user license included."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/synth = 15)
	icon_state = "/obj/item/disk/neuroware/hexacrocin"
	post_init_icon_state = "chip_lewd"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	uses = 4
	is_lewd = TRUE
