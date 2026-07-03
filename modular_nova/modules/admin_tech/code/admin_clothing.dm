// knownbugs: contacts icon state fucky
// Debug Encryption Key and Headset, still manually populates the channel list because I am not a real coder, just a denthead

/// Admin encryption key with basically every channel
/obj/item/encryptionkey/admin
	name = "\proper the subspace encryption key"
	desc = "Holding and looking at this little chip fills you with a sense of existential dread. The taste of metaknowledge fills your mouth. \
		It tastes salty. Like tears. Why do you know what tears taste like? \
		You're a badmin, of course you know what tears taste like. Those of your coworkers taste better."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "captain"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_AI_PRIVATE = 1,
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_CYBERSUN = 1,
		RADIO_CHANNEL_ENGINEERING = 1,
		RADIO_CHANNEL_ENTERTAINMENT = 1,
		RADIO_CHANNEL_FACTION = 1,
		RADIO_CHANNEL_GUILD = 1,
		RADIO_CHANNEL_INTERDYNE = 1,
		RADIO_CHANNEL_MEDICAL = 1,
		RADIO_CHANNEL_SCIENCE = 1,
		RADIO_CHANNEL_SECURITY = 1,
		RADIO_CHANNEL_SERVICE = 1,
		RADIO_CHANNEL_SOLFED = 1,
		RADIO_CHANNEL_SUPPLY = 1,
		RADIO_CHANNEL_SYNDICATE = 1,
		RADIO_CHANNEL_TARKON = 1,
		RADIO_CHANNEL_UPLINK = 1,
	)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2b2793#dca01b"

/obj/item/encryptionkey/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: balloon popup on ghost ping use
// TODO: revisit base model for vars to modify
/obj/item/radio/headset/admin
	name = "bluespace headset"
	desc = "You can hear all of them. All OF THEM. THE VOICES. SO MANY VOICES. AAAAAAAAAA-"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "blue-headset"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = "blue-headset"
	keyslot2 = null
	keyslot = /obj/item/encryptionkey/admin
	inhand_icon_state = "null"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	w_class = WEIGHT_CLASS_TINY
	/// A cache of ghosts orbiting this item
	var/list/mob/dead/observer/spirits
	/// Whether the debug-reach feature is currently toggled on
	var/active = FALSE
	/// Cooldown for pinging ghosts
	COOLDOWN_DECLARE(subspace_harmonic_signaller_cooldown)

/obj/item/radio/headset/admin/item_ctrl_click(mob/user)
	. = CLICK_ACTION_BLOCKING
	if(user.get_item_by_slot(slot_flags) != src)
		to_chat(user, span_warning("You need to be wearing [src] to toggle it."))
		return
	if(active)
		turn_off(user)
	else
		turn_on(user)
	return CLICK_ACTION_SUCCESS

/obj/item/radio/headset/admin/proc/turn_on(mob/user)
	active = TRUE
	ADD_TRAIT(user, TRAIT_ADMIN_REACHABLE, ADMIN_GEAR_TRAIT)
	ADD_TRAIT(user, TRAIT_MOVE_PHASING, ADMIN_GEAR_TRAIT)
	add_filter("admin_active_item", 1, outline_filter(1, "#cc00ff", OUTLINE_SQUARE))
	to_chat(user, span_notice("[src] tunnels through narrative continuity. Reach, interaction, and collision limits are bypassed."))
	update_appearance()

/obj/item/radio/headset/admin/proc/turn_off(mob/user)
	active = FALSE
	REMOVE_TRAIT(user, TRAIT_ADMIN_REACHABLE, ADMIN_GEAR_TRAIT)
	REMOVE_TRAIT(user, TRAIT_MOVE_PHASING, ADMIN_GEAR_TRAIT)
	remove_filter("admin_active_item")
	to_chat(user, span_notice("[src] powers down and returns you to a non-reality warping state."))
	update_appearance()

