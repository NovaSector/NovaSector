/obj/item/clothing/neck/kink_collar
	name = "collar"
	desc = "A nice, tight collar. It fits snug to your skin"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_cyan"
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	interaction_flags_click = NEED_DEXTERITY
	unique_reskin = list("Cyan" = "collar_cyan",
						"Yellow" = "collar_yellow",
						"Green" = "collar_green",
						"Red" = "collar_red",
						"Latex" = "collar_latex",
						"Orange" = "collar_orange",
						"White" = "collar_white",
						"Purple" = "collar_purple",
						"Black" = "collar_black",
						"Black-teal" = "collar_tealblack",
						"Spike" = "collar_spike")
	/// Item path of on-init creation in the collar's storage
	var/treat_path = /obj/item/food/cookie

//spawn thing in collar

/obj/item/clothing/neck/kink_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small)
	atom_storage.set_holdable(list(
		/obj/item/food/cookie,
		/obj/item/key/kink_collar,
	))

	if(!treat_path)
		return
	var/obj/item/key/kink_collar/key = new treat_path(src)
	if(!istype(key))
		return
	key.key_id = REF(src)

/obj/item/clothing/neck/kink_collar/locked
	name = "locked collar"
	desc = "A tight collar. It appears to have some kind of lock."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "lock_collar_cyan"
	treat_path = /obj/item/key/kink_collar
	interaction_flags_click = NEED_DEXTERITY
	unique_reskin = list("Cyan" = "lock_collar_cyan",
						"Yellow" = "lock_collar_yellow",
						"Green" = "lock_collar_green",
						"Red" = "lock_collar_red",
						"Latex" = "lock_collar_latex",
						"Orange" = "lock_collar_orange",
						"White" = "lock_collar_white",
						"Purple" = "lock_collar_purple",
						"Black" = "lock_collar_black",
						"Black-teal" = "lock_collar_tealblack",
						"Spike" = "lock_collar_spike")
	/// If the collar is currently locked
	var/locked = FALSE
	/// If the collar has been broken or not
	var/broken = FALSE

/obj/item/clothing/neck/kink_collar/locked/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(can_unequip))

/obj/item/clothing/neck/kink_collar/locked/proc/can_unequip(obj/item/source, force, atom/newloc, no_move, invdrop, silent)
	var/mob/living/carbon/wearer = source.loc
	if(istype(wearer) && wearer.wear_neck == source && locked)
		to_chat(wearer, "The collar is locked! You'll need to unlock it before you can take it off!")
		return COMPONENT_ITEM_BLOCK_UNEQUIP
	return NONE

/obj/item/clothing/neck/kink_collar/locked/canStrip(mob/stripper, mob/owner)
	if(!locked)
		return ..()
	owner.balloon_alert(stripper, "locked!")
	return FALSE

//spawn thing in collar

//locking or unlocking collar code

/obj/item/clothing/neck/kink_collar/locked/proc/set_lock(to_lock, mob/user)
	if(!broken)
		to_chat(user, span_warning("[to_lock ? "The collar locks with a resounding click!" : "The collar unlocks with a small clunk."]"))
		locked = to_lock
		return
	to_chat(user, span_warning("It looks like the lock is broken - now it's just an ordinary old collar."))
	locked = FALSE

/obj/item/clothing/neck/kink_collar/locked/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	var/obj/item/key/kink_collar/key = tool
	if(!istype(key))
		return ..()
	if(key.key_id == REF(src))
		set_lock((!locked), user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("This isn't the correct key!"))
	return ITEM_INTERACT_BLOCKING

/obj/item/clothing/neck/kink_collar/locked/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(locked && src == user.get_item_by_slot(ITEM_SLOT_NECK)))
		return
	to_chat(user, span_warning("You hear a suspicious click around your neck - it seems the collar is now locked!"))

//This is a KEY moment of this code. You got it. Key.
//...
//It's 2:56 of 08.04.2021, i want to sleep. Please laugh.

