## Title: Paperwork

MODULE ID: PAPERWORK

### Description

Adds modular photocopier paper templates for Nova Sector.
The photocopier now loads upstream templates from `config/blanks.json` and merges/overrides them with module templates from `modular_nova/modules/paperwork/config/blanks.json`.

### What changed

- Added `NOVA_BLANKS_FILE_NAME` define in `code/modules/paperwork/photocopier.dm`.
- Modified `init_paper_blanks()` to load and merge two JSON sources:
  - Upstream: `config/blanks.json`
  - Nova module: `modular_nova/modules/paperwork/config/blanks.json`
- Merge policy: Nova module entries override upstream entries.

### Files added / edited

- Edited: `code/modules/paperwork/photocopier.dm` — added modular blanks support and merge logic.
- Added (module): `modular_nova/modules/paperwork/config/blanks.json` Modular file for putting Nova photocopier templates.
