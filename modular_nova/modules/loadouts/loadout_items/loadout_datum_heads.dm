// LOADOUT ITEM DATUMS FOR THE HEAD SLOT

/datum/loadout_item/head/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.head))
		.. ()
		return TRUE

/datum/loadout_item/head/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.head)
			LAZYADD(outfit.backpack_contents, outfit.head)
		outfit.head = item_path
	else
		outfit.head = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/head/wrussian
	name = "Papakha (Recolorable)"
	item_path = /obj/item/clothing/head/costume/nova/papakha

/datum/loadout_item/head/standalone_hood
	name = "Standalone Hood"
	item_path = /obj/item/clothing/head/standalone_hood

/*
*	BEANIES
*/

/datum/loadout_item/head/white_beanie
	name = "Beanie  (Colorable)"
	item_path = /obj/item/clothing/head/beanie

/datum/loadout_item/head/black_beanie
	name = "Beanie (Black)"
	item_path = /obj/item/clothing/head/beanie/black
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/head/dark_blue_beanie
	name = "Beanie (Dark Blue)"
	item_path = /obj/item/clothing/head/beanie/darkblue
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/head/orange_beanie
	name = "Beanie (Orange)"
	item_path = /obj/item/clothing/head/beanie/orange
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/head/red_beanie
	name = "Beanie (Red)"
	item_path = /obj/item/clothing/head/beanie/red
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/head/yellow_beanie
	name = "Beanie (Yellow)"
	item_path = /obj/item/clothing/head/beanie/yellow
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/head/christmas_beanie
	name = "Beanie - Christmas"
	item_path = /obj/item/clothing/head/beanie/christmas
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/*
*	BERETS
*/

/datum/loadout_item/head/greyscale_beret
	name = "Beret (Colorable)"
	item_path = /obj/item/clothing/head/beret

/datum/loadout_item/head/greyscale_beret/badge
	name = "Beret (With Badge, Colorable)"
	item_path = /obj/item/clothing/head/beret/badge

/datum/loadout_item/head/atmos_beret
	name = "Beret - Atmospherics"
	item_path = /obj/item/clothing/head/beret/atmos

/datum/loadout_item/head/beret_chem
	name = "Beret - Chemist"
	item_path = /obj/item/clothing/head/beret/medical/chemist

/datum/loadout_item/head/engi_beret
	name = "Beret - Engineering"
	item_path = /obj/item/clothing/head/beret/engi

/datum/loadout_item/head/beret_med
	name = "Beret - Medical"
	item_path = /obj/item/clothing/head/beret/medical

/datum/loadout_item/head/beret_paramedic
	name = "Beret - Paramedic"
	item_path = /obj/item/clothing/head/beret/medical/paramedic

/datum/loadout_item/head/beret_robo
	name = "Beret - Roboticist"
	item_path = /obj/item/clothing/head/beret/science/fancy/robo

/datum/loadout_item/head/beret_sci
	name = "Beret - Scientist"
	item_path = /obj/item/clothing/head/beret/science

/datum/loadout_item/head/cargo_beret
	name = "Beret - Supply"
	item_path = /obj/item/clothing/head/beret/cargo

/datum/loadout_item/head/beret_viro
	name = "Beret - Virologist"
	item_path = /obj/item/clothing/head/beret/medical/virologist

/datum/loadout_item/head/beret_clown
	name = "Beret - Clown"
	item_path = /obj/item/clothing/head/beret/clown

/*
*	CAPS
*/

/datum/loadout_item/head/delinquent_cap
	name = "Cap - Delinquent"

/datum/loadout_item/head/mail_cap
	name = "Cap - Mail"

/datum/loadout_item/head/flatcap
	name = "Cap - Flat"

/datum/loadout_item/head/pflatcap
	name = "Cap - Flat (Colorable)"
	item_path = /obj/item/clothing/head/colourable_flatcap

/datum/loadout_item/head/fashionable_cap
	name = "Cap - Baseball"
	item_path = /obj/item/clothing/head/soft/yankee

/datum/loadout_item/head/colonialcap
	name = "Cap - Colonial"
	item_path = /obj/item/clothing/head/hats/colonial
	species_blacklist = list(SPECIES_TESHARI)

