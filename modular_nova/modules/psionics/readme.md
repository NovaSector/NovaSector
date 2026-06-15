# Psionics

Standalone psionics prototype for NovaSector.

Design notes:

- Psionics are not spells and do not inherit `/datum/action/cooldown/spell`.
- Antimagic does not block psionics. Psionic counters use `COMSIG_MOB_RECEIVE_PSIONICS` and `/datum/component/anti_psionic`.
- Psions with latent ranks above Gamma receive `TRAIT_NOGUNS` and `TRAIT_TOSS_GUN_HARD` from `PSIONIC_TRAIT_SOURCE`.
- Powers use individual cooldowns plus profile-level strain, not mana.
- Genetics and anomalies should interact through `mob/living/proc/awaken_psionics()` rather than editing this module's internals.
- Psionic schools are anomaly resonance metadata, currently mapped to bioscrambler, gravity, bluespace, and flux signatures.
- `get_psionic_school_for_anomaly_source()` maps either live anomaly paths or anomaly core item paths to a school.
- Effective ranks above Gamma cause psionic actions to interfere with nearby technology. The effect scales with effective rank and power cost: lights can flicker, machines can suffer light EMP disruption, and robotic bodyparts can take minor burn damage.

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
