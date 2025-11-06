#define BUILDING_EMP_TOTEM "building totem ability"
/**
 * ### Webslinger
 * These are the abilities tailored to specifically the webslinger spider
 */
/// Webslinger snare
/datum/action/cooldown/spell/pointed/projectile/web_restraints
	name = "sticky restraints"
	desc = "Launch at your prey to immobilize them."
	button_icon = 'modular_nova/modules/spider/icons/spider.dmi'
	button_icon_state = "spideregg"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"

	cooldown_time = 15 SECONDS
	spell_requirements = NONE

	active_msg = "You prepare to throw a restraint at your target!"
	cast_range = 8
	projectile_type = /obj/projectile/webslinger_snare

/obj/projectile/webslinger_snare
	name = "web snare"
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "spideregg"
	damage = 0
	// So this is basically to avoid hitting webs before the person
	projectile_phasing =  PASSTABLE | PASSGRILLE | PASSSTRUCTURE
	reflectable = FALSE

/obj/projectile/webslinger_snare/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!iscarbon(target) || blocked >= 100)
		return
	var/obj/item/restraints/legcuffs/beartrap/webslinger_snare/restraint = new(get_turf(target))
	restraint.spring_trap(target, ignore_movetypes = TRUE)

/obj/item/restraints/legcuffs/beartrap/webslinger_snare
	name = "sticky restraints"
	desc = "Used by mega-arachnids to immobilize their prey."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	flags_1 = NONE
	item_flags = DROPDEL
	icon_state = "spideregg"
	armed = TRUE
	trap_damage = 10
	breakouttime = 10 SECONDS

/obj/item/restraints/legcuffs/beartrap/webslinger_snare/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/// Webslinger sneak
/datum/action/cooldown/mob_cooldown/sneak/webslinger
	name = "Webslinger Spider Sneak"
	desc = "Blend into the webs to stalk your prey."
	button_icon = 'modular_nova/modules/spider/icons/spider.dmi'
	button_icon_state = "webslinger"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"

/**
 * ### Baron
 * These are the abilities tailored to specifically the Baron spider
 */

// leap ability
/datum/action/cooldown/mob_cooldown/spider_leap
	name = "Leap"
	desc = "Leap on your enemy!"
	cooldown_time = 20 SECONDS
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	shared_cooldown = NONE

/datum/action/cooldown/mob_cooldown/spider_leap/Activate(atom/target)
	var/turf/target_turf = get_turf(target)
	if(isclosedturf(target_turf) || isspaceturf(target_turf))
		owner.balloon_alert(owner, "base not suitable!")
		return FALSE
	new /obj/effect/temp_visual/leaper_crush(target_turf)
	owner.throw_at(target = target_turf, range = 7, speed = 1, spin = FALSE, callback = CALLBACK(src, PROC_REF(flop_on_turf), target_turf))
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/spider_leap/proc/flop_on_turf(turf/target, original_pixel_y)
	playsound(get_turf(owner), 'sound/effects/meteorimpact.ogg', 150, TRUE)
	for(var/mob/living/victim in oview(1, owner))
		if(victim in owner.buckled_mobs)
			continue
		victim.apply_damage(15)
		if(QDELETED(victim)) // Some mobs are deleted on death
			continue
		var/throw_dir = victim.loc == owner.loc ? get_dir(owner, victim) : pick(GLOB.alldirs)
		var/throwtarget = get_edge_target_turf(victim, throw_dir)
		victim.throw_at(target = throwtarget, range = 1, speed = 1)
		victim.visible_message(span_warning("[victim] is thrown clear of [owner]!"))

// Baron's snare
/datum/action/cooldown/spell/pointed/projectile/web_restraints/baron
	name = "Baron Web Restraint"
	cooldown_time = 5 SECONDS
	projectile_type = /obj/projectile/webslinger_snare

/**
 * ### Ogre
 * These are the abilities tailored to specifically the Ogre
 */
