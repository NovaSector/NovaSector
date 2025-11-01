/*!
 * Contains Voltaic Combat Cyberheart
 */

/obj/item/organ/heart/cybernetic/anomalock
	name = "voltaic combat cyberheart"
	desc = "A cutting-edge cyberheart. Voltaic technology allows the heart to keep the body upright in dire circumstances, \
		along with fully shielding the user from shocks and electro-magnetic pulses. \
		Requires a refined flux core as a power source. \
		The critical protection functionality requires a cooldown period before it can be used again."
	icon_state = "anomalock_heart"
	beat_noise = "an astonishing <b>BZZZ</b> of immense electrical power"
	bleed_prevention = TRUE
	toxification_probability = 0

	COOLDOWN_DECLARE(survival_cooldown)
	///Cooldown for the activation of the organ
	var/survival_cooldown_time = 5 MINUTES
	///The lightning effect on our mob when the implant is active
	var/mutable_appearance/lightning_overlay
	///how long the lightning lasts
	var/lightning_timer

	//---- Anomaly core variables:
	///The core item the organ runs off.
	var/obj/item/assembly/signaler/anomaly/core
	///Accepted types of anomaly cores.
	var/required_anomaly = /obj/item/assembly/signaler/anomaly/flux
	///If this one starts with a core in.
	var/prebuilt = FALSE
	///If the core is removable once socketed.
	var/core_removable = TRUE

/obj/item/organ/heart/cybernetic/anomalock/Initialize(mapload) // The heart itself is ALWAYS immune to EMPs
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF)
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The voltaic combat cyberheart was originally designed for corporate killsquad usage, \
		but later declassified for normal research. Nobody knows where the original designs came from, and \
		how Nanotrasen got the designs, you'll probably never know.<br>\
		<br>\
		However, continuous improvements over the design allow it to fully utilize the anomalous energies \
		from a flux anomaly's core, leveraging the flux core's power to provide both \
		total protection against electromagnetic pulse interference, and keep a user's body upright even under stress \
		that would incapacitate or outright kill lesser men. There are some caveats with this, though. \
		Without a flux core, the voltaic combat cyberheart only provides increased blood regeneration, \
		and with a flux core, receiving an electromagnetic pulse will force the heart into voltaic overdrive, \
		which could possibly leave the user vulnerable to a direct attack once their voltaic overdrive wears off. \
		Voltaic overdrive lasts about thirty seconds, and recharges after approximately five minutes. \
		In that four minutes and thirty seconds, the user is, arguably, quite vulnerable."\
	)

/obj/item/organ/heart/cybernetic/anomalock/Destroy()
	QDEL_NULL(core)
	return ..()

/obj/item/organ/heart/cybernetic/anomalock/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(!core)
		return
	add_lightning_overlay(30 SECONDS)
	playsound(organ_owner, 'sound/items/eshield_recharge.ogg', 40)
	RegisterSignal(organ_owner, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION), PROC_REF(activate_survival))
	RegisterSignal(organ_owner, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp_act))

/obj/item/organ/heart/cybernetic/anomalock/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(!core)
		return
	if(owner?.has_status_effect(/datum/status_effect/voltaic_overdrive))
		owner?.remove_status_effect(/datum/status_effect/voltaic_overdrive)
	UnregisterSignal(organ_owner, list(COMSIG_ATOM_EMP_ACT, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION)))
	tesla_zap(source = organ_owner, zap_range = 20, power = 2.5e5, cutoff = 1e3)

/obj/item/organ/heart/cybernetic/anomalock/proc/on_emp_act(severity)
	// for some reason getting shot with an ion rifle triggers this twice.
	SIGNAL_HANDLER
	if(owner.has_status_effect(/datum/status_effect/voltaic_overdrive))
		. = EMP_PROTECT_ALL
		to_chat(owner, span_danger("Your voltaic combat cyberheart flutters against an electromagnetic pulse!"))
		return
	if(activate_survival(owner))
		. = EMP_PROTECT_ALL
		to_chat(owner, span_userdanger("Your voltaic combat cyberheart thunders in your chest wildly, surging to hold against the electromagnetic pulse!"))
		return
	add_lightning_overlay(10 SECONDS)
	to_chat(owner, span_danger("Your voltaic combat cyberheart flutters weakly, failing to protect against an electromagnetic pulse!"))

/obj/item/organ/heart/cybernetic/anomalock/proc/add_lightning_overlay(time_to_last = 10 SECONDS)
	if(lightning_overlay)
		lightning_timer = addtimer(CALLBACK(src, PROC_REF(clear_lightning_overlay)), time_to_last, (TIMER_UNIQUE|TIMER_OVERRIDE))
		return
	lightning_overlay = mutable_appearance(icon = 'icons/effects/effects.dmi', icon_state = "lightning")
	owner?.add_overlay(lightning_overlay)
	lightning_timer = addtimer(CALLBACK(src, PROC_REF(clear_lightning_overlay)), time_to_last, (TIMER_UNIQUE|TIMER_OVERRIDE))

/obj/item/organ/heart/cybernetic/anomalock/proc/clear_lightning_overlay()
	owner?.cut_overlay(lightning_overlay)
	lightning_overlay = null

