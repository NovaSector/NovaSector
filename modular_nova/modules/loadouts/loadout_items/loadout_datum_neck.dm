// LOADOUT ITEM DATUMS FOR THE NECK SLOT

/datum/loadout_category/neck
	tab_order = /datum/loadout_category/ears::tab_order + 1

/datum/loadout_item/neck/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.neck))
		.. ()
		return TRUE

/datum/loadout_item/neck/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.neck)
			LAZYADD(outfit.backpack_contents, outfit.neck)
		outfit.neck = item_path
	else
		outfit.neck = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/neck/face_scarf
	name = "Face Scarf (Colorable)"
	item_path = /obj/item/clothing/neck/face_scarf

/datum/loadout_item/neck/maid_neck_cover
	name = "Maid Neck Cover (Colorable)"
	item_path = /obj/item/clothing/neck/maid_neck_cover

/datum/loadout_item/neck/stethoscope
	name = "Stethoscope"
	item_path = /obj/item/clothing/neck/stethoscope

/datum/loadout_item/neck/tarkon_gauntlet
	name = "Tarkon Confidante Gauntlet"
	item_path = /obj/item/clothing/neck/security_cape/tarkon
	blacklisted_roles = list(ALL_JOBS_SEC, ALL_JOBS_COM, JOB_PRISONER)

/*
*	COLLARS
*/

/// THIN
/datum/loadout_item/neck/thinchoker
	name = "Choker"
	item_path = /obj/item/clothing/neck/collar

/datum/loadout_item/neck/collar
	name = "Collar (Tagged)"
	item_path = /obj/item/clothing/neck/collar/tagged

/datum/loadout_item/neck/cbellcollar
	name = "Collar (Cowbell)"
	item_path = /obj/item/clothing/neck/collar/cowbell

/datum/loadout_item/neck/bellcollar
	name = "Collar (Bell)"
	item_path = /obj/item/clothing/neck/collar/bell

/datum/loadout_item/neck/hcollar
	name = "Collar (Holo)"
	item_path = /obj/item/clothing/neck/collar/holocollar

/datum/loadout_item/neck/crosscollar
	name = "Collar (Cross)"
	item_path = /obj/item/clothing/neck/collar/cross

/// THICK
/datum/loadout_item/neck/choker
	name = "Choker (Thick)"
	item_path = /obj/item/clothing/neck/collar/thick

/datum/loadout_item/neck/thick_bellcollar
	name = "Collar (Bell, Thick)"
	item_path = /obj/item/clothing/neck/collar/thick/bell

/datum/loadout_item/neck/thick_cowbellcollar
	name = "Collar (Cowbell, Thick)"
	item_path = /obj/item/clothing/neck/collar/thick/cowbell

/datum/loadout_item/neck/thick_crosscollar
	name = "Collar (Cross, Thick)"
	item_path = /obj/item/clothing/neck/collar/thick/cross

/datum/loadout_item/neck/thick_holocollar
	name = "Collar (Holocollar, Thick)"
	item_path = /obj/item/clothing/neck/collar/thick/holocollar

/datum/loadout_item/neck/thick_collar
	name = "Collar (Thick)"
	item_path = /obj/item/clothing/neck/collar/thick/tagged

/// LEATHER
/datum/loadout_item/neck/leater_collar
	name = "Collar (Leather)"
	item_path = /obj/item/clothing/neck/collar/leather

/datum/loadout_item/neck/leather_bellcollar
	name = "Collar (Bell, Leather)"
	item_path = /obj/item/clothing/neck/collar/leather/bell

/datum/loadout_item/neck/leather_cowbellcollar
	name = "Collar (Cowbell, Leather)"
	item_path = /obj/item/clothing/neck/collar/leather/cowbell

/datum/loadout_item/neck/leather_crosscollar
	name = "Collar (Cross, Leather)"
	item_path = /obj/item/clothing/neck/collar/leather/cross

/datum/loadout_item/neck/leather_holocollar
	name = "Collar (Holocollar, Leather)"
	item_path = /obj/item/clothing/neck/collar/leather/holocollar

/datum/loadout_item/neck/leather_collar
	name = "Collar (Tagged, Leather)"
	item_path = /obj/item/clothing/neck/collar/leather/tagged

