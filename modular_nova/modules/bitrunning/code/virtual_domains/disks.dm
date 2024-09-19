/obj/item/bitrunning_disk/item/tier1/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/storage/belt/military,
	)

/obj/item/bitrunning_disk/item/tier2/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/clothing/head/helmet,
		/obj/item/melee/energy/sword/saber/blue,
		/obj/item/storage/medkit/expeditionary/surplus,
	)

/obj/item/bitrunning_disk/item/tier3/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/autosurgeon/syndicate/nodrop,
	)

/obj/item/bitrunning_disk/ability/tier1/Initialize(mapload)
	. = ..()
	selectable_actions += list(
	/datum/action/cooldown/spell/touch/lay_on_hands,
	/datum/action/cooldown/spell/conjure/flare,
	)

/obj/item/bitrunning_disk/ability/tier2/Initialize(mapload)
	. = ..()
	selectable_actions += list(
	/datum/action/cooldown/adrenaline,
	/datum/action/cooldown/spell/charge,
	)

/obj/item/bitrunning_disk/ability/tier3/Initialize(mapload)
	. = ..()
	selectable_actions += list(
	/datum/action/cooldown/mob_cooldown/charge/basic_charge,
	/datum/action/cooldown/spell/touch/scream_for_me,
	/datum/action/cooldown/spell/death_loop,
	)

/datum/orderable_item/bitrunning_tech/item_tier1
	desc = "This disk contains a program that lets you equip a medical beamgun, a C4 explosive, a box of infinite pizza, or a military webbing."

/datum/orderable_item/bitrunning_tech/item_tier2
	desc = "This disk contains a program that lets you equip a luxury medipen, a pistol, an armour vest, a helmet, an energy sword, or an expeditionary medkit."

/datum/orderable_item/bitrunning_tech/item_tier3
	desc = "This disk contains a program that lets you equip an advanced energy gun, a dual bladed energy sword, a minibomb, or an anti-drop implanter."

/datum/orderable_item/bitrunning_tech/ability_tier1
	desc = "This disk contains a program that lets you cast Summon Cheese, Summon Light Source, Lesser Heal, or Mending Touch."

/datum/orderable_item/bitrunning_tech/ability_tier2
	desc = "This disk contains a program that lets you cast Fireball, Lightning Bolt, Forcewall, Adrenaline Rush, or Charge Item."

/datum/orderable_item/bitrunning_tech/ability_tier3
	desc = "This disk contains a program that lets you shapeshift into a lesser ashdrake, or a polar bear; or cast Charging Attack, Scream For Me, or Death Loop."

/datum/action/cooldown/spell/conjure/flare
	name = "Summon Light Source"
	desc = "This spell creates a green flare."

	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/projectiles.dmi'
	button_icon_state = "flare_burn-on"

	school = SCHOOL_CONJURATION
	cooldown_time = 10 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	summon_radius = 0
	summon_type = list(/obj/item/flashlight/flare/plasma_projectile)

/datum/action/cooldown/spell/death_loop
	name = "Death Loop"
	desc = "Makes the caster unable to die unwillingly via a forced memory leak delaying the death state assignation."

	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_plus"
	sound = 'sound/magic/staff_healing.ogg'
	cooldown_time = 10 SECONDS
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_HUMAN

	invocation = "NullReferenceException: Object reference not set to an instance of an object at Necrosis.Start."
	invocation_type = INVOCATION_SHOUT

/datum/action/cooldown/spell/death_loop/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/death_loop/cast(mob/living/cast_on)
	. = ..()
	cast_on.visible_message(
		span_warning("Faintest glitches and binary code lines briefly cover [cast_on]!"),
		span_notice("You memory hack your digital mortality!"),
	)
	ADD_TRAIT(cast_on, TRAIT_NODEATH, REF(src))
	ADD_TRAIT(cast_on, TRAIT_SUCCUMB_OVERRIDE, REF(src))
	Remove(cast_on)
