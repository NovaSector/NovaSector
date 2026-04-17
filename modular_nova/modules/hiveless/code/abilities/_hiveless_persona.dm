/// Snapshot of a spawn-time appearance used by the shapeshift revert path.
/datum/hiveless_persona
	/// Savefile slot loaded at capture time, or null if no client was attached.
	var/original_slot
	/// Deep copy of the mob's DNA, used when `original_slot` is null.
	var/datum/dna/dna_snapshot
	var/real_name
	var/voice
	var/voice_filter
	var/mob_height
	var/age

/datum/hiveless_persona/Destroy()
	QDEL_NULL(dna_snapshot)
	return ..()

/// Snapshots the mob's current appearance into this datum.
/datum/hiveless_persona/proc/capture(mob/living/carbon/human/source)
	if(!istype(source))
		return
	real_name = source.real_name
	voice = source.voice
	voice_filter = source.voice_filter
	mob_height = source.mob_height
	age = source.age
	if(source.dna)
		dna_snapshot = new source.dna.type()
		source.dna.copy_dna(dna_snapshot)
	original_slot = source.client?.prefs?.default_slot