// Safety: don't leave the wearer permanently phasing/omniscient if the suit comes off mid-use
/obj/item/radio/headset/admin/dropped(mob/user, silent)
	. = ..()
	if(active)
		turn_off(user)

/obj/item/radio/headset/admin/doStrip(mob/user, mob/stripped_mob)
	. = ..()
	if(active)
		turn_off(stripped_mob)

/obj/item/radio/headset/admin/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, EAR_PROTECTION_HEAVY)
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Thank you, code\modules\mining\lavaland\mining_loot\megafauna\ash_drake.dm - /obj/item/melee/ghost_sword, very cool
/obj/item/radio/headset/admin/click_ctrl_shift(mob/user)//CtrlShift click as its a secondary function for this item.
	. = ..()
	if(!COOLDOWN_FINISHED(src, subspace_harmonic_signaller_cooldown))
		to_chat(user, span_warning("The subspace harmonic signaller is cooling down! Using this too frequently might upset the powers that be!"))
		return

	COOLDOWN_START(src, subspace_harmonic_signaller_cooldown, 15 SECONDS) // let's just assume the admin is responsible behind the wheel
	to_chat(user, span_notice("The subspace harmonic signaller charges up and releases a pulse, notifying all the eyes-between-spaces of your activities!"))
	notify_ghosts(
		"[user.real_name] has attenuated and pulsed the subspace harmonic signaller of [user.p_their()] [name], alerting the eyes-between-spaces of their activities!",
		source = user,
		ignore_key = POLL_IGNORE_SPECTRAL_BLADE, // we keep this because it's going to draw the same people—chronic observers
		header = name,
	)
	return CLICK_ACTION_SUCCESS

/obj/item/radio/headset/admin/process()
	ghost_check()

/obj/item/radio/headset/admin/proc/ghost_check()
	var/turf/cur_turf = get_turf(src)
	var/list/contents = cur_turf.get_all_contents()
	var/mob/dead/observer/current_spirits = list()
	for(var/atom/random_thing in contents)
		random_thing.transfer_observers_to(src)

	for(var/mob/dead/observer/ghost in orbiters?.orbiter_list)
		ghost.SetInvisibility(INVISIBILITY_NONE, id = type, priority = INVISIBILITY_PRIORITY_BASIC_ANTI_INVISIBILITY)
		current_spirits |= ghost

	for(var/mob/dead/observer/ghost in spirits - current_spirits)
		ghost.RemoveInvisibility(type)

	spirits = current_spirits
	return length(spirits)

/obj/item/radio/headset/admin/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Shift-Click while wearing to ping your subspace harmonic signaller, which will notify all observers to come orbit you.")

/obj/item/radio/headset/admin/subspace
	name = "subspace headset"
	icon_state = "sub-headset"
	worn_icon_state = "sub-headset"

