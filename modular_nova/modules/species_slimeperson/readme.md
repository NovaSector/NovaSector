## Title: Slimeperson Species

MODULE ID: SPECIES_SLIMEPERSON

### Description:

Adds a new roundstart slimeperson species, reworking and rebalancing TG's jellyperson with new organs, water interactions, shapeshifting, and unique death mechanics.

### TG Proc/File Changes:

- `code/datums/components/chasm.dm`
  - Adds slime core to chasm storage
- `code/modules/fishing/fish/chasm_detritus.dm`
  - Adds slime core as body detritus target
- `code/modules/mob/living/basic/lavaland/legion/legion.dm`
  - Makes legion eject a stored slime core
- `code/controllers/subsystem/processing/quirks.dm`
  - Adds a blacklist arg for slime revival
- `code/datums/dna/dna.dm`
  - Adds code to preserve DNA properties
- `code/_globalvars/traits/_traits.dm`
  - Adds `TRAIT_SLIME_HYDROPHOBIA` to the list
- `code/_globalvars/traits/admin_tooling.dm`
  - Adds `TRAIT_SLIME_HYDROPHOBIA` to the list
- `tgstation.dme`
  - Adds modular files to the include
- `config/game_options.txt`
  - Adds `ROUNDSTART_RACES slimeperson`

### Modular File Changes:

- `modular_nova/modules/customization/modules/mob/living/carbon/human/human.dm`
  - Adds `/mob/living/carbon/human/species/roundstartslime`
- `modular_nova\modules\quirk_hydrophobia\hydrophobia.dm`
  - Adds unique quirk interaction when used by a slime

### Defines:

- `code/__HELPERS/~nova_helpers/is_helpers.dm`
  - `isroundstartslime()`, `isslimecore()`
- `code/__DEFINES/~nova_defines/traits/declarations.dm`
  - `TRAIT_SLIME_HYDROPHOBIA`
- `code/__DEFINES/~nova_defines/DNA.dm`
  - `SPECIES_SLIMESTART`
- `modular_nova\modules\species_slimeperson\code\signals_slime.dm`
  - `COMSIG_SLIME_CORE_EJECTED`, `COMSIG_SLIME_REVIVED`

### Credits:

- Nerev4r
- Absolucy
- Siro
- Hardly3D
