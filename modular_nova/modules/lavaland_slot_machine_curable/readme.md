## Lavaland Slot-Machine Curse Cures

Module ID: `LAVALAND_SLOT_MACHINE_CURABLE`

### Description

Adds two ways to cure the lavaland slot machine curse (aka burning hand).

- Removing the bodypart branded by the curse clears the status effect.
- Metabolizing 10 around units of holy water clears the status effect. This corresponds to 25 seconds of accumulated holy-water metabolism.

### TG Proc/File Changes

- N/A. No core source files are modified.

### Modular Overrides

- [code/slot_machine_curse.dm](code/slot_machine_curse.dm): adds limb-removal and holy-water cures by extending the curse status effect and holy-water metabolism.
- The curse status effect being extended is defined in [code/datums/status_effects/debuffs/cursed.dm](../../../code/datums/status_effects/debuffs/cursed.dm).
- The holy-water metabolism proc being extended is defined in [code/modules/reagents/chemistry/reagents/other_reagents.dm](../../../code/modules/reagents/chemistry/reagents/other_reagents.dm).

### Defines

- N/A.

### Included files that are not contained in this module

- N/A

### Credits

- RichardBlonski 🐢
