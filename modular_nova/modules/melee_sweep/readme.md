## Melee Sweep Attack

Module ID: MELEE_SWEEP

### Description:

Adds a sweep mechanic to melee weapons. Instead of requiring a precise click on a mob,
melee attacks now hit all mobs in a 3-tile arc in front of the attacker, centered on the
direction toward the click target. Side targets take 70% damage.

Only activates when:

- The user is in combat mode
- The weapon has force > 0
- The weapon has reach == 1 (melee range only)

### TG Proc/File Changes:

None. Fully modular via component and signal hooks.

### Modular Overrides:

- `obj/item/claymore/Initialize` - Adds sweep component
- `obj/item/katana/Initialize` - Adds sweep component
- `obj/item/chainsaw/Initialize` - Adds sweep component
- `obj/item/dualsaber/Initialize` - Adds sweep component
- `obj/item/soulscythe/Initialize` - Adds sweep component

### Defines:

None.

### Included files that are not contained in this module:

None.

### Credits:

NovaSector contributors
