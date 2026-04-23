/obj/item/organ/stomach/fuel_generator
	name = "Android engine"
	desc = "An incredibly small, versatile modern combustion engine produced by Conarex Aeronautics, meant to power cybernetic organisms."
	disable_base_stomach_behavior = TRUE
	can_process_solids = FALSE
	organ_flags = ORGAN_ROBOTIC
	reagent_vol = 100
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'
	icon_state = "fuel_generator"
	organ_traits = list(TRAIT_NOHUNGER)
	var/offset_pixel = 0
	var/hud_icon = "power_beer"
	var/hud_icon_file = 'icons/hud/screen_gen.dmi'
	/// Is the favorite reagent an exact match?
	var/favorite_reagent_exact = FALSE
	var/favorite_reagent = /datum/reagent/consumable/ethanol
	var/ethanol_modifier = 6
	var/flammable_modifier = 3
	var/list/flammable_reagents = list(
		/datum/reagent/thermite = 70,
		/datum/reagent/clf3 = 80,
		/datum/reagent/stable_plasma = 10, // too stable to burn well, not a good source of fuel
		/datum/reagent/fuel = 30, // Not great but works in a pinch
		/datum/reagent/toxin/plasma = 300 // STRAIGHT PLASMA BABY LETS GO
	)
	// Burns into carbon, which clogs up the fuel generator until it cooks off, reducing power conversion
	var/list/bad_reagents = list(
		/datum/reagent/toxin,
		/datum/reagent/consumable,
		/datum/reagent/drug,
		/datum/reagent/catalyst_agent,
		/datum/reagent/medicine
	)
	var/obj/effect/abstract/particle_holder/particle_effect
	var/datum/looping_sound/generator/soundloop

/obj/item/organ/stomach/fuel_generator/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/organ/stomach/fuel_generator/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	var/obj/item/organ/brain/robot_nova/robot_brain = receiver.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	robot_brain.run_updates()

/obj/item/organ/stomach/fuel_generator/on_mob_remove(mob/living/carbon/stomach_owner, special, movement_flags)
	var/obj/item/organ/brain/robot_nova/robot_brain = stomach_owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		return
	. = ..()
	if(robot_brain)
		robot_brain.run_updates()

/obj/item/organ/stomach/fuel_generator/Destroy()
	qdel(soundloop)
	. = ..()

/obj/item/organ/stomach/fuel_generator/on_life(seconds_per_tick, times_fired)
	. = ..()
	process_fuel()

/obj/item/organ/stomach/fuel_generator/on_death(seconds_per_tick, times_fired)
	. = ..()
	process_fuel()

/obj/item/organ/stomach/fuel_generator/proc/handle_favorite_reagent(datum/reagent/reagent_burned)
	var/carbon_amount = reagents.get_reagent_amount(/datum/reagent/carbon)
	var/datum/reagent/consumable/ethanol/liquid = reagent_burned
	var/power_generated = (max((liquid.boozepwr / 100) - (carbon_amount / 100), 0) * ethanol_modifier) * ((maxHealth - damage) / maxHealth)
	reagents.remove_reagent(liquid.type, 2)
	return power_generated

/obj/item/organ/stomach/fuel_generator/proc/process_fuel()
	var/power_generated = 0
	var/mob/living/carbon/body = owner
	if(reagents.total_volume)
		soundloop.start()
	else
		soundloop.stop()
	var/carbon_amount = reagents.get_reagent_amount(/datum/reagent/carbon)
	if(carbon_amount > 0)
		if(!particle_effect)
			to_chat(body, span_warning("The exhaust pipe on [src] emits smoke."))
			balloon_alert(body, "generator smoking!")
			particle_effect = new(body, /particles/smoke/burning/small)
		reagents.remove_reagent(/datum/reagent/carbon, 0.1) // Cook off Carbon at a quarter the rate of addition
	else
		if(particle_effect)
			QDEL_NULL(particle_effect)
	reagents.set_temperature(1000)
	reagents.handle_reactions()
	for(var/datum/reagent/bit as anything in reagents?.reagent_list)
		if((favorite_reagent_exact && bit.type == favorite_reagent) || (!favorite_reagent_exact && istype(bit, favorite_reagent))) // Burn ethanol for power!
			power_generated += handle_favorite_reagent(bit)
			break
		else if(is_type_in_list(bit, flammable_reagents)) // Alternative burn options
			power_generated += (max((flammable_reagents[bit.type] / 100) - (carbon_amount / 100), 0) * flammable_modifier) * ((maxHealth - damage) / maxHealth)
			reagents.remove_reagent(bit.type, 2)
			break
		else if(is_type_in_list(bit, bad_reagents)) // Expressly do not try to burn these
			reagents.add_reagent(/datum/reagent/carbon, 0.4)
			reagents.remove_reagent(bit.type, 2)
			break
		else if(!istype(bit, /datum/reagent/carbon))
			reagents.remove_reagent(bit.type, 2)
			break
	if(owner)
		var/obj/item/organ/brain/robot_nova/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(!robot_brain || !istype(robot_brain))
			return
		robot_brain.power = min(robot_brain.power + power_generated, robot_brain.max_power)
		robot_brain.run_updates()
		if(owner.stat == DEAD)
			if(robot_brain.power > 0)
				owner.revive() // RISE FROM YOUR GRAVE

