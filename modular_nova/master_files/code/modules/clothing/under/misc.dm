//DO NOT ADD TO THIS FILE UNLESS THE SITUATION IS DIRE
//MISC FILES = UNSORTED FILES. EVEN TG HATES THIS ONE.

/obj/item/clothing/under/misc
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/misc_digi.dmi'

/obj/item/clothing/under/misc/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/misc.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/misc.dmi'
	can_adjust = FALSE

/*
	Do we even bother sorting these? We don't want to use the file, it's for emergencies and in-betweens.
	Just... don't lose your stuff.
*/

/obj/item/clothing/under/misc/nova/gear_harness
	name = "gear harness"
	desc = "A simple, inconspicuous harness replacement for a jumpsuit."
	icon_state = "gear_harness"
	body_parts_covered = NONE
	attachment_slot_override = CHEST
	can_adjust = FALSE
	slot_flags = ITEM_SLOT_ICLOTHING | ITEM_SLOT_OCLOTHING
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	/// Default appearance data used when not showing an imprint.
	var/default_icon
	var/default_worn_icon
	var/default_icon_state
	var/default_worn_icon_state
	/// Saved appearance data copied from an imprinted undersuit.
	var/imprinted_icon
	var/imprinted_worn_icon
	var/imprinted_icon_state
	var/imprinted_worn_icon_state
	/// If TRUE, the harness is currently displaying its imprinted appearance.
	var/use_imprinted_appearance = FALSE

/obj/item/clothing/under/misc/nova/gear_harness/suit // Functionally the same, this is just so the loadout system allows you to pick either one

/obj/item/clothing/under/misc/nova/gear_harness/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed
	default_icon = initial(icon)
	default_worn_icon = initial(worn_icon)
	default_icon_state = initial(icon_state)
	default_worn_icon_state = initial(worn_icon_state)

/obj/item/clothing/under/misc/nova/gear_harness/examine(mob/user)
	. = ..()
	. += span_notice("Use another jumpsuit on [src] to imprint its appearance.")
	if(imprinted_icon_state)
		. += span_notice("Alt-click [src] to switch between harness and imprinted look.")

/obj/item/clothing/under/misc/nova/gear_harness/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(attacking_item, /obj/item/clothing/under) && attacking_item != src)
		balloon_alert(user, "imprinting...")
		if(!do_after(user, 5 SECONDS, target = src))
			balloon_alert(user, "imprint interrupted")
			return

		var/obj/item/clothing/under/imprint_source = attacking_item
		imprinted_icon = imprint_source.icon
		imprinted_worn_icon = imprint_source.worn_icon
		imprinted_icon_state = imprint_source.icon_state
		imprinted_worn_icon_state = imprint_source.worn_icon_state
		use_imprinted_appearance = FALSE
		apply_visual_state()
		balloon_alert(user, "appearance imprinted")
		return

	return ..()

/obj/item/clothing/under/misc/nova/gear_harness/click_alt(mob/user)
	if(!can_use(user))
		return NONE
	if(!imprinted_icon_state)
		balloon_alert(user, "no imprint")
		return CLICK_ACTION_BLOCKING

	balloon_alert(user, "switching...")
	if(!do_after(user, 5 SECONDS, target = src))
		balloon_alert(user, "switch interrupted")
		return CLICK_ACTION_BLOCKING

	use_imprinted_appearance = !use_imprinted_appearance
	apply_visual_state()
	balloon_alert(user, use_imprinted_appearance ? "imprint on" : "imprint off")
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/under/misc/nova/gear_harness/proc/apply_visual_state()
	if(use_imprinted_appearance)
		icon = imprinted_icon
		worn_icon = imprinted_worn_icon
		icon_state = imprinted_icon_state
		worn_icon_state = imprinted_worn_icon_state
	else
		icon = default_icon
		worn_icon = default_worn_icon
		icon_state = default_icon_state
		worn_icon_state = default_worn_icon_state

	update_icon()

/obj/item/clothing/under/misc/nova/gear_harness/eve
	name = "collection of leaves"
	desc = "Three leaves, designed to cover the nipples and genetalia of the wearer. A foe so proud will first the weaker seek."
	icon_state = "eve"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/under/misc/nova/gear_harness/adam
	name = "leaf"
	desc = "A single leaf, designed to cover the genitalia of the wearer. Seek not temptation."
	icon_state = "adam"
	body_parts_covered = GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/misc/nova/taccas
	name = "tacticasual uniform"
	desc = "A white wifebeater on top of some cargo pants. For when you need to carry various beers."
	icon_state = "tac_s"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION | CLOTHING_BIG_LEGS_MASK

/obj/item/clothing/under/misc/nova/mechanic
	name = "mechanic's overalls"
	desc = "An old-fashioned pair of brown overalls, along with assorted pockets and belt-loops."
	icon_state = "mechanic"

/obj/item/clothing/under/misc/nova/utility
	name = "general utility uniform"
	desc = "A utility uniform worn by civilian-ranked crew."
	icon_state = "utility"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	can_adjust = FALSE

/obj/item/clothing/under/misc/nova/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/datum/armor/clothing_under/utility_syndicate
	melee = 10
	fire = 50
	acid = 40

/obj/item/clothing/under/misc/nova/modskin
	name = "M.O.D. skinsuit"
	desc = "A M.O.D. skinsuit worn by... anyone, really."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/misc/nova/modskin"
	post_init_icon_state = "modskin"
	greyscale_config = /datum/greyscale_config/modskin
	greyscale_config_worn = /datum/greyscale_config/modskin/worn
	greyscale_config_worn_digi = /datum/greyscale_config/modskin/worn/digi
	greyscale_colors = "#39393F#B3B3B3"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	flags_1 = IS_PLAYER_COLORABLE_1
	bodyshapes_with_variations = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
