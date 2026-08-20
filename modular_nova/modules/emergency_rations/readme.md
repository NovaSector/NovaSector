<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/NovaSector/NovaSector/pull/7616

## Emergency Rations

Module ID: EMERGENCY_RATIONS

### Description:

This module adds in emergency ration packs to the game, and the contents of the packs.

### TG Proc/File Changes:

- N/A

### Modular Overrides:

- N/A

### Defines:

- N/A

### Included files that are not contained in this module:

- `modular_nova/modules/cargo/code/packs.dm`: An emergency rations box was added to cargo.
- `modular_nova/modules/imported_vendors/code/vendor_food.dm`: The ration mains/sides are subtypes of the vendor ones. As well, a base type for a vendor main spawner was added in, because there originally wasn't one there like there was for vendor sides.

### Credits:

sergeirocks100: Programming, partial sprite work
Paxilmaniac: Original foodpack/packaging sprites