/// SPIKE
/datum/loadout_item/neck/spikecollar
	name = "Collar (Spiked)"
	item_path = /obj/item/clothing/neck/collar/spike

/*
*	SCARVES
*/

/datum/loadout_item/neck/scarf_greyscale
	name = "Scarf  (Colorable)"

/datum/loadout_item/neck/scarf_black
	name = "Scarf (Black)"
	item_path = /obj/item/clothing/neck/scarf/black
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_cyan
	name = "Scarf (Cyan)"
	item_path = /obj/item/clothing/neck/scarf/cyan
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_dark_blue
	name = "Scarf (Dark Blue)"
	item_path = /obj/item/clothing/neck/scarf/darkblue
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_green
	name = "Scarf (Green)"
	item_path = /obj/item/clothing/neck/scarf/green
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_pink
	name = "Scarf (Pink)"
	item_path = /obj/item/clothing/neck/scarf/pink
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_purple
	name = "Scarf (Purple)"
	item_path = /obj/item/clothing/neck/scarf/purple
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_red
	name = "Scarf (Red)"
	item_path = /obj/item/clothing/neck/scarf/red
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_orange
	name = "Scarf (Orange)"
	item_path = /obj/item/clothing/neck/scarf/orange
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_yellow
	name = "Scarf (Yellow)"
	item_path = /obj/item/clothing/neck/scarf/yellow
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_zebra
	name = "Scarf (Zebra)"
	item_path = /obj/item/clothing/neck/scarf/zebra
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_christmas
	name = "Scarf - Christmas"
	item_path = /obj/item/clothing/neck/scarf/christmas
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/greyscale_large
	name = "Scarf - Large  (Colorable)"

/datum/loadout_item/neck/scarf_red_striped
	name = "Scarf - Large (Red)"
	item_path = /obj/item/clothing/neck/large_scarf/red
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_blue_striped
	name = "Scarf - Large (Blue)"
	item_path = /obj/item/clothing/neck/large_scarf/blue
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_green_striped
	name = "Scarf - Large (Green)"
	item_path = /obj/item/clothing/neck/large_scarf/green
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/neck/scarf_infinity
	name = "Scarf - Infinity"
	item_path = /obj/item/clothing/neck/infinity_scarf

/*
*	TIES
*/

/datum/loadout_item/neck/necktie
	name = "Tie  (Colorable)"

/datum/loadout_item/neck/necktie_black
	name = "Tie (Black)"
	item_path = /obj/item/clothing/neck/tie/black

/datum/loadout_item/neck/necktie_blue
	name = "Tie (Blue)"
	item_path = /obj/item/clothing/neck/tie/blue

/datum/loadout_item/neck/necktie_red
	name = "Tie (Red)"
	item_path = /obj/item/clothing/neck/tie/red

/datum/loadout_item/neck/bowtie_black
	name = "Tie - Bow"
	item_path = /obj/item/clothing/neck/bowtie

/datum/loadout_item/neck/discoproper
	name = "Tie - Horrible"
	item_path = /obj/item/clothing/neck/tie/disco

/datum/loadout_item/neck/necktie_loose
	name = "Tie - Loose"

/datum/loadout_item/neck/necktie_disco
	name = "Tie - Ugly"

