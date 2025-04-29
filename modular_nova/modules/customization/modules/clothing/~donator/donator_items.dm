//In the event someone needs one.
/obj/item/storage/box/donator
	name = "personal items box"
	desc = "It's full of things you brought from home."

//Donator reward for UltramariFox
/obj/item/cigarette/khi
	name = "\improper Kitsuhana Singularity cigarette"
	icon = 'modular_nova/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "khioff"
	icon_on = "khion"
	icon_off = "khioff"
	type_butt = /obj/item/cigbutt/khi
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/toxin/mindbreaker = 5)

/obj/item/cigbutt/khi
	icon = 'modular_nova/master_files/icons/obj/cigarettes_khi.dmi'
	icon_state = "khibutt"

/obj/item/storage/fancy/cigarettes/khi
	name = "\improper Kitsuhana Singularity packet"
	icon = 'modular_nova/master_files/icons/obj/cigarettes_khi.dmi'
	icon_state = "khi_cig_packet"
	base_icon_state = "khi_cig_packet"
	spawn_type = /obj/item/cigarette/khi

//Donator reward for Stonetear
/obj/item/hairbrush/switchblade
	name = "switchcomb"
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "switchblade"
	base_icon_state = "switchblade"
	desc = "A sharp, concealable, spring-loaded comb."
	hitsound = 'sound/items/weapons/genhit.ogg'
	resistance_flags = FIRE_PROOF
	var/extended = FALSE

/obj/item/hairbrush/switchblade/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_HANDS)

///This is called when you transform it
/obj/item/hairbrush/switchblade/attack_self(mob/user, modifiers)
	extended = !extended
	icon_state = "switchblade[extended ? "_on" : ""]"

	playsound(user || src, 'sound/items/weapons/batonextend.ogg', 30, TRUE)


/// This makes it so you have to extend it.
/obj/item/hairbrush/switchblade/attack(mob/target, mob/user)
	if(!extended)
		to_chat(user, span_warning("Try extending the blade first, silly!"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(target.stat == DEAD)
		to_chat(user, span_warning("There isn't much point brushing someone who can't appreciate it!"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	brush(target, user)

	return COMPONENT_CANCEL_ATTACK_CHAIN


#define TURN_DIAL 		0
#define TAP_SCREEN		1
#define PRESS_KEYS		2
#define EXTEND_ANTENNA	3
#define SLAP_SIDE		4

//Donation reward for Thedragmeme, avalible to craft publicly
/datum/crafting_recipe/stellar_bouquet
	name = "stellar bouquet"
	result = /obj/item/bouquet/stellar
	reqs = list(
		/obj/item/food/grown/poppy/lily = 2,
		/obj/item/food/grown/rose = 2,
		/obj/item/food/grown/poppy/geranium = 2,
		/obj/item/stack/sheet/mineral/silver = 1,
	)
	category = CAT_ENTERTAINMENT

/obj/item/donator/transponder
	name = "broken Helian transponder"
	desc = "Used by Helians to communicate with their mothership, the screen is cracked and its edges scuffed. This one has seen better days."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "transponder"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	var/datum/effect_system/spark_spread/sparks
	var/current_state = TURN_DIAL
	var/next_activate = 0

/obj/item/donator/transponder/Initialize(mapload)
	. = ..()
	sparks = new
	sparks.set_up(2, 0, src)
	sparks.attach(src)

/obj/item/donator/transponder/Destroy()
	if(sparks)
		qdel(sparks)
	sparks = null
	. = ..()

/obj/item/donator/transponder/attack_self(mob/user)
	if(QDELETED(src) || (next_activate > world.time))
		return FALSE

	add_fingerprint(user)

	switch(current_state)
		if(TURN_DIAL)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] As [user] turns the red dial on the side of \the [src], it spits out some encrypted static and warbles before silencing itself.",
				"[icon2html(src, user)] As you turn the red dial on the side of the device, it spits out some encrypted static and warbles before silencing itself.",
				vision_distance=2)
			playsound(user, 'modular_nova/master_files/sound/effects/bab1.ogg', 100, TRUE)
			sparks.start()
			current_state = TAP_SCREEN
			next_activate = world.time + 20
			return
		if(TAP_SCREEN)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] taps the screen of \the [src], making it light up and starting the boot sequence. \the [src] displays an error message and shuts off.",
				"[icon2html(src, user)] You tap the device's screen, making it light up and starting the boot sequence. The device displays an error message and shuts off.",
				vision_distance=2)
			playsound(user, 'modular_nova/master_files/sound/effects/platform_call.ogg', 100, TRUE)
			current_state = PRESS_KEYS
			next_activate = world.time + 20
			return
		if(PRESS_KEYS)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] presses some keys, producing some promising beeps, before a harsh buzz returns [src] to silence again.",
				"[icon2html(src, user)] You press some keys, producing some promising beeps, before a harsh buzz returns the device to silence again.",
				vision_distance=2)
			sparks.start()
			playsound(user, 'modular_nova/master_files/sound/effects/gmalfunction.ogg', 100, TRUE)
			current_state = EXTEND_ANTENNA
			next_activate = world.time + 20
			return
		if(EXTEND_ANTENNA)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] extends the antennae on \the [src], yielding a progress bar, but no amount of adjusting gets it to 100%. [user] returns them to normal.",
				"[icon2html(src, user)] You extend the antennae, yielding a progress bar, but no amount of adjusting gets it to 100%. You return them to normal.",
				vision_distance=2)
			current_state = SLAP_SIDE
			next_activate = world.time + 20
			return
		if(SLAP_SIDE)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] slaps the side of \the [src] and it whirrs into life, before thunking and remains still.",
				"[icon2html(src, user)] You slap the side of the device and it whirrs into life, before thunking and remaining still.",
				vision_distance=2)
			playsound(user, 'modular_nova/master_files/sound/effects/hacked.ogg', 100, TRUE)
			sparks.start()
			current_state = TURN_DIAL
			next_activate = world.time + 110
			return
		else
			current_state = TURN_DIAL
			next_activate = world.time + 20
			return

