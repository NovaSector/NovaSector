// Debug Encryption Key and Headset, still manually populates the channel list because I am not a real coder, just a denthead
/obj/item/encryptionkey/admin
	name = "\proper the subspace encryption key"
	desc = "Holding and looking at this little chip fills you with a sense of existential dread. The taste of metaknowledge fills your mouth. \
		It tastes salty. Like tears. Why do you know what tears taste like? \
		You're a badmin, of course you know what tears taste like. Those of your coworkers taste better."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "captain"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	post_init_icon_state = "cypherkey_cube"
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_AI_PRIVATE = 1, RADIO_CHANNEL_CENTCOM = 1, RADIO_CHANNEL_CTF_BLUE = 1, RADIO_CHANNEL_CTF_GREEN = 1, RADIO_CHANNEL_CTF_RED = 1, RADIO_CHANNEL_CTF_YELLOW = 1, RADIO_CHANNEL_CYBERSUN = 1, RADIO_CHANNEL_ENTERTAINMENT = 1, RADIO_CHANNEL_FACTION = 1, RADIO_CHANNEL_GUILD = 1, RADIO_CHANNEL_INTERDYNE = 1, RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_TARKON = 1, RADIO_CHANNEL_SYNDICATE = 1, RADIO_CHANNEL_UPLINK = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2b2793#dca01b"

/obj/item/radio/headset/admin
	name = "bluespace headset"
	desc = "You can hear all of them. All oF THEM. THE VOICES. SO MANY VOICES. AAAAAAAAAA-"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = 'blue-headset'
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = 'blue-headset'
	keyslot2 = null
	keyslot = /obj/item/encryptionkey/admin
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	w_class = WEIGHT_CLASS_TINY

/obj/item/radio/headset/headset/admin/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, EAR_PROTECTION_HEAVY)

/obj/item/radio/headset/admin/subspace
	name = "subspace headset"
	desc = "You can hear all of them. All oF THEM. THE VOICES. SO MANY VOICES. AAAAAAAAAA-"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = 'sub-headset'
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = 'sub-headset'

//Hey check out this cancerous atompath.
//Squishes together Syndie Thermal Xrays, Debug Goggles, and the Engine Admin glasses.
//The one set of lenses to rule them all
/obj/item/clothing/glasses/meson/engine/admin/debug//code\modules\clothing\glasses\engine_goggles.dm & code\modules\clothing\glasses\_glasses.dm
	name = "subspace contacts"
	desc = "One of Central Command's best kept secrets, resting on the eyes of many of its officers, operatives, and technicians."
	desc_controls = "Ctrl + Click to toggle xray and thermals. Use the action button to change goggle modes."
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "contacts"
	inhand_icon_state = "contacts"
	worn_icon_state = "null"
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	glass_colour_type = FALSE
	clothing_traits = list(
		TRAIT_REAGENT_SCANNER,
		TRAIT_MADNESS_IMMUNE,
		TRAIT_MEDICAL_HUD,
		TRAIT_SECURITY_HUD,
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_BOT_PATH_HUD,
		TRAIT_NEARSIGHTED_CORRECTED
	)
	var/xray = FALSE
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP


//I am sorry for I must initialize and recreate procs or the drip will suffer, these goggles are too ugly
/obj/item/clothing/glasses/meson/engine/admin/debug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -15)

//Please stop updating icon states, youre ugly
/obj/item/clothing/glasses/meson/engine/admin/debug/update_icon_state()
	return

