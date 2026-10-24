## Title: Shift-Start Department Emergency Access

MODULE ID: SHIFT_START_EMERGENCY_ACCESS

### Description:

Gives departments a grace period at the start of a shift to fill their jobs. After the delay, the system finds station airlocks whose access requirements match an unstaffed department, announces the affected departments, and enables emergency access on those airlocks. When a player later spawns into a department, the system revokes emergency access from airlocks it enabled for that department. Airlocks already in emergency mode before the system's scan are left unchanged.

Engineering, Medical, Science, Cargo, and Service are included. Command and Security are excluded. Matching uses required access flags rather than area location. Unrestricted doors, doors with command access, and doors with `ACCESS_MAINT_TUNNELS` in `req_one_access` are ignored. Maintenance access in `req_access` does not by itself exclude a door.

### TG Proc/File Changes:

- N/A

### Modular Overrides:

- N/A

### Defines:

- N/A

### Master file additions:

- `tgstation.dme` includes this module's source file.

### Included files that are not contained in this module:

- N/A

### Credits:

- Richard Blonski
