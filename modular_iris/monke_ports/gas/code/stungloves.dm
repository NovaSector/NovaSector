/obj/item/melee/baton/security/stungloves //Compatible with species with chunky fingers.
	name = "PSG-MK3"
	desc = "The Mark-Three Powered Stun Gloves. For re-educating the Clown with your fists, now in legally-correct flavors! Wearable - turns your punches into stunbaton hits!."
	force = 1 // These are gloves meant to stun targets. They're not meant to be used to beat the clown to death. Hopefully.
	icon = 'modular_iris/monke_ports/gas/icons/stunglove_item.dmi'
	worn_icon = 'modular_iris/monke_ports/gas/icons/stunglove_item.dmi'
	worn_icon_nabber = 'modular_iris/monke_ports/gas/icons/mob/clothing/hands.dmi'
	icon_state = "stunglove"
	base_icon_state = "stunglove"
	inhand_icon_state = "stunbaton"
	worn_icon_state = "stunglove_onmob"
	body_parts_covered = HANDS
	slot_flags = ITEM_SLOT_GLOVES
	chunky_finger_usable = TRUE

	cooldown = 1.5 SECONDS //Reduced down to accomodate the way less stam damage.
	stamina_damage = 70 //Lower.
	knockdown_time = 2.5 SECONDS //Half
	clumsy_knockdown_time = 6 SECONDS //Lower power batong
	var/datum/action/cooldown/toggle_stunners/assistant_killer
	var/traits_to_give = list(TRAIT_CHUNKYFINGERS_IGNORE_BATON)

/obj/item/melee/baton/security/stungloves/Destroy()
	qdel(assistant_killer) // This should never be neccessary except if admins are manually deleting players.
	return ..()

/obj/item/melee/baton/security/stungloves/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_GLOVES)
		RegisterSignal(user, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(punch_to_stun))
		assistant_killer = new(user)
		assistant_killer.Grant(user)
		user.add_traits(traits_to_give, TRAIT_GENERIC)

/obj/item/melee/baton/security/stungloves/dropped(mob/user)
	. = ..()
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		UnregisterSignal(user, COMSIG_LIVING_UNARMED_ATTACK)
		assistant_killer.Remove(user)
		qdel(assistant_killer) //Ensure this evaporates itself. Likely WILL NOT happen if an admin deletes someone wearing them, so handle it on destroy too.
		user.remove_traits(traits_to_give, TRAIT_GENERIC)

/obj/item/melee/baton/security/stungloves/proc/punch_to_stun(mob/living/carbon/human/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER
	if(!proximity)
		return NONE
	if(ishuman(target))
		if (source.combat_mode)
			return src.attack(target, source, !stun_on_harmbaton) //Make sure we stun them, or at worst case, just prod them if no cell
	if(ismob(target))
		if (source.combat_mode)
			return src.attack(target, source) //Make sure we beat they ass
	return NONE

/obj/item/melee/baton/security/stungloves/preloaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/datum/action/cooldown/toggle_stunners
	name = "Toggle Stungloves"
	desc = "Toggle your stungloves on or off."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS
	button_icon_state = "bci_power" //Placeholder
	cooldown_time = 0.25 SECONDS //Stops spam.

/datum/action/cooldown/toggle_stunners/Activate()
	. = ..()
	var/mob/living/carbon/human/shitsec = owner // we do a little trolling
	var/obj/item/melee/baton/security/stungloves/assistantkiller = shitsec.get_item_by_slot(ITEM_SLOT_GLOVES)
	assistantkiller.attack_self(shitsec) //handles turning this on and off pretty well
