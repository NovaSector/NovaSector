/**
 * Gives Bloodsuckers the ability to choose a Clade.
 * If they are already in a Clade, or is in a Feral Episode, they will not be able to do so.
 * The arg is optional and should really only be an Admin setting a Clade for a player.
 * If set however, it will give them the control of their Clade instead of the Bloodsucker.
 * This is selected through a radial menu over the player's body, even when an Admin is setting it.
 * Args:
 * person_selecting - Mob override for stuff like Admins selecting someone's clade.
 */
/datum/antagonist/bloodsucker/proc/assign_clade_and_bane(mob/person_selecting)
	if(my_clade)
		return
	if(owner.current.has_status_effect(/datum/status_effect/frenzy))
		return
	if(!person_selecting)
		person_selecting = owner.current

	var/list/options = list()
	var/list/radial_display = list()
	for(var/datum/bloodsucker_clade/all_clans as anything in typesof(/datum/bloodsucker_clade))
		if(!initial(all_clans.joinable_clan)) //flavortext only
			continue
		options[initial(all_clans.name)] = all_clans

		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(all_clans.join_icon), icon_state = initial(all_clans.join_icon_state))
		option.info = "[initial(all_clans.name)] - [span_boldnotice(initial(all_clans.join_description))]"
		radial_display[initial(all_clans.name)] = option
	var/anchor = get_turf(owner.current) == owner.current.loc ? owner.current : get_turf(owner.current)
	var/require_near = person_selecting == owner.current ? TRUE : FALSE
	var/chosen_clan = show_radial_menu(person_selecting, anchor, radial_display, require_near = require_near)
	chosen_clan = options[chosen_clan]
	if(QDELETED(src) || QDELETED(owner.current))
		return FALSE
	if(!chosen_clan)
		to_chat(person_selecting, span_announce("You choose to remain unspecialized, for now."))
		return
	my_clade = new chosen_clan(src)

/datum/antagonist/bloodsucker/proc/remove_clade(mob/admin)
	if(owner.current.has_status_effect(/datum/status_effect/frenzy))
		to_chat(admin, span_announce("Removing a Bloodsucker from a Clade while they are in a Feral Episode will break stuff, this action has been blocked."))
		return
	QDEL_NULL(my_clade)
	to_chat(owner.current, span_announce("You have been forced out of your clade! You can re-enter one by regular means."))

/datum/antagonist/bloodsucker/proc/admin_set_clade(mob/admin)
	assign_clade_and_bane(admin)
