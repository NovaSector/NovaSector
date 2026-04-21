/// Cyborgs don't have genital organs, but can still participate in lewd interactions.
/// `simulated_genitals` is a toggle-list checked in [/datum/interaction/proc/allow_act] when
/// `user_required_parts` / `target_required_parts` names a slot — cyborgs declare which slots
/// they're "simulating" and interactions flow normally from there (messaging, mood, etc.).
/// Simple mobs intentionally don't have this var — lewd interactions remain cyborg/human only.
/mob/living/silicon/robot
	/// Default-on so cyborgs can participate in lewd interactions out of the box.
	/// Players can opt out of individual slots via the `toggle_genital_active` ui_act.
	/// (Needs TGUI-side rendering; server-side toggle is wired.)
	var/list/simulated_genitals = list(
		ORGAN_SLOT_PENIS = TRUE,
		ORGAN_SLOT_VAGINA = TRUE,
		ORGAN_SLOT_BREASTS = TRUE,
		ORGAN_SLOT_ANUS = TRUE,
	)
