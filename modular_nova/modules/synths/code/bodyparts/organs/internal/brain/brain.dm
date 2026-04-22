/obj/item/organ/brain/synth
	name = "compact positronic brain"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"
	brain_size = 0.8 // *compact* posibrain
	/// The last time (in ticks) a message about brain damage was sent. Don't touch.
	var/last_message_time = 0
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)
	var/obj/item/modular_computer/pda/synth/internal_computer
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)

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

/obj/item/organ/brain/synth/update_icon_state()
	. = ..()
	if(brainmob?.key)
		icon_state = "[src::name]-occupied"
		return
	icon_state = "[src::name]"
	return

/datum/design/synth_posi
	name = "Compact Positronic Brain"
	desc = "Inactive compact positronic brain."
	id = "synth_posi"
	build_type = MECHFAB
	construction_time = 30 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/brain/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/synth_posi/create_result(atom/drop_loc, list/custom_materials, amount)
	var/obj/item/organ/brain/synth/new_posi = ..()
	new_posi.AddComponent( \
		/datum/component/ghostrole_on_revive, \
		refuse_revival_if_failed = TRUE, \
		on_successful_revive = CALLBACK(src, PROC_REF(on_successful_revive), new_posi), \
		revive_title = "a newly created android", \
		spawn_text = "New Android", \
		you_are_text = "You are a newly created android.", \
		flavor_text = " Do your best to help the station.", \
		important_text = "While not being lawbound as cyborgs or AIs, your continued existence is still in hands of your creators, so try to behave well! You are not an antagonist but can still roll for one.", \
	)
	return new_posi

/datum/design/synth_posi/proc/on_successful_revive(obj/item/organ/brain/synth/our_posi)
	var/mob/living/carbon/human/owner = our_posi.owner
	var/inputed_name = tgui_input_text(owner, "Enter your new name", "Your name", owner.real_name, max_length = MAX_NAME_LEN)
	if(!isnull(inputed_name))
		owner.real_name = inputed_name
	owner.mind.add_antag_datum(/datum/antagonist/recovered_crew) //admin tooling, to discern between normal crew and ghost crew

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