//Hey check out this cancerous atompath.
//Squishes together Syndie Thermal Xrays, Debug Goggles, and the Engine Admin glasses.
//New trait code at modular_nova\master_files\code\datums\wires\_wires.dm to show all wires w/o needing to hold blueprints or abductor multitool
//The one set of lenses to rule them all
//todo: icon fuckery in procs. verify show wires trait is working.
/obj/item/clothing/glasses/meson/engine/admin/debug//code\modules\clothing\glasses\engine_goggles.dm & code\modules\clothing\glasses\_glasses.dm
	name = "subspace contacts"
	desc = "One of Central Command's best kept secrets, resting on the eyes of many of its officers, operatives, and technicians."
	desc_controls = "Ctrl + Click to toggle xray and thermals. Use the action button to change goggle modes."
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "contacts"
	inhand_icon_state = "contacts"
	worn_icon_state = "null"
	inhand_icon_state = "null"
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	invis_view = SEE_INVISIBLE_OBSERVER
	glass_colour_type = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	clothing_traits = list(
		TRAIT_SHOW_ALL_WIRES,
		TRAIT_REAGENT_SCANNER,
		TRAIT_MADNESS_IMMUNE,
		TRAIT_MEDICAL_HUD,
		TRAIT_SECURITY_HUD,
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_BOT_PATH_HUD,
		TRAIT_NEARSIGHTED_CORRECTED,
	)
	var/xray = FALSE
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/meson/engine/admin/debug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/clothing/glasses/meson/engine/admin/debug/click_ctrl_shift(mob/user)
	if(!ishuman(user))
		return CLICK_ACTION_BLOCKING
	if(xray)
		vision_flags &= ~(SEE_TURFS|SEE_MOBS|SEE_OBJS)
		detach_clothing_traits(TRAIT_XRAY_VISION)
		add_filter("admin_active_item", 1, outline_filter(1, "#cc00ff", OUTLINE_SQUARE))
	else
		vision_flags |= (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		attach_clothing_traits(TRAIT_XRAY_VISION)
		remove_filter("admin_active_item")
	xray = !xray
	var/mob/living/carbon/human/human_user = user
	human_user.update_sight()
	return CLICK_ACTION_SUCCESS

// Admin Helmet
// todo: add inspect blocking to phasing mode, add a visual.
// We love casting spells. Did you know the perceptomatrix counts for spell clothing? Aint that neat.
/obj/item/clothing/head/helmet/perceptomatrix/admin
	name = "bluespace visor"
	desc = "This exceptional piece of headgear seems to be one of the main reality-warping sources of the administrative kit. It feels nearly weightless on your head."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "blue-visor"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = "blue-visor"
	base_icon_state = "blue-visor"
	worn_icon_muzzled = "blue-visor"
	inhand_icon_state = "null"
	core_installed = TRUE
	armor_type = /datum/armor/admin
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/admin_phasing = FALSE

// Attempts to create a wall-phasing mode that you can enable with control clicking the helmet
/// Whether phasing is currently active
/obj/item/clothing/head/helmet/perceptomatrix/admin/item_ctrl_click(mob/user)
	if(!isliving(user))
		return CLICK_ACTION_BLOCKING

	// Must be worn, not just held
	var/mob/living/wearer = user
	if(wearer.get_slot_by_item(src) != ITEM_SLOT_HEAD)
		balloon_alert(user, "must be worn!")
		return CLICK_ACTION_BLOCKING

	admin_phasing = !admin_phasing
	if(admin_phasing)
		attach_clothing_traits(TRAIT_MOVE_PHASING)
		add_filter("admin_active_item", 1, outline_filter(1, "#cc00ff", OUTLINE_SQUARE))
	else
		detach_clothing_traits(TRAIT_MOVE_PHASING)
		remove_filter("admin_active_item")

	balloon_alert(user, "phasing [admin_phasing ? "enabled" : "disabled"]")
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/helmet/perceptomatrix/admin/dropped(mob/user)
	. = ..()
	if(admin_phasing)
		admin_phasing = FALSE
		// detach_clothing_traits is already called by the parent unequip logic, but we reset our state variable here

//Informs our silly staff that they can do this, if they bothered to inspect
/obj/item/clothing/head/helmet/perceptomatrix/admin/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Click while wearing to toggle phasing. Currently [admin_phasing ? "active" : "inactive"].")

//Intercepts init icon state from parent, this might not be necessary. It also might not be working right, I dont know enough to know.
/obj/item/clothing/head/helmet/perceptomatrix/admin/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/hat_stabilizer, loose_hat = FALSE)
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

//Now we get really magical.
/obj/item/clothing/head/helmet/perceptomatrix/admin/subspace
	name = "subspace visor"
	desc = "This exceptional piece of headgear seems to be one of the main reality-warping sources of the administrative kit. It feels nearly weightless on your head."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "sub-visor"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = "sub-visor"
	base_icon_state = "sub-visor"
	worn_icon_muzzled = "sub-visor"
	armor_type = /datum/armor/admin/badmin

