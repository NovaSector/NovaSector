//Gateway Medkit, no more combat defibs!
/obj/item/storage/medkit/expeditionary
	name = "expeditionary medical kit"
	desc = "Now with 100% less bullshit."
	icon_state = "medkit_tactical"
	damagetype_healed = "all"

/obj/item/storage/medkit/expeditionary/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/defibrillator/compact/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/clothing/glasses/hud/health(src)

/obj/item/storage/medkit/expeditionary/surplus
	desc = "Now with less bullshit. And more dust. But mainly less bullshit. If you have to use this, there's no way you've got insurance."

/obj/item/storage/medkit/expeditionary/surplus/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/reagent_containers/hypospray/combat(src) // epi/atro + lepo + omnizine
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/clothing/glasses/hud/health(src)

//New and improved, no longer a downgrade!
/obj/item/circular_saw/field_medic
	name = "bone saw"
	desc = "An ancient medical instrument used for surgery and amputations, still being used in the 26th century. Well, what are you waiting for? Let's go practice medicine."
	force = 20
	icon_state = "bonesaw"
	icon = 'modular_nova/modules/exp_corps/icons/bonesaw.dmi'
	lefthand_file = 'modular_nova/modules/exp_corps/icons/bonesaw_l.dmi'
	righthand_file = 'modular_nova/modules/exp_corps/icons/bonesaw_r.dmi'
	inhand_icon_state = "bonesaw"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	toolspeed = 2
	throw_range = 3
	attack_verb_continuous = list("saws", "slashes")
	attack_verb_simple = list("saw", "slash")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/circular_saw/field_medic/lowforce
	force = 9

/obj/item/circular_saw/field_medic/attack(mob/living/amputee, mob/living/user)
	if(!iscarbon(amputee) || user.combat_mode)
		return ..()

	if(user.zone_selected == BODY_ZONE_CHEST)
		return ..()

	var/mob/living/carbon/patient = amputee

	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		to_chat(user, span_warning("The patient's limbs look too sturdy to amputate."))
		return

	var/candidate_name
	var/obj/item/organ/tail_snip_candidate
	var/obj/item/bodypart/limb_snip_candidate

	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		tail_snip_candidate = patient.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(!tail_snip_candidate)
			to_chat(user, span_warning("[patient] does not have a tail."))
			return
		candidate_name = tail_snip_candidate.name

	else
		limb_snip_candidate = patient.get_bodypart(check_zone(user.zone_selected))
		if(!limb_snip_candidate)
			to_chat(user, span_warning("[patient] is already missing that limb, what more do you want?"))
			return
		candidate_name = limb_snip_candidate.name

	var/amputation_speed_mod = 1

	patient.visible_message(span_danger("[user] begins sawing off [patient]'s [candidate_name] with [src]!"), span_userdanger("[user] begins sawing off your [candidate_name] with [src]!"))
	playsound(get_turf(patient), 'sound/items/weapons/bladeslice.ogg', 250, TRUE)
	if(patient.stat >= UNCONSCIOUS || HAS_TRAIT(patient, TRAIT_INCAPACITATED)) //if you're incapacitated (due to paralysis, a stun, being in staminacrit, etc.), critted, unconscious, or dead, it's much easier to properly line up a snip
		amputation_speed_mod *= 0.5
	if(patient.stat != DEAD && patient.has_status_effect(/datum/status_effect/jitter)) //jittering will make it harder to secure the shears, even if you can't otherwise move
		amputation_speed_mod *= 1.5 //15*0.5*1.5=11.25, so staminacritting someone who's jittering (from, say, a stun baton) won't give you enough time to snip their head off, but staminacritting someone who isn't jittering will
	if(HAS_MIND_TRAIT(user, TRAIT_MORBID))
		amputation_speed_mod *= 0.7 //its morbin time

	if(do_after(user,  toolspeed * 15 SECONDS * amputation_speed_mod, target = patient))
		playsound(get_turf(patient), 'sound/items/weapons/bladeslice.ogg', 250, TRUE)
		if(user.zone_selected == BODY_ZONE_PRECISE_GROIN) //OwO
			tail_snip_candidate.Remove(patient)
			tail_snip_candidate.forceMove(get_turf(patient))
		else
			limb_snip_candidate.dismember()
		user.visible_message(span_danger("[src] violently cuts through, amputating [patient]'s [candidate_name]."), span_notice("You amputate [patient]'s [candidate_name] with [src]."))
		user.log_message("[user] has amputated [patient]'s [candidate_name] with [src]", LOG_GAME)
		patient.log_message("[patient]'s [candidate_name] has been amputated by [user] with [src]", LOG_GAME)

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID)) //Freak
		user.add_mood_event("morbid_dismemberment", /datum/mood_event/morbid_dismemberment)

