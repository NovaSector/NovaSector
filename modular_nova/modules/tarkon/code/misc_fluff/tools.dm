/obj/item/construction/rcd/tarkon
	name = "Tarkon Industries RCD"
	desc = "An RCD of an improved design with a \"Tarkon Industries\" logo on it. Reload using metal, glass, or plasteel."
	icon = 'modular_nova/modules/tarkon/icons/misc/tools.dmi'
	icon_state = "trcd"
	righthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	canRturf = FALSE //We at tarkon industries believe in "Manual Correction". memorize the Rwall decon sequence and you're hired.
	delay_mod = 0.8	//Faster than RCD, Slower than ARCD.
	max_matter = 200	//Industrial/Combat RCD is like 500. Its still better than default 160 and wont matter once silo upgraded. also I like properly rounded numbers.
	matter = 200
	construction_upgrades = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS | RCD_UPGRADE_NO_FREQUENT_USE_COOLDOWN
