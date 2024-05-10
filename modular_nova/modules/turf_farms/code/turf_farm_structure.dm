/obj/machinery/hydroponics/turf_farm
	name = "farmable land"
	desc = "A pile of the floor that happens to be prepared for farming on."
	icon = 'modular_nova/modules/turf_farms/icons/turf_overlay.dmi'
	icon_state = null
	gender = PLURAL
	circuit = null
	density = FALSE
	use_power = NO_POWER_USE
	obj_flags = parent_type::obj_flags | NO_DEBRIS_AFTER_DECONSTRUCTION
	unwrenchable = TRUE
	self_sustaining_overlay_icon_state = null
	maxnutri = 30
	self_sustaining = TRUE
	pixel_z = 0
	var/random_icons_list = list(
		"farm_overlay_horizontal",
		"farm_overlay_vertical",
	)

/obj/machinery/hydroponics/turf_farm/Initialize(mapload)
	. = ..()
	icon_state = pick(random_icons_list)

/obj/machinery/hydroponics/turf_farm/update_status_light_overlays()
	return

/obj/machinery/hydroponics/turf_farm/CtrlClick(mob/user)
	return

/obj/machinery/hydroponics/turf_farm/on_deconstruction(disassembled)
	return

/obj/machinery/hydroponics/turf_farm/set_seed(obj/item/seeds/new_seed, delete_old_seed)
	. = ..()
	if(isnull(myseed))
		qdel(src)

// Why did tg even remove no_deconstruction
/obj/machinery/hydroponics/turf_farm/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/hydroponics/turf_farm/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/hydroponics/turf_farm/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

