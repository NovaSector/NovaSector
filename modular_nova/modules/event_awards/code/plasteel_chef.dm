/// Plasteel Chef Event

// THATS A KNOIFE
/obj/item/knife/kitchen/plasteel_chef
	name = "émincer"
	icon = 'modular_nova/modules/event_awards/icons/kitchen.dmi'
	lefthand_file = 'modular_nova/modules/event_awards/icons/kitchen_lefthand.dmi'
	righthand_file = 'modular_nova/modules/event_awards/icons/kitchen_righthand.dmi'
	slot_flags = ITEM_SLOT_HANDS
	desc = "A custom exotic knife, made of plasteel with a golden trim on a wooden handle. An icon is etched at the base of the blade, with a chef knife crossing on top of a butchering cleaver. The winners named is carved on the handle."
	/// The ckeys allowed to get the mood buff from this event reward.
	var/static/list/allowed_ckeys

// Mood define
/datum/mood_event/plasteel_chef
	description = "You have an extreme sense of pride at what you've accomplished."
	mood_change = 3

// Mood application
/obj/item/knife/kitchen/plasteel_chef/equipped(mob/living/user, slot)
	. = ..()
	if(!(user.ckey in allowed_ckeys))
		return
	if(slot_flags & slot)
		user.add_mood_event("plasteel_chef", /datum/mood_event/plasteel_chef)

// Remove it once they set the knife down
/obj/item/knife/kitchen/plasteel_chef/dropped(mob/living/user)
	. = ..()
	user.clear_mood_event("plasteel_chef")

// loadout whitelist
/datum/loadout_item/inhand/plasteel_chef
	name = "émincer"
	item_path = /obj/item/knife/kitchen/plasteel_chef
	ckeywhitelist = list("bearagon", "mrsanderp")

/datum/loadout_item/inhand/plasteel_chef/on_equip_item(
	obj/item/knife/kitchen/plasteel_chef/equipped_item,
	datum/preferences/preference_source,
	list/preference_list,
	mob/living/carbon/human/equipper,
	visuals_only = FALSE,
)
	. = ..()
	equipped_item.allowed_ckeys = ckeywhitelist.Copy()
	equipper.add_mood_event("plasteel_chef", /datum/mood_event/plasteel_chef)
