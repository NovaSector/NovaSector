https://github.com/NovaSector/NovaSector/pull/4531

## Title: All the emotes.

MODULE ID: species_synthesizer

### Description:

Adds an action to Synthetic and Ethereal species that allows them to synthesize music.

- Added to `modular_nova/modules/synths/code/species/synthetic.dm`:
  - Edited `/datum/species/synthetic/on_species_gain()` to add the action to the mob.

### Master File Additions

- Added to `modular_nova/master_files/code/modules/mob/living/carbon/human/species_type/ethereal.dm`:
  - Overrode `/datum/species/ethereal/on_species_gain()` to add the action to the mob.

### Credits:
- [@Floofies](https://github.com/Floofies)