/obj/item/circular_saw/field_medic/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] is cutting [user.p_them()]self with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	var/timer = 1 SECONDS
	for(var/obj/item/bodypart/thing in user.bodyparts)
		if(thing.body_part == CHEST)
			continue
		addtimer(CALLBACK(thing, TYPE_PROC_REF(/obj/item/bodypart/, dismember)), timer)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), user, 'sound/items/weapons/bladeslice.ogg', 70), timer)
		timer += 1 SECONDS
	sleep(timer)
	return BRUTELOSS

//Pointman's riot shield. Fixable with 1 plasteel, crafting recipe for broken shield
/obj/item/shield/riot/pointman
	name = "pointman shield"
	desc = "A shield fit for those that want to sprint headfirst into the unknown. Its heavy, unwieldy nature makes its defensive performance suffer when in the off-hand; \
	wielding will provide best results at the cost of reduced mobility."
	icon_state = "riot"
	icon = 'modular_nova/modules/exp_corps/icons/riot.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/back.dmi'
	worn_icon_state = "erisriot"
	lefthand_file = 'modular_nova/modules/exp_corps/icons/riot_left.dmi'
	righthand_file = 'modular_nova/modules/exp_corps/icons/riot_right.dmi'
	force = 10
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	block_chance = 15
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("slams", "bashes")
	attack_verb_simple = list("slam", "bash")
	transparent = FALSE
	max_integrity = 200
	shield_break_leftover = /obj/item/pointman_broken
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5)

/obj/item/shield/riot/pointman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
	force_unwielded=10, force_wielded=20, \
	wield_callback = CALLBACK(src, PROC_REF(shield_wield)), \
	unwield_callback = CALLBACK(src, PROC_REF(shield_unwield)), \
	)


/// handles buffing the shield's defensive ability and nerfing user mobility
/obj/item/shield/riot/pointman/proc/shield_wield()
	item_flags |= SLOWS_WHILE_IN_HAND
	block_chance *= 5 // 15 * 5 = 75
	slowdown = 0.6

/// nerfs the shield's defensive ability, buffs user mobility
/obj/item/shield/riot/pointman/proc/shield_unwield()
	item_flags &= ~SLOWS_WHILE_IN_HAND
	block_chance /= 5
	slowdown = 0

/obj/item/pointman_broken
	name = "broken pointman shield"
	desc = "Enough of it is still intact that you could probably just weld more bits on."
	icon_state = "riot_broken"
	icon = 'modular_nova/modules/exp_corps/icons/riot.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/pointman_broken/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/pointman_repair)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

//broken shield fixing
/datum/crafting_recipe/pointman_repair
	name = "pointman shield (repaired)"
	result = /obj/item/shield/riot/pointman
	reqs = list(/obj/item/pointman_broken = 1,
				/obj/item/stack/sheet/plasteel = 3,
				/obj/item/stack/sheet/rglass = 3)
	time = 5 SECONDS
	category = CAT_MISC
	tool_behaviors = list(TOOL_WELDER)

//Marksman's throwing knife and a pouch for it
/obj/item/knife/combat/throwing
	name = "throwing knife"
	desc = "While very well weighted for throwing, the distribution of mass makes it unwieldy for use in melee."
	icon = 'modular_nova/modules/exp_corps/icons/throwing.dmi'
	icon_state = "throwing"
	force = 12 // don't stab with this
	throwforce = 30 // 38 force on embed? compare contrast with throwing stars.
	throw_speed = 4
	embed_type = /datum/embedding/combat_knife/throwing

// +10 embed chance up from combat knife's 65
/datum/embedding/combat_knife/throwing
	embed_chance = parent_type::embed_chance + 10

/obj/item/storage/pouch/ammo/marksman
	name = "marksman's knife pouch"

/obj/item/storage/pouch/ammo/marksman/setup_reskins()
	return

/obj/item/storage/pouch/ammo/marksman/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/marksman)

/datum/storage/marksman
	max_total_storage = 60
	max_slots = 10
	numerical_stacking = TRUE
	quickdraw = TRUE

/datum/storage/marksman/New()
	. = ..()
	can_hold = typecacheof(list(/obj/item/knife/combat))

/obj/item/storage/pouch/ammo/marksman/PopulateContents() //can kill most basic enemies with 5 knives, though marksmen shouldn't be soloing enemies anyways
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
