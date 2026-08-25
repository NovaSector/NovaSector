/// How much damage and progress is reduced when on stasis.
#define ELECTRICAL_DAMAGE_ON_STASIS_MULT 0.15
/// How much damage and progress is reduced when limb is grasped.
#define ELECTRICAL_DAMAGE_GRASPED_MULT 0.7
/// How much damage and progress is reduced when our victim lies down.
#define ELECTRICAL_DAMAGE_LYING_DOWN_MULT 0.7
/// How much progress is reduced when our victim is dead.
#define ELECTRICAL_DAMAGE_DEAD_PROGRESS_MULT 0.2 // they'll be resting to, so this is more like 0.1

/// Base time for a wirecutter being used.
#define ELECTRICAL_DAMAGE_WIRECUTTER_BASE_DELAY 8 SECONDS
/// Base time for a cable coil being used.
#define ELECTRICAL_DAMAGE_SUTURE_WIRE_BASE_DELAY 0.8 SECONDS
/// Global damage multiplier for the power a given electrical damage wound will add per tick.
#define ELECTRICAL_DAMAGE_POWER_PER_TICK_MULT 1
/// Global damage multiplier for how much repairing wiring will reduce intensity. Higher is more.
#define ELECTRICAL_DAMAGE_SUTURE_WIRE_HEALING_AMOUNT_MULT 1

/// The minimum shock power we must have available to zap our victim. Must be at least one, since electrocute_act fails if it's lower.
#define ELECTRICAL_DAMAGE_MINIMUM_SHOCK_POWER_PER_ZAP 1
/// The maximum burn damage our limb can have before we refuse to let people who havent aggrograbbed the limb repair it with wires. This is so people can opt to just fix the burn damage.
#define ELECTRICAL_DAMAGE_MAX_BURN_DAMAGE_TO_LET_WIRES_REPAIR 5

/// If progress is positive (not decreasing) after applying ELECTRICAL_DAMAGE_CLOTTING_HEALING_AMOUNT, we multiply it against this.
#define ELECTRICAL_DAMAGE_CLOTTING_PROGRESS_MULT 0.5

/datum/wound/electrical_damage
	name = "Electrical (Wires) Wound"
	treat_text_short = "Replace wiring until it's fixed, or use wirecutters." //no need to add this to pierce as its a subtype
	simple_treat_text = "<b>Replacing</b> of broken wiring, or <b>repairing</b> via a wirecutter. <b>Bandaging</b> binds the wiring and reduces intensity buildup, \
	as does <b>firmly grasping</b> the limb - both the victim and someone else can do this. <b>Roboticists/Engineers</b> get a bonus to treatment, as do <b>diagnostic HUDs</b>."
	homemade_treat_text = "<b>Sutures</b> can repair the wiring at reduced efficiency, as can <b>retractors</b>. In a pinch, <b>high temperatures</b> can repair the wiring!"

	wound_flags = (ACCEPTS_GAUZE|CAN_BE_GRASPED|SPLINT_OVERLAY)

	treatable_tools = list(TOOL_WIRECUTTER, TOOL_RETRACTOR)
	treatable_by = list(/obj/item/stack/medical/suture)

	default_scar_file = METAL_SCAR_FILE

	processes = TRUE

	/// How many sparks do we spawn when we're gained?
	var/initial_sparks_amount = 1

	/// How much of our damage is reduced if the target is shock immune. Percent.
	var/shock_immunity_self_damage_reduction = 75

	/// Mult for our damage if we are unimportant.
	var/limb_unimportant_damage_mult = 0.8
	/// Mult for our progress if we are unimportant.
	var/limb_unimportant_progress_mult = 0.8

	/// The overall "intensity" of this wound. Goes up to [processing_full_shock_threshold], and is used for determining our effect scaling. Measured in deciseconds.
	var/intensity
	/// The time, in deciseconds, it takes to reach 100% power.
	var/processing_full_shock_threshold = 3 MINUTES
	/// If [intensity] is at or below this, we remove ourselves.
	var/minimum_intensity = 0

	/// How much shock power we add to [processing_shock_power_this_tick] per tick. Lower bound
	var/processing_shock_power_per_second_min = 0.1
	/// How much shock power we add to [processing_shock_power_this_tick] per tick. Upper bound
	var/processing_shock_power_per_second_max = 0.2

	/// In the case we get below 1 power, we add the power to this buffer and use it next tick.
	var/processing_shock_power_this_tick = 0
	/// The chance for each processed shock to stun the user.
	var/processing_shock_stun_chance = 0
	/// The chance for each processed shock to spark.
	var/processing_shock_spark_chance = 30
	/// The chance for each processed shock to message the user.
	var/process_shock_message_chance = 80

	/// Simple mult for how much of real time is added to [intensity].
	var/seconds_per_intensity_mult = 1

	/// How many sparks we spawn if a shock sparks. Lower bound
	var/process_shock_spark_count_min = 1
	/// How many sparks we spawn if a shock sparks. Upper bound
	var/process_shock_spark_count_max = 1

	// Generally should be less fast than wire, but its effectiveness should increase with severity
	/// The percent, in decimal, a successful wirecut use will reduce intensity by.
	var/wirecut_repair_percent
	// Generally should be lower than wirecut
	/// The percent, in decimal, a successful wire use will reduce intensity by.
	var/wire_repair_percent

	/// The basic multiplier to all our effects. Damage, progress, etc.
	var/overall_effect_mult = 1

	/// The bodyheat our victim must be at or above to start getting passive healing.
	var/heat_thresh_to_heal = (BODYTEMP_HEAT_DAMAGE_LIMIT + 30)
	/// The mult that heat differences between normal and bodytemp threshold is multiplied against. Controls passive heat healing.
	var/heat_differential_healing_mult = 0.08

	/// Percent chance for a heat repair to give the victim a message.
	var/heat_heal_message_chance = 20

	/// If [get_intensity_mult()] is at or above this, the limb gets disabled. If null, it will never occur.
	var/disable_at_intensity_mult

/datum/wound_pregen_data/electrical_damage
	abstract = TRUE
	required_limb_biostate = (BIO_WIRED)
	required_wounding_type = WOUND_SLASH
	wound_series = WOUND_SERIES_WIRE_SLASH_ELECTRICAL_DAMAGE

