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

/obj/projectile/webslinger_snare/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!iscarbon(target) || blocked >= 100)
		return
	var/obj/item/restraints/legcuffs/beartrap/webslinger_snare/restraint = new(get_turf(target))
	restraint.spring_trap(target)

/obj/item/restraints/legcuffs/beartrap/webslinger_snare
	name = "sticky restraints"
	desc = "Used by mega-arachnids to immobilize their prey."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	flags_1 = NONE
	item_flags = DROPDEL
	icon_state = "spideregg"
	armed = TRUE

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
