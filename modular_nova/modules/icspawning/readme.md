https://github.com/Skyrat-SS13/Skyrat-tg/pull/104

## Title: IC Spawning for admins

MODULE ID: ICSPAWNING

### Description:

Adds a control click function to ghosts which allows an admin to spawn the player in via a supply pod or teleportation with effects.
Extended to allow admins to save preferred spawn methods and outfits to custom slots.

### TG Proc Changes:

N/A

### Defines:

N/A

### Included files:

- ./observer.dm
- ./spell.dm

### Core Code Changes:

- `code/modules/client/preferences_savefile.dm`: Added saving and loading for `preferred_spawn_methods` and `preferred_spawn_outfits`.
- `modular_nova/master_files/code/modules/client/preferences.dm`: Added variables to `/datum/preferences` to store custom spawn slots.

### Credits:

Gandalf2k15 - Porting
BunBun - Cration
Moonridden - Partially gutted this and included it in nova module admin_tech. Migrated outfits + custom bst brped
Manus AI - Admin custom slots
