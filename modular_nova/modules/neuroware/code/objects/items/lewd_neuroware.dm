/obj/item/disk/neuroware/camphor
	name = "AphroCalm neuroware"
	desc = "A neuroware chip containing AphroCalm, a basic \"anaphrodisiac\" emulator which causes a reduction in libido. This is not an aphrodisiac."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor/synth = 10)
	icon_state = "chip_nolewd"
	greyscale_colors = "#eeeeee"
	can_overdose = TRUE
	is_lewd = TRUE

/obj/item/disk/neuroware/pentacamphor
	name = "Nobido Xtreme neuroware"
	desc = "A neuroware chip containing Nobido Xtreme, a very powerful \"anaphrodisiac\" emulator which causes an extreme reduction in libido. Over-installing may cause brain damage."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/synth = 10)
	icon_state = "chip_nolewd"
	greyscale_colors = "#474747"
	can_overdose = TRUE
	is_lewd = TRUE

/obj/item/disk/neuroware/crocin
	name = "EroStim neuroware"
	desc = "A neuroware chip containing EroStim, a basic aphrodisiac emulator which increases libido."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin/synth = 10)
	icon_state = "chip_lewd"
	greyscale_colors = "#784abc"
	can_overdose = TRUE
	is_lewd = TRUE

/obj/item/disk/neuroware/hexacrocin
	name = "EroStim Deluxe neuroware"
	desc = "A neuroware chip containing EroStim Deluxe, which is an extremely powerful and addictive version of the EroStim aphrodisiac emulator. Addiction withdrawals or over-installing may cause brain damage."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/synth = 10)
	icon_state = "chip_lewd"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	can_overdose = TRUE
	is_lewd = TRUE