/datum/loadout_item/head/frontiercap
	name = "Cap - Frontier"
	item_path = /obj/item/clothing/head/soft/frontier_colonist

/datum/loadout_item/head/frontiercap/medic
	name = "Cap - Frontier Medical"
	item_path = /obj/item/clothing/head/soft/frontier_colonist/medic

/datum/loadout_item/head/tarkon
	name = "Tarkon Welder"
	item_path = /obj/item/clothing/head/utility/welding/hat
	blacklisted_roles = list(ALL_JOBS_SEC, ALL_JOBS_COM, JOB_PRISONER)
	group = "Job-Locked"

/datum/loadout_item/head/welder
	name = "Regular Welder"
	item_path = /obj/item/clothing/head/utility/welding
	blacklisted_roles = list(JOB_PRISONER)

/*
*	FEDORAS
*/

/datum/loadout_item/head/greyscale_fedora
	name = "Fedora  (Colorable)"
	item_path = /obj/item/clothing/head/fedora/greyscale

/datum/loadout_item/head/brown_fedora
	name = "Fedora (Brown)"
	item_path = /obj/item/clothing/head/fedora/brown

/*
*	HARDHATS
*/

/datum/loadout_item/head/dark_blue_hardhat
	name = "Hardhat (Dark Blue)"
	item_path = /obj/item/clothing/head/utility/hardhat/dblue

/datum/loadout_item/head/orange_hardhat
	name = "Hardhat (Orange)"
	item_path = /obj/item/clothing/head/utility/hardhat/orange

/datum/loadout_item/head/red_hardhat
	name = "Hardhat (Red)"
	item_path = /obj/item/clothing/head/utility/hardhat/red

/datum/loadout_item/head/white_hardhat
	name = "Hardhat (White)"
	item_path = /obj/item/clothing/head/utility/hardhat/white

/datum/loadout_item/head/yellow_hardhat
	name = "Hardhat (Yellow)"
	item_path = /obj/item/clothing/head/utility/hardhat

/*
*	MISCELLANEOUS
*	(For things that aren't QUITE a hat, y'know?)
*/

/datum/loadout_item/head/back_bow
	name = "Bow - Back"
	item_path = /obj/item/clothing/head/large_bow/back_bow
	group = "Miscellaneous"

/datum/loadout_item/head/large_bow
	name = "Bow - Large"
	item_path = /obj/item/clothing/head/large_bow
	group = "Miscellaneous"

/datum/loadout_item/head/small_bow
	name = "Bow - Small"
	item_path = /obj/item/clothing/head/small_bow
	group = "Miscellaneous"

/datum/loadout_item/head/sweet_bow
	name = "Bow - Sweet"
	item_path = /obj/item/clothing/head/large_bow/sweet_bow
	group = "Miscellaneous"

/datum/loadout_item/head/cone_of_shame
	name = "Cone of Shame"
	item_path = /obj/item/clothing/head/cone_of_shame
	group = "Miscellaneous"

/datum/loadout_item/head/warning_cone
	name = "Warning Cone"
	item_path = /obj/item/clothing/head/cone
	group = "Miscellaneous"

/datum/loadout_item/head/wig //TG overwrite so that we can have both fake/natural wigs
	name = "Wig"
	item_path = /obj/item/clothing/head/wig
	group = "Miscellaneous"

/datum/loadout_item/head/wignatural
	name = "Wig - Natural"
	item_path = /obj/item/clothing/head/wig/natural
	group = "Miscellaneous"

// FLOWERS
/datum/loadout_item/head/geranium
	name = "Flower - Geranium"
	group = "Miscellaneous"

/datum/loadout_item/head/harebell
	name = "Flower - Harebell"
	group = "Miscellaneous"

/datum/loadout_item/head/lily
	name = "Flower - Lily"
	group = "Miscellaneous"

/datum/loadout_item/head/poppy
	name = "Flower - Poppy"
	group = "Miscellaneous"

/datum/loadout_item/head/rose
	name = "Flower - Rose"
	group = "Miscellaneous"