// Create Effigy
/datum/action/cooldown/mob_cooldown/lay_web/create_totem
	name = "Plant Totem"
	desc = "Plant a Spider Totem to spread webs."
	button_icon = 'modular_nova/modules/spider/icons/spider.dmi'
	cooldown_time = 6 MINUTES
	button_icon_state = "spider_effigy"

/datum/action/cooldown/mob_cooldown/lay_web/create_totem/baron
	cooldown_time = 3 MINUTES

/datum/action/cooldown/mob_cooldown/lay_web/create_totem/obstructed_by_other_web()
	return !!(locate(/obj/structure/spider/stickyweb/sealed/reflector) in get_turf(owner))

/datum/action/cooldown/mob_cooldown/lay_web/create_totem/plant_web(turf/target_turf, obj/structure/spider/stickyweb/existing_web)
	new /obj/structure/spider/stickyweb/alive/spider_effigy(target_turf)

// base web structure subtype, we wanna keep the web functions but make it so they can spread
/obj/structure/spider/stickyweb/alive
	var/spider_effigy_range = 3
	///the parent node that will determine if we grow or die
	var/obj/structure/spider/stickyweb/alive/spider_effigy/parent_node
	///the list of turfs that the weeds will not be able to grow over
	var/static/list/blacklisted_turfs = list(
		/turf/open/space,
		/turf/open/chasm,
		/turf/open/lava,
		/turf/open/water,
		/turf/open/openspace,
	)

/obj/structure/spider/stickyweb/alive/Initialize(mapload)
	. = ..()

/obj/structure/spider/stickyweb/alive/Destroy()
	if(parent_node)
		UnregisterSignal(parent_node, COMSIG_QDELETING)
		parent_node = null
	return ..()

/**
 * Called when the spider_effigy is trying to grow/expand
 */
/obj/structure/spider/stickyweb/alive/proc/try_expand()
	//we cant grow without a parent spider_effigy
	if(!parent_node)
		return
	//lets make sure we are still on a valid location
	var/turf/src_turf = get_turf(src)
	if(is_type_in_list(src_turf, blacklisted_turfs))
		qdel(src)
		return
	//lets try to grow in a direction
	for(var/turf/check_turf in src_turf.get_atmos_adjacent_turfs())
		//we cannot grow on blacklisted turfs
		if(is_type_in_list(check_turf, blacklisted_turfs))
			continue
		var/obj/structure/spider/stickyweb/alive/check_web = locate() in check_turf
		//we cannot grow onto other webs
		if(check_web)
			continue
		//spawn a new one in the turf
		check_web = new(check_turf)
		//set the new one's parent spider_effigy to our parent spider_effigy
		check_web.parent_node = parent_node

/*
* Spider Totem - Placing this will mirror how resin works for xenmorphs, but for webs
*/
/obj/structure/spider/stickyweb/alive/spider_effigy
	name = "spider effigy"
	desc = "an organic structure that seems to spread webs"
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "spider_effigy"
	base_icon_state = "spider_effigy"
	smoothing_flags = NONE
	smoothing_groups = NONE
	canSmoothWith = NONE
	density = TRUE
	light_range = 1
	light_color = COLOR_RED_LIGHT
	light_power = 0.5
	///the minimum time it takes for another weed to spread from this one
	var/minimum_growtime = 5 SECONDS
	///the maximum time it takes for another weed to spread from this one
	var/maximum_growtime = 10 SECONDS
	//the cooldown between each growth
	COOLDOWN_DECLARE(growtime)

// Assign the boi as the parent
/obj/structure/spider/stickyweb/alive/spider_effigy/Initialize(mapload)
	. = ..()
	//we are the parent spider_effigy
	parent_node = src

	return INITIALIZE_HINT_LATELOAD