/datum/loadout_item/neck/bowtie
	name = "Tie - Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiewizard
	name = "Tie - Magical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/magician
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiecc
	name = "Tie - Centcom Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/centcom
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiesoviet
	name = "Tie - Soviet Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/communist
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtieblue
	name = "Tie - Blue Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/blue
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtienocap
	name = "Tie - Captain Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/captain
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiecargo
	name = "Tie - Cargo Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/cargo
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiemail
	name = "Tie - Courier Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/mailman
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiebitrunner
	name = "Tie - Gamer Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/bitrunner
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtieengi
	name = "Tie - Engineer Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/engineer
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtieengiatmos
	name = "Tie - Atmos Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/atmos_tech
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtieengice
	name = "Tie - Chief Engineer Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/ce
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiemed
	name = "Tie - Medical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/doctor
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiemedpara
	name = "Tie - Paramedical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/paramedic
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiemedchem
	name = "Tie - Chemical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/chemist
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiemedviro
	name = "Tie - Pathological Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/pathologist
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiemedcoroner
	name = "Tie - Coroner's Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/coroner
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiemedcmo
	name = "Tie - Chief Medical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/cmo
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiernd
	name = "Tie - Scientific Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/scientist
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtierndrobo
	name = "Tie - Robotical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/roboticist
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtierndgene
	name = "Tie - Genetical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/geneticist
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtierndrd
	name = "Tie - Director Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/rd
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiesec
	name = "Tie - Secure Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/security
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiesecdept
	name = "Tie - Less Secure Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/security_assistant
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiesecdept
	name = "Tie - Secure Medical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/brig_phys
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiesecdet
	name = "Tie - Curious Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/detective
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiesecprison
	name = "Tie - Criminal Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/prisoner
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiehop
	name = "Tie - Paper Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/hop
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiejanitor
	name = "Tie - Clean Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/janitor
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiebar
	name = "Tie - Drunk Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/bartender
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiecook
	name = "Tie - Hungry Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/cook
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtiehydro
	name = "Tie - Botanical Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/botanist
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtieclown
	name = "Tie - Large Bow Collar"
	item_path = /obj/item/clothing/neck/tie/clown

/datum/loadout_item/neck/rabbit
	name = "Rabbit Necklace"
	item_path = /obj/item/clothing/neck/bunny_pendant

/datum/loadout_item/neck/bowtielawyerblack
	name = "Tie - Black Lawful Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/lawyer_black
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtielawyerblue
	name = "Tie - Blue Lawful Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/lawyer_blue
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtielawyerred
	name = "Tie - Red Lawful Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/lawyer_red
	group = "Bunny Ties"

/datum/loadout_item/neck/bowtielawyergood
	name = "Tie - Lawful Good Bow Collar"
	item_path = /obj/item/clothing/neck/tie/bunnytie/lawyer_good
	group = "Bunny Ties"

/*
*	CAPES, CLOAKS, MANTLES, PONCHOS, SHROUDS, AND VEILS
*/

/datum/loadout_item/neck/long_cape
	name = "Cape - Long (Colorable)"
	item_path = /obj/item/clothing/neck/long_cape
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/robe_cape
	name = "Cape - Robed (Colorable)"
	item_path = /obj/item/clothing/neck/robe_cape
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/wide_cape
	name = "Cape - Wide (Colorable)"
	item_path = /obj/item/clothing/neck/wide_cape
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/gags_cloak
	name = "Cloak (Colorable)"
	item_path = /obj/item/clothing/neck/cloak/colourable
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/colonial_cloak
	name = "Colonial Cloak"
	item_path = /obj/item/clothing/neck/cloak/colonial
	group = "Cloaks and Shrouds"
	species_blacklist = list(SPECIES_TESHARI)

/datum/loadout_item/neck/coalition_police_cloak
	name = "Colonial Cloak - Coalition Police"
	item_path = /obj/item/clothing/neck/cloak/colonial/hc_police
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/mantle
	name = "Mantle"
	item_path = /obj/item/clothing/neck/mantle
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/gags_mantle
	name = "Mantle (Colorable)"
	item_path = /obj/item/clothing/neck/mantle/recolorable
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/gags_boat //This isn't actually a boatcloak (its way too short)
	name = "Mantle - Long (Colorable)"
	item_path = /obj/item/clothing/neck/cloak/colourable/boat
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/tesharian_mantle
	name = "Mantle - Tesharian"
	item_path = /obj/item/clothing/neck/tesharian_mantle
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/ponchocowboy
	name = "Poncho - Cowboy"
	item_path = /obj/item/clothing/neck/cowboylea
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/ranger_poncho_greyscale
	name = "Poncho - Ranger (Colorable)"
	item_path = /obj/item/clothing/neck/ranger_poncho
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/security_cape
	name = "Security Cape"
	item_path = /obj/item/clothing/neck/security_cape/shoulder
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/gags_shroud
	name = "Shroud (Colorable)"
	item_path = /obj/item/clothing/neck/cloak/colourable/shroud
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/gags_veil
	name = "Veil (Colorable)"
	item_path = /obj/item/clothing/neck/cloak/colourable/veil
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/shortcloak
	name = "Short Cloak (Colorable)"
	item_path = /obj/item/clothing/neck/greyscaled
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/seecloak
	name = "Seer Cloak (Colorable)"
	item_path = /obj/item/clothing/neck/greyscaled/seecloak
	group = "Cloaks and Shrouds"
	reskin_datum = /datum/atom_skin/seecloak