/datum/wound_pregen_data/electrical_damage/generate_scar_priorities()
	return list("[BIO_METAL]") // wire scars dont exist so we can just use metal

/datum/wound/burn/electrical_damage/slash/get_limb_examine_description()
	return span_warning("The wiring on this limb is slashed open.")

/datum/wound/burn/electrical_damage/check_grab_treatments(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/stack/cable_coil))
		return TRUE
	return FALSE

/datum/wound/electrical_damage/handle_process(seconds_per_tick)
	. = ..()

	var/base_mult = get_base_mult()

	var/seconds_per_tick_for_intensity = seconds_per_tick * get_progress_mult()
	seconds_per_tick_for_intensity = modify_progress_after_progress_mult(seconds_per_tick_for_intensity, seconds_per_tick)

	adjust_intensity(seconds_per_tick_for_intensity SECONDS)

	if (!victim || victim.stat == DEAD)
		return

	var/damage_mult = get_damage_mult(victim)
	var/intensity_mult = get_intensity_mult()

	damage_mult *= seconds_per_tick
	damage_mult *= intensity_mult

	var/picked_damage = LERP(processing_shock_power_per_second_min, processing_shock_power_per_second_max, rand())
	processing_shock_power_this_tick += (picked_damage * damage_mult)
	if (processing_shock_power_this_tick <= ELECTRICAL_DAMAGE_MINIMUM_SHOCK_POWER_PER_ZAP)
		return

	var/stun_chance = (processing_shock_stun_chance * intensity_mult) * base_mult
	var/spark_chance = (processing_shock_spark_chance * intensity_mult) * base_mult

	var/should_stun = SPT_PROB(stun_chance, seconds_per_tick)
	var/should_message = SPT_PROB(process_shock_message_chance, seconds_per_tick)

	zap(victim,
		processing_shock_power_this_tick,
		stun = should_stun,
		spark = SPT_PROB(spark_chance, seconds_per_tick),
		animation = should_stun, message = FALSE,
		message = should_stun,
		tell_victim_if_no_message = should_message,
		ignore_immunity = TRUE,
		jitter_time = seconds_per_tick,
		stutter_time = 0,
		delay_stun = TRUE,
		knockdown = TRUE,
		ignore_gloves = TRUE
	)
	processing_shock_power_this_tick = 0

/// If someone is aggrograbbing us and targetting our limb, intensity progress is multiplied against this.
#define LIMB_AGGROGRABBED_PROGRESS_MULT 0.5

/// Returns the multiplier used by our intensity progress. Intensity increment is multiplied against this.
/datum/wound/electrical_damage/proc/get_progress_mult()
	var/progress_mult = get_base_mult() * seconds_per_intensity_mult

	if (!limb_essential())
		progress_mult *= limb_unimportant_progress_mult

	if (isliving(victim.pulledby))
		var/mob/living/living_puller = victim.pulledby
		if (living_puller.grab_state >= GRAB_AGGRESSIVE && living_puller.zone_selected == limb.body_zone)
			progress_mult *= LIMB_AGGROGRABBED_PROGRESS_MULT // they're holding it down

	if (victim.stat == DEAD)
		progress_mult *= ELECTRICAL_DAMAGE_DEAD_PROGRESS_MULT // doesnt totally stop it but slows it down a lot

	return progress_mult
#undef LIMB_AGGROGRABBED_PROGRESS_MULT

/// Returns the multiplier used by the damage we deal.
/datum/wound/electrical_damage/proc/get_damage_mult(mob/living/target)
	SHOULD_BE_PURE(TRUE)

	var/damage_mult = get_base_mult()

	if (!limb_essential())
		damage_mult *= limb_unimportant_damage_mult

	return damage_mult * ELECTRICAL_DAMAGE_POWER_PER_TICK_MULT

/// Returns the global multiplier used by both progress and damage.
/datum/wound/electrical_damage/proc/get_base_mult()
	var/base_mult = 1

	if (victim)
		if (HAS_TRAIT(victim, TRAIT_STASIS))
			base_mult *= ELECTRICAL_DAMAGE_ON_STASIS_MULT
		if (victim.body_position == LYING_DOWN)
			base_mult *= ELECTRICAL_DAMAGE_LYING_DOWN_MULT
	if (limb.grasped_by)
		base_mult *= ELECTRICAL_DAMAGE_GRASPED_MULT

	if (victim.has_status_effect(/datum/status_effect/determined))
		base_mult *= WOUND_DETERMINATION_BLEED_MOD

	if (HAS_TRAIT(victim, TRAIT_SHOCKIMMUNE)) // it'd be a bit cheesy to just become immune to this, so it only makes it a lot lot better
		base_mult *= shock_immunity_self_damage_reduction

	base_mult *= limb.get_splint_factor()

	return overall_effect_mult * base_mult

/// Is called after seconds_for_intensity is modified by get_progress_mult().
/datum/wound/electrical_damage/proc/modify_progress_after_progress_mult(seconds_for_intensity, seconds_per_tick)
	if (!victim)
		return seconds_for_intensity

	seconds_for_intensity -= (get_heat_healing() * seconds_per_tick)

	if (seconds_for_intensity > 0 && HAS_TRAIT(victim, TRAIT_COAGULATING))
		seconds_for_intensity *= ELECTRICAL_DAMAGE_CLOTTING_PROGRESS_MULT

	if (HAS_TRAIT(src, TRAIT_ELECTRICAL_DAMAGE_REPAIRING))
		seconds_for_intensity = min(seconds_for_intensity, 0) // it cant get any worse

	return seconds_for_intensity

/// Returns how many deciseconds progress should be reduced by, based on the current heat of our victim's body.
/datum/wound/electrical_damage/proc/get_heat_healing(do_message = prob(heat_heal_message_chance))
	var/healing_amount = max((victim.bodytemperature - heat_thresh_to_heal), 0) * heat_differential_healing_mult
	if (do_message && healing_amount)
		to_chat(victim, span_notice("You feel the solder within your [limb.plaintext_zone] reform and repair your [name]..."))

	return healing_amount

