## Title: Neuroware

MODULE ID: NEUROWARE

### Description:

Adds neuroware chips, which add reagents to synthetic humanoids which are contextualized as "neurocomputing programs".

### TG Proc/File Changes:

- `code/_globalvars/lists/reagents.dm`
  - Added global `name2reagent_normalized`. Same as `name2reagent` but omits neuroware reagents.
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

The macro `NEUROWARE_METABOLIZE_HELPER` overrides `on_mob_end_metabolize()` for each neuroware reagent:
- `modular_nova/modules/neuroware/code/objects/items/drug_neuroware.dm`
- `modular_nova/modules/neuroware/code/objects/items/lewd_neuroware.dm`
- `modular_nova/modules/neuroware/code/objects/items/medicine_neuroware.dm`

### Defines:

Defined in `code/__DEFINES/~nova_defines/neuroware_defines.dm`:

- `NEUROWARE_METABOLIZE_HELPER` macro, overrides `on_mob_end_metabolize()`.
- `REAGENT_NEUROWARE` bitflag for `chemical_flags`.

Bitflags for chip labels:
- `NEUROWARE_BISHOP`
- `NEUROWARE_DEFOREST`
- `NEUROWARE_DONK`
- `NEUROWARE_MAINT`
- `NEUROWARE_NT`
- `NEUROWARE_SYNDIE`
- `NEUROWARE_WARD`
- `NEUROWARE_ZENGHU`

 ### Included files that are not contained in this module:

- `code/__DEFINES/~nova_defines/neuroware_defines.dm`
- `modular_nova/modules/GAGS/json_configs/items/neuroware.json`

### Credits:
- Code by [@Floofies](https://github.com/Floofies)
- Sprites by [@splat1125](https://github.com/splat1125)
