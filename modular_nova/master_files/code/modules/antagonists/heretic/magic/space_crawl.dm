/datum/action/cooldown/spell/jaunt/space_crawl
	/// Have we successfully casted a jaunt? Used for triggering a cooldown when we exit Space Phase.
	var/successful_jaunt = FALSE
	/// What cooldown do we inflict when exiting jaunt?
	var/jaunt_cooldown = 30 SECONDS

/datum/action/cooldown/spell/jaunt/space_crawl/after_cast(atom/cast_on)
	. = ..()
	successful_jaunt = !successful_jaunt
	if(!successful_jaunt)
		StartCooldown(jaunt_cooldown)

/obj/effect/dummy/phased_mob/spell_jaunt/space/set_jaunter(atom/movable/new_jaunter)
	. = ..()
	RegisterSignal(src, COMSIG_MOB_PHASED_CHECK, PROC_REF(is_it_outside))

/obj/effect/dummy/phased_mob/spell_jaunt/space
	/// When was the jaunter last warned about space crawling's limitations?
	var/last_warning

/obj/effect/dummy/phased_mob/spell_jaunt/space/proc/is_it_outside(obj/effect/dummy/phased_mob/jaunt, mob/living/parent, turf/new_turf)
	SIGNAL_HANDLER
	// if it's space OR it's outdoors and low pressure, it's fine
	if(isspaceturf(new_turf))
		return
	var/area/my_area = get_area(new_turf)
	if(isopenturf(new_turf) && my_area.outdoors && lavaland_equipment_pressure_check(new_turf))
		return
	if(last_warning + 3 SECONDS < world.time)
		last_warning = world.time
		to_chat(parent, span_warning("You can only traverse space or low-pressure outdoors areas while space crawling!"))
	return COMPONENT_BLOCK_PHASED_MOVE