/// Changes intensity by the given amount, and then updates our status, removing ourselves if fixed.
/datum/wound/electrical_damage/proc/adjust_intensity(to_adjust)
	intensity = clamp((intensity + to_adjust), 0, processing_full_shock_threshold)

	if (disable_at_intensity_mult)
		set_disabling(get_intensity_mult() >= disable_at_intensity_mult)

	remove_if_fixed()

/datum/wound/electrical_damage/wound_injury(datum/wound/electrical_damage/old_wound, attack_direction)
	. = ..()

	if (old_wound)
		intensity = max(intensity, old_wound.intensity)
		processing_shock_power_this_tick = old_wound.processing_shock_power_this_tick

	do_sparks(initial_sparks_amount, FALSE, victim)

/datum/wound/electrical_damage/modify_desc_before_span(desc, mob/user)
	. = ..()

	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if (isnull(current_gauze))
		return

	var/intensity_mult = get_intensity_mult()
	if (intensity_mult < 0.2 || (victim.stat == DEAD))
		return

	. += ", and "

	var/extra
	switch (intensity_mult)
		if (0.2 to 0.4)
			extra += "[span_deadsay("is letting out some sparks")]"
		if (0.4 to 0.6)
			extra += "[span_deadsay("is sparking quite a bit")]"
		if (0.6 to 0.8)
			extra += "[span_deadsay("is practically hemorrhaging sparks")]"
		if (0.8 to 1)
			extra += "[span_deadsay("has golden bolts of electricity constantly striking the surface")]"

	. += extra

/datum/wound/electrical_damage/get_scanner_description(mob/user)
	. = ..()

	. += "\nWound status: [get_wound_status_info()]"

/datum/wound/electrical_damage/get_simple_scanner_description(mob/user)
	. = ..()

	. += "\nWound status: [get_wound_status_info()]"

/// Returns a string with our fault intensity and threshold to removal for use in health analyzers.
/datum/wound/electrical_damage/proc/get_wound_status_info()
	return "Fault intensity is currently at [span_bold("[get_intensity_mult() * 100]")]%. It must be reduced to [span_blue("<b>[minimum_intensity]</b>")]% to remove the wound."

// this wound is unaffected by cryoxadone and pyroxadone
/datum/wound/electrical_damage/on_xadone(power)
	return

/datum/wound/electrical_damage/item_can_treat(obj/item/potential_treater, mob/user)
	if (istype(potential_treater, /obj/item/stack/cable_coil) && ((user.pulling == victim && user.grab_state >= GRAB_AGGRESSIVE) || (limb.burn_dam <= ELECTRICAL_DAMAGE_MAX_BURN_DAMAGE_TO_LET_WIRES_REPAIR)))
		return TRUE // if we're aggrograbbed, or relatively undamaged, go ahead. else, we dont want to impede normal treatment

	return ..()

/datum/wound/electrical_damage/treat(obj/item/treating_item, mob/user)
	if (treating_item.tool_behaviour == TOOL_WIRECUTTER || treating_item.tool_behaviour == TOOL_RETRACTOR)
		return wirecut(treating_item, user)

	if (istype(treating_item, /obj/item/stack/medical/suture) || istype(treating_item, /obj/item/stack/cable_coil))
		return suture_wires(treating_item, user)

	return ..()

/**
 * The "trauma" treatment, done with cables/sutures. Sutures get a debuff.
 * Low self-tend penalty.
 * Very fast, but low value. Eats up wires for breakfast.
 * Has limited wire/HUD bonuses. If you're a robo, use a wirecutter instead.
 */
/datum/wound/electrical_damage/proc/suture_wires(obj/item/stack/suturing_item, mob/living/carbon/human/user)
	if (!suturing_item.tool_start_check())
		return TRUE

	var/is_suture = (istype(suturing_item, /obj/item/stack/medical/suture))

	var/change = (processing_full_shock_threshold * wire_repair_percent) * ELECTRICAL_DAMAGE_SUTURE_WIRE_HEALING_AMOUNT_MULT
	var/delay_mult = 1
	if (user == victim)
		delay_mult *= 1.4
	if (is_suture)
		delay_mult *= 1.5
		var/obj/item/stack/medical/suture/suture_item = suturing_item
		var/obj/item/stack/medical/suture/base_suture = /obj/item/stack/medical/suture
		change = max(change - (suture_item.heal_brute - initial(base_suture.heal_brute)), 0.00001)

	// as this is the trauma treatment, there are less bonuses
	// if youre doing this, youre probably doing this on-the-spot
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= 0.8
	else if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= 0.9
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		delay_mult *= 0.8
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		change *= 1.5

	ADD_TRAIT(src, TRAIT_ELECTRICAL_DAMAGE_REPAIRING, REF(user))
	do_suture_repairs(suturing_item, user, change, delay_mult)
	REMOVE_TRAIT(src, TRAIT_ELECTRICAL_DAMAGE_REPAIRING, REF(user))
	return TRUE