/obj/item/key/kink_collar
	name = "kink collar key"
	desc = "A key for a tiny lock on a collar or bag."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "collar_key_metal"
	base_icon_state = "collar_key"
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	interaction_flags_click = NEED_DEXTERITY
	/// The ID of the key to pair with a collar. Will normally be the ref of the collar
	var/key_id = null //Adding same unique id to key
	unique_reskin = list("Cyan" = "collar_key_blue",
						"Yellow" = "collar_key_yellow",
						"Green" = "collar_key_green",
						"Red" = "collar_key_red",
						"Latex" = "collar_key_latex",
						"Orange" = "collar_key_orange",
						"White" = "collar_key_white",
						"Purple" = "collar_key_purple",
						"Black" = "collar_key_black",
						"Metal" = "collar_key_metal",
						"Black-teal" = "collar_key_tealblack")

//we checking if we can open collar with THAT KEY with SAME ID as the collar.
/obj/item/key/kink_collar/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/carbon/pet = interacting_with
	if(!istype(pet) || !istype(pet.wear_neck, /obj/item/clothing/neck/kink_collar/locked))
		return NONE
	var/obj/item/clothing/neck/kink_collar/locked/collar = pet.wear_neck
	if(REF(collar) == src.key_id)
		collar.set_lock(!collar.locked, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("This isn't the correct key!"))
	return ITEM_INTERACT_BLOCKING

/obj/item/circular_saw/attack(mob/living/carbon/target, mob/living/user, params)
	if(!istype(target))
		return ..()
	if(!istype(target.wear_neck, /obj/item/clothing/neck/kink_collar/locked))
		return ..()
	var/obj/item/clothing/neck/kink_collar/locked/collar = target.wear_neck
	if(collar.broken)
		to_chat(user, span_warning("The lock is already broken!"))
		return
	to_chat(user, span_warning("You try to cut the lock right off!"))
	if(target != user)
		if(!do_after(user, 2 SECONDS, target))
			return
		collar.broken = TRUE
		collar.set_lock(FALSE, user)
		if(prob(33)) //chance to get damage
			to_chat(user, span_warning("You successfully cut away the lock, but gave [target.name] several cuts in the process!"))
			target.apply_damage(rand(1, 4), BRUTE, BODY_ZONE_HEAD, wound_bonus = 10)
		else
			to_chat(user, span_warning("You successfully cut away the lock!"))
	else
		if(!do_after(user, 3 SECONDS, target))
			return
		if(prob(33))
			to_chat(user, span_warning("You successfully cut away the lock, but gave yourself several cuts in the process!"))
			collar.broken = TRUE
			collar.set_lock(FALSE, user)
			target.apply_damage(rand(2, 4), BRUTE, BODY_ZONE_HEAD, wound_bonus = 10)
		else
			to_chat(user, span_warning("You fail to cut away the lock, cutting yourself in the process!"))
			target.apply_damage(rand(3, 5), BRUTE, BODY_ZONE_HEAD, wound_bonus = 30)

//Ok, first - it's not mind control. Just forcing someone to do emotes that user added to remote thingy. Just a funny illegal ERP toy.

//Controller stuff
/obj/item/mind_controller
	name = "mind controller"
	desc = "A small remote for sending basic emotion patterns to a collar."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "mindcontroller"
	/// Reference to the mind control collar
	var/obj/item/clothing/neck/mind_collar/collar = null
	w_class = WEIGHT_CLASS_SMALL

/obj/item/mind_controller/Initialize(mapload, collar_init)
	. = ..()
	src.collar = collar_init

/obj/item/mind_controller/Destroy(force)
	collar?.remote = null
	collar = null
	. = ..()

/obj/item/mind_controller/attack_self(mob/user)
	if(!collar)
		return
	collar.emoting = tgui_input_text(user, "Change the emotion pattern.", max_length = MAX_MESSAGE_LEN)
	collar.emoting_proc()

//Collar stuff
/obj/item/clothing/neck/mind_collar
	name = "mind collar"
	desc = "A tight collar. It has some strange high-tech emitters on the side."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "mindcollar"
	inhand_icon_state = null
	/// Reference to the mind control remote
	var/obj/item/mind_controller/remote = null
	var/emoting = "Shivers."

/obj/item/clothing/neck/mind_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small)
	atom_storage.set_holdable(/obj/item/mind_controller)
	remote = new /obj/item/mind_controller(src, src)
	remote.forceMove(src)

/obj/item/clothing/neck/mind_collar/proc/emoting_proc()
	var/mob/living/carbon/human/user = src.loc
	if(istype(user) && src == user.wear_neck)
		user.emote("me", 1, "[emoting]", TRUE)

/obj/item/clothing/neck/mind_collar/Destroy()
	remote?.collar = null
	remote = null
	. = ..()
