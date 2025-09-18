// At some point upstream should make it a thing
/datum/job_department
	var/default_radio_channel = null

/datum/job_department/command
	default_radio_channel = RADIO_CHANNEL_COMMAND

/datum/job_department/security
	default_radio_channel = RADIO_CHANNEL_SECURITY

/datum/job_department/engineering
	default_radio_channel = RADIO_CHANNEL_ENGINEERING

/datum/job_department/medical
	default_radio_channel = RADIO_CHANNEL_MEDICAL

/datum/job_department/science
	default_radio_channel = RADIO_CHANNEL_SCIENCE

/datum/job_department/cargo
	default_radio_channel = RADIO_CHANNEL_SUPPLY

/datum/job_department/service
	default_radio_channel = RADIO_CHANNEL_SERVICE
