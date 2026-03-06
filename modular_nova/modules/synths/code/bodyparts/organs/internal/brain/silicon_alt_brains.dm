// Don't know of a better place to put these. They're technically related to synths, so they're going here.

/obj/item/mmi/posibrain/circuit
	name = "compact AI circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon = 'modular_nova/master_files/icons/obj/alt_silicon_brains.dmi'
	icon_state = "circuit"
	base_icon_state = "circuit"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	// It pains me to copy-paste so much, but I can't do it any other way
	begin_activation_message = span_notice("You carefully locate the manual activation switch and start the compact AI circuit's boot process.")
	success_message = span_notice("The compact AI circuit pings, and its lights start flashing. Success!")
	fail_message = span_notice("The compact AI circuit buzzes quietly, and the golden lights fade away. Perhaps you could try again?")
	new_mob_message = span_notice("The compact AI circuit chimes quietly.")
	recharge_message = span_warning("The compact AI circuit isn't ready to activate again yet! Give it some time to recharge.")

/obj/item/mmi/posibrain/circuit/hyperboard
	name = "compact hyperboard circuit"
	desc = "An advanced compact circuit... at least it looks advanced, however it's perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "hyperboard"
	base_icon_state = "hyperboard"
	fail_message = span_notice("The compact AI circuit buzzes quietly, and the cyan lights fade away. Perhaps you could try again?")

/obj/item/mmi/posibrain/circuit/limaengine
	name = "compact liquid-engine circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "limaengine"
	base_icon_state = "limaengine"

	begin_activation_message = span_notice("You carefully locate the manual activation switch, pulsing the liquid core. It seems as if it has starting the boot process.")
	success_message = span_notice("The liquid core comes to life, its fluids like a lava lamp defying gravity. Success!")
	fail_message = span_notice("The liquid becomes cold, losing its life, as it just coldly floats about... Perhaps give it another pulse.")
	new_mob_message = span_notice("The liquid core pulses itself seeming to come to life all on its own...")
	recharge_message = span_warning("The liquid core is not properly stable enough to pulse again, give it time to cool.")

/obj/item/mmi/posibrain/circuit/disk
	name = "compact ai braindisk circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "diskbrain"
	base_icon_state = "diskbrain"

	begin_activation_message = span_notice("You carefully locate the manual activation switch and start the disk's boot process.")
	success_message = span_notice("The disk pings to life with a smile displayed on it. Success!")
	fail_message = span_notice("The disk's display slowly turns off fading to its idle background... perhaps give it another try?")
	new_mob_message = span_notice("The disk display boots up with a happy smile... at least you hope it is...")
	recharge_message = span_warning("The disk is too hot right now, give it some time to cool.")

/obj/item/mmi/posibrain/circuit/neuroboard
	name = "compact neuroboard circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "neuroboard"
	base_icon_state = "neuroboard"

	begin_activation_message = span_notice("You carefully locate the manual activation switch and start the compact neural circuit's boot process.")
	fail_message = span_notice("The neural AI circuit buzzes quietly, and the golden lights fade away. Perhaps you could try again?")
	new_mob_message = span_notice("The neural AI circuit chimes quietly, booting to life.")
	recharge_message = span_warning("The neural AI circuit isn't ready to activate again yet! Give it some time to recharge.")

/obj/item/mmi/posibrain/circuit/condensed
	name = "condensed crystalline AI brain"
	desc = "A whole artificial brain in a crystal, made through advanced crystallization and possibly witchcraft, still requires electricity to function. Try not to touch the crystal, instead \
		hold it by the handles. Oddly enough it is perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "condensed"
	base_icon_state = "condensed"

	begin_activation_message = span_notice("You carefully shake the crystal activating it... it seems to be booting... at least... you hope it is...")
	success_message = span_notice("The crystal pulses consistently and rhythmically. Success!")
	fail_message = span_notice("The light in the crystal fades, as it ceases its rhythmic pulsing... Perhaps give it another shake?")
	new_mob_message = span_notice("The crystal rumbles to life seeming to have jumpstarted itself...")
	recharge_message = span_warning("The crystal is too fragile right now to be activated, give it some time to lose its built up charge.")

/obj/item/mmi/posibrain/circuit/cyberdeck
	name = "advanced cyberdeck"
	desc = "A whole artificial brain in a crystal, through advanced crystallization, still requires electricity to function. try not to touch the crystal, hold it by the handles instead. \
		It's perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "cyberdeck"
	base_icon_state = "cyberdeck"

	begin_activation_message = span_notice("You carefully tap the cyberdeck activating it... it seems to be booting... at least... you hope it is...")
	success_message = span_notice("The the deck brightens its lights, flashing its strange symbols and indicators. Success!")
	fail_message = span_notice("The lights from the cyberdeck fade back into its seamless material... Perhaps give it another tap?")
	new_mob_message = span_notice("The cyberdeck comes to life lacking any intervention... seeming to be active.")
	recharge_message = span_warning("The cyberdeck is... doing something... you don't really know what its doing, its just best you give it a bit time to relax.")

// CODE THAT ACTUALLY APPLIES THE BRAINS.
// See modular_nova/master_files/code/modules/client/preferences/brain.dm for Synth/IPC application.

