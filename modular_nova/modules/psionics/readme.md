# Psionics

Standalone psionics prototype for NovaSector.

Design notes:

- Psionics are not spells and do not inherit `/datum/action/cooldown/spell`.
- Antimagic does not block psionics. Psionic counters use `COMSIG_MOB_RECEIVE_PSIONICS` and `/datum/component/anti_psionic`.
- Psions with effective ranks above Gamma receive `TRAIT_NOGUNS` and `TRAIT_TOSS_GUN_HARD` from `PSIONIC_TRAIT_SOURCE`.
- Powers use individual cooldowns plus profile-level strain, not mana.
- Genetics and anomalies should interact through `mob/living/proc/awaken_psionics()` rather than editing this module's internals.
- Psionic schools are anomaly resonance metadata, currently mapped to bioscrambler, gravity, bluespace, and flux signatures.
- `get_psionic_school_for_anomaly_source()` maps either live anomaly paths or anomaly core item paths to a school.
- Effective ranks above Gamma cause psionic actions to interfere with nearby technology. The effect scales with effective rank and power cost: lights can flicker, machines can suffer light EMP disruption, and robotic bodyparts can take minor burn damage.
- Psionic limiter implants fully respec the holder while installed: all imprinted disciplines are removed, the holder receives Gamma's point pool to spend, and removing the limiter resets them again to their full latent point pool.
- Spending at least 3 imprint points in one branch reduces strain gained by that branch's powers by 15%.
- Activating a matching anomaly core while awakened consumes it and attunes that branch, reducing strain gained by that branch's powers by 20%.

Current schools:

- Bioscrambler: neural, somatic, and identity resonance. Current powers: `Telepathic Whisper`, `Sense Health`.
- Gravity: mass, inertia, and kinetic pressure. Starter power: `Kinetic Shove`.
- Bluespace: distance, folds, and spatial discontinuity. Starter power: `Spatial Slip`.
- Flux: interference, disruption, reactive static, and thermal shaping. Current powers: `Psychic Guard`, `Pyro Bolt`, `Pyro Assault`.

Psionic Gift ranks:

- Lambda: 0 imprint points. Sensitivity only.
- Epsilon: 1 imprint point. Latent faculties or minor operancy.
- Gamma: 3 imprint points. Operant-rank faculties.
- Delta: 5 latent imprint points. Starts capped to Gamma by a psionic limiter implant.
- Beta: 7 latent imprint points. Starts capped to Gamma by a psionic limiter implant.
- Alpha: 9 latent imprint points and reduced max strain. Starts capped to Gamma by a psionic limiter implant.

Current hooks:

- `/datum/mutation/psionic_resonance` awakens a human with the default point grant.
- `/datum/quirk/psionic_gift` awakens a character with the default point grant at round start.
- `/obj/item/psionic_resonator` is a reusable admin/test item for awakening a living mob.
- `/obj/item/clothing/head/psionic_dampener` is a psionic-only counter item.

Adding powers:

Power metadata lives on the action. The `/datum/psionic_power` entry only exposes
that action to the imprinting tree and declares tree-only requirements.

Minimal tree entry:

```dm
/datum/psionic_power/my_power
	action_type = /datum/action/cooldown/psionic/my_power
```

Tree entry with prerequisites:

```dm
/datum/psionic_power/my_advanced_power
	required_school_points = 3
	required_powers = list(/datum/action/cooldown/psionic/my_power)
	action_type = /datum/action/cooldown/psionic/my_advanced_power
```

Self-cast action template:

```dm
/datum/action/cooldown/psionic/my_power
	name = "My Power"
	desc = "Briefly do a psionic thing."
	button_icon_state = "psi_my_power"
	point_cost = 1
	cooldown_time = 10 SECONDS
	strain_gain = 10
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_FLUX

/datum/action/cooldown/psionic/my_power/psionic_activate(atom/target)
	// Effect code goes here.
	return TRUE
```

Pointed living-target action template:

```dm
/datum/action/cooldown/psionic/pointed/living_target/my_power
	name = "My Power"
	desc = "Focus a psionic effect on a nearby target."
	button_icon_state = "psi_my_power"
	point_cost = 1
	cooldown_time = 10 SECONDS
	cast_range = 6
	strain_gain = 12
	psionic_flags = PSIONIC_INTRUSIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER

/datum/action/cooldown/psionic/pointed/living_target/my_power/psionic_activate(atom/target)
	var/mob/living/living_target = target
	// Effect code goes here.
	return TRUE
```

Projectile action template:

```dm
/datum/action/cooldown/psionic/pointed/projectile/my_power
	name = "My Power"
	desc = "Launch a psionic projectile."
	button_icon_state = "psi_my_power"
	point_cost = 1
	cooldown_time = 12 SECONDS
	cast_range = 8
	strain_gain = 14
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	projectile_type = /obj/projectile/psionic/my_power

/obj/projectile/psionic/my_power
	name = "psionic projectile"
	damage = 15
	damage_type = BRUTE
	range = 8
```
