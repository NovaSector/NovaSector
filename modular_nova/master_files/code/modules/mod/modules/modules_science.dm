/obj/item/mod/module/anomaly_locked/antigrav/on_activation()
	. = ..()
	if(!mod.wearer)
		return

	// Check to see if the users has the spacer quirk. If not null, will result in the negation of gravity sickness.
	var/datum/quirk/spacer_born/spacer_quirk = mod.wearer.get_quirk(/datum/quirk/spacer_born)
	if (!isnull(spacer_quirk))
		spacer_quirk.in_space(mod.wearer)

/obj/item/mod/module/anomaly_locked/antigrav/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!mod.wearer)
		return

	// Check to see if the users has the spacer quirk. If not null, will result in the negation of gravity sickness.
	var/datum/quirk/spacer_born/spacer_quirk = mod.wearer.get_quirk(/datum/quirk/spacer_born)
	if (!isnull(spacer_quirk))
		spacer_quirk.update_effects(mod.wearer)

/obj/item/mod/module/anomaly_locked/kinesis/commercial
	name = "MOD kinesis module (commercial variant)"
	desc = "A modular plug-in to the forearm, this widely distributed model refines kinesis technology \
		into a stable and accessible format, eliminating the need for exotic anomaly based components. \
		The resulting system prioritizes reliability over raw performance, producing modest anti-gravity \
		fields with increased energy demands, extended recovery periods between uses and the \
		corresponding increased system complexity. As expected, it does not function on living organisms."
	prebuilt = TRUE
	core_removable = FALSE
	use_energy_cost = parent_type::use_energy_cost * 2
	complexity = 4 // original is 3
	cooldown_time = 1 SECONDS // original is 0.5
	hit_cooldown_time = 1.5 SECONDS // original is 1

/obj/item/mod/module/anomaly_locked/antigrav/commercial
	name = "MOD anti-gravity module (commercial variant)"
	desc = "A modular plug-in that achieves complete weightlessness through controlled anti-gravity output, \
		redesigned to operate without anomaly based cores. It matches the performance of earlier models, \
		though at the cost of increased system complexity and significantly higher power consumption."
	prebuilt = TRUE
	core_removable = FALSE
	complexity = 3 // original is 2
	active_power_cost = parent_type::active_power_cost * 2

/obj/item/mod/module/anomaly_locked/teleporter
	teleport_time = 4 SECONDS // original is 1

/obj/item/mod/module/anomaly_locked/teleporter/commercial
	name = "MOD teleporter module (commercial variant)"
	desc = "A modular plug-in that enables localized particle displacement, redesigned to operate without anomaly-based cores. \
		While retaining its ability to transport the user across space, the system relies on more complex circuitry, \
		resulting in longer recalibration periods and more limited operational use between cycles."
	prebuilt = TRUE
	core_removable = FALSE
	complexity = 4 // original is 3
	teleport_time = 6 SECONDS // original is 1, post nerf original is 4
	cooldown_time = 8 SECONDS // original is 4

