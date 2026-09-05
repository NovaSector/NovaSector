/obj/structure/shuttle_decoration/munition
	abstract_type = /obj/structure/shuttle_decoration/munition
	name = "munition basetype"
	desc = "A basetype for munitions that you SHOULD NOT BE SEEING!!"
	icon = 'modular_nova/modules/shipbreaking/icons/64x32.dmi'
	icon_state = null
	density = TRUE
	unfasten_time = 3 SECONDS
	drag_slowdown = 3
	inertia_force_weight = 2
	SET_BASE_PIXEL(-16, -16)
	shuttles_wont_pixelshift = TRUE
	resets_pixelshifting = FALSE
	/// Has the weapon been armed by mistake?
	var/armed_and_dangerous = FALSE
	/// Do we even need to be armed to do our problem effect?
	var/needs_to_be_armed = TRUE
	/// Are we currently in the process of exploding?
	var/currently_cooking_off = FALSE
	/// Chance to arm on throw impact
	var/chance_to_arm = 100

/obj/structure/shuttle_decoration/munition/examine(mob/user)
	. = ..()
	if(needs_to_be_armed)
		. += "[span_notice("It will not go off unless under extreme circumstances, unless it is armed. Which, currently,")] [armed_and_dangerous ? span_warning("it is.") : span_nicegreen("it isn't.")]"
	else
		. += span_warning("It looks old and unstable, and might go off if handled improperly.")

/// Determines if the weapon should go off or not when non-catastrophic accidents occur to it, sets it off if so
/obj/structure/shuttle_decoration/munition/proc/set_off()
	if(needs_to_be_armed && !armed_and_dangerous)
		return FALSE
	subtle_foreshadowing()
	return TRUE

/// Makes the munition start sparking and spewing fire as a leadup to exploding, like rimworld
/obj/structure/shuttle_decoration/munition/proc/subtle_foreshadowing()
	if(currently_cooking_off)
		return // We're already exploding, have some patience
	currently_cooking_off = TRUE
	update_appearance(UPDATE_OVERLAYS)
	visible_message(span_boldwarning("[src] sparks into a violent jet of flame!"), blind_message = span_boldwarning("You hear a violent burning jet of fire!"))
	playsound(src, 'sound/effects/fuse.ogg', 50, TRUE)
	set_light(3, 2, LIGHT_COLOR_ELECTRIC_CYAN, l_on = TRUE)
	addtimer(CALLBACK(src, PROC_REF(disaster_effects)), 5 SECONDS)

/// Makes the munition explode, or do whatever it does
/obj/structure/shuttle_decoration/munition/proc/disaster_effects()
	return

/obj/structure/shuttle_decoration/munition/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!prob(chance_to_arm))
		return
	if(!needs_to_be_armed || armed_and_dangerous)
		subtle_foreshadowing()
	else
		armed_and_dangerous = TRUE
		playsound(src, 'sound/items/timer.ogg', 50, TRUE)
		visible_message(span_warning("[src] makes an ominous beep!"), blind_message = span_warning("You hear an ominous beep!"))

/obj/structure/shuttle_decoration/munition/update_overlays()
	. = ..()
	if(currently_cooking_off)
		. += mutable_appearance('icons/effects/welding_effect.dmi', "welding_sparks", GASFIRE_LAYER, src, ABOVE_LIGHTING_PLANE, appearance_flags = RESET_COLOR|KEEP_APART)

/obj/structure/shuttle_decoration/munition/blob_act(obj/structure/blob/blob_bit)
	set_off()

/obj/structure/shuttle_decoration/munition/ex_act()
	subtle_foreshadowing() // No chance when you blow up the missiles
	return TRUE

/obj/structure/shuttle_decoration/munition/fire_act(exposed_temperature, exposed_volume)
	set_off()

/obj/structure/shuttle_decoration/munition/zap_act(power, zap_flags)
	. = ..()
	if(ZAP_OBJ_DAMAGE & zap_flags)
		set_off()