/// Does a while loop that repairs us with cables. A proc for containing runtimes and allowing trait removal at all times.
/datum/wound/electrical_damage/proc/do_suture_repairs(obj/item/stack/suturing_item, mob/living/carbon/human/user, change, delay_mult)
	var/is_suture = (istype(suturing_item, /obj/item/stack/medical/suture))
	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	var/replacing_or_suturing = (is_suture ? "repairing some" : "replacing")
	while (suturing_item.tool_start_check())
		user?.visible_message(span_danger("[user] begins [replacing_or_suturing] wiring within [their_or_other] [limb.plaintext_zone] with [suturing_item]..."), \
			span_notice("You begin [replacing_or_suturing] wiring within [your_or_other] [limb.plaintext_zone] with [suturing_item]..."))
		if (!suturing_item.use_tool(target = victim, user = user, delay = ELECTRICAL_DAMAGE_SUTURE_WIRE_BASE_DELAY * delay_mult, amount = 1, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
			return

		if (user != victim && user.combat_mode)
			user?.visible_message(span_danger("[user] mangles some of [their_or_other] [limb.plaintext_zone]'s wiring!"), \
				span_danger("You mangle some of [your_or_other] [limb.plaintext_zone]'s wiring!"), ignored_mobs = victim)
			to_chat(victim, span_userdanger("[capitalize(your_or_other)] mangles some of your [limb.plaintext_zone]'s wiring!"))
			adjust_intensity(change * 2)
		else
			var/repairs_or_replaces = (is_suture ? "repairs" : "replaces")
			var/repair_or_replace = (is_suture ? "repair" : "replace")
			user?.visible_message(span_notice("[user] [repairs_or_replaces] some of [their_or_other] [limb.plaintext_zone]'s wiring!"), \
				span_notice("You [repair_or_replace] some of [your_or_other] [limb.plaintext_zone]'s wiring!"))
			adjust_intensity(-change)
			victim?.balloon_alert(user, "intensity reduced to [get_intensity_mult() * 100]%")

		if (fixed())
			return

/**
 * The "proper" treatment, done with wirecutters/retractors. Retractors get a debuff.
 * High self-tend penalty.
 * Slow, but high value.
 * Has high wire/HUD bonuses. The ideal treatment for a robo.
 */
/datum/wound/electrical_damage/proc/wirecut(obj/item/wirecutting_tool, mob/living/carbon/human/user)
	if (!wirecutting_tool.tool_start_check())
		return TRUE

	var/is_retractor = (wirecutting_tool.tool_behaviour == TOOL_RETRACTOR)

	var/change = (processing_full_shock_threshold * wirecut_repair_percent)
	var/delay_mult = 1
	if (user == victim)
		delay_mult *= 2
	if (is_retractor)
		delay_mult *= 2
	var/knows_wires = FALSE
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= 0.3
		knows_wires = TRUE
	else if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= 0.6
		knows_wires = TRUE
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		if (knows_wires)
			delay_mult *= 0.9
		else
			delay_mult *= 0.75
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		change *= 1.5

	ADD_TRAIT(src, TRAIT_ELECTRICAL_DAMAGE_REPAIRING, REF(user))
	do_wirecutter_repairs(wirecutting_tool, user, change, delay_mult)
	REMOVE_TRAIT(src, TRAIT_ELECTRICAL_DAMAGE_REPAIRING, REF(user))
	return TRUE

/// Does a while loop that repairs us with a wirecutter. A proc for containing runtimes and allowing trait removal at all times.
/datum/wound/electrical_damage/proc/do_wirecutter_repairs(obj/item/wirecutting_tool, mob/living/carbon/human/user, change, delay_mult)
	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	while (wirecutting_tool.tool_start_check())
		user?.visible_message(span_danger("[user] begins resetting misplaced wiring within [their_or_other] [limb.plaintext_zone]..."), \
			span_notice("You begin resetting misplaced wiring within [your_or_other] [limb.plaintext_zone]..."))
		if (!wirecutting_tool.use_tool(target = victim, user = user, delay = ELECTRICAL_DAMAGE_WIRECUTTER_BASE_DELAY * delay_mult, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
			return

		if (user != victim && user.combat_mode)
			user?.visible_message(span_danger("[user] mangles some of [their_or_other] [limb.plaintext_zone]'s wiring!"), \
				span_danger("You mangle some of [your_or_other] [limb.plaintext_zone]'s wiring!"), ignored_mobs = victim)
			to_chat(victim, span_userdanger("[capitalize(your_or_other)] mangles some of your [limb.plaintext_zone]'s wiring!"))
			adjust_intensity(change * 2)
		else
			user?.visible_message(span_notice("[user] resets some of [their_or_other] [limb.plaintext_zone]'s wiring!"), \
				span_notice("You reset some of [your_or_other] [limb.plaintext_zone]'s wiring!"))
			adjust_intensity(-change)
			victim?.balloon_alert(user, "intensity reduced to [get_intensity_mult() * 100]%")

		if (fixed())
			return

/// If fixed() is true, we remove ourselves and return TRUE. FALSE otherwise.
/datum/wound/electrical_damage/proc/remove_if_fixed()
	if (fixed())
		to_chat(victim, span_green("Your [limb.plaintext_zone] has recovered from its [name]!"))
		remove_wound()
		return TRUE
	return FALSE

/// Should we remove ourselves?
/datum/wound/electrical_damage/proc/fixed()
	return (intensity <= minimum_intensity || isnull(limb))

/// Returns the multiplier we apply to our outgoing damage based off our current intensity. Is always between 0-1.
/datum/wound/electrical_damage/proc/get_intensity_mult()
	return (min((intensity / processing_full_shock_threshold), 1))

/// Wrapper for electrocute_act
/datum/wound/electrical_damage/proc/zap(
	mob/living/target,
	damage,
	coeff = 1,
	stun,
	spark = TRUE,
	animation = TRUE,
	message = TRUE,
	ignore_immunity = FALSE,
	delay_stun = FALSE,
	knockdown = FALSE,
	ignore_gloves = FALSE,
	tell_victim_if_no_message = TRUE,
	jitter_time = 20 SECONDS,
	stutter_time = 4 SECONDS,
)

	var/flags = NONE
	if (!stun)
		flags |= SHOCK_NOSTUN
	if (!animation)
		flags |= SHOCK_NO_HUMAN_ANIM
	if (!message)
		flags |= SHOCK_SUPPRESS_MESSAGE
		if (tell_victim_if_no_message && target == victim)
			to_chat(target, span_warning("Your [limb.plaintext_zone] short-circuits and zaps you!"))
	if (ignore_immunity)
		flags |= SHOCK_IGNORE_IMMUNITY
	if (delay_stun)
		flags |= SHOCK_DELAY_STUN
	if (knockdown)
		flags |= SHOCK_KNOCKDOWN
	if (ignore_gloves)
		flags |= SHOCK_NOGLOVES

	target.electrocute_act(damage, limb, coeff, flags, jitter_time, stutter_time)
	if (spark)
		do_sparks(rand(process_shock_spark_count_min, process_shock_spark_count_max), FALSE, victim)

// Slash
// Fast to rise, but lower damage overall
// Also a bit easy to treat
/datum/wound/electrical_damage/slash
	simple_desc = "Wiring has been slashed open, resulting in a fault that <b>quickly</b> intensifies!"

/datum/wound/electrical_damage/slash/moderate
	name = "Frayed Wiring"
	desc = "Internal wiring has suffered a slight abrasion, causing a slow electrical fault that will intensify over time."
	occur_text = "lets out a few sparks, as a few frayed wires stick out"
	examine_desc = "has a few frayed wires sticking out"
	treat_text = "Replacing of damaged wiring, though repairs via wirecutting instruments or sutures may suffice, albeit at limited efficiency. In case of emergency, \
				subject may be subjected to high temperatures to allow solder to reset."

	sound_effect = 'modular_nova/modules/medical/sound/robotic_slash_T1.ogg'

	severity = WOUND_SEVERITY_MODERATE

	sound_volume = 30

	threshold_penalty = 20

	intensity = 10 SECONDS
	processing_full_shock_threshold = 3 MINUTES

	processing_shock_power_per_second_max = 0.5
	processing_shock_power_per_second_min = 0.4

	processing_shock_stun_chance = 0
	processing_shock_spark_chance = 30

	process_shock_spark_count_max = 1
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.1
	wire_repair_percent = 0.023

	initial_sparks_amount = 1

	status_effect_type = /datum/status_effect/wound/electrical_damage/slash/moderate

	a_or_from = "from"

	scar_keyword = "slashmoderate"

/datum/wound_pregen_data/electrical_damage/slash/moderate
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/slash/moderate
	threshold_minimum = 35

/datum/wound/electrical_damage/slash/severe
	name = "Severed Conduits"
	desc = "A number of wires have been completely cut, resulting in electrical faults that will intensify at a worrying rate."
	occur_text = "sends some electrical fiber in the direction of the blow, beginning to profusely spark"
	examine_desc = "has multiple severed wires visible to the outside"
	treat_text = "Containment of damaged wiring via gauze, then application of fresh wiring/sutures, or resetting of displaced wiring via wirecutter/retractor."

	sound_effect = 'modular_nova/modules/medical/sound/robotic_slash_T2.ogg'

	severity = WOUND_SEVERITY_SEVERE

	sound_volume = 15

	threshold_penalty = 30

	intensity = 10 SECONDS
	processing_full_shock_threshold = 2 MINUTES

	processing_shock_power_per_second_max = 0.7
	processing_shock_power_per_second_min = 0.6

	processing_shock_stun_chance = 0
	processing_shock_spark_chance = 60

	process_shock_spark_count_max = 2
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.09
	wire_repair_percent = 0.015

	initial_sparks_amount = 3

	status_effect_type = /datum/status_effect/wound/electrical_damage/slash/severe

	a_or_from = "from"

	scar_keyword = "slashsevere"

/datum/wound_pregen_data/electrical_damage/slash/severe
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/slash/severe
	threshold_minimum = 60

/datum/wound/electrical_damage/slash/critical
	name = "Systemic Fault"
	desc = "A significant portion of the power distribution network has been cut open, resulting in massive power loss and runaway electrocution."
	occur_text = "lets out a violent \"zhwarp\" sound as angry electric arcs attack the surrounding air"
	examine_desc = "has lots of mauled wires sticking out"
	treat_text = "Immediate securing via gauze, followed by emergency cable replacement and securing via wirecutters or retractor. \
		If the fault has become uncontrollable, extreme heat therapy is recommended."

	severity = WOUND_SEVERITY_CRITICAL
	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|CAN_BE_GRASPED|SPLINT_OVERLAY)

	sound_effect = 'modular_nova/modules/medical/sound/robotic_slash_T3.ogg'

	sound_volume = 30

	threshold_penalty = 50

	intensity = 10 SECONDS
	processing_full_shock_threshold = 1.25 MINUTES

	processing_shock_power_per_second_max = 1.3
	processing_shock_power_per_second_min = 1.1

	processing_shock_stun_chance = 5
	processing_shock_spark_chance = 90

	process_shock_spark_count_max = 3
	process_shock_spark_count_min = 2

	wirecut_repair_percent = 0.08
	wire_repair_percent = 0.01

	initial_sparks_amount = 8

	status_effect_type = /datum/status_effect/wound/electrical_damage/slash/critical

	a_or_from = "a"

	scar_keyword = "slashcritical"

/datum/wound_pregen_data/electrical_damage/slash/critical
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/slash/critical
	threshold_minimum = 100


// Synth bleeding


/*
	bleeding wounds wounds
*/


/datum/wound_pregen_data/synth_bleed
	abstract = TRUE

	required_wounding_type = (WOUND_SLASH_)
	required_limb_biostate = BIO_ROBOTIC

	wound_series = WOUND_SERIES_SYNTH_BLEED

/datum/wound/slash/synth
	var/blood_noun = get_blood_noun()
	name = "Small [blood_noun] Leak"
	threshold_penalty = 5
	processes = TRUE
	treatable_tools = list(TOOL_CAUTERY, TOOL_WELDER)
	base_treat_time = 3 SECONDS
	wound_flags = (ACCEPTS_GAUZE|CAN_BE_GRASPED)

	default_scar_file = FLESH_SCAR_FILE

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// When we have less than this amount of flow, either from treatment or clotting, we demote to a lower cut or are healed of the wound
	var/minimum_flow
	/// How much our blood_flow will naturally decrease per second, not only do larger cuts bleed more blood faster, they clot slower (higher number = clot quicker, negative = opening up)
	var/clot_rate

	/// Once the blood flow drops below minimum_flow, we demote it to this type of wound. If there's none, we're all better
	var/demotes_to

	/// A bad system I'm using to track the worst scar we earned (since we can demote, we want the biggest our wound has been, not what it was when it was cured (probably moderate))
	var/datum/scar/highest_scar

/datum/wound/slash/synth/Destroy()
	highest_scar = null

	return ..()

/datum/wound/slash/synth/wound_injury(datum/wound/slash/flesh/old_wound = null, attack_direction = null)
	if(old_wound)
		set_blood_flow(max(old_wound.blood_flow, initial_flow))
		if(old_wound.severity > severity && old_wound.highest_scar)
			set_highest_scar(old_wound.highest_scar)
			old_wound.clear_highest_scar()
	else
		set_blood_flow(initial_flow)
		if(limb.can_bleed() && attack_direction && victim.get_blood_volume() > BLOOD_VOLUME_OKAY)
			victim.spray_blood(attack_direction, severity)

	if(!highest_scar)
		var/datum/scar/new_scar = new
		set_highest_scar(new_scar)
		new_scar.generate(limb, src, add_to_scars=FALSE)

	return ..()

/datum/wound/slash/synth/proc/set_highest_scar(datum/scar/new_scar)
	if(highest_scar)
		UnregisterSignal(highest_scar, COMSIG_QDELETING)
	if(new_scar)
		RegisterSignal(new_scar, COMSIG_QDELETING, PROC_REF(clear_highest_scar))
	highest_scar = new_scar

/datum/wound/slash/synth/proc/clear_highest_scar(datum/source)
	SIGNAL_HANDLER
	set_highest_scar(null)

/datum/wound/slash/synth/remove_wound(ignore_limb, replaced, destroying)
	if(!replaced && highest_scar)
		already_scarred = TRUE
		highest_scar.lazy_attach(limb)
	return ..()

/datum/wound/slash/synth/get_wound_description(mob/user)
	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if(!current_gauze)
		return ..()

	var/list/msg = list("The cuts on [victim.p_their()] [limb.plaintext_zone] are wrapped with ")
	// how much life we have left in these bandages
	switch(current_gauze.absorption_capacity)
		if(0 to 1.25)
			msg += "nearly ruined "
		if(1.25 to 2.75)
			msg += "badly worn "
		if(2.75 to 4)
			msg += "slightly bloodied "
		if(4 to INFINITY)
			msg += "clean "
	msg += "[current_gauze.name]!"

	return "<B>[msg.Join()]</B>"

/datum/wound/slash/synth/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if (!victim) // if we are dismembered, we can still take damage, its fine to check here
		return

	if(victim.stat != DEAD && wound_bonus != CANT_WOUND && wounding_type == WOUND_SLASH) // can't stab dead bodies to make it bleed faster this way
		adjust_blood_flow(WOUND_SLASH_DAMAGE_FLOW_COEFF * wounding_dmg)

	return ..()

/datum/wound/slash/synth/drag_bleed_amount()
	// say we have 3 severe cuts with 3 blood flow each, pretty reasonable
	// compare with being at 100 brute damage before, where you bled (brute/100 * 2), = 2 blood per tile
	var/bleed_amt = min(blood_flow * 0.1, 1) // 3 * 3 * 0.1 = 0.9 blood total, less than before! the share here is .3 blood of course.

	if(limb.seep_gauze(bleed_amt * 0.33)) // gauze stops all bleeding from dragging on this limb, but wears the gauze out quicker
		return 0

	return bleed_amt

/datum/wound/slash/synth/get_bleed_rate_of_change()
	//basically if a species doesn't bleed, the wound is stagnant and will not heal on its own (nor get worse)
	if(!limb.can_bleed())
		return BLOOD_FLOW_STEADY
	if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
		return BLOOD_FLOW_INCREASING
	if(LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE) || clot_rate > 0)
		return BLOOD_FLOW_DECREASING
	if(clot_rate < 0)
		return BLOOD_FLOW_INCREASING

/datum/wound/slash/synth/handle_process(seconds_per_tick)
	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	// in case the victim has the NOBLOOD trait, the wound will simply not clot on its own
	if(limb.can_bleed())
		if(clot_rate > 0)
			adjust_blood_flow(-clot_rate * seconds_per_tick)
			if(QDELETED(src))
				return

		if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
			adjust_blood_flow(0.25) // old heparin used to just add +2 bleed stacks per tick, this adds 0.5 bleed flow to all open cuts which is probably even stronger as long as you can cut them first

	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if(current_gauze?.absorption_rate)
		var/gauze_power = current_gauze.absorption_rate
		limb.seep_gauze(gauze_power * seconds_per_tick)
		adjust_blood_flow(-gauze_power * seconds_per_tick)

/* BEWARE, THE BELOW NONSENSE IS MADNESS. bones.dm looks more like what I have in mind and is sufficiently clean, don't pay attention to this messiness */

/datum/wound/slash/synth/check_grab_treatments(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/gun/energy/laser))
		return TRUE
	if(tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST) // if we're using something hot but not a cautery, we need to be aggro grabbing them first, so we don't try treating someone we're eswording
		return TRUE
	return FALSE

/datum/wound/slash/synth/treat(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/gun/energy/laser))
		las_cauterize(tool, user)
	else if(tool.tool_behaviour == TOOL_CAUTERY || tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		tool_cauterize(tool, user)

/datum/wound/slash/synth/try_handling(mob/living/user)
	if(user.pulling != victim || !HAS_TRAIT(user, TRAIT_WOUND_LICKER) || !victim.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))
		return FALSE
	if(!isnull(user.hud_used?.screen_objects[HUD_MOB_ZONE_SELECTOR]) && user.zone_selected != limb.body_zone)
		return FALSE

	if(DOING_INTERACTION_WITH_TARGET(user, victim))
		to_chat(user, span_warning("You're already interacting with [victim]!"))
		return
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		if(carbon_user.is_mouth_covered())
			to_chat(user, span_warning("Your mouth is covered, you can't lick [victim]'s wounds!"))
			return
		if(!carbon_user.get_organ_slot(ORGAN_SLOT_TONGUE))
			to_chat(user, span_warning("You can't lick wounds without a tongue!")) // f in chat
			return

	lick_wounds(user)
	return TRUE

