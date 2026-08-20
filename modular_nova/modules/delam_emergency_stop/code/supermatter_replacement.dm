// Helper proc to blast someone out of the SM chamber and to relative safety. ish.
/datum/component/supermatter_crystal/proc/find_blast_destination(atom/source)
	var/atom/atom_source = source
	var/list/possible_turfs = list()
	for(var/turf/candidate as anything in RANGE_TURFS(12, atom_source))
		if(get_dist(atom_source, candidate) < 4)
			continue
		if(candidate.is_blocked_turf())
			continue
		possible_turfs += candidate
	if(!length(possible_turfs))
		return null
	return pick(possible_turfs)
