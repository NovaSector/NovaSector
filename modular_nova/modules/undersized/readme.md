## Title: Undersized

MODULE ID: UNDERSIZED

### Description:

Adds the `Undersized` quirk: a tiny carbon humanoid (`MOB_SIZE_TINY`, half-scale sprite) with reduced movement speed, weakened unarmed damage, longer melee click cooldown, 15% lower maxHealth, no neck-grabs, table/grille passability, and a custom step-crush component that pulps them under combat-mode walkers (or any walker, if they're prone) and dense structures. Pacifists, characters too small (`MOB_SIZE_SMALL` and below), and anyone in zero-G can't squash an undersized.

`TRAIT_UNDENSE` is granted (in addition to `passtable_on()` for tables/grilles). Without it, the holder stays dense and crewmates bump them at the tile edge instead of crossing onto the tile — the squash component listens via `COMSIG_ATOM_ENTERED`, which only fires when a `Cross()` succeeds, so a dense undersized is effectively uncrushable. The stacking-bypass concerns from the original dev-suggest are addressed elsewhere: the crusher's `movement_type & MOVETYPES_NOT_TOUCHING_GROUND` check (for slime/wing-flying stacks) and the victim's gravity check (for zero-G).

Ports `Undersized` from DopplerShift (`modular_doppler/modular_quirks/undersized/`), forwarding examine, ID/access, and breath behavior through the `mob_holder` so a held undersized still functions.

### Design notes:

Melee CD is increased (applies to both unarmed swings via `COMSIG_LIVING_UNARMED_ATTACK` and weapon swings via `COMSIG_MOB_ITEM_ATTACK`), not the unarmed damage bonuses. Heavy weapons with attack_speed already longer than `UNDERSIZED_MELEE_CD` aren't sped up.

`TRAIT_NO_GUN_AKIMBO` is granted so the holder can't dual-wield firearms.

The **combat-mode-or-prone** step-crush gate is intentionally permissive: most crew don't run combat-mode by default, so accidental Frogger deaths from incidental movement basically end. Griefers who _want_ to crush a tiny crewmate must consciously toggle combat (which is `attack_log`-loggable). A soap-slipped or knocked-down undersized can still be casually trampled, which preserves the original RP hazard.

The 15% maxHealth reduction is the "organic holosynth" identity lever: less to repair, every chem heals a proportionally larger fraction of the bar.

### TG Proc Changes:

- `/datum/component/squashable/Initialize` — gate `squash_callback` registration on `istype(... /datum/callback)` so non-callback args silently noop instead of risking malformed registration
- `/mob/living/carbon/human/will_escape_storage` — undersized humans no longer escape storage (lets them be carried in containers)
- `/obj/item/gun/shoot_live_shot` — `MOB_SIZE_TINY` shooters are thrown back proportional to the projectile's damage
- `/obj/item/gun/before_firing` — caches projectile-damage-derived `kickback_*` vars for the throwback above
- `/obj/item/mob_holder` — examine, examine_more, get_examine_name/icon, GetAccess, GetID, handle_internal_lifeform now defer to a held carbon
- `/obj/item/mob_holder/release` — clears `held_mob` before `dropItemToGround` so the `Moved` auto-release hook doesn't recursively re-enter (latent base bug: thrown mob_holder qdels itself inside the inner release, then the outer release's `forceMove(drop_location())` crashes with null because the holder is gone)

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
- `code/modules/mob/living/inhand_holder.dm` — re-entrant `release()` guard

### Credits:

Recovered from a closed NovaSector PR; original mechanic ported from DopplerShift.
