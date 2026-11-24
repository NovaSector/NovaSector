## Emergency Energy Node

Module ID: EMERGENCY_POWER_NODE

### Description:

Adds a drop-in generator for shifts with nobody available to run the engine.

A living player uses the `Request Emergency Power` verb in the IC tab. Admins get Approve and Deny links. If nobody responds within two minutes, the node launches automatically. A denial blocks new requests for ten minutes.

Requests are refused above 10 active, living, human players. Each map needs a drop site in `GLOB.emergency_node_drop_sites`, on a tile with a cable on the station's main grid.

### TG Proc/File Changes:

- N/A

### Modular Overrides:

- N/A

### Defines:

- `code/emergency_power_node.dm`: `EMERGENCY_NODE_APPROVAL_TIME`, `EMERGENCY_NODE_DENIAL_COOLDOWN`, `EMERGENCY_NODE_MAX_ACTIVE_PLAYERS`, `EMERGENCY_NODE_POD_TRANSIT_TIME`, `EMERGENCY_NODE_STATE_IDLE`, `EMERGENCY_NODE_STATE_PENDING`, `EMERGENCY_NODE_STATE_DEPLOYED`

### Included files that are not contained in this module:

- `modular_nova/modules/colony_fabricator`: `/obj/item/flatpacked_machine`, its `rtg_packed` icon, and `/datum/element/repackable`

### Credits:

- sqn