/datum/loadout_item/head/sunflower
	name = "Flower - Sunflower"
	group = "Miscellaneous"

/datum/loadout_item/head/floral_garland
	name = "Floral Garland"
	item_path = /obj/item/clothing/head/costume/garland
	group = "Miscellaneous"

/datum/loadout_item/head/lily_crown
	name = "Floral Crown - Lily"
	item_path = /obj/item/clothing/head/costume/garland/lily
	group = "Miscellaneous"

/datum/loadout_item/head/poppy_crown
	name = "Floral Crown - Poppy"
	item_path = /obj/item/clothing/head/costume/garland/poppy
	group = "Miscellaneous"

/datum/loadout_item/head/sunflower_crown
	name = "Floral Crown - Sunflower"
	item_path = /obj/item/clothing/head/costume/garland/sunflower
	group = "Miscellaneous"

/datum/loadout_item/head/flowerpin
	name = "Flower Pin"
	item_path = /obj/item/clothing/head/costume/nova/flowerpin
	group = "Miscellaneous"

/*
*	COSTUME
*/

/datum/loadout_item/head/rastafarian
	group = "Costumes"

/datum/loadout_item/head/kitty_ears
	group = "Costumes"

/datum/loadout_item/head/rabbit_ears
	group = "Costumes"

/datum/loadout_item/head/synde
	name = "Black Space-Helmet Replica"
	item_path = /obj/item/clothing/head/syndicatefake
	group = "Costumes"

/datum/loadout_item/head/blastwave_helmet
	name = "Blastwave Plastic Helmet"
	item_path = /obj/item/clothing/head/blastwave
	group = "Costumes"

/datum/loadout_item/head/blastwave_cap
	name = "Blastwave Peaked Cap"
	item_path = /obj/item/clothing/head/blastwave/officer
	group = "Costumes"

/datum/loadout_item/head/deckers
	name = "Deckers Hat"
	item_path = /obj/item/clothing/head/costume/deckers
	group = "Costumes"

/datum/loadout_item/head/hairpin
	name = "Fancy Hairpin"
	item_path = /obj/item/clothing/head/costume/hairpin
	group = "Costumes"

/datum/loadout_item/head/saints
	name = "Fancy Hat (Colorable)"
	item_path = /obj/item/clothing/head/costume/fancy
	group = "Costumes"

/datum/loadout_item/head/flakhelm
	name = "Flak Helmet"
	item_path = /obj/item/clothing/head/hats/flakhelm
	group = "Costumes"

/datum/loadout_item/head/glatiator
	name = "Gladiator Helmet"
	item_path = /obj/item/clothing/head/helmet/gladiator
	group = "Costumes"

/datum/loadout_item/head/griffin
	name = "Griffon Head"
	item_path = /obj/item/clothing/head/costume/griffin
	group = "Costumes"

/datum/loadout_item/head/jester
	name = "Jester Hat"
	item_path = /obj/item/clothing/head/costume/jester
	group = "Costumes"

/datum/loadout_item/head/jesteralt
	name = "Jester Hat - Alt"
	item_path = /obj/item/clothing/head/costume/jesteralt
	group = "Costumes"

/datum/loadout_item/head/nursehat
	name = "Nurse Hat"
	item_path = /obj/item/clothing/head/costume/nursehat
	group = "Costumes"

/datum/loadout_item/head/pirate_bandana
	name = "Pirate Bandana"
	item_path = /obj/item/clothing/head/costume/pirate/bandana
	group = "Costumes"

/datum/loadout_item/head/pirate
	name = "Pirate Hat"
	item_path = /obj/item/clothing/head/costume/pirate
	group = "Costumes"

/datum/loadout_item/head/plague_hat
	name = "Plague Doctor's Hat"
	item_path = /obj/item/clothing/head/bio_hood/plague
	group = "Costumes"

/datum/loadout_item/head/rice_hat
	name = "Rice Hat"
	item_path = /obj/item/clothing/head/costume/rice_hat
	group = "Costumes"

/datum/loadout_item/head/slime
	name = "Slime Hat"
	item_path = /obj/item/clothing/head/collectable/slime
	group = "Costumes"

