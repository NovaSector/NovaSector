#define UNDERSIZED_SPEED_SLOWDOWN 0.5
#define UNDERSIZED_HUNGER_MOD 0.5
#define UNDERSIZED_HARM_DAMAGE_BONUS -10
#define UNDERSIZED_KICK_EFFECTIVENESS_BONUS -5
#define UNDERSIZED_SQUASH_CHANCE 100
#define UNDERSIZED_SQUASH_DAMAGE 20
#define UNDERSIZED_SHOULD_GIB FALSE
#define UNDERSIZED_MAXHEALTH_MULT 0.85 // small frame: less HP to heal, same chems mend a larger fraction
#define UNDERSIZED_MELEE_CD (1.4 SECONDS) // ~1.75x base CLICK_CD_MELEE — outgoing damage is a placebo when speed is war

/datum/quirk/undersized
	name = "Undersized"
	desc = "You're a tiny little creature, with all the benefits and mostly consequences that result."
	gain_text = span_notice("Woah everything looks huge!...")
	lose_text = span_notice("Woah, now I look huge too!")
	medical_record_text = "Patient is abnormally small."
	value = 0
	mob_trait = TRAIT_UNDERSIZED
	icon = FA_ICON_PERSON_FALLING
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	hidden_quirk = TRUE // PR some fixes and improvements before setting this back to FALSE!
	/// Saves refs to the original (normal size) organs, which are on ice in nullspace in case this quirk gets removed somehow.
	var/list/obj/item/organ/old_organs
	/// Stored maxHealth pre-shrink so /remove restores cleanly.
	var/saved_max_health
	/// `TRAIT_UNDENSE` is intentionally NOT granted here — it bypasses the step-crush hazard
	/// because the squash component only fires on `COMSIG_ATOM_ENTERED` on the holder's turf.
	/// `passtable_on()` covers the "small things slip under tables/grilles" intent without
	/// also letting players phase through everyone who might step on them.
	var/list/undersized_traits = list(
		TRAIT_HATED_BY_DOGS,
		TRAIT_EASILY_WOUNDED,
		TRAIT_GRABWEAKNESS,
	)

/datum/quirk/undersized/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder

	human_holder.add_traits(undersized_traits, QUIRK_TRAIT)
	human_holder.mob_size = MOB_SIZE_TINY
	human_holder.held_w_class = WEIGHT_CLASS_TINY
	human_holder.can_be_held = TRUE //makes u scoopable
	human_holder.worn_slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_BACK

	passtable_on(human_holder, QUIRK_TRAIT)

	human_holder.max_grab = GRAB_AGGRESSIVE //you are too weak to neck slam or strangle
	human_holder.physiology.hunger_mod *= UNDERSIZED_HUNGER_MOD
	human_holder.add_movespeed_modifier(/datum/movespeed_modifier/undersized)

	RegisterSignal(human_holder, COMSIG_CARBON_POST_ATTACH_LIMB, PROC_REF(on_gain_limb))
	RegisterSignal(human_holder, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(damage_weakness))
	RegisterSignal(human_holder, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(extend_melee_cd))

	saved_max_health = human_holder.maxHealth
	human_holder.maxHealth = saved_max_health * UNDERSIZED_MAXHEALTH_MULT
	human_holder.health = min(human_holder.health, human_holder.maxHealth)
	human_holder.update_health_hud()

	for(var/obj/item/bodypart/bodypart as anything in human_holder.bodyparts)
		on_gain_limb(src, bodypart, special = FALSE)

	human_holder.transform = human_holder.transform.Scale(0.5)
	human_holder.maptext_height = 24

	human_holder.AddComponent( \
		/datum/component/squashable_carbons, \
		squash_chance = UNDERSIZED_SQUASH_CHANCE, \
		squash_damage = UNDERSIZED_SQUASH_DAMAGE, \
		squash_flags = UNDERSIZED_SHOULD_GIB, \
	)

