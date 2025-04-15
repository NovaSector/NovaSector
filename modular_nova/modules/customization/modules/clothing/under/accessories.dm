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
	icon_state = "holobadge"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/badge/holo/blue
	name = "blue holobadge"
	desc = "This glowing blue badge marks the holder as THE LAW."
	icon_state = "holobadge_blue"

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

If someone could make it be able to track individual roles as well like for blueshield, I want it to track blueshield time only, that would be awesome!
I plan/hope to have thee medals be given on spawn as a "opt-in" for on spawn but also unlock themselves in the loadouts menu, not sure how hard that would be though
I plan to many more medals be time based like role/department based so people can show their dedications, and also having more unique situational medals that centcomm can issue, and so we have more medals to play with, as the department medals that could be rewarded are very very limiting
Note for Contributors/Maintainers, I did what I could to keep things robust and allow for as much customization as possible!, feel free to do what you can for your own accessories!

*/
// Awardable medals
/obj/item/clothing/accessory/medal/nova
	name = "medal of honors"
	desc = "awarded by members of central command, this medal is a commendation for individuals with the highest honors."
	icon_state = "debugmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF#CCCED1#A5A9B6#757283#257283"
	greyscale_config = /datum/greyscale_config/nova_medal
	greyscale_config_worn = /datum/greyscale_config/nova_medal/worn

// DS-2/Syndicate Medals
/obj/item/clothing/accessory/medal/nova/syndicate
	name = "syndicate medal of Robustness"
	desc = "A medal dedicated to true syndicate agents for robustness in many fields"
	icon_state = "medal_robust"
	greyscale_colors = "#a50021#ffff66#990000#ffffff"
	greyscale_config = /datum/greyscale_config/syndi_medal
	greyscale_config_worn = /datum/greyscale_config/syndi_medal/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/medal/nova/syndicate/espionage
	name = "syndicate medal of Espionage"
	desc = "A medal dedicated to those who have proven themselves capable at covert operations."
	icon_state = "medal_espi"

/obj/item/clothing/accessory/medal/nova/syndicate/interrogation
	name = "syndicate medal of Interrogation"
	desc = "A medal dedicated to those who have proven themselves capable at interrogating even the most resilient members of an enemy corporation"
	icon_state = "medal_inter"

/obj/item/clothing/accessory/medal/nova/syndicate/intelligence
	name = "syndicate medal of Intelligence"
	desc = "A medal dedicated to those who"
	icon_state = "medal_intel"

/obj/item/clothing/accessory/medal/nova/syndicate/diligence
	name = "syndicate medal of Diligence"
	desc = "A medal dedicated to those who"
	icon_state = "medal_dili"

/obj/item/clothing/accessory/medal/nova/syndicate/communications
	name = "syndicate medal of Communication"
	desc = "A medal dedicated to those whom prove themselvese as capable counter-communications specialists"
	icon_state = "medal_comms"

// Accesory Medals (Medals that are accessories, Added acc_medal so people wont get confused)
/obj/item/clothing/accessory/nova/acc_medal
	name = "medal of colors"
	desc = "A canvas covered in many colors this medal has no meaning to it. But artists claim meaning is present, perhaps only those who've enlightened themselves may find the truth"
	icon_state = "debugmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF#CCCED1#A5A9B6#757283#257283"
	greyscale_config = /datum/greyscale_config/nova_medal
	greyscale_config_worn = /datum/greyscale_config/nova_medal/worn

/obj/item/clothing/accessory/nova/acc_medal/specialpins
	name = "\improper NT company neckpin"
	desc = "A pin specially dedicated to show loyalty to your company!"
	icon_state = "ntpin"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#FFFFFF#CCCED1"
	greyscale_config = /datum/greyscale_config/specialpins
	greyscale_config_worn = /datum/greyscale_config/specialpins/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/specialpins/syndicate
	name = "\improper Syndicate neckpin"
	desc = "A pin specially dedicated to show loyalty to the Syndicate!"
	icon_state = "syndipin"
	greyscale_colors = "#262626#9c0000"

