https://github.com/NovaSector/NovaSector/pull/3577

## Title: Lathe Medipens

MODULE ID: lathe_medipens

### Description:

Contains empty subtypes of several medipens, custom/universal medipen subtypes with new icons, and techweb nodes/designs for them.

### TG Proc Changes:

Overridden to implement medipens which spawn without reagents:

- `/obj/item/reagent_containers/hypospray/medipen/Initialize()`
- `/obj/item/reagent_containers/hypospray/medipen/inject()`

### Defines:

- N/A

### Master file additions

- `modular_nova\master_files\code\modules\reagents\reagent_containers\hypospray.dm`
  - Overrides `Initialize()` and `inject()`.
  - Adds new variables `medipen/var/init_empty` and `medipen/var/unused`.

### Included files that are not contained in this module:

Dependent to avoid runtime errors:

- `modular_nova\master_files\code\modules\reagents\reagent_containers\hypospray.dm`

### Credits:
- [@Floofies](https://github.com/Floofies)
