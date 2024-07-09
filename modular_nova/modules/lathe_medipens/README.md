https://github.com/NovaSector/NovaSector/pull/3577

## Title: Lathe Medipens

MODULE ID: lathe_medipens

### Description:

Contains empty subtypes of several medipens, custom/universal medipen subtypes with new icons, and techweb nodes/designs for them.

### TG Proc Changes:

- `/obj/item/reagent_containers/hypospray/medipen/Initialize` is overridden by this module to implement medipens which spawn without reagents.

### Defines:

- N/A

### Master file additions

Implements variables `init_empty` and `unused` on `/obj/item/reagent_containers/hypospray/medipen`:

- `modular_nova\master_files\code\modules\reagents\reagent_containers\hypospray.dm`

### Included files that are not contained in this module:

Dependent to avoid runtime errors:

- `modular_nova\master_files\code\modules\reagents\reagent_containers\hypospray.dm`

### Credits:
- [@Floofies](https://github.com/Floofies)
