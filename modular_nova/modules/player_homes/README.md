# Player Homes

Persistent per-account housing. A player enters through the registry terminal in the cafe, rearranges
the rooms, and saves from the console inside. The save is a real `.dmm` under their ckey, so it
reloads next round and every character on the account shares it.

Homes load into a turf reservation on demand and unload once the last minded occupant leaves. Nothing
is ever saved automatically. Saving is always an explicit press of the console.

## Files

| File                       | Job                                                                 |
| -------------------------- | ------------------------------------------------------------------- |
| `_home_defines.dm`         | Defines, config entries, reservation type, starter template list    |
| `home_subsystem.dm`        | `SShomes`: template registry, active homes, blacklists, sidecar I/O |
| `home_persistence.dm`      | Filing, loading, `write_map()` saving, backups                      |
| `home_instance.dm`         | One loaded home, its area, room settings, the closed-economy strip  |
| `home_door.dm`             | Front door turf and its flat-pack                                   |
| `home_terminal.dm`         | Cafe pad; knocking to visit                                         |
| `home_console.dm`          | Console inside: save, settings, requisitions; the waste compactor   |
| `home_supply.dm`           | Requisition filing, drop pods, admin approval queue                 |
| `home_supply_catalogue.dm` | Pure data: what the console can call down                           |
| `home_preview.dm`          | Renders the terminal's preview picture at save time                 |
| `home_decals.dm`           | Makes turf decals survive a save (they're elements, not objects)    |

Starter templates: `_maps/nova/persistent_housing/`
UI: `tgui/packages/tgui/interfaces/` (`PlayerHome.tsx`, `HomeConsole.tsx`)
Unit tests: `code/modules/unit_tests/~nova/player_homes.dm`.

## Important to Know

**Everything a save spawns is marked `TRAIT_HOME_FURNISHING`, and the door takes back exactly what
carries that mark.** That is the whole anti-duplication scheme. Any new way for items to enter or
leave a home must respect this.

**`/area/misc/player_home` is deliberately not `UNIQUE_AREA`.** The map loader reuses areas
registered in `GLOB.areas_by_type`; leaving the flag `NONE` is what gives each loaded home its own
area instance.

## On disk

```
data/player_saves/[c]/[ckey]/homes/
    home.dmm            current record
    home_backup.dmm     previous save
    home.json           landing offset, lighting, gravity, last-saved, object count
    home_preview.png    terminal preview
```

Room settings live in the sidecar json, not the map, so changing one never touches the record.

## Adding a starter interior

1. Draw the `.dmm` into `_maps/nova/persistent_housing/` — not into this module, since `mappath` maps
   are read off disk at runtime and only `_maps/` is deployed. Max 40×40. Everything in
   `/area/misc/player_home`. Exactly one `/turf/closed/indestructible/hoteldoor/fakedoor/player_home`.
   The bottom-left turf must touch the rest of the interior and share its area. Include at least one
   `/obj/machinery/light` — the area uses static lighting. Copy a `home_blank_*.dmm` to start.
2. Add a subtype in `code/_home_defines.dm` with `name`, `blurb`, `mappath`, and
   `landing_zone_x/y_offset` (0-based offset from the bottom-left turf).

## Adding a catalogue line

Subtype the category parent in `code/home_supply_catalogue.dm` and set `name`, `desc`, `manifest`
Don't set `category` on a line, that lives on the parent, along with `category_order` (the console's layout order).
Anything under`/datum/home_supply/restricted` is admin-gated.

Shipping most things freely is safe only because deliveries are marked.
Be careful about shipping machines that can create other things (like autolathes) since
things that get produced don't have the `TRAIT_HOME_FURNISHING` flag.

## Config

```
PLAYER_HOMES_ENABLED 0          # takes the terminal offline, saves untouched
PLAYER_HOME_SUPPLY_COOLDOWN 30  # seconds between requisitions
```

## Admin

**Debug → Player Homes**: inspect, download as `.dmm`, restore backup, wipe, and audit the save tree.
Pending requisitions get APPROVE/DENY links in adminchat.
