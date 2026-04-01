/obj/item/organ/brain/synth
	name = "compact positronic brain"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"
	/// The last time (in ticks) a message about brain damage was sent. Don't touch.
	var/last_message_time = 0
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)
	var/obj/item/modular_computer/pda/synth/internal_computer
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)

	///Can be set to tell ghosts what the brain will be used for
	var/ask_role = ""
	///Role assigned to the newly created mind
	var/posibrain_job_path = /datum/job/positronic_brain
	///World time tick when ghost polling will be available again
	var/next_ask
	///Delay after polling ghosts
	var/ask_delay = 60 SECONDS
	///One of these names is randomly picked as the posibrain's name on possession. If left blank, it will use the global posibrain names
	var/list/possible_names
	///Picked posibrain name
	var/picked_name
	///Whether this positronic brain is currently looking for a ghost to enter it.
	var/searching = FALSE

	///Message sent to the user when polling ghosts
	var/begin_activation_message = span_notice("You carefully locate the manual activation switch and start the positronic brain's boot process.")
	///Message sent as a visible message on success
	var/success_message = span_notice("The positronic brain pings, and its lights start flashing. Success!")
	///Message sent as a visible message on failure
	var/fail_message = span_notice("The positronic brain buzzes quietly, and the golden lights fade away. Perhaps you could try again?")
	///Visible message sent when a player possesses the brain
	var/new_mob_message = span_notice("The positronic brain chimes quietly.")
	///Examine message when the posibrain has no mob
	var/dead_message = span_deadsay("It appears to be completely inactive. The reset light is blinking.")
	///Examine message when the posibrain cannot poll ghosts due to cooldown
	var/recharge_message = span_warning("The positronic brain isn't ready to activate again yet! Give it some time to recharge.")

/obj/item/organ/brain/synth/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "robot", BUBBLE_ICON_PRIORITY_ORGAN)
	internal_computer = new(src)
	ADD_TRAIT(src, TRAIT_SILICON_EMOTES_ALLOWED, INNATE_TRAIT)

/obj/item/organ/brain/synth/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()
	var/mob/living/carbon/human/human_brain_owner = brain_owner
	if(!istype(human_brain_owner))
		return

	if(human_brain_owner.stat == DEAD && HAS_TRAIT(human_brain_owner, TRAIT_REVIVES_BY_HEALING) && human_brain_owner.health > SYNTH_BRAIN_WAKE_THRESHOLD)
		human_brain_owner.revive(FALSE)

	RegisterSignal(human_brain_owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_signal))
	if(internal_computer && human_brain_owner.wear_id)
		internal_computer.handle_id_slot(human_brain_owner, human_brain_owner.wear_id)

/obj/item/organ/brain/synth/emp_act(severity) // EMP act against the posi, keep the cap far below the organ health
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)

	switch(severity)
		if(EMP_HEAVY)
			to_chat(owner, span_warning("01001001 00100111 01101101 00100000 01100110 01110101 01100011 01101011 01100101 01100100 00101110"))
			apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)
		if(EMP_LIGHT)
			to_chat(owner, span_warning("Alert: Electromagnetic damage taken in central processing unit. Error Code: 401-YT"))
			apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)

/obj/item/organ/brain/synth/apply_organ_damage(damage_amount, maximum, required_organ_flag)
	. = ..()

	if(owner && damage > 0 && (world.time - last_message_time) > SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL)
		last_message_time = world.time

		if(damage > BRAIN_DAMAGE_SEVERE)
			to_chat(owner, span_warning("Alre: re oumtnin ilir tocorr:pa ni ne:cnrrpiioruloomatt cessingode: P1_1-H"))
			return

		if(damage > BRAIN_DAMAGE_MILD)
			to_chat(owner, span_warning("Alert: Minor corruption in central processing unit. Error Code: 001-HP"))

/obj/item/organ/brain/synth/Destroy()
	QDEL_NULL(internal_computer)
	return ..()

