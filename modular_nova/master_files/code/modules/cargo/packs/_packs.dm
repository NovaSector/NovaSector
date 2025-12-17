/datum/supply_pack
	///Flag that controls which consoles can this supply pack be ordered to.
	var/console_flag = CARGO_CONSOLE_ALL
	///Boolean to indicate that express consoles cannot order this.
	var/express_lock = FALSE
	///Boolean to indicate if the pack has a custom name and description or not.
	var/auto_name = FALSE

/datum/supply_pack/New()
	. = ..()
	if (auto_name && length(contains))
		var/obj/item/first_item = contains[1]
		if(first_item)
			name = first_item.name
			desc = first_item.desc