/obj/structure/shuttle_decoration/munition/bullet_act(obj/projectile/hitting_projectile)
	if(hitting_projectile.damage > 0 && ((hitting_projectile.damage_type == BURN) || (hitting_projectile.damage_type == BRUTE)))
		log_bomber(hitting_projectile.firer, "ruptured", src, "via projectile")
		set_off()
		return hitting_projectile.on_hit(src, 0)
	return ..()

/obj/structure/shuttle_decoration/munition/welder_act(mob/living/user, obj/item/tool)
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	if(!set_off())
		return ITEM_INTERACT_FAILURE
	user.visible_message(span_danger("[user] cuts into [src]!"))
	log_bomber(user, "set off", src, "via [tool.name]")
	return ITEM_INTERACT_SUCCESS

/obj/structure/shuttle_decoration/munition/missile
	name = "\improper M-Seira Transorbital Missile"
	desc = "Considering the choices of your life that brought you before a decade old missile is an important first step. \
		Every information packet that exists gives only one simple direction for safely handling these: Don't. Failing that, \
		you could at least try to be gentle with it."
	icon_state = "mseira"
	custom_materials = list(
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 2.5,
	)

/obj/structure/shuttle_decoration/munition/missile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noisy_movement)

/obj/structure/shuttle_decoration/munition/missile/disaster_effects()
	explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 4, flame_range = 4, flash_range = 5, smoke = TRUE)
	Destroy()

/obj/structure/shuttle_decoration/munition/missile/orbital
	name = "\improper Cha-Seira Orbital Interceptor"
	icon_state = "chaseira"

/obj/structure/shuttle_decoration/munition/missile/extraorbital
	name = "\improper Cha-Seira Extra-Orbital Interceptor"
	icon_state = "chaseira_extended"

/obj/structure/shuttle_decoration/munition/ciws
	name = "defense cannon shell crate"
	desc = "A large box of dusty old 26mm point defense cannon shells. While the fuzes for the heads are inert until fired \
		from their weapon, the shells remain violently flammable if mistreated."
	icon_state = "autocannon"
	needs_to_be_armed = FALSE
	custom_materials = list(
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/structure/shuttle_decoration/munition/ciws/disaster_effects()
	explosion(src, heavy_impact_range = 1, light_impact_range = 3, flame_range = 3, flash_range = 5, smoke = TRUE)
	var/obj/item/grenade/shrapnel_maker = new /obj/item/grenade/c980payload(get_turf(src))
	shrapnel_maker.detonate()
	qdel(shrapnel_maker)
	Destroy()

/obj/structure/shuttle_decoration/munition/autocannon
	name = "large autocannon shell cart"
	desc = "A cart laden with large 64mm autocannon shells. While they sit securely in foam inserts on the cart, \
		severe mistreatment could still set them off."
	icon_state = "shells"
	needs_to_be_armed = FALSE
	custom_materials = list(
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/structure/shuttle_decoration/munition/autocannon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noisy_movement)

/obj/structure/shuttle_decoration/munition/autocannon/disaster_effects()
	explosion(src, heavy_impact_range = 2, light_impact_range = 4, flame_range = 4, flash_range = 5, smoke = TRUE)
	var/obj/item/grenade/shrapnel_maker = new /obj/projectile/bullet/c980grenade/shrapnel(get_turf(src))
	shrapnel_maker.detonate()
	qdel(shrapnel_maker)
	Destroy()

/obj/structure/shuttle_decoration/munition/chaff_flares
	name = "large calibre countermeasures cart"
	desc = "A cart laden with large calibre countermeasure canisters, filled to the brim with metal strips of all flavours \
		to distract incoming weapons and radar. The explosive launching charge attached to each canister demands respect."
	icon_state = "flares"
	needs_to_be_armed = FALSE
	custom_materials = list(
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/structure/shuttle_decoration/munition/chaff_flares/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noisy_movement)

/obj/structure/shuttle_decoration/munition/chaff_flares/disaster_effects()
	explosion(src, heavy_impact_range = 2, light_impact_range = 4, flame_range = 4, flash_range = 5, smoke = TRUE)
	do_smoke(1, src, src, smoke_type = /datum/effect_system/fluid_spread/smoke/bad)
	Destroy()