/datum/quirk/undersized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.mob_size = MOB_SIZE_HUMAN

	human_holder.transform = human_holder.transform.Scale(2)
	human_holder.maptext_height = 32

	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_damage_high = initial(left_arm.unarmed_damage_high)

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_damage_high = initial(right_arm.unarmed_damage_high)

	var/obj/item/bodypart/leg/left_leg = human_holder.get_bodypart(BODY_ZONE_L_LEG)
	if (left_leg)
		left_leg.unarmed_effectiveness = initial(left_leg.unarmed_effectiveness)

	var/obj/item/bodypart/leg/right_leg = human_holder.get_bodypart(BODY_ZONE_R_LEG)
	if (right_leg)
		right_leg.unarmed_effectiveness = initial(right_leg.unarmed_effectiveness)

	for(var/obj/item/bodypart/bodypart as anything in human_holder.bodyparts)
		bodypart.name = replacetext(bodypart.name, "tiny ", "")

	UnregisterSignal(human_holder, list(COMSIG_CARBON_POST_ATTACH_LIMB, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, COMSIG_LIVING_UNARMED_ATTACK))

	if(saved_max_health)
		human_holder.maxHealth = saved_max_health
		saved_max_health = null
		human_holder.update_health_hud()

	human_holder.remove_traits(undersized_traits, QUIRK_TRAIT)

	human_holder.held_w_class = WEIGHT_CLASS_NORMAL
	human_holder.can_be_held = FALSE
	human_holder.worn_slot_flags = null

	passtable_off(human_holder, QUIRK_TRAIT)

	human_holder.max_grab = GRAB_KILL
	human_holder.physiology.hunger_mod /= UNDERSIZED_HUNGER_MOD
	human_holder.remove_movespeed_modifier(/datum/movespeed_modifier/undersized)

	for(var/obj/item/organ/organ_to_restore in old_organs)
		old_organs -= organ_to_restore

		if(QDELETED(organ_to_restore))
			continue

		var/obj/item/organ/brain/possibly_a_brain = organ_to_restore
		if(istype(possibly_a_brain))
			var/obj/item/organ/brain/current_brain = human_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
			possibly_a_brain.brainmob = current_brain.brainmob

		organ_to_restore.replace_into(quirk_holder)

	var/datum/component/squashable_carbons/component = human_holder.GetComponent(/datum/component/squashable_carbons)
	qdel(component)

/// Tweak the effectiveness/damage values of outbound unarmed attacks of newly gained limbs
/datum/quirk/undersized/proc/on_gain_limb(datum/source, obj/item/bodypart/gained, special)
	SIGNAL_HANDLER

	if(findtext(gained.name, "tiny"))
		return

	if(istype(gained, /obj/item/bodypart/arm))
		var/obj/item/bodypart/arm/new_arm = gained
		new_arm.unarmed_damage_high = initial(new_arm.unarmed_damage_high) + UNDERSIZED_HARM_DAMAGE_BONUS

	else if(istype(gained, /obj/item/bodypart/leg))
		var/obj/item/bodypart/leg/new_leg = gained
		new_leg.unarmed_effectiveness = initial(new_leg.unarmed_effectiveness) + UNDERSIZED_KICK_EFFECTIVENESS_BONUS

	gained.name = "tiny " + gained.name

/datum/movespeed_modifier/undersized
	multiplicative_slowdown = UNDERSIZED_SPEED_SLOWDOWN

/// Tweak the effectiveness/damage values of inbound attacks
/datum/quirk/undersized/proc/damage_weakness(datum/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(istype(attacking_item, /obj/item/melee/flyswatter))
		damage_mods += 50 // :)

/// On each unarmed swing, schedule a click-cooldown bump for the next tick. We defer with
/// addtimer because the natural CLICK_CD_MELEE assignment happens inside the attack chain
/// *after* this signal fires; the timer runs after the chain settles and pushes next_move
/// further out. SS13 combat is decided by click rate, not damage-per-click — this is the
/// load-bearing nerf, the unarmed damage bonuses are flavor.
/datum/quirk/undersized/proc/extend_melee_cd(mob/living/source, atom/target, proximity, list/modifiers)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(apply_melee_cd), source), 1)

/datum/quirk/undersized/proc/apply_melee_cd(mob/living/holder)
	if(QDELETED(holder))
		return
	if(holder.next_move - world.time < UNDERSIZED_MELEE_CD)
		holder.changeNext_move(UNDERSIZED_MELEE_CD)

#undef UNDERSIZED_HUNGER_MOD
#undef UNDERSIZED_SPEED_SLOWDOWN
#undef UNDERSIZED_HARM_DAMAGE_BONUS
#undef UNDERSIZED_KICK_EFFECTIVENESS_BONUS
#undef UNDERSIZED_SQUASH_CHANCE
#undef UNDERSIZED_SQUASH_DAMAGE
#undef UNDERSIZED_SHOULD_GIB
#undef UNDERSIZED_MAXHEALTH_MULT
#undef UNDERSIZED_MELEE_CD