/datum/loadout_item/head/sombrero
	name = "Sombrero"
	item_path = /obj/item/clothing/head/costume/sombrero
	group = "Costumes"

/datum/loadout_item/head/cybergoggles_civ
	name = "Type-34C Forensics Headwear"
	item_path = /obj/item/clothing/head/fedora/det_hat/cybergoggles/civilian
	group = "Costumes"

/datum/loadout_item/head/wedding_veil
	name = "Wedding Veil"
	item_path = /obj/item/clothing/head/costume/weddingveil
	group = "Costumes"

/datum/loadout_item/head/witch
	name = "Witch Hat"
	item_path = /obj/item/clothing/head/wizard/marisa/fake
	group = "Costumes"

/datum/loadout_item/head/wizard
	name = "Wizard Hat"
	item_path = /obj/item/clothing/head/wizard/fake
	group = "Costumes"

/datum/loadout_item/head/xenos
	name = "Xenos Helmet"
	item_path = /obj/item/clothing/head/costume/xenos
	group = "Costumes"

//Pelts
/datum/loadout_item/head/bear_pelt
	name = "Pelt - Bear (Space)"
	group = "Costumes"

/datum/loadout_item/head/bearpeltblack
	name = "Pelt - Bear (Black)"
	item_path = /obj/item/clothing/head/pelt/black
	group = "Costumes"

/datum/loadout_item/head/bearpelt
	name = "Pelt - Bear (Brown)"
	item_path = /obj/item/clothing/head/pelt
	group = "Costumes"

/datum/loadout_item/head/bearpeltwhite
	name = "Pelt - Bear (White)"
	item_path = /obj/item/clothing/head/pelt/white
	group = "Costumes"

/datum/loadout_item/head/tigerpelt
	name = "Pelt - Tiger"
	item_path = /obj/item/clothing/head/pelt/tiger
	group = "Costumes"

/datum/loadout_item/head/tigerpeltpink
	name = "Pelt - Tiger (Pink)"
	item_path = /obj/item/clothing/head/pelt/pink_tiger
	group = "Costumes"

/datum/loadout_item/head/tigerpeltsnow
	name = "Pelt - Tiger (Snow)"
	item_path = /obj/item/clothing/head/pelt/snow_tiger
	group = "Costumes"

/datum/loadout_item/head/wolfpeltblack
	name = "Pelt - Wolf (Black)"
	item_path = /obj/item/clothing/head/pelt/wolf/black
	group = "Costumes"

/datum/loadout_item/head/wolfpelt
	name = "Pelt - Wolf (Brown)"
	item_path = /obj/item/clothing/head/pelt/wolf
	group = "Costumes"

/datum/loadout_item/head/wolfpeltwhite
	name = "Pelt - Wolf (White)"
	item_path = /obj/item/clothing/head/pelt/wolf/white
	group = "Costumes"

//Maid
/datum/loadout_item/head/maid_headband
	name = "Maid Headband (Colorable)"
	item_path = /obj/item/clothing/head/maid_headband
	group = "Costumes"

/datum/loadout_item/head/maidhead
	name = "Maid Headband - Simple"
	item_path = /obj/item/clothing/head/costume/nova/maid
	group = "Costumes"

/datum/loadout_item/head/tactical_headband
	name = "Maid Headband - Tactical"
	item_path = /obj/item/clothing/head/costume/maid_headband/syndicate/loadout_headband
	group = "Costumes"

/datum/loadout_item/head/maidhead/get_item_information()
	. = ..()
	.[FA_ICON_HAT_COWBOY] = "Top of Head"

/datum/loadout_item/head/maidhead2
	name = "Maid Headband - Frilly"
	item_path = /obj/item/clothing/head/costume/maid_headband
	group = "Costumes"

/datum/loadout_item/head/maidhead2/get_item_information()
	. = ..()
	.[FA_ICON_EAR_DEAF] = "Behind Ears"

//Chaplain
/datum/loadout_item/head/chap_nunh
	name = "Nun's Hood"
	item_path = /obj/item/clothing/head/chaplain/nun_hood
	group = "Costumes"

