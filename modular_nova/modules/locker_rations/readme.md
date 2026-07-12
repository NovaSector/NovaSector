<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/NovaSector/NovaSector/pull/<!--PR Number-->

## Emergency Locker Rations

Module ID: LOCKER_RATIONS

### Description:

This module adds in emergency ration packs to the game, and the contents of the packs.

### TG Proc/File Changes:

- `code/game/objects/structures/crates_lockers/closets/utility_closets.dm`: A ration pack was added to the emergency locker, expanding the existing Nova edit that added the emergency space suit case.
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g: 
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
-->

### Modular Overrides:

- N/A
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g: 
- `modular_nova/master_files/sound/my_cool_sound.ogg`
- `modular_nova/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
-->

### Defines:

- N/A
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- `modular_nova/modules/cargo/code/packs.dm`: An emergency rations box was added to cargo.
- `modular_nova/modules/imported_vendors/code/vendor_food.dm`: The ration mains/sides are subtypes of the vendor ones. As well, a base type for a vendor main spawner was added in, because there originally wasn't one there like there was for vendor sides.

### Credits:

sergeirocks100: Programming, partial sprite work
Paxilmaniac: Original foodpack/packaging sprites
