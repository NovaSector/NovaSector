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

/datum/loadout_item/neck/maid
	name = "Maid Neck Cover"
	item_path = /obj/item/clothing/neck/maid

/datum/loadout_item/neck/maid_neck_cover
	name = "Maid Neck Cover (Colorable)"
	item_path = /obj/item/clothing/neck/maid_neck_cover

/datum/loadout_item/neck/stethoscope
	name = "Stethoscope"
	item_path = /obj/item/clothing/neck/stethoscope

/datum/loadout_item/neck/tarkon_gauntlet
	name = "Tarkon Confidante Gauntlet"
	item_path = /obj/item/clothing/neck/security_cape/tarkon
	blacklisted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_BLUESHIELD, JOB_CORRECTIONS_OFFICER)

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
	erp_item = TRUE

/*
*	SCARVES
*/

/datum/loadout_item/neck/scarf_greyscale
	name = "Scarf  (Colorable)"

/datum/loadout_item/neck/scarf_black
	name = "Scarf (Black)"
	item_path = /obj/item/clothing/neck/scarf/black
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_cyan
	name = "Scarf (Cyan)"
	item_path = /obj/item/clothing/neck/scarf/cyan
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_dark_blue
	name = "Scarf (Dark Blue)"
	item_path = /obj/item/clothing/neck/scarf/darkblue
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_green
	name = "Scarf (Green)"
	item_path = /obj/item/clothing/neck/scarf/green
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_pink
	name = "Scarf (Pink)"
	item_path = /obj/item/clothing/neck/scarf/pink
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_purple
	name = "Scarf (Purple)"
	item_path = /obj/item/clothing/neck/scarf/purple
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_red
	name = "Scarf (Red)"
	item_path = /obj/item/clothing/neck/scarf/red
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_orange
	name = "Scarf (Orange)"
	item_path = /obj/item/clothing/neck/scarf/orange
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_yellow
	name = "Scarf (Yellow)"
	item_path = /obj/item/clothing/neck/scarf/yellow
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_zebra
	name = "Scarf (Zebra)"
	item_path = /obj/item/clothing/neck/scarf/zebra
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_christmas
	name = "Scarf - Christmas"
	item_path = /obj/item/clothing/neck/scarf/christmas
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/greyscale_large
	name = "Scarf - Large  (Colorable)"

/datum/loadout_item/neck/scarf_red_striped
	name = "Scarf - Large (Red)"
	item_path = /obj/item/clothing/neck/large_scarf/red
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_blue_striped
	name = "Scarf - Large (Blue)"
	item_path = /obj/item/clothing/neck/large_scarf/blue
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/neck/scarf_green_striped
	name = "Scarf - Large (Green)"
	item_path = /obj/item/clothing/neck/large_scarf/green
	can_be_greyscale = DONT_GREYSCALE

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

/datum/loadout_item/neck/imperial_police_cloak
	name = "Colonial Cloak - Imperial Police"
	item_path = /obj/item/clothing/neck/cloak/colonial/nri_police
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
	item_path = /obj/item/clothing/neck/security_cape
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/gags_shroud
	name = "Shroud (Colorable)"
	item_path = /obj/item/clothing/neck/cloak/colourable/shroud
	group = "Cloaks and Shrouds"

/datum/loadout_item/neck/gags_veil
	name = "Veil (Colorable)"
	item_path = /obj/item/clothing/neck/cloak/colourable/veil
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
	group = "Job-Locked"

/datum/loadout_item/neck/security_gauntlet
	name = "Security Gauntlet"
	item_path = /obj/item/clothing/neck/security_cape/armplate
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Job-Locked"

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
