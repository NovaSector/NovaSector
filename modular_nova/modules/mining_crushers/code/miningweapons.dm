/// Base handler for variant switch feedback
/obj/item/kinetic_crusher/proc/on_variant_switch(mob/living/user)
	to_chat(user, "You have converted your kit into the [initial(name)].")
	playsound(get_turf(user), 'sound/items/tools/rped.ogg', 50)

/obj/item/kinetic_crusher
	light_system = OVERLAY_LIGHT_DIRECTIONAL // Adds this to overwrite the current light system for the kinetic crusher, for consistency sake.
	/// This var is used to imitate being weilded if it's one handed
	var/acts_as_if_wielded
	/// This var is used by retool kits when changing the crusher's projectile appearance
	var/projectile_icon_file = 'icons/obj/weapons/guns/projectiles.dmi'
	block_sound = 'sound/items/weapons/parry.ogg' //Added this for cases for the machete or adding the Marked One's trophy to the crusher variants.

/obj/item/kinetic_crusher/machete
	icon = 'modular_nova/modules/mining_crushers/icons/items_and_weapons.dmi'
	icon_state = "PKMachete"
	inhand_icon_state = "PKMachete0"
	lefthand_file = 'modular_nova/modules/mining_crushers/icons/melee_lefthand.dmi'
	righthand_file = 'modular_nova/modules/mining_crushers/icons/melee_righthand.dmi'
	worn_icon = 'modular_nova/modules/mining_crushers/icons/belt.dmi'
	worn_icon_state = "PKMachete0"
	name = "proto-kinetic machete"
	desc = "A further-developed iteration of the proto-kinetic crusher, compacting the essentials of the kinetic crusher's destabilizer unit \
		into a package light enough to be used one-handed and capable of deflecting a blow or two, in return for losses in raw performance."
	force = 10
	force_wielded = 15
	block_chance = 15
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list(
		"cleaves",
		"chops",
		"cuts",
		"swipes",
		"slashes",
	)
	attack_verb_simple = list(
		"cleave",
		"chop",
		"cut",
		"swipe",
		"slash",
	)
	charge_time =  1 SECONDS
	detonation_damage = 35 // 45 damage on det, 50 wielded
	backstab_bonus = 20 // 65 damage on backstab, 70 wielded
	acts_as_if_wielded = TRUE
	current_inhand_icon_state = "PKMachete"

/obj/item/kinetic_crusher/machete/Initialize(mapload)
	. = ..()
	update_wielding()
	AddComponent(/datum/component/butchering, \
		speed = 4 SECONDS, \
		effectiveness = 150, \
	)
/obj/item/kinetic_crusher/machete/update_wielding()
	// Component that handles special behaviour for force differences between wielding and unwielding
	AddComponent(/datum/component/two_handed, force_unwielded = 10, force_wielded = 15) // If you happen to sharpen the machete, you will increase its sharpness but until you wield it, you will not get the force values applied (consequence of one-handed use).

/obj/item/kinetic_crusher/machete/update_icon_state()
	. = ..()
	if(current_inhand_icon_state == initial(current_inhand_icon_state)) // don't alter retool kit appearance
		inhand_icon_state = "PKMachete0" // this is not icon_state and not supported by 2hcomponent

/obj/item/kinetic_crusher/spear
	icon = 'modular_nova/modules/mining_crushers/icons/items_and_weapons.dmi'
	icon_state = "PKSpear"
	inhand_icon_state = "PKSpear0"
	lefthand_file = 'modular_nova/modules/mining_crushers/icons/melee_lefthand.dmi'
	righthand_file = 'modular_nova/modules/mining_crushers/icons/melee_righthand.dmi'
	worn_icon = 'modular_nova/modules/mining_crushers/icons/back.dmi'
	worn_icon_state = "PKSpear0"
	name = "proto-kinetic spear"
	desc = "A further-developed iteration of the proto-kinetic crusher, with safety as less of an afterthought. A streamlined destabilizer unit along with \
		a linear chassis enables striking at a distance, and slightly better armor penetration, at the cost of some raw performance."
	force_wielded = 15
	w_class = WEIGHT_CLASS_HUGE
	armour_penetration = 15
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list(
		"pierces",
		"stabs",
		"impales",
		"pokes",
		"jabs",
	)
	attack_verb_simple = list(
		"pierce",
		"stab",
		"impale",
		"poke",
		"jab",
	)
	light_range = 8
	detonation_damage = 35 // 50 damage on det
	backstab_bonus = 20	// 70 damage on det
	reach = 2
	current_inhand_icon_state = "PKSpear"

/obj/item/kinetic_crusher/spear/Initialize(mapload)
	. = ..()
	update_wielding()
	AddComponent(/datum/component/butchering, \
		speed = 6 SECONDS, \
		effectiveness = 90, \
	)

/obj/item/kinetic_crusher/spear/update_icon_state()
	. = ..()
	if(current_inhand_icon_state == initial(current_inhand_icon_state)) // don't alter retool kit appearance
		inhand_icon_state = "PKSpear[HAS_TRAIT(src, TRAIT_WIELDED)]" // this is not icon_state and not supported by 2hcomponent

