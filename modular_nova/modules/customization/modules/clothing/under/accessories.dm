/obj/item/clothing/accessory/badge
	name = "detective's badge"
	desc = "Security Department detective's badge, made from gold."
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "badge"
	slot_flags = ITEM_SLOT_NECK
	attachment_slot = CHEST

	var/stored_name
	var/badge_string = "Corporate Security"

	drop_sound = 'modular_nova/master_files/sound/items/drop/ring.ogg'
	pickup_sound = 'modular_nova/master_files/sound/items/pickup/ring.ogg'

/obj/item/clothing/accessory/badge/old
	name = "faded badge"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	desc = "A faded badge, backed with leather. It bears the emblem of the Forensic division."
	icon_state = "goldbadge"

/obj/item/clothing/accessory/badge/proc/set_name(new_name)
	stored_name = new_name
	name = "[initial(name)] ([stored_name])"

/obj/item/clothing/accessory/badge/proc/set_desc(mob/living/carbon/human/H)

/obj/item/clothing/accessory/badge/attack_self(mob/user as mob)

	if(!stored_name)
		to_chat(user, "You polish your old badge fondly, shining up the surface.")
		set_name(user.real_name)
		return

	if(isliving(user))
		if(stored_name)
			user.visible_message(span_notice("[user] displays their [src.name].\nIt reads: [stored_name], [badge_string]."),span_notice("You display your [src.name].\nIt reads: [stored_name], [badge_string]."))
		else
			user.visible_message(span_notice("[user] displays their [src.name].\nIt reads: [badge_string]."),span_notice("You display your [src.name]. It reads: [badge_string]."))

/obj/item/clothing/accessory/badge/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(span_danger("[user] invades [M]'s personal space, thrusting [src] into their face insistently."),span_danger("You invade [M]'s personal space, thrusting [src] into their face insistently."))
		user.do_attack_animation(M)

// Sheriff Badge (toy)
/obj/item/clothing/accessory/badge/sheriff
	name = "sheriff badge"
	desc = "This town ain't big enough for the two of us, pardner."
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "sheriff"

/obj/item/clothing/accessory/badge/sheriff/attack_self(mob/user as mob)
	user.visible_message("[user] shows their sheriff badge. There's a new sheriff in town!",\
		"You flash the sheriff badge to everyone around you!")

/obj/item/clothing/accessory/badge/sheriff/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(span_danger("[user] invades [M]'s personal space, the sheriff badge into their face!."),span_danger("You invade [M]'s personal space, thrusting the sheriff badge into their face insistently."))
		user.do_attack_animation(M)

//.Holobadges.
/obj/item/clothing/accessory/badge/holo
	name = "holobadge"
	desc = "This glowing blue badge marks the holder as THE LAW."
	icon_state = "holobadge_lopland"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/badge/holo/cord
	name = "holobadge with lanyard"
	icon_state = "holobadge-cord"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	attachment_slot = NONE // it has a lanyard. you don't pin lanyards to your uniform, you wear them around your neck.

/obj/item/clothing/accessory/badge/holo/attack_self(mob/user as mob)
	if(!stored_name)
		to_chat(user, "Waving around a holobadge before swiping an ID would be pretty pointless.")
		return
	return ..()

/obj/item/clothing/accessory/badge/holo/emag_act(remaining_charges, mob/user)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "already cracked")
		return FALSE

	obj_flags |= EMAGGED
	balloon_alert(user, "security checks cracked!")
	to_chat(user, span_danger("You crack the holobadge security checks."))
	return TRUE

/obj/item/clothing/accessory/badge/holo/attackby(obj/item/object as obj, mob/user as mob)
	if(istype(object, /obj/item/card/id))

		var/obj/item/card/id/id_card = null

		if(istype(object, /obj/item/card/id))
			id_card = object

		if((ACCESS_SECURITY in id_card.access) || (obj_flags & EMAGGED))
			to_chat(user, "You imprint your ID details onto the badge.")
			set_name(user.real_name)
			badge_string = id_card.assignment
		else
			to_chat(user, "[src] rejects your insufficient access rights.")
		return
	return ..()

