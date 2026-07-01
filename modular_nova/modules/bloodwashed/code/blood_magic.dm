/datum/action/innate/cult/blood_magic/bloodwashed
	name = "Prepare Bloodwashed Magic"

/datum/action/innate/cult/blood_magic/bloodwashed/Positioning()
	for(var/datum/hud/hud as anything in viewers)
		var/our_view = hud.mymob?.canon_client?.view || "15x15"
		var/atom/movable/screen/movable/action_button/button = viewers[hud]
		var/list/position = screen_loc_to_offset(button.screen_loc)
		var/list/available_positions = list()
		var/max_spell_count = magic_enhanced ? ENHANCED_BLOODCHARGE : MAX_BLOODCHARGE
		for(var/possible_position in 1 to max_spell_count)
			available_positions += possible_position
		for(var/datum/action/innate/prepared_spell as anything in spells)
			var/current_position = get_prepared_spell_position(prepared_spell)
			if(current_position)
				available_positions.Remove(current_position)
				continue
			var/atom/movable/screen/movable/action_button/moving_button = prepared_spell.viewers[hud]
			if(!moving_button || !length(available_positions))
				continue
			var/first_available_slot = available_positions[1]
			var/our_x = position[1] + first_available_slot * ICON_SIZE_X
			hud.position_action(moving_button, offset_to_screen_loc(our_x, position[2], our_view))
			set_prepared_spell_position(prepared_spell, first_available_slot)

/datum/action/innate/cult/blood_magic/bloodwashed/proc/get_prepared_spell_position(datum/action/innate/prepared_spell)
	if(istype(prepared_spell, /datum/action/innate/cult/blood_spell))
		var/datum/action/innate/cult/blood_spell/blood_spell = prepared_spell
		return blood_spell.positioned
	if(istype(prepared_spell, /datum/action/innate/cult/bloodwashed_spell))
		var/datum/action/innate/cult/bloodwashed_spell/bloodwashed_spell = prepared_spell
		return bloodwashed_spell.positioned

/datum/action/innate/cult/blood_magic/bloodwashed/proc/set_prepared_spell_position(datum/action/innate/prepared_spell, new_position)
	if(istype(prepared_spell, /datum/action/innate/cult/blood_spell))
		var/datum/action/innate/cult/blood_spell/blood_spell = prepared_spell
		blood_spell.positioned = new_position
		return
	if(istype(prepared_spell, /datum/action/innate/cult/bloodwashed_spell))
		var/datum/action/innate/cult/bloodwashed_spell/bloodwashed_spell = prepared_spell
		bloodwashed_spell.positioned = new_position

/datum/action/innate/cult/blood_magic/bloodwashed/Activate()
	var/has_empowering_rune = locate(/obj/effect/rune/empower) in range(1, owner)
	var/limit = RUNELESS_MAX_BLOODCHARGE
	if(has_empowering_rune)
		limit = magic_enhanced ? ENHANCED_BLOODCHARGE : MAX_BLOODCHARGE
	if(length(spells) >= limit)
		if(has_empowering_rune)
			to_chat(owner, span_cult_italic("You cannot store more than [limit] spells. <b>Pick a spell to remove.</b>"))
		else
			to_chat(owner, span_cult_bold_italic("<u>You cannot store more than [RUNELESS_MAX_BLOODCHARGE] spells without an empowering rune! Pick a spell to remove.</u>"))
		var/nullify_spell = tgui_input_list(owner, "Spell to remove", "Current Spells", spells)
		if(isnull(nullify_spell))
			return
		qdel(nullify_spell)
	var/entered_spell_name
	var/datum/action/innate/selected_spell_type
	var/list/possible_spells = list()
	for(var/spell_type in bloodwashed_spell_types())
		var/datum/action/innate/possible_spell_type = spell_type
		var/cult_name = initial(possible_spell_type.name)
		possible_spells[cult_name] = possible_spell_type
	possible_spells += "(REMOVE SPELL)"
	entered_spell_name = tgui_input_list(owner, "Blood spell to prepare", "Spell Choices", possible_spells)
	if(isnull(entered_spell_name))
		return
	if(entered_spell_name == "(REMOVE SPELL)")
		var/nullify_spell = tgui_input_list(owner, "Spell to remove", "Current Spells", spells)
		if(isnull(nullify_spell))
			return
		qdel(nullify_spell)
		return
	selected_spell_type = possible_spells[entered_spell_name]
	if(QDELETED(src) || owner.incapacitated || !ispath(selected_spell_type, /datum/action/innate) || (has_empowering_rune && !(locate(/obj/effect/rune/empower) in range(1, owner))) || (length(spells) >= limit))
		return
	to_chat(owner, span_warning("You begin to carve unnatural symbols into your flesh!"))
	SEND_SOUND(owner, sound('sound/items/weapons/slice.ogg', 0, 1, 10))
	if(!channeling)
		channeling = TRUE
	else
		to_chat(owner, span_cult_italic("You are already invoking blood magic!"))
		return
	var/spell_carving_timer = 10 SECONDS
	if(has_empowering_rune)
		spell_carving_timer = 4 SECONDS
	if(magic_enhanced)
		spell_carving_timer *= 0.5
	if(do_after(owner, spell_carving_timer, target = owner))
		if(ishuman(owner))
			var/mob/living/carbon/human/human_owner = owner
			human_owner.bleed(has_empowering_rune ? 8 : 40)
		var/datum/action/innate/new_spell = new selected_spell_type(owner.mind)
		new_spell.Grant(owner, src)
		spells += new_spell
		Positioning()
		to_chat(owner, span_warning("Your wounds glow with power, you have prepared a [new_spell.name] invocation!"))
	channeling = FALSE