//Admin Gas Mask
//Creates a new filter
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
/obj/item/clothing/mask/gas/atmos/admin
	name = "bluespace mask"
	desc = "A proprietary filtration mask which route gasses that CentCom deems toxic directly into the space between dimensions.\
	Wasteful? Totally. Convenient? Extremely."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "blue-mask"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = "blue-mask"
	inhand_icon_state = "null"
	resistance_flags = FIRE_PROOF
	max_filters = 2
	starting_filter_type = /obj/item/gas_filter/admin
	armor_type = /datum/armor/admin
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEARS|HIDEEYES|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | EARS_COVERED

/obj/item/clothing/mask/gas/atmos/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/clothing/mask/gas/atmos/admin/subspace
	name = "subspace mask"
	desc = "A proprietary filtration mask which route gasses that CentCom deems toxic directly into the space between dimensions.\
	Wasteful? Totally. Convenient? Extremely."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "sub-mask"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = "sub-mask"
	armor_type = /datum/armor/admin/badmin

// Glorious Stable Slime Management System
// Cytotheca is greek!
// todo: icons
/obj/item/storage/neck/admin/cytotheca
	name = "bluespace cytotheca"
	desc = "Why is it squishy?"
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/neck.dmi'
	icon = 'modular_nova/modules/tarkon/icons/obj/clothing/neck.dmi'
	icon_state = "armplate_shemaugh"
	slot_flags = ITEM_SLOT_NECK | ITEM_SLOT_POCKETS
	storage_type = /datum/storage/admin/cytotheca
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/admin_godmode = TRUE

/obj/item/storage/neck/admin/cytotheca/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Creates a storage on the cytotheca, which acts as our base level storage for stablizied slime cores to interact with our mob
// We populate with a subspace_pouch
/obj/item/storage/neck/admin/cytotheca/PopulateContents()
	new /obj/item/storage/subspace_pouch/cytotheca(src)

/obj/item/storage/neck/admin/cytotheca/dropped(mob/user)
	. = ..()
	if(!user)
		admin_godmode = FALSE
	REMOVE_TRAIT(user, TRAIT_GODMODE, REF(src))

/obj/item/storage/neck/admin/cytotheca/equipped(mob/user, slot, initial = TRUE)
	. = ..()
	if(admin_godmode)
		ADD_TRAIT(user, TRAIT_GODMODE, REF(user))
		add_filter("admin_active_item", 1, outline_filter(1, "#cc00ff", OUTLINE_SQUARE))

/// Whether godmode is currently active
/obj/item/storage/neck/admin/cytotheca/item_ctrl_click(mob/user)
	. = ..()
	if(!isliving(user))
		return CLICK_ACTION_BLOCKING

	// Must be worn, not just held
	var/mob/living/wearer = user
	if(wearer.get_slot_by_item(src) != ITEM_SLOT_NECK)
		balloon_alert(user, "must be worn!")
		return CLICK_ACTION_BLOCKING
	admin_godmode = !admin_godmode
	if(admin_godmode)
		ADD_TRAIT(wearer, TRAIT_GODMODE, REF(src))
		add_filter("admin_active_item", 1, outline_filter(1, "#cc00ff", OUTLINE_SQUARE))
	else
		REMOVE_TRAIT(wearer, TRAIT_GODMODE, REF(src))
		remove_filter("admin_active_item")
	balloon_alert(user, "godmode [admin_godmode ? "enabled" : "disabled"]")
	return CLICK_ACTION_SUCCESS

// Informs our silly staff that they can do this, if they bothered to inspect
/obj/item/storage/neck/admin/cytotheca/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Click while wearing to toggle godmode. Currently [admin_godmode ? "active" : "inactive"].")

// Special pouch full of stabilized slimes! This replaces the stabilized extracts box
/obj/item/storage/subspace_pouch/cytotheca
	icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
	name = "slimy subspace pouch"
	desc = span_notice("Gross. Click to open the pouch.")
	icon_state = "storage_pouch_icon"
	worn_icon_state = "storage_pouch_icon"
	storage_type = /datum/storage/admin/cytotheca

