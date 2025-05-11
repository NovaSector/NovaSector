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
	return ..()

/obj/item/mind_controller/attack_self(mob/user)
	if(!collar)
		return
	var/new_emotion_pattern = tgui_input_text(user, "Change the emotion pattern.", max_length = MAX_MESSAGE_LEN)
	if(!isnull(new_emotion_pattern))
		collar.emoting = new_emotion_pattern
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
	/// What the default emoting pattern is set to
	var/emoting = "Shivers."

/obj/item/clothing/neck/mind_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small)
	atom_storage.set_holdable(/obj/item/mind_controller)
	remote = new /obj/item/mind_controller(src, src)
	remote.forceMove(src)

/// Makes the controlled person actually perform the emote.
/obj/item/clothing/neck/mind_collar/proc/emoting_proc()
	var/mob/living/carbon/human/user = src.loc
	if(istype(user) && src == user.wear_neck)
		user.emote("me", 1, "[emoting]", TRUE)

/obj/item/clothing/neck/mind_collar/Destroy()
	QDEL_NULL(remote)
	return ..()
