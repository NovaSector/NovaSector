//Ported from Maplestation https://github.com/MrMelbert/MapleStationCode/pull/17
/obj/item/reagent_containers/applicator/pill/morphine/diluted
	desc = "Used to treat major to severe pain. Causes moderate drowsyness. Mildly addictive."
	icon_state = "pill11"
	list_reagents = list(/datum/reagent/medicine/morphine = 5) // Lasts ~1 minute, heals ~10 pain per bodypart (~100 pain)
	rename_with_volume = TRUE
