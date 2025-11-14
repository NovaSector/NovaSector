/datum/supply_pack/New()
	. = ..()
	if (auto_name)
		var/obj/item/first_item = length(contains) > 0 ? contains[1] : null
		if (first_item)
			name = first_item.name
			desc = first_item.desc