/obj/item/organ/brain/synth/on_mob_remove(mob/living/carbon/human/brain_owner, special)
	. = ..()
	if(!istype(brain_owner))
		return
	UnregisterSignal(brain_owner, COMSIG_MOB_EQUIPPED_ITEM)
	if(internal_computer)
		internal_computer.handle_id_slot(brain_owner)
		internal_computer.clear_id_slot_signals(brain_owner.wear_id)

/obj/item/organ/brain/synth/proc/on_equip_signal(datum/source, obj/item/item, slot)
	SIGNAL_HANDLER
	if(isnull(internal_computer))
		return
	if(slot == ITEM_SLOT_ID)
		internal_computer.handle_id_slot(owner, item)

/obj/item/organ/brain/synth/click_alt(mob/living/user)
	var/input_seed = tgui_input_text(user, "Enter a personality seed", "Enter seed", ask_role, max_length = MAX_NAME_LEN)
	if(isnull(input_seed) || !user.can_perform_action(src))
		return CLICK_ACTION_BLOCKING
	to_chat(user, span_notice("You set the personality seed to \"[input_seed]\"."))
	ask_role = input_seed
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/organ/brain/synth/attack_self(mob/user)
	if(!brainmob)
		brainmob = new(src)
	if(!(GLOB.ghost_role_flags & GHOSTROLE_SILICONS))
		to_chat(user, span_warning("Central Command has temporarily outlawed posibrain sentience in this sector..."))
	if(brainmob.ckey)
		to_chat(user, span_warning("This [name] is already active!"))
		return
	if(next_ask > world.time)
		to_chat(user, recharge_message)
		return
	//Start the process of requesting a new ghost.
	to_chat(user, begin_activation_message)
	ping_ghosts("requested", FALSE)
	next_ask = world.time + ask_delay
	searching = TRUE
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(check_success)), ask_delay)

/obj/item/organ/brain/synth/proc/check_success()
	searching = FALSE
	update_appearance()
	if(QDELETED(brainmob))
		return
	if(brainmob.client)
		visible_message(success_message)
		playsound(src, 'sound/machines/ping.ogg', 15, TRUE)
	else
		visible_message(fail_message)

///Notify ghosts that the posibrain is up for grabs
/obj/item/organ/brain/synth/proc/ping_ghosts(msg, newlymade)
	if(newlymade || GLOB.posibrain_notify_cooldown <= world.time)
		notify_ghosts(
			"[name] [msg] in [get_area(src)]! [ask_role ? "Personality requested: \[[ask_role]\]" : ""]",
			source = src,
			header = "Ghost in the Machine",
			click_interact = TRUE,
			ghost_sound = !newlymade ? 'sound/effects/ghost2.ogg':null,
			ignore_key = POLL_IGNORE_POSIBRAIN,
			notify_flags = (GHOST_NOTIFY_IGNORE_MAPLOAD),
			notify_volume = 75,
		)
		if(!newlymade)
			GLOB.posibrain_notify_cooldown = world.time + ask_delay

/obj/item/organ/brain/synth/attack_ghost(mob/user)
	if(QDELETED(brainmob))
		return
	if(brainmob.ckey || is_banned_from(user.ckey, ROLE_POSIBRAIN) || QDELETED(src) || QDELETED(user))
		return
	var/posi_ask = tgui_alert(user, "Become a [name]? (Warning, You can no longer be revived, and all past lives will be forgotten!)", "Confirm", list("Yes","No"))
	if(posi_ask != "Yes" || QDELETED(src))
		return
	if(HAS_TRAIT(brainmob, TRAIT_SUICIDED)) //clear suicide status if the old occupant suicided.
		brainmob.set_suicide(FALSE)
	transfer_personality(user)