#undef TURN_DIAL
#undef TAP_SCREEN
#undef PRESS_KEYS
#undef EXTEND_ANTENNA
#undef SLAP_SIDE

// Donation rewards for SQNZTB
/obj/item/storage/box/donator/sqn

/obj/item/storage/box/donator/sqn/PopulateContents()
	new /obj/item/holosign_creator/hardlight_wheelchair(src)
	new /obj/item/nanite_leg_reinforcement(src)
	new /obj/item/lipstick/quantum/sqn(src)
	new /obj/item/clothing/glasses/hud/ar/projector/science/sqn(src)

/obj/vehicle/ridden/wheelchair/hardlight
	name = "hardlight wheelchair"
	desc = "A wheelchair made out of hardlight, propulsed by miniaturized bluespace technology."
	alpha = 150 // Just to help differentiate it from a real wheelchair, and to show that it's a bit squishier.
	max_integrity = 10 //standard wheelchairs have 100, motorized 150
	/// The projector associated with this wheelchair.
	/// Only used so that we can remove this wheelchair from it when it gets destroyed.
	var/obj/item/holosign_creator/projector = null
	foldabletype = null


/obj/vehicle/ridden/wheelchair/hardlight/Initialize(mapload, source_projector)
	. = ..()
	if(source_projector)
		projector = source_projector
		LAZYADD(projector.signs, src)


/obj/vehicle/ridden/wheelchair/hardlight/Destroy()
	if(projector)
		LAZYREMOVE(projector.signs, src)
		projector = null

	return ..()


/obj/vehicle/ridden/wheelchair/hardlight/post_unbuckle_mob()
	. = ..()

	visible_message(span_notice("[src] flickers and disappears as the hardlight emitters disengage."))
	qdel(src)


/obj/vehicle/ridden/wheelchair/hardlight/make_ridable()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/wheelchair/hardlight)


