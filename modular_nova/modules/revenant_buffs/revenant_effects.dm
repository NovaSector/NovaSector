/// Special version of manifest, plus override to make sure that the two reveals don't conflict.
/datum/status_effect/revenant/revealed/on_remove()
	REMOVE_TRAIT(owner, TRAIT_REVENANT_REVEALED, TRAIT_STATUS_EFFECT(id))

	if(HAS_TRAIT(owner, TRAIT_REVENANT_REVEALED)) // checks if we're still visible through manifest so we don't give jaunt movement too early
		owner.incorporeal_move = FALSE
	else
		owner.incorporeal_move = INCORPOREAL_MOVE_JAUNT

	owner.RemoveInvisibility(type)
	owner.update_appearance(UPDATE_ICON)
	owner.update_mob_action_buttons()
	return

/datum/status_effect/revenant/revealed/manifest
	id = "revenant_revealed_manifest"
