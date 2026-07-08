#define SMOKE_STATE_NONE 0
#define SMOKE_STATE_ACTIVE 1

/obj/machinery/smartfridge/drying/rack/smoker
	name = "primitive smoker"
	desc = "A simple smoke-chamber used to dry food, hides, and herbs. A small firebox on the side burns logs or planks to produce the warm smoke needed for drying."
	icon = 'modular_nova/modules/primitive_cooking_additions/icons/stone_kitchen_machines.dmi'
	icon_state = "tribal_smoker"
	base_icon_state = "tribal_smoker"
	resistance_flags = FLAMMABLE
	visible_contents = FALSE
	base_build_path = /obj/machinery/smartfridge/drying/rack/smoker
	use_power = NO_POWER_USE
	active_power_usage = 0
	idle_power_usage = 0
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/stone = SHEET_MATERIAL_AMOUNT  * 4,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
	)

	/// How many seconds of fuel does the smoker have left
	var/fuel_time_left = 0
	///Are we smoking? Literally
	var/smoke_state = SMOKE_STATE_NONE

/obj/machinery/smartfridge/drying/rack/smoker/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_NO_EXAMINE)

///Helper proc to check if something added to the smoker is fuel.
/obj/machinery/smartfridge/drying/rack/smoker/proc/is_fuel(obj/item/fuel)
	if(istype(fuel, /obj/item/stack/sheet/mineral/wood)) return TRUE
	if(istype(fuel, /obj/item/grown/log)) return TRUE
	return FALSE

/obj/machinery/smartfridge/drying/rack/smoker/item_interaction(mob/living/user, obj/item/added, list/modifiers)
	if(is_fuel(added))
		return add_fuel(added, user)

	return ..()

///Helper proc to add to the fuel variable when fuel is added to the machine.
/obj/machinery/smartfridge/drying/rack/smoker/proc/add_fuel(obj/item/fuel, mob/user)
	user.visible_message("[user] starts feeding fuel into the smoker.")

	if(!do_after(user, 2 SECONDS, target = src))
		return FALSE
	if(QDELETED(fuel))
		return FALSE

	if(istype(fuel, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/fuelsheet = fuel
		fuel_time_left += fuelsheet.amount * 10 SECONDS
		fuelsheet.use(fuelsheet.amount)
	else if(istype(fuel, /obj/item/grown/log))
		fuel_time_left += 20 SECONDS
		qdel(fuel)
	user.visible_message("[user] adds fuel to the smoker.")
	return TRUE

/obj/machinery/smartfridge/drying/rack/smoker/toggle_drying(forceoff, mob/user)
	if(drying || forceoff)
		drying = FALSE
		current_user = null
		update_appearance()
		return

	if(fuel_time_left <= 0)
		if(user)
			to_chat(user, span_warning("The smoker has no fuel."))
		drying = FALSE
		update_appearance()
		return

	drying = TRUE
	if(user?.mind)
		current_user = WEAKREF(user.mind)

	update_appearance()

/obj/machinery/smartfridge/drying/rack/smoker/process(seconds_per_tick)
	..()

	if(drying)
		if(fuel_time_left > 0)
			fuel_time_left -= seconds_per_tick
			set_smoke_state(SMOKE_STATE_ACTIVE)
		else
			drying = FALSE
			current_user = null
			update_appearance()
			set_smoke_state(SMOKE_STATE_NONE)
	else
		set_smoke_state(SMOKE_STATE_NONE)

///Helper proc to set the smoking particle on if the smoker is on, off if it is off.
/obj/machinery/smartfridge/drying/rack/smoker/proc/set_smoke_state(new_state)
	if(new_state == smoke_state)
		return

	smoke_state = new_state

	QDEL_NULL(particles)

	switch(smoke_state)
		if(SMOKE_STATE_NONE)
			return

		if(SMOKE_STATE_ACTIVE)
			particles = new /particles/smoke/steam/mild()
			particles.position = list(6, 4, 0)

/obj/machinery/smartfridge/drying/rack/smoker/examine(mob/user)
	. = ..()

	if(in_range(user, src) || isobserver(user))
		if(fuel_time_left > 0)
			if(drying)
				. += span_notice("The firebox glows warmly, feeding smoke into the chamber. It has about <b>[round(fuel_time_left / (1 SECONDS))]</b> seconds of fuel left.")
			else
				. += span_notice("The firebox is ready, but the chamber isn't drying anything right now.")
		else
			. += span_warning("The firebox is cold. Feed it logs or planks to produce smoke.")

/datum/crafting_recipe/primitive_smoker
	name = "Primitive Smoker"
	result = /obj/machinery/smartfridge/drying/rack/smoker
	reqs = list(/obj/item/stack/sheet/mineral/wood = 6,
		/obj/item/stack/sheet/mineral/stone = 4,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/stack/rods = 1,
	)
	time = 5 SECONDS
	category = CAT_STRUCTURE

#undef SMOKE_STATE_NONE
#undef SMOKE_STATE_ACTIVE