// Highway robbery off the stable slime box, idk if this is current for all available stables or not
/obj/item/storage/subspace_pouch/cytotheca/PopulateContents()
	new /obj/item/slimecross/stabilized/adamantine(src)
	new /obj/item/slimecross/stabilized/black(src)
	new /obj/item/slimecross/stabilized/blue(src)
	new /obj/item/slimecross/stabilized/bluespace(src)
	new /obj/item/slimecross/stabilized/cerulean(src)
	new /obj/item/slimecross/stabilized/darkblue(src)
	new /obj/item/slimecross/stabilized/darkpurple(src)
	new /obj/item/slimecross/stabilized/gold(src)
	new /obj/item/slimecross/stabilized/green(src)
	new /obj/item/slimecross/stabilized/grey(src)
	new /obj/item/slimecross/stabilized/lightpink(src)
	new /obj/item/slimecross/stabilized/metal(src)
	new /obj/item/slimecross/stabilized/oil(src)
	new /obj/item/slimecross/stabilized/orange(src)
	new /obj/item/slimecross/stabilized/pink(src)
	new /obj/item/slimecross/stabilized/purple(src)
	new /obj/item/slimecross/stabilized/pyrite(src)
	new /obj/item/slimecross/stabilized/rainbow(src)
	new /obj/item/slimecross/stabilized/red(src)
	new /obj/item/slimecross/stabilized/sepia(src)
	new /obj/item/slimecross/stabilized/silver(src)
	new /obj/item/slimecross/stabilized/yellow(src)

// Keeping it thematic
// todo: icon
/obj/item/storage/neck/admin/cytotheca/subspace
	name = "subspace cytotheca"
	desc = "How is this squishier?"
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/neck.dmi'
	icon = 'modular_nova/modules/tarkon/icons/obj/clothing/neck.dmi'
	icon_state = "armplate_shemaugh"

// New admin undersuit
/obj/item/clothing/under/admin
	name = "bluespace techsuit"
	desc = "A perfectly tailored and customized skin suit made specifically for this technician. \
	Composed of experimental textiles, and assembled with the legendary Bluespace Sewing Machine, it fits the body with perfect comfort, and carries an air of security."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "blue-techsuit"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = "blue-techsuit"
	worn_icon_digi = 'modular_nova/modules/admin_tech/icons/mob/clothing_digi.dmi'
	inhand_icon_state = "null"
	has_sensor = NO_SENSORS//admin techs should NEVER be on sensors
	resistance_flags = FIRE_PROOF | ACID_PROOF
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/admin
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT

//Gives the undersuit the ability to teleport.
//todo: apparently just doesnt work. fix this at some point.
//todo: non-restricted teleport_loc setup and new spell just for this. This'll do for now though.
/obj/item/clothing/under/admin/Initialize(mapload)
	. = ..()
	// In the future, this can be generalized into just "magic scrolls that give you a specific spell".
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
	var/datum/action/cooldown/spell/teleport/area_teleport = locate() in actions
	if(!area_teleport)
		return
	area_teleport.name = name
	area_teleport.button_icon = icon
	area_teleport.button_icon_state = icon_state

/obj/item/clothing/under/admin/subspace
	name = "subspace techsuit"
	icon_state = "sub-techsuit"
	worn_icon_state = "sub-techsuit"
	armor_type = /datum/armor/admin/badmin

//Admeme jackets. Oh so comfortable. And shiny
/obj/item/clothing/suit/admin
	name = "bluespace letterman"
	desc = "Hand-stitched by legendary tailors, these jackets are made specifically for each technician. Using the same advanced fabrics and techniques as the rest of their soft kit, the comfort of these coats is unrivaled."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "blue-jacket"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_state = "blue-jacket"
	worn_icon_digi = 'modular_nova/modules/admin_tech/icons/mob/clothing_digi.dmi'
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor_type = /datum/armor/admin
	strip_delay = 3 SECONDS
	equip_delay_other = 4 SECONDS
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/hit_reflect_chance = 50

