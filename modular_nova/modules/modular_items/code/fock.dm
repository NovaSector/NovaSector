/// Upper and lower bounds for the randomized damage dealt to doors
#define FOCK_DOOR_DAMAGE_LOWER 45
#define FOCK_DOOR_DAMAGE_UPPER 90
/// Upper and lower bounds for the randomized damage dealt to apcs
#define FOCK_APC_DAMAGE_LOWER 20
#define FOCK_APC_DAMAGE_UPPER 50
/// Upper and lower bounds for the jacking speed
#define FOCK_JACKING_SPEED_LOWER 12
#define FOCK_JACKING_SPEED_UPPER 18

/obj/item/multitool //we make the multitool cheaper on vending machines as this thing depreciates its price
	custom_premium_price = PAYCHECK_COMMAND * 2 //originally 300, becomes 200 credits.

// So, this is a multitool that it's whole deal is that it lets people unlock doors like a PAI, and unlock (or relock!) apc's and air alarms, but doing so causes damage to it, unless the apc or air alarm are being locked, then no damage.

/obj/item/multitool/fock
	name = "full override control kit"
	desc = parent_type::desc + " The F.O.C.K. additionally allows the user to engage the emergency protocols of doors, apc's and air alarms."
	special_desc = "Made by a disgruntled inventor that got into an argument with the FTU over their colonial prybars, the Full Override Control Kit \
	is marketed as a solution to emergency situations where the integrity of machinery is of less concern than the lives at stake of their users. \
	Sadly, some unsavory types had been known to be using the F.O.C.K. to do the exact kind of activities that the inventor wanted to stop. "
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "multitool"
	inhand_icon_state = "multitool"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_premium_price = PAYCHECK_COMMAND * 3

/obj/item/multitool/fock/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/machinery/door/airlock))
		hack_door(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	if(istype(interacting_with, /obj/machinery/airalarm))
		hack_air_alarm(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	if(istype(interacting_with, /obj/machinery/power/apc))
		hack_apc(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/multitool/fock/proc/hack_door(obj/machinery/door/door, mob/living/user) //stolen from Pai hacking
	playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 50, TRUE)
	balloon_alert(user, "overriding...")
	do_sparks(4, TRUE, door)
	visible_message(span_warning("Sparks fly out of [door]!"))
	if(door.locked)
		to_chat(user, span_warning("The [door]'s bolts prevent it from being forced!"))
		balloon_alert(user, "failed!")
		return FALSE
	if(door.welded)
		to_chat(user, span_warning("It's welded, it won't budge!"))
		balloon_alert(user, "failed!")
		return FALSE
	if(!do_after(user, rand(FOCK_JACKING_SPEED_LOWER, FOCK_JACKING_SPEED_UPPER) SECONDS, door, timed_action_flags = NONE, progress = TRUE))
		balloon_alert(user, "failed!")
		do_sparks(2, TRUE, door)
		return FALSE
	balloon_alert(user, "success")
	door.open()
	door.take_damage(rand(FOCK_DOOR_DAMAGE_LOWER, FOCK_DOOR_DAMAGE_UPPER), BRUTE)
	do_sparks(4, FALSE, door)
	return TRUE

/obj/item/multitool/fock/proc/hack_air_alarm(obj/machinery/airalarm/airalarm, mob/living/user)
	playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	balloon_alert(user, "overriding...")
	do_sparks(2, TRUE, airalarm)
	visible_message(span_warning("Sparks fly out of [airalarm]!"))
	if(!do_after(user, rand(FOCK_JACKING_SPEED_LOWER, FOCK_JACKING_SPEED_UPPER) SECONDS, airalarm, timed_action_flags = NONE, progress = TRUE))
		balloon_alert(user, "failed!")
		do_sparks(1, TRUE, airalarm)
		return FALSE
	balloon_alert(user, "success")
	airalarm.locked = !airalarm.locked
	airalarm.update_appearance()
	if(!airalarm.locked)
		airalarm.ui_interact(user)
		airalarm.take_damage(rand(FOCK_APC_DAMAGE_LOWER, FOCK_APC_DAMAGE_UPPER), BRUTE)
	do_sparks(3, FALSE, airalarm)
	return TRUE

/obj/item/multitool/fock/proc/hack_apc(obj/machinery/power/apc/apc, mob/living/user)
	playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	balloon_alert(user, "overriding...")
	do_sparks(2, TRUE, apc)
	visible_message(span_warning("Sparks fly out of [apc]!"))
	if(!do_after(user, rand(FOCK_JACKING_SPEED_LOWER, FOCK_JACKING_SPEED_UPPER) SECONDS, apc, timed_action_flags = NONE, progress = TRUE))
		balloon_alert(user, "failed!")
		do_sparks(1, TRUE, apc)
		return FALSE
	balloon_alert(user, "success")
	apc.locked = !apc.locked
	apc.update_appearance()
	if(!apc.locked)
		apc.ui_interact(user)
		apc.take_damage(rand(FOCK_APC_DAMAGE_LOWER, FOCK_APC_DAMAGE_UPPER), BRUTE)
	do_sparks(3, FALSE, apc)
	return TRUE

#undef FOCK_DOOR_DAMAGE_LOWER
#undef FOCK_DOOR_DAMAGE_UPPER
#undef FOCK_APC_DAMAGE_LOWER
#undef FOCK_APC_DAMAGE_UPPER
#undef FOCK_JACKING_SPEED_LOWER
#undef FOCK_JACKING_SPEED_UPPER
