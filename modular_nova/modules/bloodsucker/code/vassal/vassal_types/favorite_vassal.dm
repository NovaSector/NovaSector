/**
 * Bonded Thrall
 *
 * Gets some cool abilities depending on the Clade.
 */
/datum/antagonist/ghoul/favorite
	name = "\improper Bonded Thrall"
	antag_hud_name = "ghoul6"
	special_type = BONDED_THRALL
	ghoul_description = "The Bonded Thrall gets unique abilities over other Thralls depending on the Progenitor's Clade \
		and becomes completely immune to Mindshields. If part of the Tyrant clade, this is the Thrall a Bloodsucker will rank up."

	///Bloodsucker levels, but for Thralls, used by Tyrant clade. Used for creating a new bloodsucker.
	var/ghoul_level
	/// Power's we're going to inherit once we turn into a Bloodsucker
	var/list/bloodsucker_powers = list()

/datum/antagonist/ghoul/favorite/on_gain()
	. = ..()
	SEND_SIGNAL(master, COMSIG_BLOODSUCKER_MAKE_BONDED, src)

/datum/antagonist/ghoul/favorite/on_removal()
	SEND_SIGNAL(master, COMSIG_BLOODSUCKER_LOOSE_BONDED, src)
	remove_powers(bloodsucker_powers)
	. = ..()

/datum/antagonist/ghoul/favorite/pre_mindshield(mob/implanter, mob/living/mob_override)
	return COMPONENT_MINDSHIELD_RESISTED
