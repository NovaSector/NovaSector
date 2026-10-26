// Don't know of a better place to put these. They're technically related to synths, so they're going here.

/obj/item/brain_processor/positronic/circuit
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

/obj/item/brain_processor/positronic/circuit/hyperboard
	name = "compact hyperboard circuit"
	desc = "An advanced compact circuit... at least it looks advanced, however it's perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "hyperboard"
	base_icon_state = "hyperboard"
	fail_message = span_notice("The compact AI circuit buzzes quietly, and the cyan lights fade away. Perhaps you could try again?")

/obj/item/brain_processor/positronic/circuit/limaengine
	name = "compact liquid-engine circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "limaengine"
	base_icon_state = "limaengine"

	begin_activation_message = span_notice("You carefully locate the manual activation switch, pulsing the liquid core. It seems as if it has starting the boot process.")
	success_message = span_notice("The liquid core comes to life, its fluids like a lava lamp defying gravity. Success!")
	fail_message = span_notice("The liquid becomes cold, losing its life, as it just coldly floats about... Perhaps give it another pulse.")

/obj/item/brain_processor/positronic/circuit/disk
	name = "compact ai braindisk circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "diskbrain"
	base_icon_state = "diskbrain"

	begin_activation_message = span_notice("You carefully locate the manual activation switch and start the disk's boot process.")
	success_message = span_notice("The disk pings to life with a smile displayed on it. Success!")
	fail_message = span_notice("The disk's display slowly turns off fading to its idle background... perhaps give it another try?")

/obj/item/brain_processor/positronic/circuit/neuroboard
	name = "compact neuroboard circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "neuroboard"
	base_icon_state = "neuroboard"

	begin_activation_message = span_notice("You carefully locate the manual activation switch and start the compact neural circuit's boot process.")
	fail_message = span_notice("The neural AI circuit buzzes quietly, and the golden lights fade away. Perhaps you could try again?")

/obj/item/brain_processor/positronic/circuit/condensed
	name = "condensed crystalline AI brain"
	desc = "A whole artificial brain in a crystal, made through advanced crystallization and possibly witchcraft, still requires electricity to function. Try not to touch the crystal, instead \
		hold it by the handles. Oddly enough it is perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "condensed"
	base_icon_state = "condensed"

	begin_activation_message = span_notice("You carefully shake the crystal activating it... it seems to be booting... at least... you hope it is...")
	success_message = span_notice("The crystal pulses consistently and rhythmically. Success!")
	fail_message = span_notice("The light in the crystal fades, as it ceases its rhythmic pulsing... Perhaps give it another shake?")

/obj/item/brain_processor/positronic/circuit/cyberdeck
	name = "advanced cyberdeck"
	desc = "A whole artificial brain in a crystal, through advanced crystallization, still requires electricity to function. try not to touch the crystal, hold it by the handles instead. \
		It's perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon_state = "cyberdeck"
	base_icon_state = "cyberdeck"

	begin_activation_message = span_notice("You carefully tap the cyberdeck activating it... it seems to be booting... at least... you hope it is...")
	success_message = span_notice("The the deck brightens its lights, flashing its strange symbols and indicators. Success!")
	fail_message = span_notice("The lights from the cyberdeck fade back into its seamless material... Perhaps give it another tap?")

// CODE THAT ACTUALLY APPLIES THE BRAINS.
// See modular_nova/master_files/code/modules/client/preferences/brain.dm for Synth/IPC application.

/// Returns a type to use based off of a given preference value (ORGAN_PREF_POSI_BRAIN, ORGAN_PREF_MMI_BRAIN and ORGAN_PREF_CIRCUIT_BRAIN), and if they're a cyborg or not.
/mob/living/proc/prefs_get_brain_to_use(value, is_cyborg = FALSE)
	switch(value)
		if(ORGAN_PREF_POSI_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic : /obj/item/organ/brain/synth

		if(ORGAN_PREF_MMI_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/organic : /obj/item/organ/brain/synth/mmi

		if(ORGAN_PREF_CIRCUIT_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic/circuit : /obj/item/organ/brain/synth/circuit

		if(ORGAN_PREF_HYPERBOARD_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic/circuit/hyperboard : /obj/item/organ/brain/synth/circuit/hyperboard

		if(ORGAN_PREF_LIMAENGINE_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic/circuit/limaengine : /obj/item/organ/brain/synth/circuit/limaengine

		if(ORGAN_PREF_DISKBRAIN_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic/circuit/disk : /obj/item/organ/brain/synth/circuit/disk

		if(ORGAN_PREF_NEUROBOARD_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic/circuit/neuroboard : /obj/item/organ/brain/synth/circuit/neuroboard

		if(ORGAN_PREF_CONDENSED_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic/circuit/condensed : /obj/item/organ/brain/synth/circuit/condensed

		if(ORGAN_PREF_CYBERDECK_BRAIN)
			return is_cyborg ? /obj/item/brain_processor/positronic/circuit/cyberdeck : /obj/item/organ/brain/synth/circuit/cyberdeck

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
	var/datum/scream_type/scream_type = GLOB.scream_types_by_name[chosen_scream]
	if(scream_type)
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
	var/new_mmi_type = prefs_get_brain_to_use(player_client?.prefs?.read_preference(/datum/preference/choiced/brain_type), TRUE)
	if(!mmi || !new_mmi_type || new_mmi_type == mmi.type)
		return

	var/obj/item/brain_processor/new_mmi
	if(ispath(new_mmi_type, /obj/item/brain_processor/organic))
		new_mmi = new new_mmi_type(src, new /obj/item/organ/brain())
	else
		new_mmi = new new_mmi_type(src, FALSE) // Positronics make their own brainmob. Don't ping ghosts for a brain that's already in use.
	new_mmi.set_name(real_name)
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
