/**
 * Feral Thrall
 *
 * Has the goal to 'get revenge' when their Progenitor dies.
 */
/datum/antagonist/ghoul/revenge
	name = "\improper Feral Thrall"
	roundend_category = "abandoned Thralls"
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	antag_hud_name = "ghoul4"
	special_type = FERAL_THRALL
	ghoul_description = "The Feral Thrall will not deconvert on a Bloodsucker's Termination, \
		instead they will gain all your Adaptations, and the objective to take revenge for your demise. \
		They additionally maintain Thralls after their Progenitor's departure, rather than become aimless."

	///all ex-thralls brought back into the fold.
	var/list/datum/antagonist/ex_ghoul/ex_ghouls = list()

/datum/antagonist/ghoul/revenge/roundend_report()
	var/list/report = list()
	report += printplayer(owner)
	if(objectives.len)
		report += printobjectives(objectives)

	// Now list their ghouls
	if(ex_ghouls.len)
		report += "<span class='header'>The Thralls brought back into the fold were...</span>"
		for(var/datum/antagonist/ex_ghoul/all_ghouls as anything in ex_ghouls)
			if(!all_ghouls.owner)
				continue
			report += "<b>[all_ghouls.owner.name]</b> the [all_ghouls.owner.assigned_role.title]"

	return report.Join("<br>")

/datum/antagonist/ghoul/revenge/on_gain()
	. = ..()
	RegisterSignal(master, COMSIG_BLOODSUCKER_TERMINATION, PROC_REF(on_master_death))

/datum/antagonist/ghoul/revenge/on_removal()
	UnregisterSignal(master, COMSIG_BLOODSUCKER_TERMINATION)
	return ..()

/datum/antagonist/ghoul/revenge/proc/on_master_death(datum/antagonist/bloodsucker/bloodsuckerdatum, mob/living/carbon/master)
	SIGNAL_HANDLER

	show_in_roundend = TRUE
	for(var/datum/objective/all_objectives as anything in objectives)
		objectives -= all_objectives
	BuyPower(/datum/action/cooldown/bloodsucker/ghoul_blood)
	for(var/datum/action/cooldown/bloodsucker/master_powers as anything in bloodsuckerdatum.powers)
		if(master_powers.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		master_powers.Grant(owner.current)
		owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/ghoul_edition)

	var/datum/objective/survive/new_objective = new
	new_objective.name = "Avenge your Progenitor"
	new_objective.explanation_text = "Avenge your Progenitor's termination by felling the ones that killed them, recruiting their ex-thralls and continuing their operations."
	new_objective.owner = owner
	objectives += new_objective

	antag_panel_title = "You are a Thrall tasked with taking revenge for the termination of your Progenitor!"
	antag_panel_description = "You have gained your Progenitor's old Adaptations, and a brand new \
		adaptation. You will have to survive and maintain your old \
		Progenitor's integrity. Bring their old Thralls back into the \
		fold using your new Ability."
	update_static_data_for_all_viewers()