/// if a felinid is licking this cut to reduce bleeding
/datum/wound/slash/synth/proc/lick_wounds(mob/living/carbon/human/user)
	// transmission is one way patient -> felinid since google said cat saliva is antiseptic or whatever, and also because felinids are already risking getting beaten for this even without people suspecting they're spreading a deathvirus
	for(var/datum/disease/iter_disease as anything in victim.diseases)
		if(iter_disease.spread_flags & (DISEASE_SPREAD_SPECIAL | DISEASE_SPREAD_NON_CONTAGIOUS))
			continue
		user.ForceContractDisease(iter_disease)

	user.visible_message(span_notice("[user] begins licking the wounds on [victim]'s [limb.plaintext_zone]."), span_notice("You begin licking the wounds on [victim]'s [limb.plaintext_zone]..."), ignored_mobs=victim)
	to_chat(victim, span_notice("[user] begins to lick the wounds on your [limb.plaintext_zone]."))
	if(!do_after(user, base_treat_time, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	user.visible_message(span_notice("[user] licks the wounds on [victim]'s [limb.plaintext_zone]."), span_notice("You lick some of the wounds on [victim]'s [limb.plaintext_zone]"), ignored_mobs=victim)
	to_chat(victim, span_green("[user] licks the wounds on your [limb.plaintext_zone]!"))
	var/mob/victim_stored = victim
	adjust_blood_flow(-0.5)

	if(blood_flow > minimum_flow)
		try_handling(user)
	else if(demotes_to)
		to_chat(user, span_green("You successfully lower the severity of [user == victim_stored ? "your" : "[victim_stored]'s"] cuts."))

/datum/wound/slash/synth/adjust_blood_flow(adjust_by, minimum)
	. = ..()
	if(blood_flow > WOUND_MAX_BLOODFLOW)
		blood_flow = WOUND_MAX_BLOODFLOW
	if(blood_flow < minimum_flow && !QDELETED(src))
		if(demotes_to)
			replace_wound(new demotes_to)
		else
			to_chat(victim, span_green("The cut on your [limb.plaintext_zone] has [!limb.can_bleed() ? "healed up" : "stopped bleeding"]!"))
			qdel(src)

/datum/wound/slash/synth/on_xadone(power)
	. = ..()
	adjust_blood_flow(-0.03 * power) // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/datum/wound/slash/synth/on_synthflesh(reac_volume)
	. = ..()
	adjust_blood_flow(-0.075 * reac_volume) // 20u * 0.075 = -1.5 blood flow, pretty good for how little effort it is

/// If someone's putting a laser gun up to our cut to cauterize it
/datum/wound/slash/synth/proc/las_cauterize(obj/item/gun/energy/laser/lasgun, mob/user)
	var/self_penalty_mult = (user == victim ? 1.25 : 1)
	user.visible_message(span_warning("[user] begins aiming [lasgun] directly at [victim]'s [limb.plaintext_zone]..."), span_userdanger("You begin aiming [lasgun] directly at [user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone]..."))
	if(!do_after(user, base_treat_time  * self_penalty_mult, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return
	var/damage = lasgun.chambered.loaded_projectile.damage
	lasgun.chambered.loaded_projectile.wound_bonus -= 30
	lasgun.chambered.loaded_projectile.damage *= self_penalty_mult
	if(!lasgun.process_fire(victim, victim, TRUE, null, limb.body_zone))
		return
	victim.emote("scream")
	victim.visible_message(span_warning("The cuts on [victim]'s [limb.plaintext_zone] scar over!"))
	adjust_blood_flow(-1 * (damage / (5 * self_penalty_mult))) // 20 / 5 = 4 bloodflow removed, p good

/// If someone is using either a cautery tool or something with heat to cauterize this cut
/datum/wound/slash/synth/proc/tool_cauterize(obj/item/I, mob/user)
	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // 25% longer and less effective if you don't use a real cautery
	var/self_penalty_mult = (user == victim ? 1.5 : 1) // 50% longer and less effective if you do it to yourself

	var/treatment_delay = base_treat_time * self_penalty_mult * improv_penalty_mult

	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		user.visible_message(span_danger("[user] begins expertly cauterizing [victim]'s [limb.plaintext_zone] with [I]..."), span_warning("You begin cauterizing [user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone] with [I], keeping the holo-image indications in mind..."))
	else
		user.visible_message(span_danger("[user] begins cauterizing [victim]'s [limb.plaintext_zone] with [I]..."), span_warning("You begin cauterizing [user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone] with [I]..."))

	playsound(user, 'sound/items/handling/surgery/cautery1.ogg', 75, TRUE)

	if(!do_after(user, treatment_delay, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	playsound(user, 'sound/items/handling/surgery/cautery2.ogg', 75, TRUE)

	var/bleeding_wording = (!limb.can_bleed() ? "cuts" : "bleeding")
	user.visible_message(span_green("[user] cauterizes some of the [bleeding_wording] on [victim]."), span_green("You cauterize some of the [bleeding_wording] on [victim]."))
	victim.apply_damage(2 + severity, BURN, limb, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	var/mob/victim_stored = victim
	adjust_blood_flow(-blood_cauterized)

	if(blood_flow > minimum_flow)
		try_treating(I, user)

	else if(demotes_to)
		to_chat(user, span_green("You successfully lower the severity of [user == victim_stored ? "your" : "[victim_stored]'s"] cuts."))

/datum/wound/slash/get_limb_examine_description()
	return span_warning("The flesh on this limb appears badly lacerated.")

/datum/wound/slash/synth/moderate
	name = "Rough Abrasion"
	desc = "Patient's skin has been badly scraped, generating moderate blood loss."
	treat_text = "Apply bandaging or suturing to the wound. \
		Follow up with food and a rest period."
	treat_text_short = "Apply bandaging or suturing."
	examine_desc = "has an open cut"
	occur_text = "is cut open, slowly leaking blood"
	sound_effect = 'sound/effects/wounds/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1.75
	minimum_flow = 0.5
	clot_rate = 0.04
	series_threshold_penalty = 10
	status_effect_type = /datum/status_effect/wound/slash/flesh/moderate
	scar_keyword = "slashmoderate"

	simple_treat_text = "<b>Bandaging</b> the wound will reduce blood loss, help the wound close by itself quicker, and speed up the blood recovery period. The wound itself can be slowly <b>sutured</b> shut."
	homemade_treat_text = "<b>Tea</b> stimulates the body's natural healing systems, slightly fastening clotting. The wound itself can be rinsed off on a sink or shower as well. Other remedies are unnecessary."

/datum/wound/slash/synth/moderate/update_descriptions()
	if(!limb.can_bleed())
		occur_text = "is cut open"

/datum/wound_pregen_data/flesh_slash/abrasion
	abstract = FALSE

	wound_path_to_generate = /datum/wound/slash/synth/moderate

	threshold_minimum = 20

/datum/wound/slash/synth/severe
	name = "Open Laceration"
	desc = "Patient's skin is ripped clean open, allowing significant blood loss."
	treat_text = "Swiftly apply bandaging or suturing to the wound, \
		or make use of blood clotting agents or cauterization. \
		Follow up with iron supplements or saline-glucose and a rest period."
	treat_text_short = "Apply bandaging, suturing, clotting agents, or cauterization."
	examine_desc = "has a severe cut"
	occur_text = "is ripped open, veins spurting blood"
	sound_effect = 'sound/effects/wounds/blood2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 2.75
	minimum_flow = 2
	clot_rate = 0.02
	series_threshold_penalty = 25
	demotes_to = /datum/wound/slash/synth/moderate
	status_effect_type = /datum/status_effect/wound/slash/flesh/severe
	scar_keyword = "slashsevere"
	surgery_states = SURGERY_SKIN_CUT | SURGERY_VESSELS_UNCLAMPED

	simple_treat_text = "<b>Bandaging</b> the wound is essential, and will reduce blood loss. Afterwards, the wound can be <b>sutured</b> shut, preferably while the patient is resting and/or grasping their wound."
	homemade_treat_text = "Bed sheets can be ripped up to make <b>makeshift gauze</b>. <b>Flour, table salt, or salt mixed with water</b> can be applied directly to stem the flow, though unmixed salt will irritate the skin and worsen natural healing. Resting and grabbing your wound will also reduce bleeding."

/datum/wound_pregen_data/flesh_slash/laceration
	abstract = FALSE

	wound_path_to_generate = /datum/wound/slash/synth/severe

	threshold_minimum = 50

/datum/wound/slash/synth/severe/update_descriptions()
	if(!limb.can_bleed())
		occur_text = "is ripped open"

/datum/wound/slash/synth/critical
	name = "Weeping Avulsion"
	desc = "Patient's skin is completely torn open, along with significant loss of tissue. Extreme blood loss will lead to quick death without intervention."
	treat_text = "Immediately apply bandaging or suturing to the wound, \
		or make use of blood clotting agents or cauterization. \
		Follow up supervised resanguination."
	treat_text_short = "Apply bandaging, suturing, clotting agents, or cauterization."
	examine_desc = "is carved down to the bone, spraying blood wildly"
	occur_text = "is torn open, spraying blood wildly"
	sound_effect = 'sound/effects/wounds/blood3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 3.75
	minimum_flow = 3.5
	clot_rate = -0.012 // critical cuts actively get worse instead of better
	threshold_penalty = 15
	demotes_to = /datum/wound/slash/synth/severe
	status_effect_type = /datum/status_effect/wound/slash/flesh/critical
	scar_keyword = "slashcritical"
	surgery_states = SURGERY_SKIN_OPEN | SURGERY_VESSELS_UNCLAMPED
	wound_flags = (ACCEPTS_GAUZE | MANGLES_EXTERIOR | CAN_BE_GRASPED)
	simple_treat_text = "<b>Bandaging</b> the wound is of utmost importance, as is seeking direct medical attention - <b>Death</b> will ensue if treatment is delayed whatsoever, with lack of <b>oxygen</b> killing the patient, thus <b>Food, Iron, and saline solution</b> is always recommended after treatment. This wound will not naturally seal itself."
	homemade_treat_text = "Bed sheets can be ripped up to make <b>makeshift gauze</b>. <b>Flour, salt, and saltwater</b> topically applied will help. Dropping to the ground and grabbing your wound will reduce blood flow."

/datum/wound/slash/synth/critical/update_descriptions()
	if (!limb.can_bleed())
		occur_text = "is torn open"

/datum/wound_pregen_data/flesh_slash/avulsion
	abstract = FALSE

	wound_path_to_generate = /datum/wound/slash/synth/critical
	threshold_minimum = 80

/datum/wound/slash/synth/moderate/many_cuts
	name = "Numerous Small Slashes"
	desc = "Patient's skin has numerous small slashes and cuts, generating moderate blood loss."
	examine_desc = "has a ton of small cuts"
	occur_text = "is cut numerous times, leaving many small slashes."

/datum/wound_pregen_data/flesh_slash/abrasion/cuts
	abstract = FALSE
	can_be_randomly_generated = FALSE

	wound_path_to_generate = /datum/wound/slash/synth/moderate/many_cuts

// Subtype for cleave (heretic spell)
/datum/wound/slash/synth/critical/cleave
	name = "Burning Avulsion"
	examine_desc = "is ruptured, spraying blood wildly"
	clot_rate = 0.01

/datum/wound/slash/synth/critical/cleave/update_descriptions()
	if(!limb.can_bleed())
		occur_text = "is ruptured"

/datum/wound_pregen_data/flesh_slash/avulsion/clear
	abstract = FALSE
	can_be_randomly_generated = FALSE

	wound_path_to_generate = /datum/wound/slash/synth/critical/cleave




#undef ELECTRICAL_DAMAGE_ON_STASIS_MULT
#undef ELECTRICAL_DAMAGE_GRASPED_MULT
#undef ELECTRICAL_DAMAGE_LYING_DOWN_MULT
#undef ELECTRICAL_DAMAGE_DEAD_PROGRESS_MULT

#undef ELECTRICAL_DAMAGE_WIRECUTTER_BASE_DELAY
#undef ELECTRICAL_DAMAGE_SUTURE_WIRE_BASE_DELAY

#undef ELECTRICAL_DAMAGE_MINIMUM_SHOCK_POWER_PER_ZAP
#undef ELECTRICAL_DAMAGE_MAX_BURN_DAMAGE_TO_LET_WIRES_REPAIR
#undef ELECTRICAL_DAMAGE_POWER_PER_TICK_MULT
#undef ELECTRICAL_DAMAGE_SUTURE_WIRE_HEALING_AMOUNT_MULT

#undef ELECTRICAL_DAMAGE_CLOTTING_PROGRESS_MULT