/datum/loadout_item/head/chap_nunv
	name = "Nun's Veil"
	item_path = /obj/item/clothing/head/chaplain/habit_veil
	group = "Costumes"

/datum/loadout_item/head/chap_kippah
	name = "Jewish Kippah"
	item_path = /obj/item/clothing/head/chaplain/kippah
	group = "Costumes"

/*
*	SPECIES
*/

/datum/loadout_item/head/mothcap
	name = "Mothic Softcap"
	item_path = /obj/item/clothing/head/mothcap
	group = "Species-Unique"

/datum/loadout_item/head/skrell_chain_gold
	name = "Skrellian Head Chain - Gold"
	item_path = /obj/item/clothing/head/skrell_chain
	group = "Species-Unique"

/datum/loadout_item/head/skrell_chain_silver
	name = "Skrellian Head Chain - Silver"
	item_path = /obj/item/clothing/head/skrell_chain/silver
	group = "Species-Unique"

/datum/loadout_item/head/akula_helmet
	name = "Shoredress Helmet"
	item_path = /obj/item/clothing/head/helmet/space/akula_wetsuit
	group = "Species-Unique"

/datum/loadout_item/head/azulea_oldblood
	name = "Oldblood's Royal Cap"
	item_path = /obj/item/clothing/head/hats/caphat/azulean/old_blood
	group = "Species-Unique"

/datum/loadout_item/head/azulea_upstart
	name = "Upstart Noble's Cap"
	item_path = /obj/item/clothing/head/hats/caphat/azulean/upstart
	group = "Species-Unique"

/*
*	COWBOY
*/

/datum/loadout_item/head/cowboyhat
	name = "Cattleman Hat"
	item_path = /obj/item/clothing/head/cowboy/nova/cattleman

/datum/loadout_item/head/cowboyhat_black
	name = "Cattleman Hat - Wide-Brimmed"
	item_path = /obj/item/clothing/head/cowboy/nova/cattleman/wide

/datum/loadout_item/head/cowboyhat_wide
	name = "Wide-Brimmed Hat"
	item_path = /obj/item/clothing/head/cowboy/nova/wide

/datum/loadout_item/head/cowboyhat_wide_feather
	name = "Wide-Brimmed Feathered Hat"
	item_path = /obj/item/clothing/head/cowboy/nova/wide/feathered

/datum/loadout_item/head/cowboyhat_flat
	name = "Flat-Brimmed Hat"
	item_path = /obj/item/clothing/head/cowboy/nova/flat

/datum/loadout_item/head/cowboyhat_flat_cowl
	name = "Flat-Brimmed Hat with Cowl"
	item_path = /obj/item/clothing/head/cowboy/nova/flat/cowl

/datum/loadout_item/head/cowboyhat_winter
	name = "Flat-Brimmed Hat with Cowl - Winter"
	item_path = /obj/item/clothing/head/cowboy/nova/flat/cowl/sheriff

/datum/loadout_item/head/cowboyhat_sheriff
	name = "Flat-Brimmed Hat - Sherrif"
	item_path = /obj/item/clothing/head/cowboy/nova/flat/sheriff

/datum/loadout_item/head/cowboyhat_deputy
	name = "Flat-Brimmed Hat - Deputy"
	item_path = /obj/item/clothing/head/cowboy/nova/flat/deputy

// Legacy unpaintable cowboy hat because it fits a character better
/datum/loadout_item/head/cowboyhat_legacy
	name = "Cowboy Hat (Legacy)"
	item_path = /obj/item/clothing/head/costume/cowboyhat_old

/*
*	TREK/STAR WARS
*/

/datum/loadout_item/head/trekcap
	name = "Officer's Cap (White)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap

/datum/loadout_item/head/trekcapcap
	name = "Officer's Cap (Black)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/black

/datum/loadout_item/head/trekcapmedisci
	name = "Officer's Cap - MedSci (Blue)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/medsci

/datum/loadout_item/head/trekcapeng
	name = "Officer's Cap - Eng (Yellow)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/eng

/datum/loadout_item/head/trekcapsec
	name = "Officer's Cap - OpSec (Red)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/sec

