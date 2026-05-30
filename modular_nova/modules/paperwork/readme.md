## Title: Paperwork

MODULE ID: PAPERWORK

### Description

Adds modular photocopier paper templates for Nova Sector without modifying core files.
The module hooks into the photocopier's UI data generation process to seamlessly inject custom Nova templates from `modular_nova/modules/paperwork/config/blanks.json` into the global `paper_blanks` list on first interaction.
Templates from the Modular `blanks.json` will merge/overwrite the ones in the core `blanks.json`, avoiding merge conflicts if upstream updates the core `blanks.json`

### Files added / edited

- **Added (Module Code):** `modular_nova/modules/paperwork/photocopier.dm` - Contains the object proc override and associative data injection logic.
- **Added (Module Config):** `modular_nova/modules/paperwork/config/blanks.json` - The dedicated modular JSON file for defining Nova-specific photocopier templates.