/obj/item/storage/box/holobadge
	name = "holobadge box"
	desc = "A box claiming to contain holobadges."

/obj/item/storage/box/holobadge/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	return

/obj/item/clothing/accessory/badge/holo/warden
	name = "warden's holobadge"
	desc = "A silver corporate security badge. Stamped with the words 'Warden.'"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "silverbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/clothing/accessory/badge/holo/hos
	name = "head of security's holobadge"
	desc = "An immaculately polished gold security badge. Labeled 'Head of Security.'"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "goldbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/clothing/accessory/badge/holo/detective
	name = "detective's holobadge"
	desc = "An immaculately polished gold security badge on leather. Labeled 'Detective.'"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "marshalbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/storage/box/holobadge/hos
	name = "holobadge box"
	desc = "A box claiming to contain holobadges."

/obj/item/storage/box/holobadge/hos/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo/warden(src)
	new /obj/item/clothing/accessory/badge/holo/detective(src)
	new /obj/item/clothing/accessory/badge/holo/detective(src)
	new /obj/item/clothing/accessory/badge/holo/hos(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	return

// The newbie pin
/obj/item/clothing/accessory/green_pin
	name = "green pin"
	desc = "A pin given to newly hired personnel on deck."
	icon_state = "green"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	attachment_slot = NONE
	/// Who the pin originally belonged to, for purposes of tracking hours of playtime left
	var/datum/weakref/owner_ref

/obj/item/clothing/accessory/green_pin/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ACCESSORY_ATTACHED, PROC_REF(on_pin_attached))

/obj/item/clothing/accessory/green_pin/proc/on_pin_attached(obj/item/clothing/accessory/source, obj/item/clothing/under/attached_to)
	SIGNAL_HANDLER

	var/mob/accessory_wearer = attached_to.loc
	if(isnull(owner_ref) && istype(accessory_wearer))
		owner_ref = WEAKREF(accessory_wearer)

// Double examining the person wearing the clothes will display the examine message of the pin
/obj/item/clothing/accessory/green_pin/accessory_equipped(obj/item/clothing/under/clothes, mob/living/user)
	RegisterSignal(user, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_examine))

/obj/item/clothing/accessory/green_pin/accessory_dropped(obj/item/clothing/under/clothes, mob/living/user)
	UnregisterSignal(user, COMSIG_ATOM_EXAMINE_MORE)

/// Adds the examine message to the clothes and mob.
/obj/item/clothing/accessory/green_pin/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	// Only show the examine message if we're close (2 tiles)
	if(!IN_GIVEN_RANGE(get_turf(user), get_turf(src), 2))
		return

	var/mob/living/carbon/human/owner = owner_ref?.resolve()
	if(isnull(owner))
		owner_ref = null

	// How many hours of playtime left until the green pin expires
	var/green_time_remaining = sanitize_integer((PLAYTIME_GREEN - owner.client?.get_exp_living(pure_numeric = TRUE) / 60), 0, (PLAYTIME_GREEN / 60))
	// Only show this if we have green time remaining
	var/green_time_remaining_text = ""
	if(green_time_remaining > 0)
		green_time_remaining_text = " It reads '[green_time_remaining] hour[green_time_remaining >= 2 ? "s" : ""].'"

	if(ismob(source))
		var/mob/living/carbon/human/human_wearer = source
		// Examining a mob wearing the clothes, wearing the pin will also show the message
		var/obj/item/clothing/attached_to = loc
		examine_list += "A green pin is attached to [human_wearer.p_their()] [attached_to.name][owner ? ", belonging to [owner]." : "."][green_time_remaining_text]"
	else
		examine_list += "A green pin is attached to [source][owner ? ", belonging to [owner]." : "."][green_time_remaining_text]"

