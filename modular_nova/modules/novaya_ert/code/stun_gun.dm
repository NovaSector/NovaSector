/obj/item/melee/baton/security/stun_gun
	name = "\improper Kopřiva stun gun"
	desc = "A remote-sized stun gun for deterring people with. With its voltage and size not being high enough to knock someone down, one's \
	best means of use is to hit a person and run away." // gotta poke some good writers with a stick so they can cobble a better description together
	desc_controls = "Left click to stun, right click to 'harm'."
	icon = 'modular_nova/modules/novaya_ert/icons/stun_gun.dmi'
	icon_state = "stun_gun"
	lefthand_file = 'modular_nova/modules/novaya_ert/icons/stun_gun_left.dmi'
	righthand_file = 'modular_nova/modules/novaya_ert/icons/stun_gun_right.dmi'
	inhand_icon_state = "stun_gun"
	base_icon_state = "stun_gun"
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "seclite"
	icon_angle = 0
	force = 10
	w_class = WEIGHT_CLASS_SMALL
	wound_bonus = 0
	attack_verb_continuous = list("thrusts")
	attack_verb_simple = list("thrust")
	throwforce = 0
	force_say_chance = 25
	stamina_damage = 35
	armour_type_against_stun = ENERGY
	knockdown_time = null
	clumsy_knockdown_time = null
	cooldown = 1 SECONDS
	light_color = LIGHT_COLOR_ELECTRIC_CYAN
	light_power = 0.25

	throw_stun_chance = 15
	cell_hit_cost = STANDARD_CELL_CHARGE*0.75
	convertible = FALSE
	active_changes_inhand = TRUE
	tip_changes_color = FALSE

/obj/item/melee/baton/security/stun_gun/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/melee/baton/security/stun_gun/get_wait_description()
	return span_danger("The stun gun is still charging!")

/obj/item/melee/baton/security/stun_gun/baton_effect(mob/living/target, mob/living/user, modifiers, stun_override)
	if(!deductcharge(cell_hit_cost))
		return FALSE
	target.visible_message(span_danger("[user] stuns [target] with [src]!"),
		span_userdanger("[user] stuns you with [src]!"))
	target.set_jitter_if_lower(5 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_confusion_if_lower(4 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_stutter_if_lower(3 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_eye_blur_if_lower(5 SECONDS* (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK)
	stun_override = FALSE

/obj/item/melee/baton/security/stun_gun/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/melee/baton/security/stun_gun/examine_more(mob/user)
	. = ..()

	. += "'Kopřiva' is the current flagship model of a stun gun standard-issued to coreworld Zvirdnyn officers - as you would not expect any more than an occasional rare drunkard \
		coming for you around the capital planets. Its newly integrated neural receptors allow for unprecedented level of pacification through pain responses to one's brain, \
		resulting in a conclusion to a confrontation that couldn't even end. The humanity of directly sparking people's CNS is dubious at best; but suspects are yet to fall limp \
		after experiencing its sting."


/obj/item/melee/baton/security/stun_gun/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high
