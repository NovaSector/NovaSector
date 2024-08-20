/datum/artifact_effect/cellcharge
	log_name = "Cell Charge"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/cellcharge/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	for(var/obj/item/stock_parts/power_store/D in user.contents)
		D.give(1e5)
	if(issilicon(user))
		to_chat(user, "<span class='notice'>SYSTEM ALERT: Energy boost detected!</span>")

/datum/artifact_effect/cellcharge/DoEffectAura()
	. = ..()
	if(!.)
		return
	recharge_everything_in_range(250000, range, holder)

/datum/artifact_effect/cellcharge/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	recharge_everything_in_range(5000 * used_power, range, holder)

/datum/artifact_effect/cellcharge/DoEffectDestroy()
	recharge_everything_in_range(1000000000, 10, holder) // One time use giga-charge

/datum/artifact_effect/cellcharge/proc/try_give_charge(atom/reciever_atmon, power)
	if(istype(reciever_atmon, /obj/item/stock_parts/power_store))
		var/obj/item/stock_parts/power_store/C = reciever_atmon
		C.give(power)
	if(istype(reciever_atmon, /obj/machinery/power/apc))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.give(power)
	if(istype(reciever_atmon, /obj/machinery/power/smes))
		var/obj/item/stock_parts/power_store/lucky = reciever_atmon
		lucky.charge += power
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.give(power)
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.give(power)
	if(istype(reciever_atmon, /obj/item/mod/control))
		var/obj/item/mod/control/luckymod = reciever_atmon
		for(var/obj/item/mod/core/luckycore in luckymod.contents)
			for(var/obj/item/stock_parts/power_store/C in luckycore.contents)
				C.give(power)
	if(issilicon(reciever_atmon))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.give(power)
		to_chat(reciever_atmon, "<span class='warning'>SYSTEM ALERT: Energy drain detected!</span>")

/datum/artifact_effect/cellcharge/proc/recharge_everything_in_range(power, range)
	var/turf/curr_turf = get_turf(holder)
	var/list/captured_atoms = range(range, curr_turf)
	for(var/atom/A in captured_atoms)
		try_give_charge(A, power)