// Custom riding component for this wheelchair, so that it behaves properly.
/datum/component/riding/vehicle/wheelchair/hardlight/driver_move(obj/vehicle/vehicle_parent, mob/living/user, direction)
	var/delay_multiplier = 6.7 // magic number from wheelchair code
	//setting speed divisor to 3. original formula from the motorized chair code is:
	//vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) * delay_multiplier) / speed
	//this makes it slightly slower than a motorized wheelchair with t1 parts.
	vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) * delay_multiplier) / 3
	return ..()


// The actual item they will be using.
/obj/item/holosign_creator/hardlight_wheelchair
	name = "hardlight wheelchair emitter"
	desc = "An emitter which projects a ridable but fragile wheelchair made out of hardlight."
	icon_state = "signmaker_med"
	holosign_type = /obj/vehicle/ridden/wheelchair/hardlight
	max_signs = 1


/obj/item/holosign_creator/hardlight_wheelchair/examine(mob/user)
	. = ..()
	. += span_tinynoticeital("\n<i>There's something etched on the underside of the handle, you can look again to take a closer look...</i>")


/obj/item/holosign_creator/hardlight_wheelchair/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Etched underneath the handle is the following message:</i>\n")
	. += span_smallnoticeital("\"I told you I would find a way to make it all easier.\" - A.H.")


/datum/action/innate/nanite_leg_reinforcement
	name = "Toggle Leg Reinforcement"
	desc = "Gain the ability to stand temporarily."
	button_icon = 'icons/obj/clothing/shoes.dmi'
	button_icon_state = "jackboots"
	/// Type of the quirk we want to stash away.
	var/quirk_to_stash = /datum/quirk/paraplegic
	/// Reference to the quirk that was stashed away.
	var/datum/quirk/stashed_quirk

/datum/action/innate/nanite_leg_reinforcement/Activate()
	var/mob/living/living_owner = owner
	stashed_quirk = living_owner.get_quirk(quirk_to_stash)
	stashed_quirk.remove_from_current_holder(TRUE)
	active = TRUE

/datum/action/innate/nanite_leg_reinforcement/Deactivate()
	stashed_quirk.add_to_holder(owner, TRUE)
	stashed_quirk = null
	active = FALSE
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

/obj/item/nanite_leg_reinforcement
	name = "nanite leg reinforcement"
	desc = "Gives you the ability to channel your nanites into letting you stand for a time."
	icon = 'modular_nova/modules/modular_implants/icons/obj/nifs.dmi'
	icon_state = "base_nif"
	/// Which action this item grants you.
	var/action_to_grant = /datum/action/innate/nanite_leg_reinforcement

/obj/item/nanite_leg_reinforcement/attack_self(mob/user, modifiers)
	. = ..()
	var/mob/living/living_user = user
	if(!istype(user) || !living_user.has_quirk(/datum/quirk/paraplegic))
		to_chat(user, "You feel like [src] wouldn't be very helpful to you.")
		return
	var/datum/action/action = new action_to_grant(user)
	action.Grant(user)
	to_chat(user, "[src] vanishes in a puff of smoke!")
	qdel(src)

/obj/item/lipstick/quantum/sqn
	name = "\improper SW:10KK lipstick"
	desc = "Starlight Wanderers brand Ten Thousand Kisses lipstick with adjustable pigmentation. Guaranteed not to smudge, stain, or leave lip prints unless you want it to. This tube looks heavily used."

/obj/item/clothing/glasses/hud/ar/projector/science/sqn
	name = "micro-retinal display"
	desc = "A retinal display so small, it's invisible to everyone but you."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/misc.dmi'
	worn_icon_state = "gear_harness"

