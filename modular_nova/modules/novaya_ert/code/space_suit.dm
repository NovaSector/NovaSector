/obj/item/clothing/suit/space/voskhod
	name = "\proper Voskhod-P depowered combat armor"
	desc = "A hybrid set of space-resistant armor built on a modified mass-produced 'Dawn' space suit, polyurea coated durathread-lined light plasteel plates hinder mobility as little as possible while the onboard life support system aids the user in combat. \
	The power cell is what makes the armor work without hassle, a sticker in the power supply unit warns anyone reading to responsibly manage battery levels. <br>\
	These 'paralyzed', marketable variations of the suit come with most of their main features removed: from the infamous wound-tending systems, to the less appreciated death alarms."
	icon = 'modular_nova/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_nova/modules/novaya_ert/icons/wornarmor.dmi'
	icon_state = "voskhod_suit"
	inhand_icon_state = "s_suit"
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	armor_type = /datum/armor/space_voskhod
	supports_variations_flags = CLOTHING_NO_VARIATION //It's already huge enough to look like it can work with digis

/obj/item/clothing/suit/space/voskhod/examine_more(mob/user)
	. = ..()

	. += "'Dawn', a brand name given to the early colonisation-era civilian space suits which were among the first ones to become consumer-grade: \
		comfortable, protective and, first of all, cheap to see themselves used en masse by the many people that were soon to turn their purpose around. \
		As the war broke out, many fitting ports of the industrial-grade models, then-modular to be clipped on with virtually anything, \
		have been repurposed to get strapped with additional armor plating; \
		and what served as a floodlight mount become the soldier's directionally-opaque face shield, sturdy enough to stop what could have resulted in a horrific accident.  \
		These models were commonly fielded with a cutting-edge for its era paramedical suite built into the suit, able to deal with most common ailments one would succumb to in space combat.\
		The dawn of human exploration has resulted in the rising of a new Coalition."

	return .

//Maybe when Teshari aren't an ass to sprite for...
/obj/item/clothing/suit/space/voskhod/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too big for you!"))
		return FALSE

	return ..()

//Syndicate space suit's armor but it also has wound protection because it's -actually- armored (And I'll assume the latter's no-woundness is an oversight)
/datum/armor/space_voskhod
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 30
	bio = 30
	fire = 80
	acid = 85
	wound = 20

/obj/item/clothing/head/helmet/space/voskhod
	name = "\proper Voskhod-P depowered combat helmet"
	desc = "A composite graphene-plasteel helmet with a ballistic nylon inner padding, complete with a deployable airtight polycarbonate visor and respirator system. <br>\
	This particular unit's rebreathers have been salvaged off; unable to resynthesize any more breathable air for the user." //Reference to its HEV past.
	icon = 'modular_nova/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_nova/modules/novaya_ert/icons/wornarmor.dmi'
	icon_state = "voskhod_helmet"
	inhand_icon_state = "space_helmet"
	armor_type = /datum/armor/space_voskhod
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/head/helmet/space/voskhod/examine_more(mob/user)
	. = ..()

	. += "'Dawn', a brand name given to the early colonisation-era civilian space suits which were among the first ones to become consumer-grade: \
		comfortable, protective and, first of all, cheap to see themselves used en masse by the many people that were soon to turn their purpose around. \
		As the war broke out, many fitting ports of the industrial-grade models, then-modular to be clipped on with virtually anything, \
		have been repurposed to get strapped with additional armor plating; \
		and what served as a floodlight mount become the soldier's directionally-opaque face shield, sturdy enough to stop what could have resulted in a horrific accident.  \
		These models were commonly fielded with a cutting-edge for its era paramedical suite built into the suit, able to deal with most common ailments one would succumb to in space combat.\
		The dawn of human exploration has resulted in the rising of a new Coalition."

	return .

//...I'll start asking for unique sprites for them.
/obj/item/clothing/head/helmet/space/voskhod/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too big for you!"))
		return FALSE

	return ..()
