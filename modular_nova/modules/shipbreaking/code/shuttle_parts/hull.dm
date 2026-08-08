/obj/structure/hull_plating
	abstract_type = /obj/structure/hull_plating
	icon = 'modular_nova/modules/shipbreaking/icons/turfs/walls_misc.dmi'
	density = TRUE
	anchored = FALSE
	drag_slowdown = 1.5
	inertia_force_weight = 2
	/// How much damage we do when we fall on or crash into someone
	var/crush_damage = 40

/obj/structure/hull_plating/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_RECYCLE_LIKE_ITEM, TRAIT_GENERIC)
	AddElement(/datum/element/falling_hazard, damage = crush_damage, wound_bonus = 20, hardhat_safety = FALSE, crushes = TRUE, impact_sound = 'sound/effects/bang.ogg')

/obj/structure/hull_plating/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(isliving(hit_atom))
		workplace_accident(hit_atom)
	return ..()

/obj/structure/hull_plating/handle_deconstruct(disassembled)
	if(obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
		return

/// Crushes someone like a vending machine if they are hit by the panel
/obj/structure/hull_plating/proc/workplace_accident(mob/living/osha_nonworker)
	var/turf/target_turf = get_turf(osha_nonworker)
	if(target_turf.is_blocked_turf(TRUE, src, list(src)))
		visible_message(span_danger("[src] nearly misses crushing [osha_nonworker], that was lucky!"))
	for(var/atom/atom_target in (target_turf.contents) + osha_nonworker)
		if(isarea(atom_target))
			continue
		var/crushed
		if(isliving(atom_target))
			crushed = TRUE
			var/mob/living/carbon/living_target = atom_target
			var/blocked = living_target.run_armor_check(attack_flag = MELEE)
			if(iscarbon(living_target))
				var/mob/living/carbon/carbon_target = living_target
				if(prob(30))
					// Will spread the damage and thus not break your bones, if you're lucky
					carbon_target.apply_damage(max(0, crush_damage), BRUTE, blocked = blocked, forced = TRUE, spread_damage = TRUE, attack_direction = get_dir(src, atom_target))
				else
					// Femur breaker if you're not lucky
					carbon_target.take_bodypart_damage(crush_damage, 0, check_armor = TRUE, wound_bonus = 5)
					carbon_target.take_bodypart_damage(crush_damage, 0, check_armor = TRUE, wound_bonus = 5)
				carbon_target.AddElement(/datum/element/squish, 30 SECONDS)
			else
				living_target.apply_damage(crush_damage, BRUTE, blocked = blocked, forced = TRUE, attack_direction = get_dir(src, atom_target))
			living_target.Paralyze(4 SECONDS)
			living_target.painful_scream()
			playsound(living_target, 'sound/effects/blob/blobattack.ogg', 40, TRUE)
			playsound(living_target, 'sound/effects/splat.ogg', 50, TRUE)
		else if(check_atom_crushable(atom_target))
			atom_target.take_damage(crush_damage, BRUTE, MELEE, FALSE, get_dir(src, atom_target))
			crushed = TRUE
		if(crushed)
			atom_target.visible_message(span_danger("[atom_target] is crushed by [src]!"), span_userdanger("You are crushed by [src]!"))
			playsound(src, 'sound/effects/bang.ogg', 40)
			visible_message(span_danger("[src] crashes into [atom_target]!"))

/obj/structure/hull_plating/nanocarbon
	name = "nanocarbon panels"
	desc = "A large section of nanocarbon hull that has been cut free, and has considerable mass."
	icon_state = "nanocarbon-2"
	custom_materials = list(
		/datum/material/nanocarbon = SHEET_MATERIAL_AMOUNT * 3,
	)
	crush_damage = 50
	color = COLOR_SILVER

/obj/structure/hull_plating/nanocarbon/ex_act(severity, target)
	. = ..()
	if(severity >= EXPLODE_HEAVY)
		nanocarbon_nuke()
	return TRUE

/// Makes shards of nanocarbon
/obj/structure/hull_plating/nanocarbon/proc/nanocarbon_nuke()
	var/random_shards = 2
	for(var/iteration in 1 to random_shards)
		var/obj/item/shard = new /obj/item/nanocarbon_shard(src)
		shard.pixel_x = rand(-6, 6)
		shard.pixel_y = rand(-6, 6)
		shard.color = color
		var/atom/throw_target = get_edge_target_turf(shard, pick(GLOB.alldirs))
		shard.throw_at(throw_target, 6, 6)

/obj/structure/hull_plating/nanocarbon/floor
	name = "nanocarbon panel"
	desc = "A section of nanocarbon hull that has been cut free, and has considerable mass."
	icon_state = "nanocarbon-1"
	custom_materials = list(
		/datum/material/nanocarbon = SHEET_MATERIAL_AMOUNT * 1,
	)

/obj/structure/hull_plating/gold_foil
	name = "roll of gold foil"
	desc = "An industrial scale roll of gold foil, presumably peeled off the nearest ship."
	icon_state = "gold_foil"
	custom_materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/structure/hull_plating/silver_foil
	name = "roll of silver foil"
	desc = "An industrial scale roll of silver foil, presumably peeled off the nearest ship."
	icon_state = "silver_foil"
	custom_materials = list(
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/structure/hull_plating/plastamic_sheets
	name = "plastimic panels"
	desc = "Panels of a complicated plastic compound used to clad the interiors of ships."
	icon_state = "plastic_1"
	base_icon_state = "plastic"
	custom_materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1,
	)

/obj/structure/hull_plating/plastamic_sheets/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/hull_plating/armor_panels
	name = "armor panels"
	desc = "High grade armor panels used to protect the exteriors of ships from anything between asteroid impacts \
		to gunfire."
	icon_state = "armor_1"
	base_icon_state = "armor"
	custom_materials = list(
		/datum/material/alloy/plastitanium = SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/structure/hull_plating/armor_panels/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/hull_plating/aluminum
	name = "aluminum panels"
	desc = "A large section of aluminum hull that has been cut free, and has considerable mass."
	icon_state = "aluminum-2"
	custom_materials = list(
		/datum/material/aluminum = SHEET_MATERIAL_AMOUNT * 2,
	)

/obj/structure/hull_plating/aluminum/floor
	name = "aluminum panel"
	desc = "A section of aluminum hull that has been cut free, and has considerable mass."
	icon_state = "aluminum-1"
	custom_materials = list(
		/datum/material/aluminum = SHEET_MATERIAL_AMOUNT,
	)
