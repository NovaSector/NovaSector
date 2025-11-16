/datum/supply_pack/New()
	. = ..()
	if (auto_name && length(contains))
		var/obj/item/first_item = contains[1]
		if(first_item)
			name = first_item.name
			desc = first_item.desc
