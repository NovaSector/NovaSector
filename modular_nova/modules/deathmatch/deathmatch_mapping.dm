/turf/closed/wall/wizarddeathmatch
	name = "wizard wall"
	desc = "A mystical wall made from wizarding materials!"
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium_wall-0"
	base_icon_state = "uranium_wall"
	baseturfs = /turf/open/floor/engine/cult
	smoothing_groups = SMOOTH_GROUP_URANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_URANIUM_WALLS

GLOBAL_LIST_INIT(mystery_wands, list(
	/obj/item/gun/magic/wand/arcane_barrage,
	/obj/item/gun/magic/wand/arcane_barrage/blood,
	/obj/item/gun/magic/wand/fireball,
	/obj/item/gun/magic/wand/resurrection,
	/obj/item/gun/magic/wand/death,
	/obj/item/gun/magic/wand/polymorph,
	/obj/item/gun/magic/wand/teleport,
	/obj/item/gun/magic/wand/door,
	/obj/item/gun/magic/wand/nothing,
	/obj/item/storage/belt/wands/full,
	/obj/item/gun/magic/staff/healing,
	/obj/item/gun/magic/staff/change,
	/obj/item/gun/magic/staff/animate,
	/obj/item/gun/magic/staff/chaos,
	/obj/item/gun/magic/staff/door,
	/obj/item/gun/magic/staff/honk,
	/obj/item/gun/magic/staff/spellblade,
	/obj/item/gun/magic/staff/locker,
	/obj/item/gun/magic/staff/flying,
	/obj/item/gun/magic/staff/babel,
	/obj/item/singularityhammer,
	/obj/item/mod/control/pre_equipped/enchanted,
	/obj/item/runic_vendor_scepter,
))

/obj/structure/mystery_box/wands
	desc = "A wooden crate that seems equally magical and mysterious, capable of granting the user all kinds of different magical wands."

/obj/structure/mystery_box/wands/generate_valid_types()
	valid_types = GLOB.mystery_wands

/datum/action/cooldown/spell/chuuni_invocations/deathmatch
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_MIND

/datum/action/cooldown/spell/rod_form/deathmatch
	spell_requirements = SPELL_REQUIRES_WIZARD_GARB|SPELL_REQUIRES_NO_ANTIMAGIC