/obj/item/clothing/accessory/green_pin/examine(mob/user)
	. = ..()
	var/mob/living/carbon/human/owner = owner_ref?.resolve()
	if(isnull(owner))
		owner_ref = null
		return

	// What is shown when a mob examines it.
	var/examine_text = "This belongs to [owner]."
	// How many hours of playtime left until the green pin expires
	var/green_time_remaining = sanitize_integer((PLAYTIME_GREEN - owner.client?.get_exp_living(pure_numeric = TRUE) / 60), 0, (PLAYTIME_GREEN / 60))
	if(green_time_remaining > 0)
		examine_text += (" It reads '[green_time_remaining] hour[green_time_remaining >= 2 ? "s" : ""].'")

	. += span_nicegreen(examine_text)

// Pride Pin Over-ride
/obj/item/clothing/accessory/pride
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	unique_reskin = list(
		"Rainbow Pride" = "pride",
		"Bisexual Pride" = "pride_bi",
		"Pansexual Pride" = "pride_pan",
		"Asexual Pride" = "pride_ace",
		"Non-binary Pride" = "pride_enby",
		"Transgender Pride" = "pride_trans",
		"Intersex Pride" = "pride_intersex",
		"Lesbian Pride" = "pride_lesbian",
		"Man-Loving-Man / Gay Pride" = "pride_mlm",
		"Genderfluid Pride" = "pride_genderfluid",
		"Genderqueer Pride" = "pride_genderqueer",
		"Aromantic Pride" = "pride_aromantic",
	)
	attachment_slot = NONE

// Accessory for Akula species, it makes them wet and happy! :)
/obj/item/clothing/accessory/vaporizer
	name = "\improper Stardress hydro-vaporizer"
	desc = "An expensive device manufactured for the civilian work-force of the Azulean military power. \
	Relying on an internal battery, the coil mechanism synthesizes a hydrogen oxygen mixture, \
	which can then be used to moisturize the wearer's skin. \n\n\
	<i>A label on its back warns about the potential dangers of electro-magnetic pulses.</i> \
	<b>ctrl-click</b> in-hand to hide the device while worn."
	icon_state = "wetmaker"
	base_icon_state = "wetmaker"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'
	obj_flags = UNIQUE_RENAME
	attachment_slot = NONE

/obj/item/clothing/accessory/vaporizer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)

/obj/item/clothing/accessory/vaporizer/item_ctrl_click(mob/user)
	. = ..()
	if(!ishuman(user))
		return CLICK_ACTION_BLOCKING
	var/mob/living/carbon/human/wearer = user
	if(wearer.get_active_held_item() != src)
		to_chat(wearer, span_warning("You must hold the [src] in your hand to do this!"))
		return CLICK_ACTION_BLOCKING
	if(icon_state == "[base_icon_state]")
		icon_state = "[base_icon_state]_hidden"
		worn_icon_state = "[base_icon_state]_hidden"
		balloon_alert(wearer, "hidden")
	else
		icon_state = "[base_icon_state]"
		worn_icon_state = "[base_icon_state]"
		balloon_alert(wearer, "shown")
	update_icon() // update that mf
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/accessory/vaporizer/emp_act(severity)
	. = ..()
	var/obj/item/clothing/under/attached_to = loc
	var/mob/living/carbon/human/wearer = attached_to.loc
	if(!istype(wearer) || !istype(attached_to))
		return
	var/turf/open/tile = get_turf(wearer)
	if(istype(tile))
		tile.atmos_spawn_air("[GAS_WATER_VAPOR]=50;[TURF_TEMPERATURE(1000)]")
	wearer.balloon_alert(wearer, "overloaded!")
	wearer.visible_message("<span class='danger'>[wearer] [wearer.p_their()] [src] overloads, exploding in a cloud of hot steam!</span>")
	wearer.set_jitter_if_lower(10 SECONDS)
	playsound(wearer, 'sound/effects/spray.ogg', 80)
	detach(attached_to) // safely remove wetsuit status effect
	qdel(src)

