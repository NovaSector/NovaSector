https://github.com/NovaSector/NovaSector/pull/3577

## Title: Lathe Medipens

MODULE ID: lathe_medipens

### Description:

Contains empty subtypes of several medipens, custom/universal medipen subtypes with new icons, and techweb nodes/designs for them.

### TG Proc Changes:

- `/obj/item/reagent_containers/hypospray/medipen/Initialize` is overridden by this module to implement medipens which spawn without reagents.

### Defines:

Local to `hypospray.dm`:

- Macro `HYPOSPRAY_PATH_HELPER` creates a hypospray subtype.
- Macro `EMPTY_MEDIPEN_HELPER` creates an empty medipen subtype.

### Master file additions

- Empty medipen subtypes: `modular_nova\master_files\code\modules\reagents\reagent_containers\hypospray.dm`

### Included files that are not contained in this module:

- N/A

### Credits:
- [@Floofies](https://github.com/Floofies)