/obj/item/clothing/suit/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/clothing/suit/admin/IsReflect(def_zone)
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/admin/subspace
	name = "subspace letterman"
	icon_state = "sub-jacket"
	worn_icon_state = "sub-jacket"
	armor_type = /datum/armor/admin/badmin
	hit_reflect_chance = 100

// Worlds most comfortable gloves, great for tickling spacetime
// todo: add actions_types fun spell casting mode with a toggle, similar to xray function toggle above
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
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/admin

/obj/item/clothing/gloves/tackler/admin/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/kaza_ruk)
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/clothing/gloves/tackler/admin/subspace
	name = "subspace gauntlets"
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	icon_state = "sub-gauntlets"
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	armor_type = /datum/armor/admin/badmin

//Debug magbooties
//Spacewalking toggle

/obj/item/clothing/shoes/magboots/advance/admin//code\modules\clothing\shoes\magboots.dm
	name = "bluespace magboots"
	desc = "Exotic hand manufactured booties made of the finest alloys the Frontier has to offer. The bluespace crystals powering each boot gleam threateningly."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	base_icon_state = "blue-magboots"
	icon_state = "blue-magboots0"// My first icon, I am very sorry. This should probably be replaced, but watch it just stick around for a long time.
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	worn_icon_digi = 'modular_nova/modules/admin_tech/icons/mob/clothing_digi.dmi'
	slowdown_active = -0.25
	magpulse_fishing_modifier = 10
	fishing_modifier = 10
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/admin
	var/admin_spacewalk = FALSE

/obj/item/clothing/shoes/magboots/advance/admin/item_ctrl_click(mob/user)
	if(!isliving(user))
		return CLICK_ACTION_BLOCKING

	// Must be worn, not just held
	var/mob/living/wearer = user
	if(wearer.get_slot_by_item(src) != ITEM_SLOT_FEET)
		balloon_alert(user, "must be worn!")
		return CLICK_ACTION_BLOCKING

	admin_spacewalk = !admin_spacewalk
	if(admin_spacewalk)
		attach_clothing_traits(TRAIT_SPACEWALK)
		add_filter("admin_active_item", 1, outline_filter(1, "#cc00ff", OUTLINE_SQUARE))
	else
		detach_clothing_traits(TRAIT_SPACEWALK)
		remove_filter("admin_active_item")

	balloon_alert(user, "spacewalking [admin_spacewalk ? "enabled" : "disabled"]")
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/shoes/magboots/advance/admin/dropped(mob/user)
	. = ..()
	if(admin_spacewalk)
		admin_spacewalk = FALSE
		// detach_clothing_traits is already called by the parent unequip logic,
		// but we reset our state variable here

/obj/item/clothing/shoes/magboots/advance/admin/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-click while wearing to toggle spacewalking. Currently [admin_spacewalk ? "active" : "inactive"].")

/obj/item/clothing/shoes/magboots/advance/admin/Initialize(mapload)// Give them pockets, damnit
	. = ..()
	create_storage(storage_type = /datum/storage/admin/pockets)//big pockets,,,
	AddElement(/datum/element/ignites_matches)
	AddComponent(/datum/component/squeak, list('sound/effects/jingle.ogg'=1), 25, 50, 16)
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/clothing/shoes/magboots/advance/admin/subspace
	name = "subspace magboots"
	desc = "Exotic hand manufactured booties made of the finest alloys the Frontier has to offer. The bluespace crystals powering each boot gleam threateningly."
	icon = 'modular_nova/modules/admin_tech/icons/obj/clothing.dmi'
	base_icon_state = "sub-magboots"
	icon_state = "sub-magboots0"// My first icon, I am very sorry. This should probably be replaced, but watch it just stick around for a long time.
	worn_icon = 'modular_nova/modules/admin_tech/icons/mob/clothing.dmi'
	armor_type = /datum/armor/admin/badmin