/obj/item/organ/stomach/fuel_generator/biofuel
	name = "Android biofuel engine"
	desc = "An incredibly small, versatile modern combustion engine produced by Conarex Aeronautics, meant to power cybernetic organisms. \
	Can't take in any liquids; put solid fuel, preferably organic, in the fuel intake. Doesn't burn as good as liquid fuels do, though."
	offset_pixel = 0
	hud_icon = "power_food"
	can_process_liquids = FALSE
	can_process_solids = TRUE
	favorite_reagent = /datum/reagent/consumable/nutriment
	favorite_reagent_exact = TRUE
	ethanol_modifier = 6
	flammable_modifier = 3
	flammable_reagents = list(
		/datum/reagent/consumable/nutraslop = 50, // lov me slop
		/datum/reagent/consumable/nutriment/soup = 75, // Doesn't burn as good, it's liquid
		/datum/reagent/consumable/sugar = 10, // Absolute dogshit.
		/datum/reagent/consumable/nutriment/peptides = 50, // Not organic, created in a lab
		/datum/reagent/consumable/nutriment/fat = 80, // Good for you but doesn't burn as well
		/datum/reagent/consumable/nutriment/protein = 200, // ORGANIC AND GOOD FOR YOU, burns well in biofuel
		/datum/reagent/consumable/nutriment/vitamin = 300, // THE GODO SHIT
	)
	bad_reagents = list(
		/datum/reagent/toxin,
		/datum/reagent/consumable/ethanol,
		/datum/reagent/drug,
		/datum/reagent/catalyst_agent,
		/datum/reagent/medicine
	)

/obj/item/organ/stomach/fuel_generator/biofuel/handle_favorite_reagent(datum/reagent/reagent_burned)
	var/carbon_amount = reagents.get_reagent_amount(/datum/reagent/carbon)
	var/datum/reagent/consumable/nutriment/liquid = reagent_burned
	var/power_generated = (max(((liquid.purity * 100) / 100) - (carbon_amount / 100), 0) * ethanol_modifier) * ((maxHealth - damage) / maxHealth)
	reagents.remove_reagent(liquid.type, 2)
	return power_generated

/obj/item/organ/stomach/fuel_generator/combo
	name = "Android weak hybrid engine"
	desc = "An incredibly small, versatile modern combustion engine produced by Conarex Aeronautics, meant to power cybernetic organisms. \
	A hybrid design capable of handling both flammable liquids and solid fuels, but it's not particularly good at either, and can't fully utilize either."
	offset_pixel = 0
	hud_icon = "power_combo"
	can_process_liquids = TRUE
	can_process_solids = TRUE
	favorite_reagent = /datum/reagent/medicine/adminordrazine // not obtainable
	favorite_reagent_exact = TRUE
	ethanol_modifier = 1
	flammable_modifier = 2
	flammable_reagents = list(
		/datum/reagent/consumable/nutraslop = 50,
		/datum/reagent/consumable/nutriment/soup = 50,
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/nutriment/peptides = 50,
		/datum/reagent/consumable/nutriment/fat = 50,
		/datum/reagent/consumable/nutriment/protein = 50,
		/datum/reagent/consumable/nutriment/vitamin = 50,
		/datum/reagent/thermite = 50,
		/datum/reagent/clf3 = 50,
		/datum/reagent/stable_plasma = 10,
		/datum/reagent/fuel = 10,
		/datum/reagent/toxin/plasma = 50,
		/datum/reagent/consumable/nutriment = 100, // Expected burn
		/datum/reagent/consumable/ethanol = 100, // Expected burn
	)
	bad_reagents = list(
		/datum/reagent/toxin,
		/datum/reagent/consumable/ethanol,
		/datum/reagent/drug,
		/datum/reagent/catalyst_agent,
		/datum/reagent/medicine
	)