/datum/loadout_item/head/trekcapcustom
	name = "Officer's Cap (Colorable)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/custom

/datum/loadout_item/head/trekcapcustom_gold
	name = "Officer's Cap (Colorable, Gold Badge)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/custom/gold

/datum/loadout_item/head/navalcap
	name = "Naval Cap (Colorable)"
	item_path = /obj/item/clothing/head/hats/caphat/naval/custom

/datum/loadout_item/head/navalcap_gold
	name = "Naval Cap (Colorable, Gold Badge)"
	item_path = /obj/item/clothing/head/hats/caphat/naval/custom/gold

/datum/loadout_item/head/imperial_generic
	name = "Naval Officer Cap"
	item_path = /obj/item/clothing/head/hats/imperial
/*
*	JOB-LOCKED
*/

//COM
/datum/loadout_item/head/imperial_cap
	name = "Captain's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/cap
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP)
	group = "Job-Locked"

//SERV
/datum/loadout_item/head/imperial_hop
	name = "Head of Personnel's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/hop
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_NT_REP)
	group = "Job-Locked"

//MED
/datum/loadout_item/head/imperial_cmo
	name = "Chief Medical Officer's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/cmo
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)
	group = "Job-Locked"

//ENGI
/datum/loadout_item/head/imperial_ce
	name = "Chief Engineer's Blast Helmet"
	item_path = /obj/item/clothing/head/hats/imperial/ce
	restricted_roles = list(JOB_CHIEF_ENGINEER)
	group = "Job-Locked"

//SEC
/datum/loadout_item/head/navybluehoscap
	name = "Head of Security's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/hos
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/datum/loadout_item/head/navybluewardenberet
	name = "Warden's Beret (Navy Blue)"
	item_path = /obj/item/clothing/head/beret/sec/navywarden
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"

/datum/loadout_item/head/officerberet
	name = "Security Beret"
	item_path = /obj/item/clothing/head/beret/sec/nova
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/navyblueofficerberet
	name = "Security Beret (Navy Blue)"
	item_path = /obj/item/clothing/head/beret/sec/navyofficer
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/officercap
	name = "Security Cap"
	item_path = /obj/item/clothing/head/security_cap
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/officergarrisoncap
	name = "Security Cap - Garrison"
	item_path = /obj/item/clothing/head/security_garrison
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/officerpatrolcap
	name = "Security Cap - Patrol"
	item_path = /obj/item/clothing/head/hats/warden/police/patrol
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/cowboyhat_sec
	name = "Security Cattleman Hat"
	item_path = /obj/item/clothing/head/cowboy/nova/cattleman/sec
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/cowboyhat_secwide
	name = "Security Cattleman Hat - Wide-Brimmed"
	item_path = /obj/item/clothing/head/cowboy/nova/cattleman/wide/sec
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/ushanka/sec
	name = "Security Ushanka"
	item_path = /obj/item/clothing/head/costume/ushanka/sec
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/cybergoggles //Cyberpunk-P.I. Outfit
	name = "Detective's Type-34P Forensics Headwear"
	item_path = /obj/item/clothing/head/fedora/det_hat/cybergoggles
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/head/detfedora
	name = "Detective's Fedora"
	item_path = /obj/item/clothing/head/fedora/det_hat
	restricted_roles = list(JOB_DETECTIVE)
	group = "Job-Locked"