/*

Greyscaled medals
I need some help with more sprites for the different medals

HELP: I want to make a medal thats all roles combined of a department
EX: A medical medal if players reach 100+ hrs on each medical dept role individually
If someone could make it be able to track individual roles as well like for blueshield, I want it to track blueshield time only, that would be awesome!

I plan/hope to have thee medals be given on spawn as a "opt-in" for on spawn but also unlock themselves in the loadouts menu, not sure how hard that would be though

I plan to many more medals be time based like role/department based so people can show their dedications, and also having more unique situational medals that centcomm can issue, and so we have more medals to play with, as the department medals that could be rewarded are very very limiting

Note for Contributors/Maintainers, I did what I could to keep things robust and allow for as much customization as possible!, feel free to do what you can for your own accessories!
*/
// Base Medal, debug failsafe
/obj/item/clothing/accessory/nova/medal
	name = "Robust Debug Medal"
	desc = "Why the fuck do you have this????"
	icon_state = "DebugMedal"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#ff0000#ff9100#f2ff00#3cff00#00f2ff"
	greyscale_config = /datum/greyscale_config/nova_medal
	greyscale_config_worn = /datum/greyscale_config/nova_medal/worn

// Give this three of this medal to DS-2
/obj/item/clothing/accessory/nova/medal/syndintel
	name = "Medal of Espionage"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal awarded to those who show dedication to espionage for the syndicate"
	icon_state = "syndintel_medal"
	greyscale_colors = "#ff0000#ffff66#800000#c0c0c0"
	greyscale_config = /datum/greyscale_config/syndintel_medal
	greyscale_config_worn = /datum/greyscale_config/syndintel_medal/worn

// 500hr+ Timed Blueshield Medal
/obj/item/clothing/accessory/nova/medal/bs_time
	name = "Hollowed Shield Medal"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal of dedication for those who go above and beyond for the blueshields"
	icon_state = "bs_time"
	greyscale_colors = "#3399ff#ffff66#003399#ffffff"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// 500hr+ Timed Consultant Medal
/obj/item/clothing/accessory/nova/medal/ntc_time
	name = "Dedication to Beaurocracy"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal of dedication for those who go above and beyond in paperwork for nanotrasen"
	icon_state = "ntc_time"
	greyscale_colors = "#33cc33#ffff66#006600#ffffff"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// 500hr+ Timed Chief Medical Officer Medal
/obj/item/clothing/accessory/nova/medal/cmo_time
	name = "Guardian Scalple"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "cmo_time"
	greyscale_colors = "#00ccff#ffff66#336699#66ffff"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// 500hr+ Timed Research Director Medal
/obj/item/clothing/accessory/nova/medal/rd_time
	name = "Diligent Scientific Studies"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "rd_time"
	greyscale_colors = "#9933ff#ffff66#6600cc#cc99ff"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// 500hr+ Timed Captain Medal
/obj/item/clothing/accessory/nova/medal/cpt_time
	name = "Diligence of Captaincy"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "cpt_time"
	greyscale_colors = "#0099ff#ffff66#003399#ffff00"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// 500hr+ Timed Quartermaster Medal
/obj/item/clothing/accessory/nova/medal/qm_time
	name = "Golden Profit Margins"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "qm_time"
	greyscale_colors = "#cc9900#ffff66#996633#cc9900"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// 500hr+ Timed Chief Engineer Medal
/obj/item/clothing/accessory/nova/medal/ce_time
	name = "Golden Wrenches Medal"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "ce_time"
	greyscale_colors = "#ff9933#ffff66#cc6600#ffff00"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// 500hr+ Timed Head of Security Medal
/obj/item/clothing/accessory/nova/medal/hos_time
	name = "Golden Batons Medal"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "hos_time"
	greyscale_colors = "#0066ff#ffff66#003399#6699ff"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// Rewarded to players who are veterans of nova sector
/obj/item/clothing/accessory/nova/medal/nova_veteran
	name = "Medal of Dedication"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "nova_vet"
	greyscale_colors = "#9933ff#ffffff#9900ff#ffffff"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn

// Rewarded to players who are veterans of nova sector (having veteran status | NOT THE PLAYTIME VETERANCY)
/obj/item/clothing/accessory/nova/medal/hop_time
	name = "Efficient Beaurocracy"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "a medal showing your true dedications."
	icon_state = "hop_time"
	greyscale_colors = "#00cc00#ffff66#008000#99ff99"
	greyscale_config = /datum/greyscale_config/cmdtime_medal
	greyscale_config_worn = /datum/greyscale_config/cmdtime_medal/worn