/obj/item/organ/stomach/fuel_generator/combo/handle_favorite_reagent(datum/reagent/reagent_burned)
	reagents.remove_reagent(reagent_burned.type, 2)
	return 2

/obj/item/organ/stomach/fuel_generator/brand
	name = "GENERIC_BRAND_HERE-brand engine"
	desc = "An incredibly small, versatile modern combustion engine produced by Conarex Aeronautics, meant to power cybernetic organisms. \
	Released as part of a brand deal with GENERIC_BRAND_HERE to encourage sales."
	offset_pixel = 8
	hud_icon = null // set in initialize
	hud_icon_file = null
	can_process_liquids = TRUE
	can_process_solids = FALSE
	favorite_reagent = null // replaced by the BRAND
	favorite_reagent_exact = TRUE
	ethanol_modifier = 1
	flammable_modifier = 1
	flammable_reagents = list()
	bad_reagents = list(
		/datum/reagent, // IF IT AINT THE BRAND IT AINT BURNING
	)
	var/list/possible_brands = list(
		/obj/item/reagent_containers/cup/soda_cans/cola = /datum/reagent/consumable/space_cola,
		/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind = /datum/reagent/consumable/spacemountainwind,
		/obj/item/reagent_containers/cup/soda_cans/dr_gibb = /datum/reagent/consumable/dr_gibb,
		/obj/item/reagent_containers/cup/soda_cans/space_up = /datum/reagent/consumable/space_up,
		/obj/item/reagent_containers/cup/soda_cans/pwr_game = /datum/reagent/consumable/pwr_game,
		/obj/item/reagent_containers/cup/soda_cans/sol_dry = /datum/reagent/consumable/sol_dry,
		/obj/item/reagent_containers/cup/soda_cans/volt_energy = /datum/reagent/consumable/volt_energy,
		/obj/item/reagent_containers/cup/soda_cans/thirteenloko = /datum/reagent/consumable/ethanol/thirteenloko,
		/obj/item/reagent_containers/cup/soda_cans/shamblers = /datum/reagent/consumable/shamblers,
		/obj/item/reagent_containers/cup/soda_cans/wellcheers = /datum/reagent/consumable/wellcheers,
		/obj/item/reagent_containers/cup/soda_cans/monkey_energy = /datum/reagent/consumable/monkey_energy,
		/obj/item/reagent_containers/cup/soda_cans/grey_bull = /datum/reagent/consumable/grey_bull,
	)

/obj/item/organ/stomach/fuel_generator/brand/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/cup/soda_cans/picked_can = pick(possible_brands)
	favorite_reagent = possible_brands[picked_can]
	name = replacetext(name, "GENERIC_BRAND_HERE", picked_can::name)
	desc = replacetext(desc, "GENERIC_BRAND_HERE", picked_can::name)
	hud_icon = picked_can::icon_state
	hud_icon_file = picked_can::icon

/obj/item/organ/stomach/fuel_generator/brand/handle_favorite_reagent(datum/reagent/reagent_burned)
	reagents.remove_reagent(reagent_burned.type, 2)
	return 10

/obj/item/organ/stomach/fuel_generator/power_cable
	name = "black market android power cable"
	desc = "A beefy illegal industrial-grade power cable, plugged directly into the power system of the android. Can be plugged into the APC of an area to charge off of it. \
	Forbidden under TerraGov and Spinward law due to regulations on Android life regarding resemblance to biological life; possession of such a cord is \
	grounds for immediate deconstruction."
	offset_pixel = 0
	hud_icon = "power_plug"
	can_process_liquids = FALSE
	can_process_solids = FALSE
	favorite_reagent = null
	favorite_reagent_exact = TRUE
	ethanol_modifier = 0
	flammable_modifier = 0
	flammable_reagents = list()
	bad_reagents = list()
	var/datum/action/toggle_cable/toggle_cable
	var/obj/item/power_plug/our_plug