/obj/item/instrument/piano_synth/headphones/catear_headphone
	name = "Cat-Ear Headphones"
	desc = "Merch of their Electric Guitarist Demi Galgan from the Singularity Shredders. It's heavily customizable and even comes with a holographic tail!"
	icon_state = "catear_headphone"
	worn_icon = 'modular_nova/modules/GAGS/icons/head/catear_headphone.dmi'
	lefthand_file = 'modular_nova/modules/GAGS/icons/head/catear_headphone_inhand.dmi'
	righthand_file = 'modular_nova/modules/GAGS/icons/head/catear_headphone_inhand.dmi'
	inhand_icon_state = "catear_headphone"
	slot_flags = ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_NECK
	var/catTailToggled = FALSE
	instrument_range = 1
	greyscale_colors = "#FFFFFF#FFFFFF"
	greyscale_config = /datum/greyscale_config/catear_headphone
	greyscale_config_worn = /datum/greyscale_config/catear_headphone/worn
	greyscale_config_inhand_left = /datum/greyscale_config/catear_headphone_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/catear_headphone_inhand_right
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/instrument/piano_synth/headphones/catear_headphone/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/instrument/piano_synth/headphones/catear_headphone/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('modular_nova/modules/GAGS/icons/head/catear_headphone.dmi', "catearphones_[song?.playing ? "on" : "off"]_emissive", src, alpha = src.alpha)
		if(catTailToggled)
			. += emissive_appearance('modular_nova/modules/GAGS/icons/head/catear_headphone.dmi', "catearphones_tail_on_emissive", src, alpha = src.alpha)
			icon_state = "catear_headphone_tail[song?.playing ? "_on" : null]"
		else
			icon_state = "catear_headphone[song?.playing ? "_on" : null]"

/obj/item/instrument/piano_synth/headphones/catear_headphone/click_alt(mob/user)
	catTailToggled = !catTailToggled
	user.update_worn_head()
	update_icon(UPDATE_OVERLAYS)
	return CLICK_ACTION_SUCCESS

/obj/item/instrument/piano_synth/headphones/catear_headphone/update_overlays()
	. = ..()
	. += emissive_appearance('modular_nova/modules/GAGS/icons/head/catear_headphone.dmi', "catearphones_obj_lights_emissive", src, alpha = src.alpha)

/obj/item/mod/skin_applier/akari
	name = "nanite MODsuit refitter"
	desc = "A small kit full of nanites designed to refit a MODsuit to Akari's personal design. Only compatible with fused MODsuits due to the refit's reliance on a symbiote."
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	icon_state = "skinapplier"
	skin = "akari"

/obj/item/mod/skin_applier/akari/pre_attack(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control/pre_equipped/entombed))
		return ..()
	var/obj/item/mod/control/mod = attacked_atom
	mod.theme.variants += list("akari" = list(
		MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/obj/clothing/modsuit.dmi',
		MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/mob/clothing/modsuit.dmi',
		/obj/item/clothing/head/mod = list(
			UNSEALED_LAYER = HEAD_LAYER,
			UNSEALED_CLOTHING = SNUG_FIT,
			UNSEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
			UNSEALED_INVISIBILITY = HIDEHAIR|HIDEEYES|HIDESNOUT,
			SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
			SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
			SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
			SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
		),
		/obj/item/clothing/suit/mod = list(
			UNSEALED_CLOTHING = THICKMATERIAL,
			SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
			UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
			SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
		),
		/obj/item/clothing/gloves/mod = list(
			UNSEALED_CLOTHING = THICKMATERIAL,
			SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			CAN_OVERSLOT = TRUE,
			UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
			SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
		),
		/obj/item/clothing/shoes/mod = list(
			UNSEALED_CLOTHING = THICKMATERIAL,
			SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			CAN_OVERSLOT = TRUE,
			UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
			SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
		),
	))
	return ..()

// donation reward for Bonkai, the funny jumper
/obj/item/mod/skin_applier/jumper
	name = "\improper PA-4 MK-7 J.S supply crate"
	desc = "A crate made mostly of titanium with handles on the side to carry. It seems to be pressure sealed and the lid seems to be hydraulically assisted. The inside of the crate opens up and folds out to display an entire toolkit with all the essentials to convert most armor into a Mark 7 PA-7 Variant Jump suit. This crate seems to have the emblem relating to a certain Commando... Perhaps you should return it to the owner where you found it, if you can even lift it."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "jumper-box"
	skin = "jumper"

