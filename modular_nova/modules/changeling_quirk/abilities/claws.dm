/datum/action/changeling/weapon/changeling_claws
	name = "Biological Claws"
	desc = "We reform one of our arms into a sickly claw. Costs 20 chemicals."
	helptext = "We may retract our claw in the same manner as we form it. Cannot be used while in lesser form."
	button_icon_state = "armblade" // leaving this to avoid bloat, won't matter much realistically
	chemical_cost = 20
	dna_cost = 1
	req_human = TRUE
	weapon_type = /obj/item/melee/changeling_claws
	weapon_name_simple = "claws"

/obj/item/melee/changeling_claws
	name = "Claw hand"
	desc = "A grotesque interpretation of a hand, with long claws to top it off."
	icon = 'modular_nova/modules/changeling_quirk/icons/changeling_claw.dmi'
	icon_state = "claw"
	inhand_icon_state = "claw"
	icon_angle = 180
	lefthand_file = 'modular_nova/modules/changeling_quirk/icons/changeling_claw_lefthand.dmi'
	righthand_file = 'modular_nova/modules/changeling_quirk/icons/changeling_claw_righthand.dmi'
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 10
	exposed_wound_bonus = 10
	armour_penetration = 15
	var/can_drop = FALSE
	var/fake = FALSE
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/melee/changeling_claws/Initialize(mapload,silent,synthetic)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc) && !silent)
		loc.visible_message(span_warning("A grotesque claw forms around [loc.name]\'s arm!"), span_warning("Our arm twists and mutates, transforming it into a sharp claw."), span_hear("You hear organic matter ripping and tearing!"))
	if(synthetic)
		can_drop = TRUE
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)
	AddComponent(/datum/component/butchering, \
		speed = 6 SECONDS, \
		effectiveness = 80, \
	)
