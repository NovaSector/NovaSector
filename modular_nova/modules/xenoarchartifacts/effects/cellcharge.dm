/datum/artifact_effect/cellcharge
	log_name = "Cell Charge"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/cellcharge/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	for(var/obj/item/stock_parts/power_store/cell in user.contents)
		cell.give(1e5)
	if(issilicon(user))
		to_chat(user, span_notice("SYSTEM ALERT: Energy boost detected!"))

/datum/artifact_effect/cellcharge/do_effect_aura()
	. = ..()
	if(!.)
		return
	recharge_everything_in_range(250000, range, holder)

/datum/artifact_effect/cellcharge/do_effect_pulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	recharge_everything_in_range(5000 * used_power, range, holder)

/datum/artifact_effect/cellcharge/do_effect_destroy()
	recharge_everything_in_range(1000000000, 10, holder) // One time use giga-charge

/datum/artifact_effect/cellcharge/proc/try_give_charge(atom/reciever_atmon, power)
	if(istype(reciever_atmon, /obj/item/stock_parts/power_store))
		var/obj/item/stock_parts/power_store/cell = reciever_atmon
		cell.give(power)
	if(istype(reciever_atmon, /obj/machinery/power/apc))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.give(power)
	if(istype(reciever_atmon, /obj/machinery/power/smes))
		var/obj/item/stock_parts/power_store/lucky = reciever_atmon
		lucky.charge += power
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.give(power)
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.give(power)
	if(istype(reciever_atmon, /obj/item/mod/control))
		var/obj/item/mod/control/luckymod = reciever_atmon
		for(var/obj/item/mod/core/luckycore in luckymod.contents)
			for(var/obj/item/stock_parts/power_store/cell in luckycore.contents)
				cell.give(power)
	if(issilicon(reciever_atmon))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.give(power)
		to_chat(reciever_atmon, span_warning("SYSTEM ALERT: Energy drain detected!"))

/datum/artifact_effect/cellcharge/proc/recharge_everything_in_range(power, range)
	var/turf/curr_turf = get_turf(holder)
	var/list/captured_atoms = range(range, curr_turf)
	for(var/atom/A in captured_atoms)
		try_give_charge(A, power)
