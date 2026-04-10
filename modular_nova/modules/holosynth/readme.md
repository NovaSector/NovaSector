## Holosynth Species

Module ID: HOLOSYNTH

### Description

Holosynths are a synthetic subtype made of soft-light, semi-solid and dependent on a projection device (pen). They can pass through glass, glow emissively, and have a custom hologel blood type.

### TG Proc/File Changes

- `code/__DEFINES/~nova_defines/DNA.dm` - Added `SPECIES_HOLOSYNTH`
- `code/__DEFINES/~nova_defines/traits/declarations.dm` - Added `TRAIT_HOLOSYNTH`
- `code/__DEFINES/~nova_defines/mobs.dm` - Added `BLOOD_TYPE_HOLOGEL`
- `code/__DEFINES/~nova_defines/colors.dm` - Added `BLOOD_COLOR_HOLOGEL`
- `code/_globalvars/traits/_traits.dm` - Registered `TRAIT_HOLOSYNTH`
- `code/_globalvars/traits/admin_tooling.dm` - Registered `TRAIT_HOLOSYNTH`

### Modular Overrides

- `modular_nova/master_files/code/modules/mob/living/blood_types.dm` - Added holosynth blood type
- `modular_nova/master_files/code/modules/client/preferences/mutant_parts.dm` - Added holosynth color preference

### Defines

- `SPECIES_HOLOSYNTH`
- `TRAIT_HOLOSYNTH`
- `BLOOD_TYPE_HOLOGEL`
- `BLOOD_COLOR_HOLOGEL`

### Credits

Original code from Doppler, ported from OculisStation