/datum/loadout_item/head/rabbit/playbunny
	name = "Playbunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/cc
	name = "CentCom Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/centcom
	restricted_roles = list(ALL_JOBS_CC)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/usa
	name = "American Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/usa
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/ussr
	name = "Soviet Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/communist
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/brit
	name = "British Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/british
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/cap
	name = "Captain Bunny Ears"
	item_path = /obj/item/clothing/head/hats/caphat/bunnyears_captain
	restricted_roles = (JOB_CAPTAIN)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/qm
	name = "Quartermaster Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/quartermaster
	restricted_roles = (JOB_QUARTERMASTER)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/cargo
	name = "Cargo Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/cargo
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/mail
	name = "Courier Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/mailman
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/bitrun
	name = "Gamer's Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/bitrunner
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/engi
	name = "Engineer's Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/engineer
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/engi/atmos
	name = "Atmos Tech's Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/atmos_tech
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/engi/ce
	name = "Chief Engineer's Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/ce
	restricted_roles = (JOB_CHIEF_ENGINEER)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/med
	name = "Medical Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/doctor
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/med/para
	name = "Paramedical Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/paramedic
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/med/chem
	name = "Chemical Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/chemist
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/med/viro
	name = "Pathological Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/pathologist
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/med/coroner
	name = "Coroner Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/coroner
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/med/cmo
	name = "Chief Medical Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/cmo
	restricted_roles = (JOB_CHIEF_MEDICAL_OFFICER)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/rnd
	name = "Research Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/scientist
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/rnd/robo
	name = "Robotic Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/roboticist
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/rnd/gene
	name = "Genetic Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/geneticist
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/rnd/rd
	name = "Director Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/rd
	restricted_roles = (JOB_RESEARCH_DIRECTOR)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/sec
	name = "Secure Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/security
	group = "Costumes"

	name = "Less Secure Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/security/assistant
	restricted_roles = (ALL_JOBS_SEC)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/secdept
	name = "Less Secure Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/security/assistant
	restricted_roles = (ALL_JOBS_SEC)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/sec/warden
	name = "Secure Silver Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/warden
	restricted_roles = (JOB_WARDEN)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/sec/hos
	name = "Secure Gold Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/hos
	restricted_roles = (JOB_HEAD_OF_SECURITY)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/secmed
	name = "Secure Medical Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/brig_phys
	restricted_roles = (ALL_JOBS_SEC)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/secdet
	name = "Curious Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/detective
	restricted_roles = (JOB_DETECTIVE)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/sec/detnoir
	name = "Curious Noir Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/detective/noir
	restricted_roles = (JOB_DETECTIVE)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/prisoner
	name = "Locked Up Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/prisoner
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/hop
	name = "Hopping Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/hop
	restricted_roles = (JOB_HEAD_OF_PERSONNEL)
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/bar
	name = "Drunk Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/bartender
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/jani
	name = "Clean Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/janitor
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/chef
	name = "Hungry Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/cook
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/hydro
	name = "Botanical Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/botanist
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/clown
	name = "Funny Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/clown
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/mime
	name = "Quiet Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/mime
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/chaplain
	name = "Holy Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/chaplain
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/curator/red
	name = "Nerdy Red Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/curator_red
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/curator/green
	name = "Nerdy Green Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/curator_green
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/curator/teal
	name = "Nerdy Green Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/curator_teal
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/lawyer/black
	name = "Lawful Black Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_black
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/lawyer/blue
	name = "Lawful Blue Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_blue
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/lawyer/red
	name = "Lawful Red Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_red
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/lawyer/good
	name = "Lawful Good Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/lawyer_good
	group = "Costumes"

/datum/loadout_item/head/rabbit/playbunny/psych
	name = "Shrink's Bunny Ears"
	item_path = /obj/item/clothing/head/playbunnyears/psychologist
	group = "Costumes"

/*
*	erp_item
*/

/datum/loadout_item/head/domina_cap
	name = "Dominant Cap"
	item_path = /obj/item/clothing/head/domina_cap
	erp_item = TRUE

/*
*	DONATOR
*/

/datum/loadout_item/head/donator
	abstract_type = /datum/loadout_item/head/donator
	donator_only = TRUE

/datum/loadout_item/head/donator/carbon_rose
	name = "Flower - Carbon Rose"
	item_path = /obj/item/grown/carbon_rose
	group = "Miscellaneous"

/datum/loadout_item/head/donator/fraxinella
	name = "Flower - Fraxinella"
	item_path = /obj/item/food/grown/poppy/geranium/fraxinella
	group = "Miscellaneous"

/datum/loadout_item/head/donator/rainbow_bunch
	name = "Flower - Rainbow Bunch"
	item_path = /obj/item/food/grown/rainbow_flower
	group = "Miscellaneous"

/datum/loadout_item/head/donator/rainbow_bunch/get_item_information()
	. = ..()
	.[FA_ICON_DICE] = TOOLTIP_RANDOM_COLOR
