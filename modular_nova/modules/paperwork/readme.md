## Title: Paperwork

MODULE ID: PAPERWORK

### Description

Adds modular photocopier paper templates for Nova Sector without forcing contributors to add temapltes to the upstream configuration file.
The module hooks into the photocopier's GLOBAL Init process to seamlessly inject custom Nova templates from `modular_nova/modules/paperwork/config/blanks.json` into the global `paper_blanks` list on server boot.

Templates from the Modular `blanks.json` will merge/overwrite the ones in the core `blanks.json`, avoiding merge conflicts if upstream updates the core config file `blanks.json`..

### What changed

- **Core Initialization Edit:** Modified the global `paper_blanks` list initialization in the core upstream file to call our custom `init_paper_blanks_nova()` proc along the upstream one.
- **Boot-Time Merging:** The new proc automatically calls the vanilla `init_paper_blanks()` first to load all standard upstream templates, then parses and merges/overwrittes the custom Nova templates over them before the round even starts.
- **Safe Fallback:** Built-in safeguards ensure that if the Nova module file is missing, corrupted, or empty, the system gracefully falls back to the vanilla upstream templates without throwing runtime errors.

### Files added / edited

- **Edited (Core Upstream):** `code/modules/paperwork/photocopier.dm` - Altered the `GLOBAL_LIST_INIT` to point to our custom Nova initialization proc.
- **Added (Module Code):** `modular_nova/modules/paperwork/photocopier.dm` - Contains the `init_paper_blanks_nova()` global proc definition and its JSON merging logic.
- **Added (Module Config):** `modular_nova/modules/paperwork/config/blanks.json` - The dedicated modular JSON file for defining Nova-specific photocopier templates.
