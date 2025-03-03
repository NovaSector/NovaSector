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
 * ### Carrier
 * These are the abilities tailored to specifically the Carrier spider
 */
