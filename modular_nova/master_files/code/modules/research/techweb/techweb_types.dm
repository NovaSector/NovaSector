/// Reference back to code/_defines/machines.dm for types, and this file's mirror for reference.

/datum/techweb/autounlocking/nova // sub type to do stuff
	/// Is the device its intended for hackable?
	var/hackable = FALSE

/datum/techweb/autounlocking/nova/col_fab
	allowed_buildtypes = COLONY_FABRICATOR

/datum/techweb/autounlocking/nova/New() //Remove a few things to hopefully get this to work right.
	. = ..()
	for(var/id in SSresearch.techweb_designs)
		var/datum/design/design = SSresearch.techweb_designs[id]
		if(!(design.build_type & allowed_buildtypes)) //Define hell incoming if we make more subtypes.
			continue

		if(hackable) // we make this a check incase someone wants to do funny stuff or make a device hackable
			if(RND_CATEGORY_HACKED in design.category)
				add_design_by_id(id, add_to = hacked_designs)

		add_design_by_id(id)
