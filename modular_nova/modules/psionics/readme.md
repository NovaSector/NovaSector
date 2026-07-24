## Title: Psionics

MODULE ID: PSIONICS

### Description:

Adds a standalone psionics system. Psions spend imprint points on disciplines, build strain when using them, and burn out if they push too hard.

Psionics are not spells. They do not use spell actions or antimagic checks; blocking and suppression go through psionic signals, psionic components, and `TRAIT_PSIONIC_DAMPENER`.

### Features:

- `Psionic Gift` quirk, with rank and manifestation color preferences.
- `Psionic Resonance` mutation, which awakens a rolled psionic rank.
- Psionic imprinting TGUI and strain HUD.
- Rank ladder from Lambda to Alpha. Delta and above start capped to Gamma by a psionic limiter implant when gained from the roundstart quirk; ranks above Gamma also get gun restriction traits.
- Individual power cooldowns, profile strain, burnout, and rank-specific power forms where needed.
- Psionic dampener cuffs, a psionic dampener head item, and reusable protection/restriction components.
- School commitment and anomaly-core attunement, both of which reduce strain in that school.

### TG Proc/File Changes:

- `modular_nova/master_files/code/datums/mind/_mind.dm`
  - Stores the mutation-sourced psionic rank on each mind.
- `modular_nova/master_files/code/game/turfs/closed/walls.dm`
  - Adds temporary psionic wall phasing used by Warp.
- `modular_nova/master_files/code/modules/research/anomaly/anomaly_core.dm`
  - Adds psionic anomaly-core attunement interaction and examine text.

### Modular Overrides / External Files:

- `code/__DEFINES/~nova_defines/psionic.dm`
  - Shared psionic ranks, sources, schools, strain defaults, flags, signals, HUD identifiers, and component return values.
- `code/__DEFINES/~nova_defines/vv.dm`
  - Adds the Give Psionics VV dropdown identifier.
- `modular_nova/modules/extra_vv/code/extra_vv.dm`
  - Adds the Give Psionics action to living mobs' VV dropdown.
- `modular_nova/master_files/code/modules/research/techweb/all_nodes.dm`
  - Adds `psionic_dampener_cuffs` to riot suppression research.
- `modular_nova/modules/implants/code/medical_nodes.dm`
  - Adds `ci-psionic-limiter` to cybernetic implant research.
- `tgui/packages/tgui/interfaces/PsionicImprinting.tsx`
- `tgui/packages/tgui/styles/interfaces/PsionicImprinting.scss`
- `tgui/packages/tgui/styles/assets/psionic-*.svg`
- `tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/character_preferences/nova/psionics.tsx`

### Defines:

- `code/__DEFINES/~nova_defines/psionic.dm`
  - Psionic ranks, sources, schools, strain defaults, flags, signal names, HUD identifiers, and component return values.

### Notes for adding powers:

Power files live in `code/power`. Keep each concrete power in its own file with its `/datum/psionic_power` entry, action type, rank variants if any, and owned helper objects or projectiles.

Most metadata lives on the action. The `/datum/psionic_power` entry exposes the action to the imprinting tree and declares tree-only requirements such as prerequisites or spent school points.

Use `mob/living/proc/awaken_psionics()` and `revoke_psionics()` for point-only sources. Sources that grant a rank must restore the previous rank when removed. Use psionic flags and `can_block_psionics()` / `can_cast_psionics()` for counters instead of spell or antimagic hooks.
