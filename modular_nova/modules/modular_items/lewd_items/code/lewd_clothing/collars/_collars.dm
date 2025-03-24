// Basetype is actually a choker, but functionally it makes the most sense
/obj/item/clothing/neck/collar
	name = "choker"
	desc = "A little ring of cloth with a locking buckle sequestered on the back. Stylish - just \
		only under very specific conditions."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "thin_choker"
	greyscale_colors = "#2d2d33"
	greyscale_config = /datum/greyscale_config/thin_collar
	greyscale_config_worn = /datum/greyscale_config/thin_collar/worn
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = IS_PLAYER_COLORABLE_1
	interaction_flags_click = NEED_DEXTERITY
	/// Item path of on-init creation in the collar's storage
	var/key_path = /obj/item/key/collar
	/// Is this collar locked?
	var/locked = FALSE
	/// Is the lock busted?
	var/broken_lock = FALSE

/obj/item/clothing/neck/collar/Initialize(mapload)
	. = ..()
	// First; create our internal matching key
	create_storage(storage_type = /datum/storage/pockets/small)
	atom_storage.set_holdable(list(
		/obj/item/key/collar,
	))

	if(!key_path)
		return
	var/obj/item/key/collar/key = new key_path(src)
	if(!istype(key))
		return
	key.key_id = REF(src)
	// Next; register attempts to strip us
	RegisterSignal(src, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(can_unequip))

/obj/item/clothing/neck/collar/proc/can_unequip(obj/item/source, force, atom/newloc, no_move, invdrop, silent)
	var/mob/living/carbon/wearer = source.loc
	if(istype(wearer) && wearer?.wear_neck == source && locked)
		to_chat(wearer, span_warning("The collar is locked! You'll need to unlock it before you can take it off!"))
		return COMPONENT_ITEM_BLOCK_UNEQUIP
	return NONE

/obj/item/clothing/neck/collar/canStrip(mob/stripper, mob/owner)
	if(!locked)
		return ..()
	owner.balloon_alert(stripper, "locked!")
	return FALSE

/obj/item/clothing/neck/collar/proc/set_lock(to_lock, mob/user)
	if(!broken_lock)
		to_chat(user, span_warning("[to_lock ? "The collar locks with a resounding click!" : "The collar unlocks with a small clunk."]"))
		locked = to_lock
		return
	to_chat(user, span_warning("It looks like the lock is busted - now it's just an ordinary old collar."))
	locked = FALSE

/obj/item/clothing/neck/collar/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	var/obj/item/key/collar/key = tool
	if(!istype(key))
		return ..()
	if(key.key_id == REF(src))
		set_lock((!locked), user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("This isn't the correct key!"))
	return ITEM_INTERACT_BLOCKING

/obj/item/clothing/neck/collar/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(broken_lock)
		to_chat(user, span_warning("The lock is already broken!"))
		return
	to_chat(user, span_warning("You jam your screwdriver into the lock, searching to exploit the tension..."))
	if(!do_after(user, 3 SECONDS, user))
		return
	if(prob(33))
		to_chat(user, span_warning("You find your mark, and the lock pops open!"))
		broken_lock = TRUE
		set_lock(FALSE, user)
	else
		to_chat(user, span_warning("You can't quite get the lock to snap!"))

/obj/item/clothing/neck/collar/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(locked && src == user.get_item_by_slot(ITEM_SLOT_NECK)))
		return
	to_chat(user, span_warning("You hear a heavy click near your neck - it's apparant the collar's locked on!"))

/// This is a KEY moment of this code. You got it. Key.
/// ...
/// It's 2:56 of 08.04.2021, i want to sleep. Please laugh. // your suffering has been preserved for future generations

/obj/item/key/collar
	name = "collar key"
	desc = "A tiny key for a presumably tiny lock."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "key_collar"
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	interaction_flags_click = NEED_DEXTERITY
	/// The ID of the collar to pair with this key. Usually a ref to the collar.
	var/key_id = null

// check the passed mob or collar to see if we can unlock their collar
/obj/item/key/collar/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/carbon/target = interacting_with
	if(!istype(target) || !istype(target.wear_neck, /obj/item/clothing/neck/collar))
		return NONE
	var/obj/item/clothing/neck/collar/collar = target.wear_neck
	if(REF(collar) == src.key_id)
		collar.set_lock(!collar.locked, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("This isn't the correct key!"))
	return ITEM_INTERACT_BLOCKING