/datum/loadout_item/neck/matroncloak
	name = "Matron Cloak (Colorable)"
	item_path = /obj/item/clothing/neck/greyscaled/matroncloak
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/xylixcloak
	name = "Xylix Cloak (Colorable)"
	item_path = /obj/item/clothing/neck/greyscaled/xylixcloak
	group = "Cloaks and Shrouds"

/*
*	JOB-LOCKED
*/

//COM
/datum/loadout_item/neck/mantle_cap
	name = "Captain's Mantle"
	item_path = /obj/item/clothing/neck/mantle/capmantle
	restricted_roles = list(JOB_CAPTAIN)
	group = "Job-Locked"

/datum/loadout_item/neck/mantle_bs
	//Weird name, but the B in Blueshield alphabetically sorts and puts the Job-Locked group high in the loadout.
	//So don't add any B items to this group. Please.
	name = "Command Bodyguard's Mantle"
	item_path = /obj/item/clothing/neck/mantle/bsmantle
	restricted_roles = list(JOB_BLUESHIELD)
	group = "Job-Locked"

//SERV
/datum/loadout_item/neck/mantle_hop
	name = "Head of Personnel's Mantle"
	item_path = /obj/item/clothing/neck/mantle/hopmantle
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)
	group = "Job-Locked"

/datum/loadout_item/neck/mantle_chap
	name = "Chaplain's Cloak"
	item_path = /obj/item/clothing/neck/chaplain
	restricted_roles = list(JOB_CHAPLAIN)
	group = "Job-Locked"

/datum/loadout_item/neck/mantle_bchap
	name = "Chaplain's Cloak (Black)"
	item_path = /obj/item/clothing/neck/chaplain/black
	restricted_roles = list(JOB_CHAPLAIN)
	group = "Job-Locked"

//MED
/datum/loadout_item/neck/mantle_cmo
	name = "Chief Medical Officer's Mantle"
	item_path = /obj/item/clothing/neck/mantle/cmomantle
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)
	group = "Job-Locked"

//ENGI
/datum/loadout_item/neck/mantle_ce
	name = "Chief Engineer's Mantle"
	item_path = /obj/item/clothing/neck/mantle/cemantle
	restricted_roles = list(JOB_CHIEF_ENGINEER)
	group = "Job-Locked"

//SCI
/datum/loadout_item/neck/mantle_rd
	name = "Research Director's Mantle"
	item_path = /obj/item/clothing/neck/mantle/rdmantle
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)
	group = "Job-Locked"

//CARGO
/datum/loadout_item/neck/mantle_qm
	name = "Quartermaster's Mantle"
	item_path = /obj/item/clothing/neck/mantle/qm
	restricted_roles = list(JOB_QUARTERMASTER)
	group = "Job-Locked"

//SEC
/datum/loadout_item/neck/mantle_hos
	name = "Head of Security's Mantle"
	item_path = /obj/item/clothing/neck/mantle/hosmantle
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Guard"

/datum/loadout_item/neck/security_gauntlet
	name = "Guard Gauntlet"
	item_path = /obj/item/clothing/neck/security_cape/armplate
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_DEPTGUARD)
	group = "Guard"

/datum/loadout_item/neck/security_caped_gauntlet
	name = "Guard Caped Gauntlet (Colorable)"
	item_path = /obj/item/clothing/neck/security_cape/armplate_caped
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_DEPTGUARD)
	group = "Guard"

/datum/loadout_item/neck/security_cape
	name = "Guard Cape (Colorable)"
	item_path = /obj/item/clothing/neck/security_cape/shoulder
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_DEPTGUARD)
	group = "Guard"

/*
*	DONATOR
*/

/datum/loadout_item/neck/donator
	abstract_type = /datum/loadout_item/neck/donator
	donator_only = TRUE

/datum/loadout_item/neck/donator/mantle
	abstract_type = /datum/loadout_item/neck/donator/mantle

/datum/loadout_item/neck/donator/mantle/regal
	name = "Regal Mantle"
	item_path = /obj/item/clothing/neck/mantle/regal
	group = "Cloaks and Shrouds"
