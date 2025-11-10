## Title: Neuroware

MODULE ID: NEUROWARE

### Description:

Adds neuroware chips, which add reagents to synthetic humanoids which are contextualized as "neurocomputing programs".

### TG Proc/File Changes:

- `code/_globalvars/lists/maintenance_loot.dm`
  - Added to global list `trash_loot`
- `code/game/objects/effects/spawners/random/trash.dm`
  - Added to `/obj/effect/spawner/random/trash/deluxe_garbage`
- `code/game/objects/effects/spawners/random/contraband.dm`
  - Added to `/obj/effect/spawner/random/contraband`
- `code/game/objects/items/storage/uplink_kits.dm`
  - Added to `/obj/item/storage/toolbox/emergency/old/ancientbundle/PopulateContents()`
  - Added to `/obj/item/storage/box/syndicate/bundle_a/PopulateContents()`:
    - `KIT_STEALTHY`
    - `KIT_REVOLUTIONARY`
- `code/game/objects/items/devices/scanners/health_analyzer.dm`
  - Added neuroware listing to `/proc/chemscan()`
- `code/modules/surgery/blood_filter.dm`
  - Added to `/datum/surgery_step/filter_blood/proc/has_filterable_chems()`
  - Added to `/datum/surgery_step/filter_blood/proc/success()`
- `code/modules/surgery/tools.dm`
  - Edited `/obj/item/blood_filter/proc/ui_act()`
- `code/game/objects/items/storage/wallets.dm`
  - Added to `/obj/item/storage/wallet/Initialize(mapload)`

### Modular Overrides:

- Macro `NEUROWARE_METABOLIZE_HELPER` overrides `on_mob_end_metabolize()` for the given reagent type.
  - Used for all neuroware reagents in `modular_nova/modules/neuroware/code/datums/reagents`

### Defines:

- Defined in `code/__DEFINES/~nova_defines/neuroware_defines.dm`:
- `NEUROWARE_METABOLIZE_HELPER` macro, overrides a reagent's `on_mob_end_metabolize()`.
- `REAGENT_NEUROWARE` bitflag for `chemical_flags`, which combines `REAGENT_INVISIBLE` with a new flag.
- Bitflags for chip labels:
  - `NEUROWARE_BISHOP`
  - `NEUROWARE_DEFOREST`
  - `NEUROWARE_DONK`
  - `NEUROWARE_MAINT`
  - `NEUROWARE_NT`
  - `NEUROWARE_SYNDIE`
  - `NEUROWARE_WARD`
  - `NEUROWARE_ZENGHU`
- Defined in `modular_nova/modules/neuroware/code/objects/items/_neuroware.dm` are macros for manufacturer tags. Matches up to bitflags defined in `neuroware_defines.dm`:
  - `CHIP_LABEL_BISHOP`
  - `CHIP_LABEL_DEFOREST`
  - `CHIP_LABEL_DONK`
  - `CHIP_LABEL_MAINT`
  - `CHIP_LABEL_NT`
  - `CHIP_LABEL_SYNDIE`
  - `CHIP_LABEL_WARD`
  - `CHIP_LABEL_ZENGHU`
  - `NEURO_SLOT_NAME`
- Defined in `modular_nova/master_files/code/_globalvars/lists/reagents.dm`:
  - Added global list `name2reagent_normalized`. Same as `name2reagent` but omits neuroware reagents.
  - Added global list `name2neuroware`. Same as `name2reagent` but contains only neuroware reagents.
  - Added global list `name2neuroware_safe`. Same as `name2neuroware` but omits aphrodisiac reagents.

 ### Included files that are not contained in this module:

- `code/__DEFINES/~nova_defines/neuroware_defines.dm`
- `modular_nova/modules/GAGS/json_configs/items/neuroware.json`
- `modular_nova/master_files/code/_globalvars/lists/reagents.dm`

### Credits:
- Code by [@Floofies](https://github.com/Floofies)
- Sprites by [@splat1125](https://github.com/splat1125)