/obj/item/clothing/accessory/nova/acc_medal/specialpins/solfed911
	name = "\improper Solfed 911 neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "911pin"

/obj/item/clothing/accessory/nova/acc_medal/specialpins/solfed811
	name = "\improper Solfed 811 neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "811pin"

/obj/item/clothing/accessory/nova/acc_medal/specialpins/solfed
	name = "\improper Solfed neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "sfpin"

/obj/item/clothing/accessory/nova/acc_medal/specialpins/interdyne
	name = "\improper Interdyne neckpin"
	desc = "A pin specially dedicated to show loyalty to your company!"
	icon_state = "ippin"
	greyscale_colors = "#FFFFFF#3aba1e"

/obj/item/clothing/accessory/nova/acc_medal/specialpins/porttarkon
	name = "\improper Port Tarkon neckpin"
	desc = "A pin specially dedicated to show loyalty to your company!"
	icon_state = "ptpin"

/obj/item/clothing/accessory/nova/acc_medal/specialpins/centcomm
	name = "\improper Central Command neckpin"
	desc = "A pin specially dedicated to show loyalty to your company!"
	icon_state = "ccpin"

// All special heart medals
/obj/item/clothing/accessory/nova/acc_medal/specheart
	name = "special heart medal"
	desc = "A regular everyday medal."
	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff"
	greyscale_config = /datum/greyscale_config/specheart
	greyscale_config_worn = /datum/greyscale_config/specheart/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/specheart/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/specheart/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/specheart/bars_ribbon
	icon_state = "medalbars"
// All regular heart medals
/obj/item/clothing/accessory/nova/acc_medal/regheart
	name = "heart medal"
	desc = "A regular everyday medal."
	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff"
	greyscale_config = /datum/greyscale_config/regheart
	greyscale_config_worn = /datum/greyscale_config/regheart/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/regheart/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/regheart/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/regheart/bars_ribbon
	icon_state = "medalbars"
// All hollow shields medals
/obj/item/clothing/accessory/nova/acc_medal/hollowshield
	name = "hollowed shield medal"
	desc = "A regular everyday medal."
	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff"
	greyscale_config = /datum/greyscale_config/hollowshield
	greyscale_config_worn = /datum/greyscale_config/hollowshield/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/hollowshield/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/hollowshield/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/hollowshield/bars_ribbon
	icon_state = "medalbars"

// Bar medals
/obj/item/clothing/accessory/nova/acc_medal/bbar
	name = "bar medal"
	desc = "A regular everyday medal."
	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff"
	greyscale_config = /datum/greyscale_config/blankbar
	greyscale_config_worn = /datum/greyscale_config/blankbar/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/bbar/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/bbar/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/bbar/bars_ribbon
	icon_state = "medalbars"

// Regular Crown
/obj/item/clothing/accessory/nova/acc_medal/crown
	name = "crown medal"
	desc = "A regular everyday medal."
	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff"
	greyscale_config = /datum/greyscale_config/crown
	greyscale_config_worn = /datum/greyscale_config/crown/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/crown/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/crown/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/crown/bars_ribbon
	icon_state = "medalbars"

// Hollow crown
/obj/item/clothing/accessory/nova/acc_medal/crown/hollow
	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff#ff99ff"
	greyscale_config = /datum/greyscale_config/hollowcrown
	greyscale_config_worn = /datum/greyscale_config/hollowcrown/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/crown/hollow/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/crown/hollow/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/crown/hollow/bars_ribbon
	icon_state = "medalbars"

// Hollow Circle medals


	icon_state = "medalbars"