/obj/item/clothing/glasses/meson/engine/admin/debug/click_ctrl(mob/user)
	if(!ishuman(user))
		return CLICK_ACTION_BLOCKING
	if(xray)
		vision_flags &= ~(SEE_TURFS|SEE_MOBS|SEE_OBJS)
		detach_clothing_traits(TRAIT_XRAY_VISION)
	else
		vision_flags |= (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		attach_clothing_traits(TRAIT_XRAY_VISION)
	xray = !xray
	var/mob/living/carbon/human/human_user = user
	human_user.update_sight()
	return CLICK_ACTION_SUCCESS

// Admin Helmet
// We love casting spells. Did you know the perceptomatrix counts for spell clothing? Aint that neat.
/obj/item/clothing/head/helmet/perceptomatrix/admin
	name = "bluespace visor"
	desc = "You can hear all of them. All oF THEM. THE VOICES. SO MANY VOICES. AAAAAAAAAA-"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = 'blue-visor'
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = 'blue-visor'

//Now we get really magical.
/obj/item/clothing/head/helmet/perceptomatrix/admin/subspace
	name = "subspace visor"
	desc = "You can hear all of them. All oF THEM. THE VOICES. SO MANY VOICES. AAAAAAAAAA-"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = 'sub-visor'
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = 'sub-visor'

//Debug Gas Mask
//Creates a new debug filter
//code\modules\clothing\masks\gas_filter.dm
/obj/item/gas_filter/admin
	filter_status = 1000
	filter_strength_high = 10
	filter_efficiency = 1
	high_filtering_gases = list(
		/datum/gas/bz,
		/datum/gas/carbon_dioxide,
		/datum/gas/freon,
		/datum/gas/goblin,
		/datum/gas/halon,
		/datum/gas/healium,
		/datum/gas/hypernoblium,
		/datum/gas/miasma,
		/datum/gas/nitrous_oxide,
		/datum/gas/plasma,
		/datum/gas/proto_nitrate,
		/datum/gas/tritium,
		/datum/gas/zauker,
		)

//code\modules\clothing\masks\gasmask.dm
//TODO:bst/sst/cc icon variants
/obj/item/clothing/mask/gas/atmos/admin
	name = "subspace gas mask"
	desc = "A proprietary filtration mask which route gasses that CentCom deems toxic directly into the space between dimensions.\
	Wasteful? Totally. Convenient? Extremely."
	icon_state = "gas_atmos"
	inhand_icon_state = "gas_atmos"
	resistance_flags = FIRE_PROOF
	max_filters = 2
	starting_filter_type = /obj/item/gas_filter/debug
	fishing_modifier = 0
	armor_type = /datum/armor/debug

// New admin undersuit
// todo: BST, CC Variants, Casualmin Variants, or.... Maybe we setup skins for this?
/obj/item/clothing/under/admin
	name = "bluespace techsuit"
	desc = "A perfectly tailored and customized skin suit made specifically for this technician. \
	Composed of experimental textiles, and assembled with the legendary Bluespace Sewing Machine, it fits the body with perfect comfort, and carries an air of security."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = 'blue-techsuit'
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = 'blue-techsuit'
	inhand_icon_state = null
	has_sensor = NO_SENSORS//admin techs should NEVER be on sensors
	resistance_flags = FIRE_PROOF | ACID_PROOF
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/debug
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT

/obj/item/clothing/under/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -25)

/obj/item/clothing/under/admin/subspace
	name = "subspace techsuit"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = 'sub-techsuit'
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = 'sub-techsuit'

//Subspace gloves
/obj/item/clothing/gloves/tackler/admin
	name = "bluespace gauntlets"
	desc = "Extraordinarily lightweight and pleasantly comfortable gauntlets packed full of useful technology. You feel perfectly capable of defending yourself."
	siemens_coefficient = 0
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	clothing_traits = list(TRAIT_FAST_CUFFING)
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "blue-gauntlets"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	armor_type = /datum/armor/debug/badmin

/obj/item/clothing/gloves/tackler/debug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/kaza_ruk)

/obj/item/clothing/gloves/tackler/admin/subspace
	name = "subspace gauntlets"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "sub-gauntlets"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'

//Debug magbooties
/obj/item/clothing/shoes/magboots/advance/admin//code\modules\clothing\shoes\magboots.dm
	name = "bluespace magboots"
	desc = "Exotic hand manufactured booties made of the finest alloys the Frontier has to offer. The bluespace crystals powering each boot gleam threateningly."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	base_icon_state = "blue-magboots"
	icon_state = "blue-magboots0"// My first icon, I am very sorry. This should probably be replaced, but watch it just stick around for a long time.
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	slowdown_active = -0.25
	magpulse_fishing_modifier = 10
	fishing_modifier = 10
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/debug

/obj/item/clothing/shoes/magboots/advance/admin/Initialize(mapload)// Give them pockets, damnit
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/debug)//big pockets,,,
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/magboots/advance/admin/subspace
	name = "subspace magboots"
	desc = "Exotic hand manufactured booties made of the finest alloys the Frontier has to offer. The bluespace crystals powering each boot gleam threateningly."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	base_icon_state = "sub-magboots"
	icon_state = "sub-magboots0"// My first icon, I am very sorry. This should probably be replaced, but watch it just stick around for a long time.
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'


// Bussy berets, using an old CC beret with built in greyscaling as our foundation
/obj/item/clothing/head/helmet/space/beret/admin//code\modules\clothing\spacesuits\specialops.dm
	name = "tech's beret"
	desc = "An armored beret commonly used by administratively deployed techs. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#303030ff#FFCE5B"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	armor_type = /datum/armor/debug
	resistance_flags = FIRE_PROOF | ACID_PROOF
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/helmet/space/beret/admin/bluespace
	name = "bluespace tech's beret"
	desc = "An armored beret commonly used by special operations officers. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#00289F#FFCE5B"

/obj/item/clothing/head/helmet/space/beret/admin/subspace
	name = "subspace tech's beret"
	desc = "An armored beret commonly used by special operations officers. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#C68EEF#FFCE5B"

// Flannel armor. Fight me.
/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/admin//modular_nova\modules\customization\modules\clothing\under\utility_port\suits_port.dm
	armor_type = /datum/armor/debug
	name = "tech's flannel"
	desc = "Comfortable. Comforting. Gives warmer hugs than VSC ever code."
	greyscale_colors = "#303030ff"


