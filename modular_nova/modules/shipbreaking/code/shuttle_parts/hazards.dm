/obj/structure/shuttle_decoration/liquid_tank
	abstract_type = /obj/structure/shuttle_decoration/liquid_tank
	name = "liquid tank basetype"
	desc = "A basetype for liquid tanks that you SHOULD NOT BE SEEING!!"
	icon_state = "basic_tank"
	density = TRUE
	unfasten_time = 3 SECONDS
	drag_slowdown = 3
	inertia_force_weight = 2
	/// What is the range of our rupture effects? Doesn't cover explosions.
	var/rupture_range = 2

/// When the tank is damaged enough to break, this is what it does
/obj/structure/shuttle_decoration/liquid_tank/proc/rupture_tank()
	return

/obj/structure/shuttle_decoration/liquid_tank/blob_act(obj/structure/blob/blob_bit)
	rupture_tank()

/obj/structure/shuttle_decoration/liquid_tank/ex_act()
	rupture_tank()
	return TRUE

/obj/structure/shuttle_decoration/liquid_tank/fire_act(exposed_temperature, exposed_volume)
	rupture_tank()

/obj/structure/shuttle_decoration/liquid_tank/zap_act(power, zap_flags)
	. = ..()
	if(ZAP_OBJ_DAMAGE & zap_flags)
		rupture_tank()

/obj/structure/shuttle_decoration/liquid_tank/bullet_act(obj/projectile/hitting_projectile)
	if(hitting_projectile.damage > 0 && ((hitting_projectile.damage_type == BURN) || (hitting_projectile.damage_type == BRUTE)))
		log_bomber(hitting_projectile.firer, "ruptured", src, "via projectile")
		rupture_tank()
		return hitting_projectile.on_hit(src, 0)
	return ..()

/obj/structure/shuttle_decoration/liquid_tank/welder_act(mob/living/user, obj/item/tool)
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	user.visible_message(
		span_danger("[user] cuts into [src]!"),
		span_userdanger("Is [src] supposed to make that sound?"))
	log_bomber(user, "ruptured", src, "via [tool.name]")
	rupture_tank()
	return ITEM_INTERACT_SUCCESS

