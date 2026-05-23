/// Reference back to code/_defines/machines.dm for types, and this file's mirror for reference.

/datum/techweb/colony_fabricator
	var/allowed_buildtypes = COLONY_FABRICATOR //Used for sorting

/datum/techweb/colony_fabricator/New() //Remove a few things to hopefully get this to work right.
	. = ..()
	for(var/id, current_design in SSresearch.techweb_designs)
		var/datum/design/design = current_design
		if(!(design.build_type & allowed_buildtypes)) //Define hell incoming if we make more subtypes.
			continue

		add_design_by_id(id)
