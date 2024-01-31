/obj/machinery/health_station
	name = "\improper N-URSEI Automated Medical Suite"
	desc = "The N-URSEI, better known as simply the 'Nurse,' is a well-known product of Medical technology in the CIN. The name is of disputed origin, \
	but believed to be based off older, less portable models affectionately referred to as 'mother bears' which required specialized light trucks to carry to the field. \
	These less unwieldy models are capable of diagnosis, treatment, arguably prevention, and prognosis; \
	employing limited medicine synthesis to fill the proprietary and unbranded models of medipens."
	icon = 'modular_nova/modules/health_station/icons/health_station.dmi'
	icon_state = "health_station"
	base_icon_state = "health_station"
	light_color = "#79F8E6"
	interaction_flags_machine = INTERACT_MACHINE_REQUIRES_LITERACY|INTERACT_MACHINE_SET_MACHINE
	anchored = TRUE
	///Options, obviously
	var/static/list/radial_options = list("Health Scan" = radial_scan, "Heal Wounds" = radial_wound, "Treat Damage" = radial_damage)
	///Maximum amount of nondescript healing fluid
	var/max_charge_amount = 100
	///Current amount of nondescript healing fluid available
	var/charge_amount
	///Items that can refill it; intended to be high-end medicine items, or otherwise 'miraculous' in nature.
	var/list/refillers = list(
		/obj/item/slimecross/regenerative = 100,
		/obj/item/organ/internal/monster_core = 25, //some more use for leftover non-legion core organs as they're less frequently used
		/obj/item/food/grown/ambrosia/gaia = 10,
	)
	///Medipens that it can refill and their attached nondescript healing fluid costs
	var/list/refillable_pens = list(
		/obj/item/reagent_containers/hypospray/medipen/glucose = 2.5, //it's a useless flavor item
		/obj/item/reagent_containers/hypospray/medipen = 5,
		/obj/item/reagent_containers/hypospray/medipen/atropine = 10,
		/obj/item/reagent_containers/hypospray/medipen/blood_loss = 5,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 5,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 10,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 5,
		/obj/item/reagent_containers/hypospray/medipen/salacid = 10,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 10,
		/obj/item/reagent_containers/hypospray/medipen/stimpack = 10, //old mining one that never actually appears anywhere nowadays
		/obj/item/reagent_containers/hypospray/medipen/health_station = 20,
	)
	var/static/radial_scan = image(icon = 'icons/obj/devices/scanner.dmi', icon_state = "health")
	var/static/radial_wound = image(icon = 'icons/obj/medical/surgery_tools.dmi', icon_state = "scalpel")
	var/static/radial_damage = image(icon = 'icons/obj/medical/stack_medical.dmi', icon_state = "suture_3")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/health_station, 32)

/obj/machinery/health_station/Initialize(mapload,ndir,building)
	. = ..()
	if(mapload)
		charge_amount = max_charge_amount
	else
		charge_amount = 0
	find_and_hang_on_wall(TRUE)
	AddElement(/datum/element/manufacturer_examine, COMPANY_COLONIAL)

/obj/machinery/health_station/update_appearance(updates = ALL)
	. = ..()
	if(machine_stat & (BROKEN))
		set_light(0)
		return
	set_light(powered() ? MINIMUM_USEFUL_LIGHT_RANGE : 0)

/obj/machinery/health_station/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return FALSE

	if(charge_amount >= 0)
		switch(charge_amount)
			if(60 to 100)
				. += "[base_icon_state]_light1"
			if(30 to 60)
				. += "[base_icon_state]_light2"
			if(15 to 30)
				. += "[base_icon_state]_light3"
			else
				. += "[base_icon_state]_light4"