// we do this in LateInitialize() because webs on the same loc may not be done initializing yet (as in create_and_destroy)
/obj/structure/spider/stickyweb/alive/spider_effigy/LateInitialize()
	//destroy any non-spider_effigy webs on turf
	var/obj/structure/spider/stickyweb/alive/check_web = locate(/obj/structure/spider/stickyweb/alive) in loc
	if(check_web && check_web != src)
		qdel(check_web)

	//start the cooldown
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))

	//start processing
	START_PROCESSING(SSobj, src)

// apply trauma to those within a few blocks who break the effigy.
/obj/structure/spider/stickyweb/alive/spider_effigy/Destroy()
	playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
	for(var/mob/living/carbon/carbon_target in view(2,src))
		if(carbon_target.soundbang_act(intensity = 1, stun_pwr = 0, damage_pwr = 5, deafen_pwr = 5)) // if you don't have earpro you get brain damage
			carbon_target.gain_trauma(/datum/brain_trauma/magic/spider)
			visible_message(span_userdanger("The spider totem screeches as it breaks, piercing your mind! You can't trust your mind!"))
		else
			visible_message(span_notice("The spider totem screeches as it breaks, but it's not enough to unsettle you."))
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/spider/stickyweb/alive/spider_effigy/process()
	//we need to have a cooldown, so check and then add
	if(!COOLDOWN_FINISHED(src, growtime))
		return
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))
	//attempt to grow all webs in range
	for(var/obj/structure/spider/stickyweb/alive/growing_web in range(spider_effigy_range, src))
		growing_web.try_expand()

/*
* Ceiling Climb - Let's the spider crawl up the wall and be extra menacing by being on the ceiling
*/
/datum/action/cooldown/mob_cooldown/ceiling_walk
	name = "Climb"
	desc = "Climb up the walls and onto the ceiling! Those pesky crew will never look up!"
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	shared_cooldown = NONE
	click_to_activate = FALSE
	/// The alpha we go to when sneaking.
	var/sneak_alpha = 135
	/// How long does it take to play our various animation stages
	var/animation_time = 1.5 SECONDS

// add the element that makes them walk on the ceiling
/datum/action/cooldown/mob_cooldown/ceiling_walk/Activate(atom/target)
	if(HAS_TRAIT(owner, TRAIT_SNEAK))

		owner.balloon_alert(owner, "you flop down off the ceiling")
		owner.RemoveElement(/datum/element/forced_gravity, NEGATIVE_GRAVITY)
		owner.density = TRUE
		REMOVE_TRAIT(owner, TRAIT_SNEAK, ACTION_TRAIT)
		animate(owner, alpha = initial(owner.alpha), time = animation_time, delay = animation_time, flags = ANIMATION_PARALLEL)

	else
		owner.balloon_alert(owner, "you skitter up the wall")
		owner.AddElement(/datum/element/forced_gravity, NEGATIVE_GRAVITY)
		owner.density = FALSE // if we're on the ceiling...
		ADD_TRAIT(owner, TRAIT_SNEAK, ACTION_TRAIT)
		animate(owner, alpha = sneak_alpha, time = animation_time, delay = animation_time, flags = ANIMATION_PARALLEL)

	return TRUE

/*
* What if we taught spiders how to fish for people?
*/
// the cooldown
/datum/action/cooldown/spell/pointed/projectile/webhook
	name = "hooked web"
	desc = "Launch at your prey to pull them in closer."
	button_icon = 'modular_nova/modules/spider/icons/abilities.dmi'
	button_icon_state = "webhook"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"

	cooldown_time = 3 MINUTES
	spell_requirements = NONE

	active_msg = "You prepare to throw a webbed hook at your target!"
	cast_range = 8
	projectile_type = /obj/projectile/hook/web

// webhook projectile, keeps every but subtypes the icons
/obj/projectile/hook/web
	name = "webhook"
	icon_state = "webhook"
	icon = 'modular_nova/modules/spider/icons/abilities.dmi'
	chain_icon = 'modular_nova/modules/spider/icons/abilities.dmi'

// Baron's
/datum/action/cooldown/spell/pointed/projectile/webhook/greater
	name = "enhanced hooked web"
	cooldown_time = 1 MINUTES
