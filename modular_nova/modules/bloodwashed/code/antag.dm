/datum/antagonist/cult/bloodwashed
	name = "Bloodwashed"
	roundend_category = "bloodwashed"
	show_name_in_check_antagonists = TRUE
	pref_flag = ROLE_BLOODWASHED
	jobban_flag = ROLE_CULTIST
	antag_hud_name = "cult"
	can_assign_self_objectives = TRUE
	default_custom_objective = "Spread occult dread in Nar'Sie's name without revealing the full truth of the blood cult."

/datum/antagonist/cult/bloodwashed/can_be_owned(datum/mind/new_owner)
	if(new_owner.has_antag_datum(/datum/antagonist/cult))
		return FALSE
	return ..()

/datum/antagonist/cult/bloodwashed/create_team(datum/team/cult/new_team)
	cult_team = new /datum/team/cult/bloodwashed

/datum/antagonist/cult/bloodwashed/admin_add(datum/mind/new_owner, mob/admin)
	give_equipment = TRUE
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has bloodwashed [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has bloodwashed [key_name(new_owner)].")

/datum/antagonist/cult/bloodwashed/on_gain()
	forge_objectives()
	var/datum/action/antag_info/info_button
	if(!owner)
		CRASH("[src] ran on_gain() without a mind")
	if(!owner.current)
		CRASH("[src] ran on_gain() on a mind without a mob")
	if(ui_name)
		info_button = new(src)
		if(antag_flags & ANTAG_OBSERVER_VISIBLE_PANEL)
			info_button.show_to_observers = TRUE
			info_button.allow_observer_click = TRUE
		info_button.Grant(owner.current)
		info_button_ref = WEAKREF(info_button)
	if(!silent)
		greet()
		if(ui_name)
			to_chat(owner.current, span_boldnotice("For more info, read the panel. \
				You can always come back to it using the button in the top left."))
			info_button.Trigger()
		var/type_policy = get_policy("[type]")
		if(type_policy)
			to_chat(owner.current, type_policy)

	owner.desensitized_level *= max(DESENSITIZED_MINIMUM, desensitized_modifier)
	apply_innate_effects()
	give_antag_moodies()
	RegisterSignal(owner, COMSIG_PRE_MINDSHIELD_IMPLANT, PROC_REF(pre_mindshield))
	RegisterSignal(owner, COMSIG_MINDSHIELD_IMPLANTED, PROC_REF(on_mindshield))
	if(is_banned(owner.current) && replace_banned)
		replace_banned_player()
	else if(owner.current.client?.holder && (CONFIG_GET(flag/auto_deadmin_antagonists) || owner.current.client.prefs?.toggles & DEADMIN_ANTAGONIST))
		owner.current.client.holder.auto_deadmin()
	if(owner.current.stat != DEAD && owner.current.client)
		owner.current.add_to_current_living_antags()

	for(var/datum/atom_hud/alternate_appearance/basic/antag_hud as anything in GLOB.active_alternate_appearances)
		antag_hud.apply_to_new_mob(owner.current)

	LAZYADD(owner.special_roles, (jobban_flag || pref_flag))

	SEND_SIGNAL(owner, COMSIG_ANTAGONIST_GAINED, src)

	var/mob/living/current = owner.current
	if(give_equipment)
		equip_bloodwashed(TRUE)
	if(ishuman(current))
		var/datum/action/innate/cult/blood_magic/bloodwashed/magic = new(owner)
		magic.Grant(current)

	current.log_message("has been bloodwashed by Nar'Sie's lingering influence!", LOG_ATTACK, color = COLOR_CULT_RED)

/datum/antagonist/cult/bloodwashed/greet()
	. = ..()
	to_chat(owner.current, span_cult_large("Something from the tainted necropolis lashes at your very soul, the maddening pain thrums away as the howls of distant screams and bloody scenery enrapture your mind's eye. You know what you must do."))
	to_chat(owner.current, span_cult("You are not a true cultist. You remember scraps of rites and bloody purpose, but conversion and Nar'Sie's final summoning are beyond you."))

/datum/antagonist/cult/bloodwashed/forge_objectives()
	if(length(objectives))
		return

	var/datum/objective/custom/occult_expression = new
	occult_expression.owner = owner
	occult_expression.completed = TRUE
	occult_expression.explanation_text = "Create occult dread, shrines, omens, sacrifices, or other signs that Nar'Sie's influence still stains this sector."
	objectives += occult_expression

	var/datum/objective/custom/bloodwashed_independence = new
	bloodwashed_independence.owner = owner
	bloodwashed_independence.completed = TRUE
	bloodwashed_independence.explanation_text = "Act alone or through mundane persuasion. You cannot convert others into true cultists."
	objectives += bloodwashed_independence

	var/datum/objective/survive/survive = new
	survive.owner = owner
	objectives += survive

/datum/antagonist/cult/bloodwashed/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current || mob_override
	current.clear_alert("bloodsense")
	RegisterSignal(current, COMSIG_LIVING_PICKED_UP_ITEM, PROC_REF(on_pickup_item))
	for(var/obj/item/melee/cultblade/dagger/dagger in current.get_all_contents())
		bloodwashed_restrict_ritual_dagger(dagger)

/datum/antagonist/cult/bloodwashed/remove_innate_effects(mob/living/mob_override)
	var/mob/living/current = owner.current || mob_override
	UnregisterSignal(current, COMSIG_LIVING_PICKED_UP_ITEM)
	return ..()

/datum/antagonist/cult/bloodwashed/proc/on_pickup_item(mob/living/source, obj/item/item)
	SIGNAL_HANDLER

	var/obj/item/melee/cultblade/dagger/dagger = item
	if(istype(dagger))
		bloodwashed_restrict_ritual_dagger(dagger)

/datum/antagonist/cult/bloodwashed/check_invoke_validity()
	return FALSE

/datum/antagonist/cult/bloodwashed/is_cult_leader()
	return FALSE

/datum/antagonist/cult/bloodwashed/make_cult_leader()
	return FALSE

/datum/antagonist/cult/bloodwashed/get_admin_commands()
	. = ..()
	. -= "Make Cult Leader"
	. -= "Demote From Leader"

/datum/antagonist/cult/bloodwashed/on_removal()
	if(!owner.current)
		return ..()

	if(!silent)
		owner.current.visible_message(span_deconversion_message("[owner.current] looks like a terrible weight has lifted from [owner.current.p_their()] mind."), ignored_mobs = owner.current)
		to_chat(owner.current, span_userdanger("A white-hot clarity burns through the blood and screaming in your thoughts. Nar'Sie's pull fades."))
		owner.current.log_message("has been cleansed of the Bloodwashed affliction!", LOG_ATTACK, color = COLOR_CULT_RED)
		silent = TRUE

	return ..()

/datum/antagonist/cult/bloodwashed/proc/equip_bloodwashed(metal = TRUE)
	var/mob/living/carbon/H = owner.current
	if(!istype(H))
		return
	. += bloodwashed_give_item(/obj/item/melee/cultblade/dagger, H)
	if(metal)
		. += bloodwashed_give_item(/obj/item/stack/sheet/runed_metal/ten, H)
	to_chat(owner, "These are the tools your stained visions remember. You are alone, and you cannot bring others fully into the fold.")

/datum/antagonist/cult/bloodwashed/proc/bloodwashed_give_item(obj/item/item_path, mob/living/carbon/mob)
	var/obj/item/item = new item_path(mob)
	ADD_TRAIT(item, TRAIT_CONTRABAND, INNATE_TRAIT)
	var/obj/item/melee/cultblade/dagger/dagger = item
	if(istype(dagger))
		bloodwashed_restrict_ritual_dagger(dagger)

	var/where = mob.equip_conspicuous_item(item, delete_item_if_failed = FALSE)
	if(where)
		to_chat(mob, span_danger("You have [item] in your [where]."))
		if(where == "backpack")
			mob.back.atom_storage?.show_contents(mob)
		return TRUE

	if(mob.put_in_hands(item))
		to_chat(mob, span_danger("You have [item] in your hands."))
		return TRUE

	item.forceMove(get_turf(mob))
	to_chat(mob, span_warning("There was no room for [item], so it appears at your feet."))
	return TRUE
