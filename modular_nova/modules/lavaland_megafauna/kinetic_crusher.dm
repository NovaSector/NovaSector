/obj/item/crusher_trophy/adaptive_intelligence_core
	name = "adaptive intelligence core"
	desc = "Seems to be one of the cores from a massive robot. Suitable as a trophy for a kinetic crusher."
	icon_state = "dark_seed"
	denied_type = /obj/item/crusher_trophy/adaptive_intelligence_core
	bonus_value = 1.2

/obj/item/crusher_trophy/adaptive_intelligence_core/effect_desc()
	return "melee hits deal <b>[bonus_value]</b> more damage per hit after hitting a target, up to <b>[bonus_value * 10]</b> extra damage to that target"

/obj/item/crusher_trophy/adaptive_intelligence_core/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.force += bonus_value * 0.2
		H.detonation_damage += bonus_value * 0.8
		AddComponent(/datum/component/two_handed, force_wielded=(20 + bonus_value * 0.2))

/obj/item/crusher_trophy/adaptive_intelligence_core/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.force += bonus_value * 0.2
		H.detonation_damage += bonus_value * 0.8
		AddComponent(/datum/component/two_handed, force_wielded=(20 + bonus_value * 0.2))
