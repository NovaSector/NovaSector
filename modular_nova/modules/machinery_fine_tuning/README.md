https://github.com/NovaSector/NovaSector/pull/3577

## Title: Lathe Medipens

MODULE ID: machine_fine_tuning

### Description:

Used to tweak upstream's and our machinery that support modular/semi-modular
approach. Mainly accesses and freq for awaysites

### TG Proc Changes:

- `/obj/machinery/post_machine_initialize()`

### Defines:

- N/A

### Master file additions

- `modular_nova/master_files/code/modules/reagents/reagent_containers/hypospray.dm`
  - Overrides `Initialize()` and `inject()`.
  - Adds new variables `medipen/var/init_empty` and `medipen/var/unused`.
- `modular_nova/master_files/code/modules/reagents/chemistry/holder.dm`
  - Adds new proc `/datum/reagents/proc/trans_to_multiple()`

### Included files that are not contained in this module:

Dependent to avoid runtime errors:

- `modular_nova/master_files/code/modules/reagents/reagent_containers/hypospray.dm`

### Credits:

- [@Floofies](https://github.com/Floofies)
