/obj/item/coupon/update_name()
	. = ..()
	if (discounted_pack?.auto_name)
		var/datum/supply_pack/pack = SSshuttle.supply_packs[discounted_pack]
		var/obj/item/first_item = length(pack.contains) > 0 ? pack.contains[1] : null
		if (first_item)
			var/pack_name = first_item.name
			name = "coupon - [round(discount_pct_off * 100)]% off [pack_name]"
