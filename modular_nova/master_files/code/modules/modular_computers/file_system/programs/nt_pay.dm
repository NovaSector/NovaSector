/datum/computer_file/program/nt_pay
	///List of areas from where you cannot pay from. Done to block bitrunners to send money to their accounts.
	var/static/list/areas_blacklist =  typecacheof(list(
		/area/virtual_domain,
		/area/icemoon/underground/explored/virtual_domain,
		/area/lavaland/surface/outdoors/virtual_domain,
		/area/ruin/space/virtual_domain,
		/area/space/virtual_domain,
	))

/datum/computer_file/program/nt_pay/_pay(token, money_to_send, mob/user)
	if(is_type_in_typecache(get_area(user), areas_blacklist))
		to_chat(user, span_notice("You cannot send virtual money to real accounts."))
		return NT_PAY_STATUS_NO_ACCOUNT

	return ..()
