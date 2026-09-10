/datum/job_department/central_command
	department_name = DEPARTMENT_CENTRAL_COMMAND
	department_bitflags = DEPARTMENT_BITFLAG_CENTRAL_COMMAND
	department_head = /datum/job/captain
	department_experience_type = EXP_TYPE_CENTRAL_COMMAND
	display_order = 1.1
	ui_color = "#86ff82"

/datum/job_department/central_command/get_label_class()
	return LOWER_TEXT(replacetext(/datum/job_department/command::department_name, " ", "_"))