// Circle medals
/obj/item/clothing/accessory/nova/acc_medal/circle
	name = "circle medal"
	desc = "A regular everyday medal."
	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff"
	greyscale_config = /datum/greyscale_config/circle
	greyscale_config_worn = /datum/greyscale_config/circle/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/circle/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/circle/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/circle/bars_ribbon
	icon_state = "medalbars"

/// Hollow Circle Variant
/obj/item/clothing/accessory/nova/acc_medal/circle/hollow

	icon_state = "ccmedal"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff#ffffff#9900cc#ffffff"
	greyscale_config = /datum/greyscale_config/hollowcircle
	greyscale_config_worn = /datum/greyscale_config/hollowcircle/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/circle/hollow/arrow_ribbon
	icon_state = "medalarrow"

/obj/item/clothing/accessory/nova/acc_medal/circle/hollow/hollow_ribbon
	icon_state = "medalhollow"

/obj/item/clothing/accessory/nova/acc_medal/circle/hollow/bars_ribbon


// Glow necklaces
/obj/item/clothing/accessory/nova/acc_medal/glowbar
	name = "glowbar necklace"
	desc = "A regular everyday medal."
	icon_state = "necklace"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff"
	greyscale_config = /datum/greyscale_config/glowbar
	greyscale_config_worn = /datum/greyscale_config/glowbar/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/glowcrystal
	name = "glowbarcrystal necklace"
	desc = "A regular everyday medal."
	icon_state = "necklace"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	greyscale_colors = "#ff99ff"
	greyscale_config = /datum/greyscale_config/glowcrystal
	greyscale_config_worn = /datum/greyscale_config/glowcrystal/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE

// Rank pins
/obj/item/clothing/accessory/nova/acc_medal/rankpin
	name = "Rank Pin"
	// Filler Desc: Change Later (Other maintainers/contributors feel free to leave suggestions!)
	desc = "A pin showing off your rank"
	icon_state = "rank1"
	greyscale_colors = "#FFFFFF"
	greyscale_config = /datum/greyscale_config/rankpin
	greyscale_config_worn = /datum/greyscale_config/rankpin/worn

/obj/item/clothing/accessory/nova/acc_medal/rankpin/rankpinalt1
	icon_state = "rank2"

/obj/item/clothing/accessory/nova/acc_medal/rankpin/rankpinalt2
	icon_state = "rank3"

/*
Ribbon Accessories
*/

/obj/item/clothing/accessory/nova/ribbon
	name = "ribbon"
	desc = "A normal everyday ribbon."
	icon_state = "ribbon1"
	greyscale_colors = "#ffffff#664200#fff700"
	greyscale_config = /datum/greyscale_config/color_ribbon
	greyscale_config_worn = /datum/greyscale_config/color_ribbon/worn
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/nova/ribbon/ribbon_slash
	icon_state = "ribbon2"

/obj/item/clothing/accessory/nova/ribbon/ribbon_arrup
	icon_state = "ribbon3"

/obj/item/clothing/accessory/nova/ribbon/ribbon_line
	icon_state = "ribbon4"

/obj/item/clothing/accessory/nova/ribbon/ribbon_dual
	icon_state = "ribbon5"

/obj/item/clothing/accessory/nova/ribbon/ribbon_flat
	icon_state = "ribbon6"

/obj/item/clothing/accessory/nova/ribbon/ribbon_twotone
	icon_state = "ribbon7"

// flat ribbons
/obj/item/clothing/accessory/nova/military_ribbon
	name = "military ribbon"
	desc = "An average military ribbon"
	icon_state = "ribbon1"
	greyscale_colors = "#ff0000#04ff00#0008ff"
	greyscale_config = /datum/greyscale_config/military_ribbon
	greyscale_config_worn = /datum/greyscale_config/military_ribbon/worn

/obj/item/clothing/accessory/nova/military_ribbon/alt1
	icon_state = "ribbon2"

/obj/item/clothing/accessory/nova/military_ribbon/alt2
	icon_state = "ribbon3"
