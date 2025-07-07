///records with only limited, unfinished data
/datum/manifest/proc/inject_guest(mob/living/carbon/human/person, client/person_client)
	set waitfor = FALSE

	var/datum/dna/stored/record_dna = new()
	person.dna.copy_dna(record_dna)

	var/shorter_name = person.real_name
	if(!is_mononym(person.real_name))
		shorter_name = "[trim(first_name(person.real_name), 2)]. [last_name(person.real_name)]"

	var/datum/record/locked/lockfile = new(
		age = person.age,
		chrono_age = person.chrono_age,
		blood_type = record_dna.blood_type.name,
		fingerprint = md5(record_dna.unique_identity),
		name = person.real_name,
		species = record_dna.species.name,
		// Locked specifics
		locked_dna = record_dna,
		mind_ref = person.mind,
	)

	new /datum/record/crew(
		age = person.age,
		chrono_age = person.chrono_age,
		blood_type = record_dna.blood_type.name,
		fingerprint = md5(record_dna.unique_identity),
		name = shorter_name,
		species = record_dna.species.name,
		major_disabilities = person.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY, from_scan = TRUE),
		major_disabilities_desc = person.get_quirk_string(TRUE, CAT_QUIRK_MAJOR_DISABILITY),
		minor_disabilities = person.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY, from_scan = TRUE),
		minor_disabilities_desc = person.get_quirk_string(TRUE, CAT_QUIRK_MINOR_DISABILITY),
		quirk_notes = person.get_quirk_string(TRUE, CAT_QUIRK_NOTES),
		lock_ref = REF(lockfile),
	)
