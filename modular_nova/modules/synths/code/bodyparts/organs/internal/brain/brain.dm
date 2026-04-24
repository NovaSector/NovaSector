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
	var/obj/effect/dummy/lighting_obj/moblight/robot_beacon/our_beacon
	var/distress_beacon_active = FALSE
	var/beacon_light_timer

/obj/item/organ/brain/synth/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "robot", BUBBLE_ICON_PRIORITY_ORGAN)
	internal_computer = new(src)
	ADD_TRAIT(src, TRAIT_SILICON_EMOTES_ALLOWED, INNATE_TRAIT)

/obj/item/organ/brain/synth/proc/activate_distress_beacon()
	distress_beacon_active = TRUE
	pulse_beacon_light()
	beacon_light_timer = addtimer(CALLBACK(src, PROC_REF(pulse_beacon_light)), 2 SECONDS, TIMER_STOPPABLE | TIMER_LOOP | TIMER_DELETE_ME)

/obj/item/organ/brain/synth/proc/pulse_beacon_light()
	our_beacon.set_light_on(!our_beacon.light_on) // toggle that mf

/obj/item/organ/brain/synth/proc/deactivate_distress_beacon()
	distress_beacon_active = FALSE
	our_beacon.set_light_on(FALSE)
	deltimer(beacon_light_timer)

/obj/item/organ/brain/synth/on_life(seconds_per_tick)
	. = ..()
	if(owner && owner.stat != DEAD && distress_beacon_active)
		deactivate_distress_beacon()

/obj/item/organ/brain/synth/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags)
	. = ..()
	var/mob/living/carbon/human/human_brain_owner = brain_owner
	if(!istype(human_brain_owner))
		return

	if(human_brain_owner.stat == DEAD && HAS_TRAIT(human_brain_owner, TRAIT_REVIVES_BY_HEALING) && human_brain_owner.health > SYNTH_BRAIN_WAKE_THRESHOLD)
		human_brain_owner.revive(FALSE)
	RegisterSignal(human_brain_owner, COMSIG_LIVING_DEATH, PROC_REF(activate_distress_beacon_death))
	RegisterSignal(human_brain_owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_signal))
	if(internal_computer && human_brain_owner.wear_id)
		internal_computer.handle_id_slot(human_brain_owner, human_brain_owner.wear_id)
	wake_the_fuck_up_samurai()

/obj/item/organ/brain/synth/proc/activate_distress_beacon_death(mob/living/target, gibbed)
	SIGNAL_HANDLER
	if(!distress_beacon_active)
		activate_distress_beacon()

/obj/item/organ/brain/synth/emp_act(severity) // EMP act against the posi, keep the cap far below the organ health
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return
	if(distress_beacon_active)
		deactivate_distress_beacon()

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
	wake_the_fuck_up_samurai()
	return ..()

/obj/item/organ/brain/synth/on_mob_remove(mob/living/carbon/human/brain_owner, special)
	. = ..()
	if(!istype(brain_owner))
		return
	UnregisterSignal(brain_owner, COMSIG_MOB_EQUIPPED_ITEM)
	if(internal_computer)
		internal_computer.handle_id_slot(brain_owner)
		internal_computer.clear_id_slot_signals(brain_owner.wear_id)
	wake_the_fuck_up_samurai()

/obj/item/organ/brain/synth/proc/trigger_reboot()
	if(owner)
		say("Powering down for reboot.")
		SEND_SOUND(owner.client, sound(null))
		play_cinematic(/datum/cinematic/robot_reboot, list(owner)) // start that shit
		ADD_TRAIT(owner, TRAIT_DEAF, "robot_reboot")
		ADD_TRAIT(owner, TRAIT_MUTE, "robot_reboot")
		owner.become_blind("robot_reboot")
		owner.apply_status_effect(/datum/status_effect/incapacitating/stun, "robot_reboot")
		addtimer(CALLBACK(src, PROC_REF(wake_the_fuck_up_samurai)), 6 SECONDS)
		// Now that we're "shut down", start fixing shit over the next 10 seconds while we're incapacitated
		for(var/datum/reagent/neuroware_reagent in owner.reagents.reagent_list)
			if(neuroware_reagent.chemical_flags & REAGENT_NEUROWARE)
				owner.reagents.remove_reagent(neuroware_reagent.type, neuroware_reagent.volume, TRUE)
		owner.cure_all_traumas(TRAUMA_RESILIENCE_BASIC)
		owner.set_disgust(0)
		owner.remove_status_effect(/datum/status_effect/drowsiness)
		owner.remove_status_effect(/datum/status_effect/dizziness)
		owner.remove_status_effect(/datum/status_effect/jitter)
		owner.remove_status_effect(/datum/status_effect/confusion)
		owner.remove_status_effect(/datum/status_effect/drugginess)
		owner.remove_status_effect(/datum/status_effect/silenced)
		owner.remove_status_effect(/datum/status_effect/hallucination)
		owner.remove_status_effect(/datum/status_effect/speech/stutter)
		owner.remove_status_effect(/datum/status_effect/speech/stutter/anxiety)
		owner.remove_status_effect(/datum/status_effect/speech/stutter/derpspeech)
		owner.remove_status_effect(/datum/status_effect/speech/slurring)
		owner.remove_status_effect(/datum/status_effect/speech/slurring/cult)
		owner.remove_status_effect(/datum/status_effect/speech/slurring/drunk)
		owner.remove_status_effect(/datum/status_effect/speech/slurring/generic)
		owner.remove_status_effect(/datum/status_effect/speech/slurring/heretic)
		if(owner.mob_mood)
			owner.mob_mood.remove_temp_moods()
			owner.mob_mood.reset_sanity(SANITY_DISTURBED)
		set_organ_damage(0)

/obj/item/organ/brain/synth/proc/wake_the_fuck_up_samurai()
	if(owner)
		REMOVE_TRAIT(owner, TRAIT_DEAF, "robot_reboot")
		REMOVE_TRAIT(owner, TRAIT_MUTE, "robot_reboot")
		owner.cure_blind("robot_reboot")
		owner.remove_status_effect(/datum/status_effect/incapacitating/stun, "robot_reboot")


/obj/item/organ/brain/synth/proc/on_equip_signal(datum/source, obj/item/item, slot)
	SIGNAL_HANDLER
	if(isnull(internal_computer))
		return
	if(slot == ITEM_SLOT_ID)
		internal_computer.handle_id_slot(owner, item)

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
