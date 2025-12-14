/obj/item/organ/heart/cybernetic/anomalock
	desc = "A cutting-edge cyberheart. Voltaic technology allows the heart to keep the body upright in dire circumstances, \
		along with fully shielding the user from shocks and electro-magnetic pulses. \
		Requires a refined flux core as a power source. \
		The critical protection functionality requires a cooldown period before it can be used again."

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
			that would incapacitate or outright kill lesser men. There are some caveats with this, though.<br>\
			<br>\
			Without a flux core, the voltaic combat cyberheart only provides increased blood regeneration, \
			and with a flux core, receiving an electromagnetic pulse will force the heart into voltaic overdrive, \
			which could possibly leave the user vulnerable to a direct attack once their voltaic overdrive wears off. \
			Voltaic overdrive lasts about <b>thirty seconds</b>, and recharges after approximately <b>five minutes</b>. \
			In that four minutes and thirty seconds between, though, the user is quite vulnerable.", \
	)

/obj/item/organ/heart/cybernetic/anomalock/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(!core)
		return
	// we're delegating the EMP protection to the status effect
	organ_owner.RemoveElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS|EMP_NO_EXAMINE)

/obj/item/organ/heart/cybernetic/anomalock/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	if(owner?.has_status_effect(/datum/status_effect/voltaic_overdrive))
		owner?.remove_status_effect(/datum/status_effect/voltaic_overdrive)
	UnregisterSignal(organ_owner, list(COMSIG_ATOM_EMP_ACT, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION)))
	. = ..()

/obj/item/organ/heart/cybernetic/anomalock/on_emp_act(severity)
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
	to_chat(owner, span_danger("Your voltaic combat cyberheart flutters weakly, failing to protect against an electromagnetic pulse!"))

/obj/item/organ/heart/cybernetic/anomalock/clear_lightning_overlay()
	owner?.cut_overlay(lightning_overlay)
	lightning_overlay = null

/obj/item/organ/heart/cybernetic/anomalock/activate_survival(mob/living/carbon/organ_owner)
	if(!COOLDOWN_FINISHED(src, survival_cooldown))
		return

	// associate the heart with the effect
	var/datum/status_effect/voltaic_overdrive/maximum_overdrive = organ_owner.apply_status_effect(/datum/status_effect/voltaic_overdrive)
	maximum_overdrive.associated_heart = src

	add_lightning_overlay(30 SECONDS)
	COOLDOWN_START(src, survival_cooldown, survival_cooldown_time)
	addtimer(CALLBACK(src, PROC_REF(notify_cooldown), organ_owner), COOLDOWN_TIMELEFT(src, survival_cooldown))

/datum/status_effect/voltaic_overdrive
	var/obj/item/organ/heart/cybernetic/anomalock/associated_heart


/datum/status_effect/voltaic_overdrive/tick(seconds_between_ticks)
	if(!associated_heart.owner)
		qdel(src)
		return
	. = ..()

/datum/status_effect/voltaic_overdrive/on_remove()
	to_chat(owner, span_userdanger("Your voltaic combat cyberheart putters weakly in your chest as it recharges; it won't protect you against EMPs until it recovers."))
	associated_heart = null
	. = ..()