/obj/item/organ/brain/synth/proc/transfer_personality(mob/candidate)
	if(QDELETED(brainmob))
		return
	if(brainmob.ckey) //Prevents hostile takeover if two ghosts get the prompt or link for the same brain.
		to_chat(candidate, span_warning("This [name] was taken over before you could get to it! Perhaps it might be available later?"))
		return FALSE
	if(candidate.mind && !isobserver(candidate))
		candidate.mind.transfer_to(brainmob)
	else
		brainmob.PossessByPlayer(candidate.ckey)
	name = "[initial(name)] ([brainmob.name])"
	var/policy = get_policy(ROLE_POSIBRAIN)
	if(policy)
		to_chat(brainmob, policy)
	brainmob.mind.set_assigned_role(SSjob.get_job_type(posibrain_job_path))
	brainmob.set_stat(CONSCIOUS)
	brainmob.grant_language(/datum/language/machine, source = LANGUAGE_ATOM)

	visible_message(new_mob_message)
	check_success()
	return TRUE

/obj/item/organ/brain/synth/examine(mob/user)
	. = ..()
	if(brainmob?.key)
		switch(brainmob.stat)
			if(CONSCIOUS)
				if(!brainmob.client)
					. += "It appears to be in stand-by mode." //afk
			if(DEAD)
				. += span_deadsay("It appears to be completely inactive.")
	else
		. += "[dead_message]"
		if(ask_role)
			. += span_notice("Current consciousness seed: \"[ask_role]\"")
		. += span_boldnotice("Alt-click to set a consciousness seed, specifying what [src] will be used for. This can help generate a personality interested in that role.")

/obj/item/organ/brain/synth/update_icon_state()
	. = ..()
	if(searching)
		icon_state = "[base_icon_state]-searching"
		return
	if(brainmob?.key)
		icon_state = "[base_icon_state]-occupied"
		return
	icon_state = "[base_icon_state]"
	return

/obj/item/organ/brain/synth/circuit
	name = "compact AI circuit"
	desc = "A compact and extremely complex circuit, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_nova/master_files/icons/obj/alt_silicon_brains.dmi'
	icon_state = "circuit-occupied"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/organ/brain/synth/circuit/hyperboard
	name = "compact hyperboard circuit"
	desc = "A compact and extremely complex circuit, made with more advanced technologies at least visually, but its perfectly dimensioned to fit in \
		the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crew members."
	icon_state = "hyperboard-occupied"

/obj/item/organ/brain/synth/circuit/limaengine
	name = "compact lima-engine circuit"
	desc = "A compact and extremely complex circuit, seeming to have a tube of fluid that holds its electricity and yet it defies the laws of gravity, but the weight of the board keeps it down... \
		it seems perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crew members."
	icon_state = "limaengine-occupied"

/obj/item/organ/brain/synth/circuit/disk
	name = "compact ai braindisk circuit"
	desc = "A compact and rather ancient disk, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crew members."
	icon_state = "diskbrain-occupied"

/obj/item/organ/brain/synth/circuit/neuroboard
	name = "compact neuroboard circuit"
	desc = "A compact and extremely complex circuit. It seems to have an overwhelming amount of processing power and yet its perfectly dimensioned to fit \
		in the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crew members."
	icon_state = "neuroboard-occupied"

/obj/item/organ/brain/synth/circuit/condensed
	name = "compact hypercrystal"
	desc = "A compact and extremely complex crystal it has no visibly solderings or circuits of any kind yet its perfectly dimensioned to fit in \
		the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crew members."
	icon_state = "condensed-occupied"

/obj/item/organ/brain/synth/circuit/cyberdeck
	name = "compact advanced cyberdeck"
	desc = "A strange black, smooth complex device, it feels like a solid chunk off metal but yet it seems as if its, perfectly dimensioned to fit in the same slot as a \
		synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crew members."
	icon_state = "cyberdeck-occupied"

/obj/item/organ/brain/synth/mmi
	name = "compact man-machine interface"
	desc = "A compact man-machine interface, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. Unfortunately, the brain seems to be permanently attached to the circuitry, and it seems relatively sensitive to its environment. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	icon_state = "mmi-ipc"