/obj/item/organ/stomach/fuel_generator/power_cable/Initialize(mapload)
	. = ..()
	toggle_cable = new(src)
	toggle_cable.our_stomach = src
	our_plug = new(src)
	our_plug.our_stomach = src
	our_plug.forceMove(src)

/obj/item/organ/stomach/fuel_generator/power_cable/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	toggle_cable.Grant(receiver)
	our_plug.cancel_plug()
	our_plug.our_leash = WEAKREF(our_plug.AddComponent(/datum/component/leash, receiver))
	our_plug.forceMove(src)
	if(receiver.stat == DEAD) // drop the plug immediately
		owner.balloon_alert_to_viewers("plug dropped")
		playsound(owner, SFX_SPARKS, 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		do_sparks(5, FALSE, owner)
		our_plug.forceMove(get_turf(owner))
	RegisterSignal(receiver, COMSIG_LIVING_DEATH, PROC_REF(drop_plug))
	RegisterSignal(receiver, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	STOP_PROCESSING(SSprocessing, our_plug)

/obj/item/organ/stomach/fuel_generator/power_cable/on_mob_remove(mob/living/carbon/stomach_owner, special, movement_flags)
	toggle_cable.Remove(stomach_owner)
	our_plug.cancel_plug()
	UnregisterSignal(stomach_owner, COMSIG_LIVING_DEATH)
	UnregisterSignal(stomach_owner, COMSIG_MOVABLE_MOVED)
	STOP_PROCESSING(SSprocessing, our_plug)
	. = ..()

/obj/item/organ/stomach/fuel_generator/power_cable/proc/on_moved(atom/movable/mover, turf/old_loc)
	SIGNAL_HANDLER
	if(!our_plug)
		return // dont do shit
	if(!our_plug.apc) // if we aren't plugged into an APC
		if(get_turf(our_plug.loc) == get_turf(src))
			qdel(our_plug.cable_beam)
		else
			qdel(our_plug.cable_beam) // DELETE AND REDRAW
			our_plug.cable_beam = our_plug.Beam(get_turf(owner), icon_state = "power_cord")

/obj/item/organ/stomach/fuel_generator/power_cable/proc/drop_plug(mob/living/target, gibbed)
	SIGNAL_HANDLER
	our_plug.cancel_plug()
	if(owner) // if the owner still exists, drop the plug there so someone can plug them in
		owner.balloon_alert_to_viewers("plug dropped")
		playsound(owner, SFX_SPARKS, 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		do_sparks(5, FALSE, owner)
		our_plug.forceMove(get_turf(owner))
		our_plug.our_leash = WEAKREF(our_plug.AddComponent(/datum/component/leash, owner))

/obj/item/organ/stomach/fuel_generator/power_cable/Destroy()
	qdel(toggle_cable)
	qdel(our_plug)
	. = ..()

/obj/item/organ/stomach/fuel_generator/power_cable/handle_favorite_reagent(datum/reagent/reagent_burned)
	return 0

/obj/item/power_plug
	name = "power plug"
	desc = "Plug this into an APC to start draining power. Will create a hazard, so be careful if people walk over it."
	icon = 'icons/effects/beam.dmi'
	icon_state = "power_cord_end"
	var/datum/beam/cable_beam
	var/obj/item/organ/stomach/fuel_generator/power_cable/our_stomach
	var/obj/machinery/power/apc/apc
	var/datum/weakref/our_leash

/obj/item/power_plug/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))

/obj/item/power_plug/proc/on_moved(atom/movable/mover, turf/old_loc)
	SIGNAL_HANDLER
	if(!our_stomach)
		return // dont do shit
	if(!apc) // if we aren't plugged into an APC
		if(get_turf(loc) == get_turf(our_stomach))
			qdel(cable_beam)
		else
			qdel(cable_beam) // DELETE AND REDRAW
			if(!isturf(loc))
				cable_beam = loc.Beam(get_turf(our_stomach.owner), icon_state = "power_cord")
			else
				cable_beam = Beam(get_turf(our_stomach.owner), icon_state = "power_cord")

/obj/item/power_plug/Destroy(force)
	cancel_plug()
	qdel(our_stomach) // if the plug is destroyed, destroy the stomach organ
	our_stomach = null
	apc = null
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/item/power_plug/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!our_stomach || !our_stomach.owner)
		return
	if(istype(target, /obj/machinery/power/apc))
		apc = target
		forceMove(apc)
		if(cable_beam)
			qdel(cable_beam)
		cable_beam = our_stomach.owner.Beam(apc, beam_type = /obj/effect/ebeam/reacting/power_cable, icon_state = "power_cord", icon_state_end = "power_cord_end")
		RegisterSignal(cable_beam, COMSIG_BEAM_ENTERED, PROC_REF(beam_entered))
		var/datum/component/leash/leash_component = our_leash?.resolve()
		if(leash_component)
			qdel(leash_component)
		our_leash = WEAKREF(our_stomach.owner.AddComponent(/datum/component/leash, apc))
		START_PROCESSING(SSprocessing, src)
		playsound(apc, 'sound/items/deconstruct.ogg', 50, TRUE)
		balloon_alert(user, "plugged in")

