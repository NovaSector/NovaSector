/obj/item/coupon/update_name()
	. = ..()
	if(discounted_pack?.auto_name)
		var/datum/supply_pack/pack = SSshuttle.supply_packs[discounted_pack]
		if(length(pack.contains))
			var/obj/item/first_item = pack.contains[1]
			if(first_item)
				name = "coupon - [round(discount_pct_off * 100)]% off [first_item.name]"
