/obj/item/organ/heart/cybernetic/anomalock
	desc = "A cutting-edge cyberheart. Voltaic technology allows the heart to keep the body upright in dire circumstances, \
		along with fully shielding the user from shocks and electro-magnetic pulses, when in an \"overdrive\" state. \
		Requires a refined flux core as a power source. \
		The critical protection functionality requires a cooldown period before it can be used again."

	/// What type of voltaic overdrive do we confer in crit?
	var/datum/status_effect/voltaic_overdrive/overdrive_type = /datum/status_effect/voltaic_overdrive

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

/datum/status_effect/voltaic_overdrive
	/// Does this voltaic overdrive effect provide EMP protection?
	var/emp_resist = TRUE

/datum/status_effect/voltaic_overdrive/on_remove()
	to_chat(owner, span_userdanger("Your voltaic combat cyberheart putters weakly in your chest as it recharges; it won't protect you against EMPs until it recovers."))
	return ..()

/obj/item/organ/heart/cybernetic/anomalock/weak
	name = "scavenged voltaic combat cyberheart"
	desc = "A cutting-edge cyberheart. Voltaic technology allows the heart to keep the body upright in dire circumstances, \
		along with fully shielding the user from shocks, when in an \"overdrive\" state. \
		Requires a refined flux core as a power source. \
		The critical protection functionality requires a cooldown period before it can be used again. \
		Due to battle damage, the overdrive does not provide immunity from EMPs, \
		has a shortened overdrive time, and has a longer, ten-minute cooldown time."

	survival_cooldown_time = 10 MINUTES
	overdrive_type = /datum/status_effect/voltaic_overdrive/short

/datum/status_effect/voltaic_overdrive/short
	emp_resist = FALSE
	duration = 10 SECONDS
