## Title: Undersized

MODULE ID: UNDERSIZED

### Description:

Adds the `Undersized` quirk: a tiny carbon humanoid (`MOB_SIZE_TINY`, half-scale sprite) with reduced movement speed, weakened unarmed damage, longer melee click cooldown, 15% lower maxHealth, no neck-grabs, table/grille passability, and a custom step-crush component that pulps them under combat-mode walkers (or any walker, if they're prone) and dense structures. Pacifists, characters too small (`MOB_SIZE_SMALL` and below), and anyone in zero-G can't squash an undersized.

The quirk does *not* grant `TRAIT_UNDENSE` — phasing through other mobs would bypass the step-crush hazard entirely. Table/grille passability is handled separately via `passtable_on()`.

Ports `Undersized` from DopplerShift (`modular_doppler/modular_quirks/undersized/`), forwarding examine, ID/access, and breath behavior through the `mob_holder` so a held undersized still functions.

### Design notes:

The load-bearing combat nerf is the **melee click-cooldown extension**, not the unarmed damage bonuses. SS13's combat is decided by who can chain stuns/disables first, not damage per click — so a 0.5× damage multiplier is mostly cosmetic, while a +0.6s delay between swings actually keeps the quirk holder out of arms-race scenarios.

The **combat-mode-or-prone** step-crush gate is intentionally permissive: most crew don't run combat-mode by default, so accidental Frogger deaths from incidental movement basically end. Griefers who *want* to crush a tiny crewmate must consciously toggle combat (which is `attack_log`-loggable). A soap-slipped or knocked-down undersized can still be casually trampled, which preserves the original RP hazard.

The 15% maxHealth reduction is the "organic holosynth" identity lever: less to repair, every chem heals a proportionally larger fraction of the bar.

### TG Proc Changes:

- `/datum/component/squashable/Initialize` — gate `squash_callback` registration on `istype(... /datum/callback)` so non-callback args silently noop instead of risking malformed registration
- `/mob/living/carbon/human/will_escape_storage` — undersized humans no longer escape storage (lets them be carried in containers)
- `/obj/item/gun/shoot_live_shot` — `MOB_SIZE_TINY` shooters are thrown back proportional to the projectile's damage
- `/obj/item/gun/before_firing` — caches projectile-damage-derived `kickback_*` vars for the throwback above
- `/obj/item/mob_holder` — examine, examine_more, get_examine_name/icon, GetAccess, GetID, handle_internal_lifeform now defer to a held carbon

### Defines:

- `TRAIT_UNDERSIZED` (in `code/__DEFINES/~nova_defines/traits/declarations.dm`)

### Master file additions

- N/A

### Included files that are not contained in this module:

- `code/__DEFINES/~nova_defines/traits/declarations.dm` — `TRAIT_UNDERSIZED`
- `code/_globalvars/traits/_traits.dm` — registry entry
- `code/_globalvars/traits/admin_tooling.dm` — admin-visible trait entry
- `code/controllers/subsystem/processing/quirks.dm` — incompatibility with `frail` and `oversized`
- `code/datums/components/squashable.dm` — callback istype gate
- `code/modules/mob/living/living.dm` — `will_escape_storage` gate

### Credits:

Recovered from a closed NovaSector PR; original mechanic ported from DopplerShift.