/obj/structure/shuttle_decoration/liquid_tank/battery
	name = "ship battery"
	desc = "A large ship's battery for long term storage of power, extremely dangerous when damaged."
	icon_state = "battery"
	custom_materials = list(
		/datum/material/alloy/plastitaniumglass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/structure/shuttle_decoration/liquid_tank/battery/rupture_tank()
	tesla_zap(source = src, zap_range = 5, power = 1e7, cutoff = 1e3, zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_LOW_POWER_GEN | ZAP_ALLOW_DUPLICATES)
	Destroy()

/obj/structure/shuttle_decoration/liquid_tank/battery/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	tesla_zap(source = src, zap_range = 3, power = 1e4, cutoff = 1e3, zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_LOW_POWER_GEN | ZAP_ALLOW_DUPLICATES)

/obj/structure/shuttle_decoration/liquid_tank/battery/shipmind
	name = "HECS-2 Shipmind Core"
	desc = "An automated shipmind core containing everything from flight control, battery storage, and even reaction wheels \
		for smaller vessels. A probe core suitable for advanced satellites and small ships. You are assured that these are \
		\"usually\" uninhabited."
	icon_state = "shipmind"
	custom_materials = list(
		/datum/material/alloy/titaniumglass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	/// Is this shipmind core inhabitable by ghosts with a soulcatcher?
	var/has_soulcatcher = TRUE

/obj/structure/shuttle_decoration/liquid_tank/battery/shipmind/Initialize(mapload)
	. = ..()
	if(has_soulcatcher)
		var/datum/component/soulcatcher/shipmind = AddComponent(/datum/component/soulcatcher/shipmind_core)
		shipmind.create_room(target_name = "Shipmind Corespace", target_desc = "An environment of constantly flowing information, data, and controls. You should be in control of a ship, and yet your contacts have worn and your senses have dulled.")

/obj/structure/shuttle_decoration/liquid_tank/battery/shipmind/inert
	has_soulcatcher = FALSE

/datum/component/soulcatcher/shipmind_core
	name = "Defunct Shipmind Core"
	ghost_joinable = TRUE
	require_approval = FALSE
	max_souls = 1
	communicate_as_parent = TRUE
	removable = FALSE

/obj/structure/shuttle_decoration/liquid_tank/coolant
	name = "coolant tank"
	desc = "A tank of semi-radioactive coolant used to keep the interiors of ships habitable. Freezes AND irradiates \
		everything around it when ruptured!"
	icon_state = "coolant"
	custom_materials = list(
		/datum/material/alloy/plastitaniumglass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
	)
	rupture_range = 2

/obj/structure/shuttle_decoration/liquid_tank/coolant/industrial
	name = "industrial coolant tank"
	icon = 'modular_nova/modules/shipbreaking/icons/closet.dmi'
	icon_state = "coolant_big"
	custom_materials = list(
		/datum/material/alloy/plastitaniumglass = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
	)
	rupture_range = 5

// Basically does the same thing as a gluon grenade, radiation and freezing everyone nearby
/obj/structure/shuttle_decoration/liquid_tank/coolant/rupture_tank()
	playsound(loc, 'sound/effects/empulse.ogg', 50, TRUE)
	radiation_pulse(src, max_range = rupture_range, threshold = RAD_HEAVY_INSULATION, chance = 100)
	for(var/turf/open/floor/floor in view(rupture_range, loc))
		floor.freeze_turf()
	Destroy()

/obj/structure/shuttle_decoration/liquid_tank/explosive
	name = "tank of fuming acid"
	desc = "One of the three components to standard chemical shuttle fuel of the last century, fuming acid. \
		Highly explosive if the tank is ruptured."
	icon_state = "acid"
	custom_materials = list(
		/datum/material/alloy/plastitaniumglass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5,
	)
	rupture_range = 4

/obj/structure/shuttle_decoration/liquid_tank/explosive/industrial
	name = "industrial tank of fuming acid"
	icon = 'modular_nova/modules/shipbreaking/icons/closet.dmi'
	icon_state = "acid_big"
	custom_materials = list(
		/datum/material/alloy/plastitaniumglass = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
	)
	rupture_range = 7

/obj/structure/shuttle_decoration/liquid_tank/explosive/rupture_tank()
	playsound(src, 'sound/effects/bamf.ogg', 75, TRUE)
	var/datum/reagents/foam_reagents = new /datum/reagents/(100)
	foam_reagents.add_reagent(/datum/reagent/toxin/acid/nitracid, 30)
	foam_reagents.add_reagent(/datum/reagent/toxin/acid, 70)
	var/datum/effect_system/fluid_spread/foam/foam = new(loc, 4, holder = src, location = get_turf(src), carry = foam_reagents)
	foam.start()
	Destroy()

/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine
	name = "tank of nitrohydrazine"
	desc = "One of the three components to standard chemical shuttle fuel of the last century, nitrohydrazine. \
		Highly explosive if the tank is ruptured, because hydrazine didn't have enough nitrogen already."
	icon_state = "nitrohydrazine"

/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine/rupture_tank()
	explosion(src, heavy_impact_range = 1, light_impact_range = 2, flame_range = 4, flash_range = 5, smoke = TRUE)
	Destroy()

/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine/industrial
	name = "industrial tank of nitrohydrazine"
	icon = 'modular_nova/modules/shipbreaking/icons/closet.dmi'
	icon_state = "hydrazine_big"

/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine/industrial/rupture_tank()
	explosion(src, heavy_impact_range = 2, light_impact_range = 4, flame_range = 8, flash_range = 12, smoke = TRUE)
	Destroy()

/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium
	name = "tank of lithium"
	desc = "One of the three components to standard chemical shuttle fuel of the last century, lithium. \
		Highly explosive if the tank is ruptured."
	icon_state = "lithium"
	rupture_range = 2

/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium/industrial
	name = "industrial tank of lithium"
	icon = 'modular_nova/modules/shipbreaking/icons/closet.dmi'
	icon_state = "lithium_big"
	rupture_range = 5

/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium/rupture_tank()
	playsound(src, 'sound/effects/bamf.ogg', 75, TRUE)
	var/datum/reagents/foam_reagents = new /datum/reagents/(100)
	foam_reagents.add_reagent(/datum/reagent/clf3, 50)
	foam_reagents.add_reagent(/datum/reagent/napalm, 50)
	var/datum/effect_system/fluid_spread/foam/foam = new(loc, 6, holder = src, location = get_turf(src), carry = foam_reagents)
	foam.start()
	explosion(src, heavy_impact_range = 0, light_impact_range = 0, flame_range = rupture_range, flash_range = rupture_range * 3, smoke = TRUE)
	Destroy()

/obj/structure/shuttle_decoration/liquid_tank/reactor
	name = "ethereal bloom reactor"
	desc = "Superceded by modern ship reactor designs, this older type of generator can be most accurately described as \
		a \"Tortured Chrysalid\". Utilizing the same type of core process that powers the ethereal, it recycles energy with nearly \
		perfect efficiency. Calling it a reactor is a complete misnomer, as these act more closely to a large battery \
		with a generational lifespan."
	icon_state = "reactor"
	custom_materials = list(
		/datum/material/alloy/alien = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/alloy/plastitaniumglass = SHEET_MATERIAL_AMOUNT * 6.5,
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 4,
	)
	light_on = TRUE
	light_power = 2
	light_range = 3
	light_color = LIGHT_COLOR_PURPLE
	rupture_range = 14

/obj/structure/shuttle_decoration/liquid_tank/reactor/rupture_tank()
	playsound(src, 'modular_nova/modules/shipbreaking/sound/plasma_bomb.ogg', 100, FALSE, 70, 1, pressure_affected = FALSE, ignore_walls = TRUE)
	radiation_pulse(src, max_range = rupture_range, threshold = RAD_EXTREME_INSULATION, chance = 100)
	var/vaporize_that_guy = rand(2, 4)
	for(var/iterator in 1 to vaporize_that_guy)
		tesla_zap(source = src, zap_range = rupture_range / 5, power = 1e7, cutoff = 1e3, zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_LOW_POWER_GEN | ZAP_ALLOW_DUPLICATES)
	goonchem_vortex(get_turf(src), FALSE, 10)
	explosion(src, heavy_impact_range = 3, light_impact_range = 7, flame_range = 12, flash_range = 23, silent = TRUE, smoke = TRUE)
	Destroy()

/obj/structure/shuttle_decoration/liquid_tank/reactor/super
	name = "large ethereal bloom reactor"
	icon_state = "super_reactor"
	custom_materials = list(
		/datum/material/alloy/alien = SHEET_MATERIAL_AMOUNT * 13,
		/datum/material/alloy/plastitaniumglass = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 7,
	)
	rupture_range = 25

/obj/structure/shuttle_decoration/liquid_tank/reactor/super/rupture_tank()
	playsound(src, 'modular_nova/modules/shipbreaking/sound/plasma_bomb.ogg', 100, FALSE, 100, 1, pressure_affected = FALSE, ignore_walls = TRUE)
	radiation_pulse(src, max_range = 25, threshold = RAD_EXTREME_INSULATION, chance = 100)
	var/vaporize_that_guy = rand(3, 6)
	for(var/iterator in 1 to vaporize_that_guy)
		tesla_zap(source = src, zap_range = 5, power = 5e7, cutoff = 1e3, zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_LOW_POWER_GEN | ZAP_ALLOW_DUPLICATES)
	goonchem_vortex(get_turf(src), FALSE, 13)
	explosion(src, heavy_impact_range = 5, light_impact_range = 10, flame_range = 15, flash_range = 34, silent = TRUE, smoke = TRUE)
	Destroy()
