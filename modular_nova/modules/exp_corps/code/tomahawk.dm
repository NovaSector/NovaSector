/obj/item/melee/tomahawk
	name = "expeditionary tomahawk"
	desc = "A decently sharp axe blade upon a short fibremetal handle. "
	icon = 'modular_nova/modules/exp_corps/icons/tomahawk.dmi'
	icon_state = "tomahawk"
	inhand_icon_state = "tomahawk"
	lefthand_file = 'modular_nova/modules/exp_corps/icons/tomahawk_l.dmi'
	righthand_file = 'modular_nova/modules/exp_corps/icons/tomahawk_r.dmi'
	worn_icon = 'modular_nova/modules/exp_corps/icons/tomahawk_worn.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 15 //Equivalent to a survival knife
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 18
	throw_speed = 4
	throw_range = 8
	embed_type = /datum/embedding/tomahawk
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5)
	attack_verb_continuous = list("chops", "tears", "lacerates", "cuts")
	attack_verb_simple = list("chop", "tear", "lacerate", "cut")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/datum/embedding/tomahawk
	pain_mult = 6
	embed_chance = 60
	fall_chance = 10

/obj/item/melee/tomahawk/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
	speed = 7 SECONDS, \
	effectiveness = 100, \
	)
