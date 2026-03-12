#define CARGO_CUT 0.05

/datum/supply_pack/companies
	access_view = NONE
	group = "★ General"
	crate_type = /obj/structure/closet/crate/large/import
	auto_name = TRUE
	order_flags = ORDER_COMPANY
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

// Original logic, gives 5% of the stuff people buy to cargo and leaves the gun check for pins
/datum/supply_pack/companies/generate(atom/A, datum/bank_account/paying_account)
	. = ..()
	var/datum/bank_account/cargo_dep = SSeconomy.get_dep_account(ACCOUNT_CAR)
	cargo_dep.account_balance += round(cost * CARGO_CUT)
	if(!(CONFIG_GET(flag/permit_pins)))
		return
	var/obj/structure/container = .
	for(var/obj/item/gun/gun_actually in container.contents)
		QDEL_NULL(gun_actually.pin)
		var/obj/item/firing_pin/permit_pin/new_pin = new(gun_actually)
		gun_actually.pin = new_pin

#undef CARGO_CUT
