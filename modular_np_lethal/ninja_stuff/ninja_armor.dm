#define MODE_LISTENOFF "Disengage Audio Sensors"
#define MODE_LISTENON "Engage Audio Sensors"


//genin are on a similar power band as gaksters, but they trade a few values around.
//the kudagitsune are support fighters that get weak but feature rich armor that allows them to move quicker than similarly armored gaksters.
/datum/armor/armor_lethal_kudagitsune
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_II
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

//the baku are frontline combatants that get mid tier gakster armor. they also get slightly less slowdown than similarly armored gaksters in return for using melee
/datum/armor/armor_lethal_baku
	melee = ARMOR_LEVEL_MID
	bullet = BULLET_ARMOR_III
	laser = ARMOR_LEVEL_MID
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/head/helmet/lethal_kudagitsune_helmet
	name = "Kudagitsune helmet system"
	desc = "A complex helmet system that sacrifices some armor plating for a suite of sensors and signal \
	amplifiers that serve to augment the wearer's situational awareness, sensory capacity, and situational effectiveness."
	icon = ''
	icon_state = ""
	worn_icon = ''
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_lethal_kudagitsune
	max_integrity = 300
	limb_integrity = 300
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/lethal_kudagitsune_helmet/equipped(mob/living/user, slot, current_mode)
	. = ..()
	if(slot & ITEM_SLOT_HEAD)
		START_PROCESSING(SSobj, src)
		RegisterSignal(user, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))

	if(!slot == ITEM_SLOT_HEAD)
		mode = MODE_LISTENOFF

/obj/item/clothing/head/helmet/lethal_kudagitsune_helmet/proc/toggle_mode(mob/user, voluntary)
	if(!istype(user) || user.incapacitated())
		return FALSE

	switch(mode)
		if(MODE_LISTENOFF)
			change_mode(MODE_LISTENON)

		if(MODE_LISTENON)
			change_mode(MODE_LISTENOFF)

	playsound(src, modeswitch_sound, 50, TRUE)

/obj/item/gravity_harness/proc/change_mode(target_mode)
	if(!target_mode)
		return FALSE
	user.RemoveElement(/datum/element/forced_gravity, 0)
	REMOVE_TRAIT(user, TRAIT_XRAY_HEARING, CLOTHING_TRAIT)

//stuff that goes on your torso

//stuff that goes on your hands

//stuff that goes on your feet
