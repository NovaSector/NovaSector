/datum/artifact_effect/celldrain
	log_name = "Cell Drain"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/celldrain/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	for(var/obj/item/stock_parts/power_store/D in user.contents)
		D.use(1e10) // uh oh
		if(issilicon(user))
			to_chat(user, "<span class='notice'>SYSTEM ALERT: Massive energy drain detected!</span>")

/datum/artifact_effect/celldrain/DoEffectAura()
	. = ..()
	if(!.)
		return
	discharge_everything_in_range(500000, range, holder)

/datum/artifact_effect/celldrain/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	discharge_everything_in_range(25000 * used_power, range, holder)

/datum/artifact_effect/celldrain/DoEffectDestroy()
	discharge_everything_in_range(1000000000, 10, holder) // Massive uh oh

/datum/artifact_effect/celldrain/proc/try_use_charge(atom/reciever_atmon, power)
	if(istype(reciever_atmon, /obj/item/stock_parts/power_store))
		var/obj/item/stock_parts/power_store/C = reciever_atmon
		C.use(power)
	if(istype(reciever_atmon, /obj/machinery/power/apc))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.use(power)
	if(istype(reciever_atmon, /obj/machinery/power/smes))
		var/obj/machinery/power/smes/unlucky = reciever_atmon
		unlucky.charge -= power
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.use(power)
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.use(power)
	if(istype(reciever_atmon, /obj/item/mod/control))
		var/obj/item/mod/control/unluckymod = reciever_atmon
		for(var/obj/item/mod/core/unluckycore in unluckymod.contents)
			for(var/obj/item/stock_parts/power_store/C in unluckycore.contents)
				C.use(power)
	if(issilicon(reciever_atmon))
		for(var/obj/item/stock_parts/power_store/C in reciever_atmon.contents)
			C.use(power)
		to_chat(reciever_atmon, "<span class='warning'>SYSTEM ALERT: Energy drain detected!</span>")

/datum/artifact_effect/celldrain/proc/discharge_everything_in_range(power, range, center)
	var/turf/curr_turf = get_turf(holder)
	var/list/captured_atoms = range(range, curr_turf)
	for(var/atom/A in captured_atoms)
		try_use_charge(A, power)
