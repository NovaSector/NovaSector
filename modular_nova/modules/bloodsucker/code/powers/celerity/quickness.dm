/datum/action/cooldown/vampire/exactitude
	name = "Exactitude"
	desc = "Focus your powers into your hands, enabling you to attack with preternatural precision."
	button_icon_state = "power_exactitude"
	power_explanation = "Imbues your hands with supernatural precision. Cannot be used with gloves on.\n\
						Use with combat mode. When punching, you will automatically hit the closest being. Best used without moving your mouse at all."
	vampire_power_flags = BP_AM_TOGGLE
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_IN_FRENZY | BP_CANT_USE_WHILE_STAKED | BP_CANT_USE_WHILE_INCAPACITATED | BP_CANT_USE_WHILE_UNCONSCIOUS
	cooldown_time = 30 SECONDS
	vitaecost = 25
	constant_vitaecost = 3

/datum/action/cooldown/vampire/exactitude/can_use()
	. = ..()
	if(!.)
		return FALSE
	if(owner.get_item_by_slot(ITEM_SLOT_GLOVES))
		owner.balloon_alert(owner, "you're wearing gloves!")
		return FALSE

/datum/action/cooldown/vampire/exactitude/activate_power()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	ADD_TRAIT(owner, TRAIT_PERFECT_ATTACKER, REF(src))

/datum/action/cooldown/vampire/exactitude/deactivate_power()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_EARLY_UNARMED_ATTACK)
	REMOVE_TRAIT(owner, TRAIT_PERFECT_ATTACKER, REF(src))

/datum/action/cooldown/vampire/exactitude/continue_active()
	. = ..()
	if(owner.get_item_by_slot(ITEM_SLOT_GLOVES))
		return FALSE

/datum/action/cooldown/vampire/exactitude/proc/on_unarmed_attack(mob/living/source, atom/target, proximity, modifiers)
	if(!source.combat_mode || !currently_active)
		return NONE

	if(isliving(target) && target != source)
		var/mob/living/living_target = target
		if(living_target.stat != DEAD) // don't focus on dead targets
			return NONE

	var/list/potential_targets = list()
	for(var/mob/living/potential_target in oview(1, source))
		if(potential_target.stat == DEAD || potential_target.invisibility > source.see_invisible)
			continue
		// if it's a fellow vampire (who doesn't have the same masquerade breaker status as us), a vassal, or has ourself in its factions, then it'll be prioritized last.
		var/datum/antagonist/vampire/target_vampire = IS_VAMPIRE(potential_target)
		if((target_vampire && target_vampire.broke_masquerade != vampiredatum_power.broke_masquerade) || IS_VASSAL(potential_target) || potential_target.has_faction(REF(source)) || potential_target.has_ally(source))
			potential_targets += potential_target
		else
			potential_targets.Insert(1, potential_target)

	if(length(potential_targets))
		var/mob/living/to_attack = potential_targets[1]
		source.face_atom(to_attack)
		to_attack.attack_hand(source, modifiers)
		source.changeNext_move(CLICK_CD_MELEE)
		return COMPONENT_CANCEL_ATTACK_CHAIN