/obj/item/organ/heart/cybernetic/anomalock/on_life(seconds_per_tick, times_fired)
	. = ..()

	if(owner.blood_volume <= BLOOD_VOLUME_NORMAL)
		owner.blood_volume += 5 * seconds_per_tick

	if(!core)
		return

	if(owner.health <= owner.crit_threshold)
		activate_survival(owner)

	if(times_fired % (1 SECONDS))
		return

	var/list/batteries = list()
	for(var/obj/item/stock_parts/power_store/cell in owner.get_all_cells())
		if(cell.used_charge())
			batteries += cell

	if(!length(batteries))
		return

	var/obj/item/stock_parts/power_store/cell = pick(batteries)
	cell.give(cell.max_charge() * 0.1)

///Does a few things to try to help you live whatever you may be going through
/obj/item/organ/heart/cybernetic/anomalock/proc/activate_survival(mob/living/carbon/organ_owner)
	if(!COOLDOWN_FINISHED(src, survival_cooldown))
		return FALSE
	var/datum/status_effect/voltaic_overdrive/maximum_overdrive = organ_owner.apply_status_effect(/datum/status_effect/voltaic_overdrive)
	maximum_overdrive.associated_heart = src
	add_lightning_overlay(30 SECONDS)
	COOLDOWN_START(src, survival_cooldown, survival_cooldown_time)
	addtimer(CALLBACK(src, PROC_REF(finish_recharge), organ_owner), COOLDOWN_TIMELEFT(src, survival_cooldown))
	return TRUE

///Alerts our owner that the organ is ready to do its thing again
/obj/item/organ/heart/cybernetic/anomalock/proc/finish_recharge(mob/living/carbon/organ_owner)
	balloon_alert(organ_owner, "your heart strengthens")
	playsound(organ_owner, 'sound/items/eshield_recharge.ogg', 40)

/obj/item/organ/heart/cybernetic/anomalock/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, required_anomaly))
		return NONE
	if(core)
		balloon_alert(user, "core already in!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	core = tool
	balloon_alert(user, "core installed")
	playsound(src, 'sound/machines/click.ogg', 30, TRUE)
	add_organ_trait(TRAIT_SHOCKIMMUNE)
	update_icon_state()
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/heart/cybernetic/anomalock/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!core)
		balloon_alert(user, "no core!")
		return
	if(!core_removable)
		balloon_alert(user, "can't remove core!")
		return
	balloon_alert(user, "removing core...")
	if(!do_after(user, 3 SECONDS, target = src))
		balloon_alert(user, "interrupted!")
		return
	balloon_alert(user, "core removed")
	core.forceMove(drop_location())
	if(Adjacent(user) && !issilicon(user))
		user.put_in_hands(core)
	core = null
	remove_organ_trait(TRAIT_SHOCKIMMUNE)
	update_icon_state()

/obj/item/organ/heart/cybernetic/anomalock/update_icon_state()
	. = ..()
	icon_state = initial(icon_state) + (core ? "-core" : "")

/obj/item/organ/heart/cybernetic/anomalock/prebuilt/Initialize(mapload)
	. = ..()
	core = new /obj/item/assembly/signaler/anomaly/flux(src)
	update_icon_state()

/datum/status_effect/voltaic_overdrive
	id = "voltaic_overdrive"
	duration = 30 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/anomalock_active
	show_duration = TRUE
	var/obj/item/organ/heart/cybernetic/anomalock/associated_heart

/datum/status_effect/voltaic_overdrive/tick(seconds_between_ticks)
	. = ..()

	if(!associated_heart.owner)
		qdel(src)
		return

	if(owner.health <= owner.crit_threshold)
		owner.heal_overall_damage(5, 5)
		owner.adjustOxyLoss(-5)
		owner.adjustToxLoss(-5)

/datum/status_effect/voltaic_overdrive/on_apply()
	. = ..()
	owner.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
	owner.reagents.add_reagent(/datum/reagent/medicine/coagulant, 5)
	owner.add_filter("emp_shield", 2, outline_filter(1, "#639BFF"))
	to_chat(owner, span_revendanger("You feel a burst of energy! It's do or die!"))
	owner.add_traits(list(TRAIT_NOSOFTCRIT, TRAIT_NOHARDCRIT, TRAIT_ANALGESIA), REF(src))

/datum/status_effect/voltaic_overdrive/on_remove()
	. = ..()
	owner.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	owner.remove_filter("emp_shield")
	owner.balloon_alert(owner, "your heart weakens!")
	to_chat(owner, span_userdanger("Your voltaic combat cyberheart putters weakly in your chest as it recharges; it won't protect you against EMPs until it recovers."))
	owner.remove_traits(list(TRAIT_NOSOFTCRIT, TRAIT_NOHARDCRIT, TRAIT_ANALGESIA), REF(src))
	associated_heart = null

/atom/movable/screen/alert/status_effect/anomalock_active
	name = "voltaic overdrive"
	icon_state = "anomalock_heart"
	desc = "Voltaic energy is flooding your muscles, keeping your body upright. You have 30 seconds before it falters!"

/obj/item/organ/heart/cybernetic/anomalock/hear_beat_noise(mob/living/hearer)
	if(prob(1))
		to_chat(hearer, span_danger("Yeah. Press a metal disk to the chest of a living arc flash hazard. See what that gets you.")) //the guy is LITERALLY sparking like a tesla coil.
	else
		to_chat(hearer, span_danger("An electrical arc strikes your stethoscope, conducting into you!"))
	if(hearer.electrocute_act(15, "stethoscope", flags = SHOCK_NOGLOVES)) //the stethoscope is in your ears. (returns true if it does damage so we only scream in that case)
		hearer.emote("scream")
	return span_danger("[owner.p_Their()] heart produces [beat_noise].")
