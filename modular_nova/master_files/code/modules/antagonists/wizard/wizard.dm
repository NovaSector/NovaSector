/datum/antagonist/wizard/roundend_report()
	var/list/parts = list()

	parts += printplayer(owner)
	if (ritual)
		parts += "<br><B>Grand Rituals completed:</B> [ritual.times_completed]<br>"

	var/count = 1
	for(var/datum/objective/objective in objectives)
		parts += "<B>Objective #[count]</B>: [objective.explanation_text] [objective.get_roundend_success_suffix()]"
		count++

	var/list/purchases = list()
	for(var/list/log as anything in GLOB.wizard_spellbook_purchases_by_key[owner.key])
		var/datum/spellbook_entry/bought = log[LOG_SPELL_TYPE]
		var/amount = log[LOG_SPELL_AMOUNT]

		purchases += "[amount > 1 ? "[amount]x ":""][initial(bought.name)]"

	if(length(purchases))
		parts += span_bold("[owner.name] used the following spells:")
		parts += purchases.Join(", ")
	else
		parts += span_bold("[owner.name] didn't buy any spells!")

	return parts.Join("<br>")

//Wizard with apprentices report
/datum/team/wizard/roundend_report()
	var/list/parts = list()

	parts += span_header("Wizards/witches of [master_wizard.owner.name] team were:")
	parts += master_wizard.roundend_report()
	parts += " "
	parts += span_header("[master_wizard.owner.name] apprentices and minions were:")
	parts += printplayerlist(members - master_wizard.owner)

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
