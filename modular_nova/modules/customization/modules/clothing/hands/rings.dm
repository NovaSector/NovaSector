/obj/item/clothing/gloves/ring
	name = "gold ring"
	desc = "A tiny gold ring, sized to wrap around a finger."
	icon_state = "ringgold"
	inhand_icon_state = "ringgold"
	worn_icon_state = "gring"
	icon = 'modular_nova/master_files/icons/obj/ring.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/hands.dmi'
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/rings_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/rings_righthand.dmi'
	gender = NEUTER
	w_class = WEIGHT_CLASS_TINY
	body_parts_covered = null
	strip_delay = 4 SECONDS
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/gloves/ring/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("\[user] is putting the [src] in [user.p_their()] mouth! It looks like [user] is trying to choke on the [src]!"))
	return OXYLOSS

/obj/item/clothing/gloves/ring/diamond
	name = "diamond ring"
	desc = "An expensive ring, studded with a diamond. Many cultures have used these rings in courtship for millenia."
	icon_state = "ringdiamond"
	inhand_icon_state = "ringdiamond"
	worn_icon_state = "dring"

/obj/item/clothing/gloves/ring/diamond/attack_self(mob/user)
	user.visible_message(span_warning("\The [user] gets down on one knee, presenting \the [src]."),span_warning("You get down on one knee, presenting \the [src]."))

/obj/item/clothing/gloves/ring/silver
	name = "silver ring"
	desc = "A tiny silver ring, sized to wrap around a finger."
	icon_state = "ringsilver"
	inhand_icon_state = "ringsilver"
	worn_icon_state = "sring"
