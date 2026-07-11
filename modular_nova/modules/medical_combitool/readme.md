# Medical Combitool

This module adds the medical combitool and related items to NovaSector.

## What's included

### Medical Combitool

- **Medical Combitool** (`/obj/item/blood_filter/advanced`): A combination tool that can switch between functioning as a bonesetter or blood filter. Alt-click to toggle between modes. Can be researched and built at the protolathe.

### Alien Medical Tools

- **Alien Bonesetter** (`/obj/item/bonesetter/alien`): A reverse-engineered bonesetter with improved speed (0.25x) that can treat severe and critical bone fractures more effectively than standard bonesetters.
- **Alien Bloodfilter** (`/obj/item/blood_filter/alien`): A reverse-engineered blood filter with improved speed (0.25x).

## Research

All items are available through research:

- **Medical Combitool**: Available in the Advanced Surgery Tools tech node
- **Alien Medical Tools**: Available in the Alien Surgery tech node

## Ported from

Originally from Bubberstation's `modular_skyrat/modules/filtersandsetters`

## Features

- The medical combitool provides both bonesetter and blood filter functionality in a single tool
- Can be transformed between modes using attack_self_secondary (alt-click) or ctrl-click for cyborgs
- The alien variants provide faster surgery speeds at the cost of more expensive materials
- Alien bonesetter can treat severe and critical bone fractures that normal bonesetters cannot handle

## Integration

### Cargo Imports

The medical combitool is available through **DeForest Medical** company imports:

- **Medical Combitool**: 9 command paychecks

### Cyborg Upgrades

The **Advanced Surgery Tools** upgrade for medical cyborgs now includes:

- Replaces the two surgical omnitools and regular blood filter with the medical combitool
- Also includes advanced scalpel, retractor, and cautery
- Provides advanced health analyzer
- Available through the mechfab after research
