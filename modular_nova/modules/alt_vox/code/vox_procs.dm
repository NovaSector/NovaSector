// Make sure that the code compiles with AI_VOX undefined
#ifdef AI_VOX

/mob/living/silicon/ai/verb/switch_vox()
	set name = "Switch Vox Voice"
	set desc = "Switch your VOX announcement voice!"
	set category = "AI Commands"

	if(incapacitated())
		return
	var/selection = tgui_input_list(src, "Please select a new VOX voice:", "VOX VOICE", vox_voices)
	if(selection == null)
		return
	vox_type = selection

	to_chat(src, "Vox voice set to [vox_type]")


/mob/living/silicon/ai/verb/display_word_string()
	set name = "Display Word String"
	set desc = "Display the list of recently pressed vox lines."
	set category = "AI Commands"

	if(incapacitated())
		return

	to_chat(src, vox_word_string)

/mob/living/silicon/ai/verb/clear_word_string()
	set name = "Clear Word String"
	set desc = "Clear recent vox words."
	set category = "AI Commands"

	vox_word_string = ""

#endif
