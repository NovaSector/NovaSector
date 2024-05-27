// Mech saw, it's a drill that winds up really fast and does less damage. Funny way to kill people stam critted, and maybe get 20ish damage in in a real fight.
// Most the code is here to rename all it's actions/change the sounds effect to the saw. It still works on terrain but I think that's fine. Big ass saw can cut through walls.

/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill/mechsaw
	name = "Exosuit-Sized Chainsaw"
	desc = "Jagged rusty chainsaw sized for exosuits, you get the idea you know what this is for."
	icon_state = "chainsaw_off"
	icon = 'icons/obj/weapons/chainsaw.dmi'
	equip_cooldown = 1
	drill_delay = 1.5
	force = 7
	toolspeed = 10


/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill/mechsaw/drill_mob(mob/living/target, mob/living/user)
	target.visible_message(span_danger("[chassis] is sawing [target] with [src]!"), \
						span_userdanger("[chassis] is sawing you with [src]!"))
	log_combat(user, target, "sawed", "[name]", "Combat mode: [user.combat_mode ? "On" : "Off"])(DAMTYPE: [uppertext(damtype)])")
	if(target.stat == DEAD && target.getBruteLoss() >= (target.maxHealth * 2))
		log_combat(user, target, "gibbed", name)
		if(LAZYLEN(target.butcher_results) || LAZYLEN(target.guaranteed_butcher_results))
			SEND_SIGNAL(src, COMSIG_MECHA_DRILL_MOB, chassis, target)
		else
			target.investigate_log("has been gibbed by [src] (attached to [chassis]).", INVESTIGATE_DEATHS)
			target.gib(DROP_ALL_REMAINS)
	else
		//drill makes a hole
		var/obj/item/bodypart/target_part = target.get_bodypart(target.get_random_valid_zone(BODY_ZONE_CHEST))
		target.apply_damage(7, BRUTE, BODY_ZONE_CHEST, target.run_armor_check(target_part, MELEE))

		//blood splatters
		var/splatter_dir = get_dir(chassis, target)
		if(isalien(target))
			new /obj/effect/temp_visual/dir_setting/bloodsplatter/xenosplatter(target.drop_location(), splatter_dir)
		else
			new /obj/effect/temp_visual/dir_setting/bloodsplatter(target.drop_location(), splatter_dir)

		//organs go everywhere
		if(target_part && prob(10 * drill_level))
			target_part.dismember(BRUTE)



/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill/mechsaw/action(mob/source, atom/target, list/modifiers, bumped)
	//If bumped, only bother drilling mineral turfs
	if(bumped)
		if(!ismineralturf(target))
			return

		//Prevent drilling into gibtonite more than once; code mostly from MODsuit drill
		if(istype(target, /turf/closed/mineral/gibtonite))
			var/turf/closed/mineral/gibtonite/giberal_turf = target
			if(giberal_turf.stage != GIBTONITE_UNSTRUCK)
				playsound(chassis, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
				to_chat(source, span_warning("[icon2html(src, source)] Active gibtonite ore deposit detected! Safety protocols preventing continued drilling."))
				return

	else
		// We can only drill non-space turfs, living mobs and objects.
		if(isspaceturf(target) || !(isliving(target) || isobj(target) || isturf(target)))
			return

		// For whatever reason we can't drill things that acid won't even stick too, and probably
		// shouldn't waste our time drilling indestructible things.
		if(isobj(target))
			var/obj/target_obj = target
			if(target_obj.resistance_flags & (UNACIDABLE | INDESTRUCTIBLE))
				return

	// You can't drill harder by clicking more.
	if(DOING_INTERACTION_WITH_TARGET(source, target) && do_after_cooldown(target, source, DOAFTER_SOURCE_MECHADRILL))
		return

	target.visible_message(span_warning("[chassis] starts to saw [target]!"), \
				span_userdanger("[chassis] starts to saw [target]!!!"), \
				span_hear("You hear sawing."))

	log_message("Started sawing [target]", LOG_MECHA)

	// Drilling a turf is a one-and-done procedure.
	if(isturf(target))
		// Check if we can even use the equipment to begin with.
		if(!action_checks(target))
			return

		var/turf/T = target
		T.drill_act(src, source)

		return ..()

	// Drilling objects and mobs is a repeating procedure.
	while(do_after_mecha(target, source, drill_delay))
		if(isliving(target))
			drill_mob(target, source)
			playsound(src,'sound/weapons/chainsawhit.ogg',40,TRUE)
		else if(isobj(target))
			var/obj/O = target
			if(istype(O, /obj/item/boulder))
				var/obj/item/boulder/nu_boulder = O
				nu_boulder.manual_process(src, source)
			else
				O.take_damage(20, BRUTE, 0, FALSE, get_dir(chassis, target))
			playsound(src,'sound/weapons/chainsawhit.ogg', 40, TRUE)

		// If we caused a qdel drilling the target, we can stop drilling them.
		// Prevents starting a do_after on a qdeleted target.
		if(QDELETED(target))
			break

	return ..()
