/// Returns a list of radio channels associated with our role.
/datum/job/proc/get_radio_channels()
	var/list/radio_channels = list()
	if(!length(departments_list))
		return radio_channels
	for(var/datum/job_department/department as anything in departments_list)
		radio_channels += department.radio_channel
	return radio_channels

/datum/job_department
	/// The radio channel associated with this department.
	var/radio_channel

/datum/job_department/assistant
	radio_channel = RADIO_CHANNEL_COMMON

/datum/job_department/service
	radio_channel = RADIO_CHANNEL_SERVICE

/datum/job_department/command
	radio_channel = RADIO_CHANNEL_COMMAND

/datum/job_department/security
	radio_channel = RADIO_CHANNEL_SECURITY

/datum/job_department/medical
	radio_channel = RADIO_CHANNEL_MEDICAL

/datum/job_department/science
	radio_channel = RADIO_CHANNEL_SCIENCE

/datum/job_department/engineering
	radio_channel = RADIO_CHANNEL_ENGINEERING

/datum/job_department/cargo
	radio_channel = RADIO_CHANNEL_SUPPLY
