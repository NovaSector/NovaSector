## Signboards

Module ID: SIGNBOARDS

### Description:

Adds signboards!

### TG Proc/File Changes:

- `code/modules/unit_tests/unit_test.dm`
  - `/datum/unit_test/proc/build_list_of_uncreatables`
- `code/datums/components/seethrough.dm`
  - new var: `var/use_parent_turf`
  - `/datum/component/seethrough/Initialize` (new args: `use_parent_turf`, `movement_source`)
  - `/datum/component/seethrough/proc/setup_perimeter`

### Modular Overrides:

- N/A

### Defines:

- `code/__DEFINES/~~oculis_defines/logging.dm`: `INVESTIGATE_SIGNBOARD`

### Included files that are not contained in this module:

- N/A

### Credits:

Absolucy
ancient-engineer (sprites)