/obj/item/kinetic_crusher/hammer
	icon = 'modular_nova/modules/mining_crushers/icons/items_and_weapons.dmi'
	icon_state = "PKHammer"
	inhand_icon_state = "PKHammer0"
	lefthand_file = 'modular_nova/modules/mining_crushers/icons/melee_lefthand.dmi'
	righthand_file = 'modular_nova/modules/mining_crushers/icons/melee_righthand.dmi'
	worn_icon = 'modular_nova/modules/mining_crushers/icons/back.dmi'
	worn_icon_state = "PKHammer0"
	name = "proto-kinetic hammer"
	desc = "A further-developed iteration of the proto-kinetic crusher, designed with raw force in mind. \
		The increased mass allows it to throw struck targets, while improved kinetic modulation increases destabilizer detonation damage, \
		in return for losing the ability to backstab."
	force_wielded = 20
	w_class = WEIGHT_CLASS_HUGE
	armour_penetration = 0
	hitsound = 'sound/items/weapons/sonic_jackhammer.ogg'
	attack_verb_continuous = list(
		"slams",
		"crushes",
		"smashes",
		"flattens",
		"pounds",
	)
	attack_verb_simple = list(
		"slam",
		"crush",
		"smash",
		"flatten",
		"pound",
	)
	sharpness = NONE
	charge_time = 2 SECONDS
	detonation_damage = 70 // 90 damage on det
	backstab_bonus = 0 // 90 damage on backstab
	acts_as_if_wielded = FALSE
	current_inhand_icon_state = "PKHammer"

/obj/item/kinetic_crusher/hammer/Initialize(mapload)
	. = ..()
	update_wielding()

/obj/item/kinetic_crusher/hammer/attack(mob/living/target, mob/living/user)
	var/relative_direction = get_cardinal_dir(src, target)
	var/atom/throw_target = get_edge_target_turf(target, relative_direction)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM) || !HAS_TRAIT(src, TRAIT_WIELDED))
		return
	else if(!QDELETED(target) && !target.anchored)
		var/whack_speed = (2)
		target.throw_at(throw_target, 2, whack_speed, user, gentle = TRUE)

/obj/item/kinetic_crusher/hammer/update_icon_state()
	. = ..()
	if(current_inhand_icon_state == initial(current_inhand_icon_state)) // don't alter retool kit appearance
		inhand_icon_state = "PKHammer[HAS_TRAIT(src, TRAIT_WIELDED)]" // this is not icon_state and not supported by 2hcomponent

/obj/item/kinetic_crusher/claw
	icon = 'modular_nova/modules/mining_crushers/icons/items_and_weapons.dmi'
	icon_state = "PKClaw"
	inhand_icon_state = "PKClaw0"
	lefthand_file = 'modular_nova/modules/mining_crushers/icons/melee_lefthand.dmi'
	righthand_file = 'modular_nova/modules/mining_crushers/icons/melee_righthand.dmi'
	worn_icon_state = "PKHammer0"
	slot_flags = NONE
	name = "proto-kinetic claw"
	desc = "A further-developed iteration of the proto-kinetic crusher, with compactness at all costs in mind. \
		While great sacrifices in performance have been made, the destabilizer unit recharges quickly, \
		and sympathetic resonance allows great performance on back-struck targets."
	acts_as_if_wielded = TRUE
	force = 10
	force_wielded = 10
	w_class = WEIGHT_CLASS_NORMAL
	armour_penetration = 0
	hitsound = 'sound/items/weapons/pierce.ogg'
	attack_verb_continuous = list(
		"swipes",
		"slashes",
		"cuts",
		"claws",
	)
	attack_verb_simple = list(
		"swipe",
		"slash",
		"cut",
		"claw",
	)
	sharpness = SHARP_POINTY
	light_range = 4
	charge_time = 1 SECONDS
	detonation_damage = 20 // 30 on det
	backstab_bonus = 90 // 120 on backstab
	// with style meter you can consistently hit backstabs in any direction. you shouldn't get 200+ damage hits for basically free
	current_inhand_icon_state = "PKClaw"
	/**
	 * possible ideas in regards to making the claw more interesting than just backstab-focused sidegrade:
	 * - long cooldown but mark detonations/melee hits reduce/reset cooldown?
	 * - getting multiple detonations off one mark?
	 */

/obj/item/kinetic_crusher/claw/Initialize(mapload)
	. = ..()
	update_wielding()
	AddComponent(/datum/component/butchering, \
		speed = 5 SECONDS, \
		effectiveness = 100, \
	)

/obj/item/kinetic_crusher/claw/update_icon_state()
	. = ..()
	if(current_inhand_icon_state == initial(current_inhand_icon_state)) // don't alter retool kit appearance
		inhand_icon_state = initial(inhand_icon_state) // get rid of the '0' or '1' at the end