// Override of the base process proc because wow this is hot garbage!
/obj/machinery/hydroponics/process(seconds_per_tick)
	var/needs_update = FALSE // Checks if the icon needs updating so we don't redraw empty trays every time

	if(self_sustaining)
		if(powered())
			adjust_waterlevel(rand(1,2) * seconds_per_tick * 0.5)
			adjust_weedlevel(-0.5 * seconds_per_tick)
			adjust_pestlevel(-0.5 * seconds_per_tick)
		else
			set_self_sustaining(FALSE)
			visible_message(span_warning("[name]'s auto-grow functionality shuts off!"))

	if(!(world.time > (lastcycle + cycledelay)))
		return

	lastcycle = world.time
	if(myseed && plant_status != HYDROTRAY_PLANT_DEAD)
		// Advance age
		age++
		if(age < myseed.maturation)
			lastproduce = age

		needs_update = TRUE


	// Nutrient handling
		// Nutrients deplete at a constant rate, since new nutrients can boost stats far easier.
		apply_chemicals(lastuser?.resolve())
		if(self_sustaining)
			reagents.remove_all(min(0.5, nutridrain))
		else
			reagents.remove_all(nutridrain)

		// Lack of nutrients hurts non-weeds
		if(reagents.total_volume <= 0 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy))
			adjust_plant_health(-rand(1,3))

	// Checks for light
		// Lack of light hurts non-mushrooms
		if(isturf(loc))
			var/turf/currentTurf = loc
			var/lightAmt = currentTurf.get_lumcount()
			var/is_fungus = myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism)
			if(lightAmt < (is_fungus ? 0.2 : 0.4))
				adjust_plant_health((is_fungus ? -1 : -2) / rating)

	// Water handling
		// Drink random amount of water
		adjust_waterlevel(-rand(1,6) / rating)

		// If the plant is dry, it loses health pretty fast, unless mushroom
		if(waterlevel <= 10 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
			adjust_plant_health(-rand(0,1) / rating)
			if(waterlevel <= 0)
				adjust_plant_health(-rand(0,2) / rating)

		// Sufficient water level and nutrient level = plant healthy but also spawns weeds
		else if(waterlevel > 10 && reagents.total_volume > 0)
			adjust_plant_health(rand(1,2) / rating)
			if(myseed && prob(myseed.weed_chance))
				adjust_weedlevel(myseed.weed_rate)
			else if(prob(5))  //5 percent chance the weed population will increase
				adjust_weedlevel(1 / rating)

	// Toxins handling
		// Too much toxins cause harm, but when the plant drinks the contaiminated water, the toxins disappear slowly
		if(toxic >= 40 && toxic < 80)
			adjust_plant_health(-1 / rating)
			adjust_toxic(-rating * 2)
		else if(toxic >= 80) // I don't think it ever gets here tbh unless above is commented out
			adjust_plant_health(-3)
			adjust_toxic(-rating * 3)

	// Pests and weeds
		if(pestlevel >= 8)
			if(!myseed.get_gene(/datum/plant_gene/trait/carnivory))
				if(myseed.potency >= 30)
					myseed.adjust_potency(-rand(2,6)) //Pests eat leaves and nibble on fruit, lowering potency.
					myseed.set_potency(min((myseed.potency), CARNIVORY_POTENCY_MIN, MAX_PLANT_POTENCY))
			else
				adjust_plant_health(2 / rating)
				adjust_pestlevel(-1 / rating)

		else if(pestlevel >= 4)
			if(!myseed.get_gene(/datum/plant_gene/trait/carnivory))
				if(myseed.potency >= 30)
					myseed.adjust_potency(-rand(1,4))
					myseed.set_potency(min((myseed.potency), CARNIVORY_POTENCY_MIN, MAX_PLANT_POTENCY))

			else
				adjust_plant_health(1 / rating)
				if(prob(50))
					adjust_pestlevel(-1 / rating)

		else if(pestlevel < 4 && myseed.get_gene(/datum/plant_gene/trait/carnivory))
			if(prob(5))
				adjust_pestlevel(-1 / rating)

		// If it's a weed, it doesn't stunt the growth
		if(weedlevel >= 5 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy))
			if(myseed.yield >= 3)
				myseed.adjust_yield(-rand(1,2)) //Weeds choke out the plant's ability to bear more fruit.
				myseed.set_yield(min((myseed.yield), WEED_HARDY_YIELD_MIN, MAX_PLANT_YIELD))

	// Handles pollination
			pollinate()

	// Stability and mutations
		if(myseed.instability >= 80)
			var/mutation_chance = myseed.instability - 75
			mutate(0, 0, 0, 0, 0, 0, 0, mutation_chance, 0) //Scaling odds of a random trait or chemical
		// This is where the only actual real edit from the base proc is, it ignores if the tray is self sustaining for mutations
		if(myseed.instability >= 60)
			if(prob((myseed.instability)/2) && LAZYLEN(myseed.mutatelist) && !myseed.get_gene(/datum/plant_gene/trait/never_mutate)) //Minimum 30%, Maximum 50% chance of mutating every age tick when not on autogrow or having Prosophobic Inclination trait.
				mutatespecie()
				myseed.set_instability(myseed.instability/2)
		if(myseed.instability >= 40)
			if(prob(myseed.instability) && !myseed.get_gene(/datum/plant_gene/trait/stable_stats)) //No hardmutation if Symbiotic Resilience trait is present.
				hardmutate()
		if(myseed.instability >= 20 )
			if(prob(myseed.instability) && !myseed.get_gene(/datum/plant_gene/trait/stable_stats)) //No mutation if Symbiotic Resilience trait is present.
				mutate()

	// Health and plant age
		// Plant dies if plant_health <= 0
		if(plant_health <= 0)
			plantdies()
			adjust_weedlevel(1 / rating) // Weeds flourish

		// If the plant is too old, lose health fast
		if(age > myseed.lifespan)
			adjust_plant_health(-rand(1,5) / rating)

		// Harvest code
		if(age > myseed.production && (age - lastproduce) > myseed.production && plant_status == HYDROTRAY_PLANT_GROWING)
			if(myseed && myseed.yield != -1) // Unharvestable shouldn't be harvested
				set_plant_status(HYDROTRAY_PLANT_HARVESTABLE)
			else
				lastproduce = age
		if(prob(5))  // On each tick, there's a 5 percent chance the pest population will increase
			adjust_pestlevel(1 / rating)
	else
		if(waterlevel > 10 && reagents.total_volume > 0 && prob(10))  // If there's no plant, the percentage chance is 10%
			adjust_weedlevel(1 / rating)

	// Weeeeeeeeeeeeeeedddssss
	if(weedlevel >= 10 && prob(50) && !self_sustaining) // At this point the plant is kind of fucked. Weeds can overtake the plant spot.
		if(myseed && myseed.yield >= 3)
			myseed.adjust_yield(-rand(1,2)) //Loses even more yield per tick, quickly dropping to 3 minimum.
			myseed.set_yield(min((myseed.yield), WEED_HARDY_YIELD_MIN, MAX_PLANT_YIELD))
		if(!myseed)
			weedinvasion()
		needs_update = 1
	if(needs_update)
		update_appearance()

	if(myseed)
		SEND_SIGNAL(myseed, COMSIG_SEED_ON_GROW, src)

	return