/obj/item/power_plug/proc/beam_entered(datum/beam/source, obj/effect/ebeam/hit, atom/movable/entered)
	SIGNAL_HANDLER
	if(entered != our_stomach.owner) // Is it us? If not, shock the motherfucker.
		if(istype(entered, /mob/living/carbon))
			var/mob/living/carbon/high_voltage_victim = entered
			electrocute_mob(high_voltage_victim, get_area(apc), src, 1, TRUE)

/obj/item/power_plug/process(seconds_per_tick)
	if(apc && apc.cell && our_stomach && our_stomach.owner)
		var/amount_to_drain = apc.cell.max_charge() * 0.1 // drain 10% of the cell a tick
		var/amount_actually_drained = apc.cell.use(amount_to_drain, force = TRUE)
		if(amount_actually_drained > 0)
			var/power_generated = 5 * (amount_actually_drained / amount_to_drain)
			do_sparks(5, FALSE, our_stomach.owner)
			do_sparks(5, FALSE, apc)
			for(var/obj/machinery/light/light in get_area(apc))
				light.flicker(1)
			var/obj/item/organ/brain/robot_nova/robot_brain = our_stomach.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
			if(!robot_brain || !istype(robot_brain))
				return
			robot_brain.power = min(robot_brain.power + power_generated, robot_brain.max_power)
			robot_brain.run_updates()
			if(our_stomach.owner.stat == DEAD)
				if(robot_brain.power > 0)
					our_stomach.owner.revive() // RISE FROM YOUR GRAVE

/obj/item/power_plug/proc/cancel_plug()
	forceMove(our_stomach)
	if(cable_beam)
		qdel(cable_beam)
	if(apc)
		apc = null
	var/datum/component/leash/leash_component = our_leash?.resolve()
	if(leash_component)
		qdel(leash_component)
	STOP_PROCESSING(SSprocessing, src)

/datum/action/toggle_cable
	name = "Toggle Power Cable"
	desc = "Deploy and retract your power cable to recharge off of APCs."
	button_icon = 'icons/effects/beam.dmi'
	button_icon_state = "power_cord_end"
	background_icon_state = "bg_tgmc"
	var/obj/item/organ/stomach/fuel_generator/power_cable/our_stomach

/datum/action/toggle_cable/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	if(!our_stomach || !our_stomach.owner)
		return
	if(our_stomach.our_plug.loc != our_stomach)
		owner.balloon_alert(owner, "retracted cable")
		our_stomach.our_plug.cancel_plug()
		our_stomach.our_plug.our_leash = WEAKREF(our_stomach.our_plug.AddComponent(/datum/component/leash, our_stomach.owner))
		playsound(our_stomach.owner, SFX_SPARKS, 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		do_sparks(5, FALSE, our_stomach.owner)
	else
		if(our_stomach.owner.put_in_hands(our_stomach.our_plug, ignore_animation = TRUE))
			owner.balloon_alert(owner, "deployed cable")
			playsound(our_stomach.owner, SFX_SPARKS, 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
			do_sparks(5, FALSE, our_stomach.owner)
		else
			owner.balloon_alert(owner, "hands full or unavailable!")

/obj/effect/ebeam/reacting/power_cable
	name = "power cable"

/obj/effect/ebeam/reacting/power_cable/on_entered(datum/source, atom/movable/entered)
	. = ..()
