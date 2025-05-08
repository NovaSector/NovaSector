// Original PR - https://github.com/SPLURT-Station/S.P.L.U.R.T-tg/pull/54
/datum/element/skirt_peeking
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

/datum/element/skirt_peeking/Attach(datum/peeked)
	. = ..()
	if(!ishuman(peeked))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(peeked, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(peeked, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_closer_look))

/datum/element/skirt_peeking/Detach(datum/peeked, ...)
	. = ..()
	UnregisterSignal(peeked, list(COMSIG_ATOM_EXAMINE, COMSIG_ATOM_EXAMINE_MORE))

/datum/element/skirt_peeking/proc/can_skirt_peek(mob/living/carbon/human/peeked, mob/peeker)
	if(peeked == peeker)
		return FALSE

	var/mob/living/living_peeker = peeker
	var/obj/item/clothing/under/worn_uniform = peeked.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	var/obj/item/clothing/suit/outer_clothing = peeked.get_item_by_slot(ITEM_SLOT_OCLOTHING)

	if(outer_clothing && outer_clothing.body_parts_covered & (CHEST | GROIN | LEGS | FEET))
		return FALSE

	if(worn_uniform && (is_type_in_typecache(worn_uniform.type, GLOB.skirt_peekable) || worn_uniform.female_sprite_flags & FEMALE_UNIFORM_TOP_ONLY))
		if(isobserver(peeker))
			return TRUE
		if(istype(living_peeker))
			if((living_peeker.loc == peeked.loc) && (living_peeker.resting && !peeked.resting))
				return TRUE

			var/obj/structure/high_ground_peeked = locate(/obj/structure) in get_turf(peeked)
			var/obj/structure/high_ground_peeker = locate(/obj/structure) in get_turf(peeker)
			if(high_ground_peeked && HAS_TRAIT(high_ground_peeked, TRAIT_CLIMBABLE) && (peeked.mobility_flags & MOBILITY_STAND) && peeked.Adjacent(peeker))
				if(!(high_ground_peeker && HAS_TRAIT(high_ground_peeker, TRAIT_CLIMBABLE)))
					return TRUE
	return FALSE

/datum/element/skirt_peeking/proc/on_examine(mob/living/carbon/human/peeked, mob/peeker, list/examine_list)
	if(can_skirt_peek(peeked, peeker))
		examine_list += span_purple("[peeked.p_theyre(TRUE)] wearing a skirt! I can probably give it a little peek <b>looking closer</b>.")

/datum/element/skirt_peeking/proc/on_closer_look(mob/living/carbon/human/peeked, mob/peeker, list/examine_content)
	if(can_skirt_peek(peeked, peeker))
		for(var/obj/item/organ/genital/genital in peeked.organs)
			if(genital.zone != BODY_ZONE_PRECISE_GROIN)
				continue
			if(genital.visibility_preference == GENITAL_SKIP_VISIBILITY)
				continue
			examine_content += genital.get_description_string()
		addtimer(CALLBACK(src, PROC_REF(try_notice), peeked, peeker), 1)

/datum/element/skirt_peeking/proc/try_notice(mob/living/carbon/human/peeked, mob/living/peeker)
	if(isnull(peeked) || isnull(peeker))
		return
	if(!istype(peeked) || !istype(peeker))
		return
	var/obj/item/clothing/under/worn_uniform = peeked.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(!istype(worn_uniform))
		return
	if(!(!peeked.client && (peeked.stat == CONSCIOUS) && peeked.has_status_effect(/datum/status_effect/grouped/blindness)))
		return
	to_chat(peeked, span_warning("You notice [peeker] looking under your [worn_uniform.name]!"))
	to_chat(peeker, span_warning("[peeked] notices you peeking under [peeked.p_their()] [worn_uniform.name]!"))
