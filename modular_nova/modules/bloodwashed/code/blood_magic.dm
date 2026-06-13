/datum/action/innate/cult/blood_magic/bloodwashed
	name = "Prepare Bloodwashed Magic"

/datum/action/innate/cult/blood_magic/bloodwashed/Activate()
	var/rune = FALSE
	var/limit = RUNELESS_MAX_BLOODCHARGE
	for(var/obj/effect/rune/empower/R in range(1, owner))
		rune = TRUE
		break
	if(rune)
		limit = magic_enhanced ? ENHANCED_BLOODCHARGE : MAX_BLOODCHARGE
	if(length(spells) >= limit)
		if(rune)
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
	for(var/I in bloodwashed_spell_types())
		var/datum/action/innate/possible_spell_type = I
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
	selected_spell_type = possible_spells[entered_spell_name]
	if(QDELETED(src) || owner.incapacitated || !selected_spell_type || (rune && !(locate(/obj/effect/rune/empower) in range(1, owner))) || (length(spells) >= limit))
		return
	to_chat(owner, span_warning("You begin to carve unnatural symbols into your flesh!"))
	SEND_SOUND(owner, sound('sound/items/weapons/slice.ogg', 0, 1, 10))
	if(!channeling)
		channeling = TRUE
	else
		to_chat(owner, span_cult_italic("You are already invoking blood magic!"))
		return
	var/spell_carving_timer = 10 SECONDS
	if(rune)
		spell_carving_timer = 4 SECONDS
	if(magic_enhanced)
		spell_carving_timer *= 0.5
	if(do_after(owner, spell_carving_timer, target = owner))
		if(ishuman(owner))
			var/mob/living/carbon/human/human_owner = owner
			human_owner.bleed(rune ? 8 : 40)
		var/datum/action/innate/new_spell = new selected_spell_type(owner.mind)
		new_spell.Grant(owner, src)
		spells += new_spell
		Positioning()
		to_chat(owner, span_warning("Your wounds glow with power, you have prepared a [new_spell.name] invocation!"))
	channeling = FALSE
