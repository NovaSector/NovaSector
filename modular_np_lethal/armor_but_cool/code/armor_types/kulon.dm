/datum/armor/armor_lethal_kora_kulon
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_III
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_TINY
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/suit/armor/lethal_kora_kulon
	name = "'Kinu-Kuroba' type III armor vest"
	desc = "A thick armor vest popular on mars for both its concealability and excellent protection. \
		This one is green, because everything black or mars colored was sold out already."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "kulon"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_lethal_kora_kulon
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	body_parts_covered = CHEST
	max_integrity = 375
	limb_integrity = 375

/obj/item/clothing/suit/armor/lethal_kora_kulon/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

/obj/item/clothing/suit/armor/lethal_kora_kulon/examine_more(mob/user)
	. = ..()

	. += "The real deal, the vest that everyone who has ever had a connection to Marsian crime has seen before at least once. \
		The vest's popularity extends far beyond just mars, with another common sight being the gaksters of Pluto. \
		Some even manage to make their way out to the frontier far away from their place of origin. \
		Is there a particular reason for this? What does this vest do that no other does? Why is it so special? \
		There's really only one reason for this, that being the only class III armor vest you can buy without breaking \
		the bank."

	return .

/obj/item/clothing/suit/armor/lethal_kora_kulon/full_set
	name = "'Kinu-Kuroba' type III full armor kit"
	desc = "A thick armor vest popular on mars for both its concealability and excellent protection. \
		This one is green, because everything black or mars colored was sold out already. \
		It's also a particularly rare variant of the armor, sporting protection for both the \
		legs and arms of the user."
	icon_state = "kulon_full"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	max_integrity = 600
	limb_integrity = 300
	slowdown = 0.5

/obj/item/clothing/head/helmet/lethal_kulon_helmet
	name = "'Robusuta' type III ballistic helmet"
	desc = "A bulky helmet made to pair with the 'Kinu-Kuroba' armor set for protection of the second most \
		important part of a person's body. The front of the helmet is exceptionally angled and thick, \
		an iconic feature that distinguishes the helmet from most others. Has attachment points for attaching \
		the glass face shield of the 'Val' helmet to."
	icon = 'modular_np_lethal/armor_but_cool/icons/armor.dmi'
	icon_state = "clam"
	worn_icon = 'modular_np_lethal/armor_but_cool/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_kora_kulon
	max_integrity = 300
	limb_integrity = 300
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	/// Holds the faceshield for quick reference
	var/obj/item/sacrificial_face_shield/face_shield

/obj/item/clothing/head/helmet/lethal_kulon_helmet/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

/obj/item/clothing/head/helmet/lethal_kulon_helmet/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()

	if(!(istype(attacking_item, /obj/item/sacrificial_face_shield)))
		return

	add_face_shield(user, attacking_item)

/obj/item/clothing/head/helmet/lethal_kulon_helmet/Destroy()
	QDEL_NULL(face_shield)
	return ..()

/obj/item/clothing/head/helmet/lethal_kulon_helmet/click_alt(mob/user)
	remove_face_shield(user)
	return CLICK_ACTION_SUCCESS

/// Attached the passed face shield to the helmet.
/obj/item/clothing/head/helmet/lethal_kulon_helmet/proc/add_face_shield(mob/living/carbon/human/user, obj/shield_in_question, on_spawn)
	if(face_shield)
		return
	if(!user?.transferItemToLoc(shield_in_question, src) && !on_spawn)
		return

	if(on_spawn)
		shield_in_question = new /obj/item/sacrificial_face_shield(src)

	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

	playsound(src, 'sound/items/modsuit/magnetic_harness.ogg', 50, TRUE)
	face_shield = shield_in_question

	icon_state = "clam_glass"
	worn_icon_state = icon_state
	update_appearance()

/// Removes the face shield from the helmet, breaking it into a glass shard decal if that's wanted, too.
/obj/item/clothing/head/helmet/lethal_kulon_helmet/proc/remove_face_shield(mob/living/carbon/human/user, break_it)
	if(!face_shield)
		return

	flags_inv = initial(flags_inv)
	flags_cover = initial(flags_cover)

	if(break_it)
		playsound(src, SFX_SHATTER, 70, TRUE)
		new /obj/effect/decal/cleanable/glass(drop_location(src))
		qdel(face_shield)
		face_shield = null // just to be safe
	else
		user.put_in_hands(face_shield)
		playsound(src, 'sound/items/modsuit/magnetic_harness.ogg', 50, TRUE)
		face_shield = null

	icon_state = initial(icon_state)
	worn_icon_state = icon_state // Against just to be safe
	update_appearance()

/obj/item/clothing/head/helmet/lethal_kulon_helmet/take_damage_zone(def_zone, damage_amount, damage_type, armour_penetration)
	. = ..()

	if((damage_amount > 20) && face_shield)
		remove_face_shield(break_it = TRUE)

/obj/item/clothing/head/helmet/lethal_kulon_helmet/examine(mob/user)
	. = ..()
	if(face_shield)
		. += span_notice("The <b>face shield</b> can be removed with <b>Right-Click</b>.")
	else
		. += span_notice("A <b>face shield</b> can be attached to it.")

	return .

/obj/item/clothing/head/helmet/lethal_kulon_helmet/examine_more(mob/user)
	. = ..()

	. += "Thick helmets to go with a thick armor set. An iconic look for gaksters, insanely armed criminals \
		or maybe rarely the actual planetary guard of Mars. While many complain about the bulk of the helmet \
		making it rather uncomfortable to wear, there isn't much you can do to argue against it's ability to \
		stop your head from exploding. The common use of the face shield depends entirely on where it's seen use. \
		Criminals rarely use them, if they can even find one intact, while gaksters and military forces alike love \
		them for the protection they offer against flying pieces of metal entering your eyes."

	return .

/obj/item/clothing/head/helmet/lethal_kulon_helmet/spawns_with_shield

/obj/item/clothing/head/helmet/lethal_kulon_helmet/spawns_with_shield/Initialize(mapload)
	. = ..()
	add_face_shield(on_spawn = TRUE)