/obj/item/mod/skin_applier/jumper/pre_attack(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control/pre_equipped/security))
		return ..()
	var/obj/item/mod/control/mod = attacked_atom
	mod.theme.variants += list("jumper" = list(
		MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/obj/clothing/modsuit.dmi',
		MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/mob/clothing/modsuit.dmi',
		/obj/item/clothing/head/mod = list(
			UNSEALED_LAYER = HEAD_LAYER,
			UNSEALED_CLOTHING = SNUG_FIT,
			UNSEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
			UNSEALED_INVISIBILITY = HIDEHAIR|HIDEEYES|HIDESNOUT,
			SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
			SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
			SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
			SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
		),
		/obj/item/clothing/suit/mod = list(
			UNSEALED_CLOTHING = THICKMATERIAL,
			SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
			UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
			SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
		),
		/obj/item/clothing/gloves/mod = list(
			UNSEALED_CLOTHING = THICKMATERIAL,
			SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			CAN_OVERSLOT = TRUE,
			UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
			SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
		),
		/obj/item/clothing/shoes/mod = list(
			UNSEALED_CLOTHING = THICKMATERIAL,
			SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			CAN_OVERSLOT = TRUE,
			UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
			SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
		),
	))
	return ..()

/obj/item/clothing/head/cone_of_shame
	name = "collar cone"
	desc = "A protective guard used to prevent infections. Its advertisement claims it is: \"used to prevent unnecessary scratching, biting or licking of wounds to better facilitate healing. Works on people and pets alike!\" You question its efficacy, while also feeling a mild sense of shame while wearing it."
	base_icon_state = "cone"
	icon_state = "cone"
	worn_icon_state = "cone_close"
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/head.dmi'
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER - 0.1
	slot_flags = parent_type::slot_flags | ITEM_SLOT_NECK
	dog_fashion = /datum/dog_fashion/head/cone
	var/toggle_state = "close"

/obj/item/clothing/head/cone_of_shame/click_alt(mob/user)
	if(toggle_state == "open")
		toggle_state = "close"
	else
		toggle_state = "open"

	balloon_alert(user, "[toggle_state == "open" ? "opened" : "closed"]")
	update_icon(UPDATE_ICON_STATE)

	var/mob/living/wearer = loc
	if(!istype(wearer))
		return CLICK_ACTION_SUCCESS

	var/equipped_slot = wearer.get_slot_by_item(src)
	if(equipped_slot & slot_flags)
		wearer.update_clothing(equipped_slot)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/cone_of_shame/equipped(mob/living/user, slot)
	if(slot & slot_flags)
		update_layer(user)
		RegisterSignal(user, COMSIG_ATOM_POST_DIR_CHANGE, PROC_REF(on_dir_change))
	return ..()

/obj/item/clothing/head/cone_of_shame/dropped(mob/user)
	if(user.get_slot_by_item(src) & slot_flags)
		UnregisterSignal(user, COMSIG_ATOM_POST_DIR_CHANGE)
	return ..()

/obj/item/clothing/head/cone_of_shame/proc/on_dir_change(mob/wearer, old_dir, new_dir)
	SIGNAL_HANDLER
	var/old_south = old_dir == SOUTH
	var/new_south = new_dir == SOUTH
	if(old_south == new_south)
		return // either still facing south or still not facing south
	update_layer(wearer)

/obj/item/clothing/head/cone_of_shame/proc/update_layer(mob/wearer)
	// renders behind hair only when facing exactly south, and above pretty much anything on the head any other direction
	// diagonals render as east/west first so only need the exact cardinal
	if(wearer.dir == SOUTH)
		alternate_worn_layer = HAIR_LAYER + 0.1
	else
		alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER - 0.1
	wearer.update_clothing(wearer.get_slot_by_item(src))

/obj/item/clothing/head/cone_of_shame/update_icon_state()
	worn_icon_state = "[base_icon_state]_[toggle_state]"
	return ..()