/// Returns a type to use based off of a given preference value (ORGAN_PREF_POSI_BRAIN, ORGAN_PREF_MMI_BRAIN and ORGAN_PREF_CIRCUIT_BRAIN), and if they're a cyborg or not.
/mob/living/proc/prefs_get_brain_to_use(value, is_cyborg = FALSE)
	switch(value)
		if(ORGAN_PREF_POSI_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain : /obj/item/organ/brain/synth

		if(ORGAN_PREF_MMI_BRAIN)
			return is_cyborg ? /obj/item/mmi : /obj/item/organ/brain/synth/mmi

		if(ORGAN_PREF_CIRCUIT_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit : /obj/item/organ/brain/synth/circuit

		if(ORGAN_PREF_HYPERBOARD_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit/hyperboard : /obj/item/organ/brain/synth/circuit/hyperboard

		if(ORGAN_PREF_LIMAENGINE_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit/limaengine : /obj/item/organ/brain/synth/circuit/limaengine

		if(ORGAN_PREF_DISKBRAIN_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit/disk : /obj/item/organ/brain/synth/circuit/disk

		if(ORGAN_PREF_NEUROBOARD_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit/neuroboard : /obj/item/organ/brain/synth/circuit/neuroboard

		if(ORGAN_PREF_CONDENSED_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit/condensed : /obj/item/organ/brain/synth/circuit/condensed

		if(ORGAN_PREF_CYBERDECK_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit/cyberdeck : /obj/item/organ/brain/synth/circuit/cyberdeck

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	// Intentionally set like this, because people have different lore for their cyborgs, and there's no real non-invasive way to print posibrains that match.
	RegisterSignal(src, COMSIG_MOB_MIND_TRANSFERRED_INTO, PROC_REF(on_mob_mind_transferred_into))

/mob/living/silicon/proc/on_mob_mind_transferred_into(mob/living/silicon/robot)
	SIGNAL_HANDLER

	if(isnull(client))
		return

	transfer_silicon_prefs(client)

/// Transfers the chat color pref to the silicon mob
/mob/living/silicon/proc/transfer_chat_color_pref(client/player_client)
	// Read the chat color from prefs and apply it to the mob. Cache it as well in case of any voice changing shenanigans.
	var/chat_color_pref = player_client?.prefs?.read_preference(/datum/preference/color/chat_color)
	if(chat_color_pref && chat_color != chat_color_pref)
		var/chat_color_pref_darkened = process_chat_color(chat_color_pref, sat_shift = 0.85, lum_shift = 0.85)
		chat_color = chat_color_pref
		chat_color_darkened = chat_color_pref_darkened
		GLOB.chat_colors_by_mob_name[real_name] = list(chat_color, chat_color_darkened)

/// Transfers the brain type pref to the silicon mob
/mob/living/silicon/proc/transfer_brain_pref(client/player_client)
	return

/// Transfers the emote pref to the silicon mob
/mob/living/silicon/proc/transfer_emote_pref(client/player_client)
	var/chosen_scream = player_client?.prefs?.read_preference(/datum/preference/choiced/scream)
	var/scream_id = GLOB.scream_types[chosen_scream]
	if(scream_id)
		var/datum/scream_type/scream_type = new scream_id
		selected_scream = scream_type

/// Transfers the blooper prefs to the silicon mob
/mob/living/silicon/proc/transfer_blooper_pref(client/player_client)
	set_blooper(player_client.prefs.read_preference(/datum/preference/choiced/vocals/blooper))
	blooper_pitch = player_client.prefs.read_preference(/datum/preference/numeric/blooper_speech_pitch)
	blooper_speed = player_client.prefs.read_preference(/datum/preference/numeric/blooper_speech_speed)
	blooper_pitch_range = player_client.prefs.read_preference(/datum/preference/numeric/blooper_pitch_range)

// This is only implemented for cyborgs at the moment. AI has their own weird way of doing things.
/mob/living/silicon/robot/transfer_brain_pref(client/player_client)
	// Read the brain type from prefs and apply it to the mob.
	var/obj/item/mmi/new_mmi = prefs_get_brain_to_use(player_client?.prefs?.read_preference(/datum/preference/choiced/brain_type), TRUE)
	if(!mmi || !new_mmi || new_mmi == mmi.type)
		return
	new_mmi = new new_mmi(src)

	// Probably shitcode, but silicon code is spaghetti as fuck.
	new_mmi.brain = new /obj/item/organ/brain(new_mmi)
	new_mmi.brain.organ_flags |= ORGAN_FROZEN
	new_mmi.brain.name = "[real_name]'s brain"
	new_mmi.name = "[initial(new_mmi.name)]: [real_name]"
	new_mmi.set_brainmob(new /mob/living/brain(new_mmi))
	new_mmi.brainmob.name = src.real_name
	new_mmi.brainmob.real_name = src.real_name
	new_mmi.brainmob.container = new_mmi
	new_mmi.update_appearance()

	QDEL_NULL(mmi)

	mmi = new_mmi

/// Sets the MMI type for a cyborg/AI, if applicable, as well as the chat color
/mob/living/silicon/proc/transfer_silicon_prefs(client/player_client)
	transfer_chat_color_pref(player_client)
	transfer_brain_pref(player_client)
	transfer_emote_pref(player_client)
	transfer_blooper_pref(player_client)

/mob/living/silicon/robot/apply_prefs_job(client/player_client, datum/job/job)
	. = ..()
	transfer_silicon_prefs(player_client)

/mob/living/silicon/ai/apply_prefs_job(client/player_client, datum/job/job)
	. = ..()
	transfer_silicon_prefs(player_client)

// hooks into this proc in order to make sure chat color prefs get applied
/mob/living/silicon/robot/updatename(client/player_client)
	. = ..()
	transfer_chat_color_pref(player_client)
