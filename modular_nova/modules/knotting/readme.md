https://github.com/NovaSector/NovaSector/pull/7208

## Knotting

Module ID: KNOTTING

### Description:

Adds opt-in knotting preferences and a temporary knot tie after internal climax. The knotter can keep moving while the tied partner is dragged along, and either participant can resist to end the tie early.

### TG Proc/File Changes:

- N/A

### Modular Overrides:

- N/A

### Defines:

- `code/__DEFINES/~nova_defines/lewd_defines.dm`: `CLIMAX_TARGET_ASSHOLE`, `CLIMAX_TARGET_MOUTH`
- `modular_nova/modules/knotting/code/knotted_component.dm`: `KNOT_DEFAULT_DURATION`, `KNOT_MIN_DURATION`, `KNOT_MAX_DURATION`
- `code/__DEFINES/~nova_defines/traits/declarations.dm`: `TRAIT_CAN_KNOT`, `TRAIT_KNOTTED`

### Included files that are not contained in this module:

- `code/_globalvars/traits/_traits.dm`: Adds `TRAIT_CAN_KNOT` to the Nova plush trait list.
- `code/_globalvars/traits/admin_tooling.dm`: Exposes `TRAIT_CAN_KNOT` to admin trait tooling.
- `modular_nova/modules/modular_items/lewd_items/code/lewd_arousal/climax.dm`: Calls `try_knot()` after an internal climax.
- `tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/character_preferences/nova/knotting.tsx`: Preference menu entries for knotting.

### Credits:

- Original implementation context: NovaSector/NovaSector#7208