/obj/machinery/health_station/examine(mob/living/carbon/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: ბიომასის პროცენტული მაჩვენებელია [charge_amount]%.")

/obj/machinery/health_station/attack_ghost(mob/user)
	examine(user)

/obj/machinery/health_station/ui_interact(mob/living/carbon/user)
	. = ..()
	open_options_menu(user)

/obj/machinery/health_station/attackby(obj/item/weapon, mob/living/carbon/user)
	. = ..()
	if(charge_station(weapon, user))
		return COMPONENT_NO_AFTERATTACK
	if(refill_pen(weapon, user))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/obj/machinery/health_station/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct()

/obj/machinery/health_station/on_deconstruction()
	new /obj/item/wallframe/health_station(loc)
	qdel(src)

/obj/machinery/health_station/proc/open_options_menu(mob/living/carbon/user)
	if(!ishuman(user) && (machine_stat & NOPOWER))
		return

	var/choice = show_radial_menu(user, src, radial_options, require_near = !issilicon(user), tooltips = TRUE)

	switch(choice)
		if("Health Scan")
			healthscan(user, user, advanced = TRUE)
			chemscan(user, user)
			balloon_alert(user, "analyzing vitals")
			playsound(user.loc, 'sound/items/healthanalyzer.ogg', 40, TRUE)
		if("Heal Wounds")
			playsound(user.loc, 'sound/machines/ping.ogg', 40, TRUE)
			heal_wound(user)
		if("Treat Damage")
			playsound(user.loc, 'sound/machines/ping.ogg', 40, TRUE)
			heal_damage(user)

/obj/machinery/health_station/proc/charge_station(obj/item/organ/internal/monster_core/regenerative_core, mob/living/carbon/user)
	var/charge_given = is_type_in_list(regenerative_core, refillers, zebra = TRUE)
	if(!charge_given)
		return FALSE
	add_charge(charge_given)
	qdel(regenerative_core)
	balloon_alert(user, "station refueled")
	update_appearance()
	return TRUE

/obj/machinery/health_station/proc/add_charge(charge_given)
	charge_amount = min(max_charge_amount, charge_amount + charge_given)

/obj/machinery/health_station/proc/refill_pen(attacking_item, mob/living/carbon/user)
	if(istype(attacking_item, /obj/item/reagent_containers/hypospray/medipen))
		var/obj/item/reagent_containers/hypospray/medipen/medipen = attacking_item
		if(!(LAZYFIND(refillable_pens, medipen.type)))
			balloon_alert(user, "medipen incompatible!")
			return
		if(medipen.reagents?.reagent_list.len)
			balloon_alert(user, "medipen full!")
			return
		var/charge_taken = is_type_in_list(medipen, refillable_pens, zebra = TRUE)
		if(charge_amount < charge_taken)
			balloon_alert(user, "no biomass!")
			return
		if(do_after(user, 2 SECONDS, src))
			medipen.used_up = FALSE
			medipen.add_initial_reagents()
			charge_amount -= charge_taken
		balloon_alert(user, "pen refilled")
		playsound(src, 'modular_nova/modules/hev_suit/sound/hev/hiss.ogg', 40, TRUE)
		use_power(active_power_usage)
		update_appearance()
	return TRUE

/obj/machinery/health_station/proc/heal_wound(mob/living/carbon/user)
	if(charge_amount < 20)
		balloon_alert(user, "no biomass!")
		return FALSE

	if(!user.all_wounds)
		balloon_alert(user, "no wounds!")
		return FALSE

	if(do_after(user, 5 SECONDS, src))
		var/datum/wound/wound2fix = user.all_wounds[1]
		wound2fix.remove_wound()
		balloon_alert(user, "wound treated")
		charge_amount -= 20
		playsound(src, 'sound/surgery/saw.ogg', 40, TRUE)
		use_power(active_power_usage)
		update_appearance()
	return TRUE

/obj/machinery/health_station/proc/heal_damage(mob/living/carbon/user)
	if(charge_amount < 15)
		balloon_alert(user, "no biomass!")
		return FALSE

	if(user.health == user.maxHealth)
		balloon_alert(user, "no damage!")
		return FALSE

	if(user.getBruteLoss() || user.getFireLoss())
		if(do_after(user, 2.5 SECONDS, src))
			balloon_alert(user, "damage treated")
			var/brute_to_heal = user.getBruteLoss()
			var/burn_to_heal = user.getFireLoss()
			user.adjustBruteLoss(-brute_to_heal/2)
			user.adjustFireLoss(-burn_to_heal/2)
			charge_amount -= 15
			playsound(src, 'sound/surgery/retractor1.ogg', 40, TRUE)
			use_power(active_power_usage)
			update_appearance()
	return TRUE

/obj/item/wallframe/health_station
	name = "detached N-URSEI Suite"
	desc = "An unmounted health station. Attach it to a wall to use."
	icon = 'modular_nova/modules/health_station/icons/health_station.dmi'
	icon_state = "health_station_item"
	w_class = WEIGHT_CLASS_HUGE
	result_path = /obj/machinery/health_station
	wall_external = TRUE
	pixel_shift = 32

/obj/item/wallframe/health_station/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_COLONIAL)
