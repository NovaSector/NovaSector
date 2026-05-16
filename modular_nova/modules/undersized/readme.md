## Title: Undersized

MODULE ID: UNDERSIZED

### Description:

Adds the `Undersized` quirk: a tiny carbon humanoid (`MOB_SIZE_TINY`, half-scale sprite) with reduced movement speed, weakened unarmed damage, no neck-grabs, table/grille passability, and a custom step-crush component that pulps them under combat-mode walkers and dense structures. Pacifists, walking non-combat-mode characters, and characters too small (`MOB_SIZE_SMALL` and below) won't squash an undersized.

Ports `Undersized` from DopplerShift (`modular_doppler/modular_quirks/undersized/`), forwarding examine, ID/access, and breath behavior through the `mob_holder` so a held undersized still functions.

Ships **`hidden_quirk = TRUE`** so only admins can grant it during the bake-in period; flip it to `FALSE` in a follow-up PR once interactions and balance are settled.

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
