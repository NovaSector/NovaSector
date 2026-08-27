# Player Homes

A persistent, per-account residence. A player steps through the registry terminal in the cafe,
rearranges the rooms however they like, and commits them to their account's record from the console
inside. The record is a real `.dmm` written under their ckey, so it reloads identically next round
and every character on that account walks into the same rooms.

Condos are the disposable version of this and remain separate. Homes borrow their instancing and
their door, nothing else.

---

## Adding a new starter interior

Four steps, and only one of them is code.

### 1. Draw the map

Anything a condo map can do, a home map can do. Open a new map in StrongDMM and keep to these rules:

| Rule | Why |
|---|---|
| **40×40 tiles maximum** | `HOME_MAX_DIMENSION`. Bigger interiors are refused at load. |
| **Everything in `/area/misc/player_home`** | Loading forces the area anyway, but getting it right means what you see in the editor is what players get. |
| **The bottom-left turf must touch the rest of the interior and share its area** | Same constraint the condo templates carry. The loader stitches outward from that corner; if it is isolated, the template loads wrong. |
| **Exactly one `/turf/closed/indestructible/hoteldoor/fakedoor/player_home`** | This is the front door, and the only way out. Loading fits one automatically if your map has none, but it lands somewhere arbitrary and looks broken. |
| **Solid perimeter** | Reservations are cordoned, so nobody escapes either way, but a player who tunnels out of your map sees bare cordon tiles. |

You do **not** need to place `/obj/machinery/home_saver`. Loading fits one beside the front door if
the interior has none, and from the player's first save onward it persists wherever they moved it
to. Place one if you want to control where it starts.

The four `home_blank_*.dmm` plots are the smallest thing that satisfies all of the above — a wall
perimeter, plating, one door and one console — so they are the easiest map to copy and build on.

**Put at least one `/obj/machinery/light` in your interior.** `/area/misc/player_home` is
`static_lighting = TRUE`, so a room with no fixture in it is pitch dark, and the console's brightness
and bulb-colour controls have nothing to act on. The blank plots deliberately ship without one.

Save it into [`_maps/nova/persistent_housing/`](../../../_maps/nova/persistent_housing/) — **not**
into this module. A `mappath` map is read off disk at runtime rather than compiled into the `.dmb`,
and `tools/deploy.sh` only copies `_maps/` and the `.dmi` files out of `modular_nova/`. An interior
kept beside the code would not exist on a deployed server, and `write_starter()` would fail at its
`fexists()` check. Same reason `_maps/nova/holodeck_wargame.dmm` lives where it does.

### 2. Register it

Add a subtype to [`code/_home_defines.dm`](code/_home_defines.dm), alphabetically:

```dm
/datum/map_template/home/lighthouse
	name = "Home - Lighthouse"
	blurb = "Nine floors of stairs and one very good view."
	mappath = "_maps/nova/persistent_housing/home_lighthouse.dmm"
	landing_zone_x_offset = 4
	landing_zone_y_offset = 2
```

`landing_zone_*_offset` is where an arriving player is put down, as a **0-based offset from the
interior's bottom-left turf** — the same convention the condo templates use. `0, 0` is the corner
itself. Pick an open tile with room to stand; if you get it wrong the loader falls back to the
doorstep rather than dropping somebody inside a wall, but the fallback is not where you meant.

### 3. That is the whole of it

Nothing else needs touching. `SShomes.preload_starter_templates()` walks `subtypesof(/datum/map_template/home)`
at init and registers everything with a `mappath` set, and the terminal lists whatever it finds. No
`.dme` edit (the maps are data, not code), no UI change, no subsystem change.

The one thing that is not obvious: the interior has to live under `_maps/`, for the deployment reason
in step 1. Put it beside the code and everything works locally and nothing works on a server.

The one subtype deliberately skipped is `/datum/map_template/home/player_save`, which has no
compile-time `mappath` because it is built at runtime from a player's own file.

### 4. Check it

```
dm.exe -DCIBUILDING -DRUNNING_LOCAL_TESTS tgstation.dme
dreamdaemon tgstation.dmb -close -trusted -verbose -params "log-directory=ci"
```

`/datum/unit_test/player_home_round_trip` runs **every** registered starter through the full path:
file it to disk, load it back, confirm it has a door, a console and somewhere to stand, save it with
`write_map()`, and reparse what was written. A new interior that breaks any of that fails the test
by name. Add `TEST_FOCUS(/datum/unit_test/player_home_round_trip)` while iterating to skip the rest
of the suite — and take it back out before committing.

### Converting an existing condo interior

The three shipped starters were made this way. Copy the `.dmm` out of
`modular_nova/modules/condos/_maps/`, then substitute two type paths:

- `/area/misc/condo` → `/area/misc/player_home`
- `/turf/closed/indestructible/hoteldoor` and `/turf/closed/indestructible/hoteldoor/fakedoor` →
  `/turf/closed/indestructible/hoteldoor/fakedoor/player_home`

Reuse the condo template's landing offsets verbatim. Run the file through
`tools/mapmerge2` afterwards so it stays byte-identical to what map CI expects.

---

## Adding to the requisition catalogue

The console can call down a drop pod of materials or tools on a cooldown. The catalogue lives in
[`code/home_supply_catalogue.dm`](code/home_supply_catalogue.dm), which is pure data — the machinery
that ships it stays in `home_supply.dm` and never needs to know what is listed.

Add a line by adding a subtype **of the category parent it belongs to**;
`preload_supply_catalogue()` picks up everything with a `name` set, exactly like the starter
templates:

```dm
/datum/home_supply/structural/plastic
	name = "Plastic sheets"
	desc = "Cheap, and it shows."
	manifest = list(/obj/item/stack/sheet/plastic = 50)
```

The parents are `structural`, `organic` (timber and textiles), `flooring`, `appliances` (fixtures and
machines), `tools` and `restricted`. They carry the `category` string and a `category_order`, and have no `name` of their
own, which is exactly why the loader skips them. **Don't set `category` on a line** — put the line
under the right parent instead, so a category can be renamed or moved in one edit.

A new category is a new parent and nothing else:

```dm
/datum/home_supply/plumbing
	category = "Plumbing"
	category_order = 35     // between flooring (30) and fittings (40)
```

The console renders categories in the order it first meets them, so `category_order` is what decides
the layout; `sortTim()` in `preload_supply_catalogue()` is stable, so lines within a category stay in
type-path order.

Anything under `/datum/home_supply/restricted` is admin-gated by its parent — **file a line there
rather than setting `needs_approval` by hand**, so a line added by somebody who never read this
paragraph is still gated.

`manifest` is `path -> amount`. For a `/obj/item/stack` the amount is the **stack size** — one stack
of fifty, not fifty stacks. For anything else it is how many separate copies to send.

`needs_approval = TRUE` routes the request to the admins with APPROVE and DENY buttons in adminchat
instead of shipping it. If the player has stepped out by the time it is approved, the pod is held and
lands the next time they walk in. Approvals are round-scoped; they are not remembered across a
restart.

In practice almost nothing uses it. **Bluespace crystals and the autolathe are the only gated lines**
— everything else, refined alloys and the rapid-whatever devices included, ships straight away. That
is safe for the reason below, not because the list was picked carefully, so weigh a new line against
that reason rather than against how expensive it looks.

The autolathe is gated for a different reason than the crystals, and the distinction is the one that
matters when adding anything that **creates** items rather than moving them around: a delivered
machine is marked, but **what a machine builds is born unmarked** and walks out of the front door in
somebody's pocket. An autolathe fed the free plasteel from this catalogue is a laundry for it. The
cooking machines are fine on the same test — they only transform ingredients a player carried in
themselves, and the catalogue sells no food. Apply that test, not a price check.

Players can also send a **written request** for anything the catalogue does not carry. Those always
go to the admins, and since there is no manifest to ship, the approving admin is expected to hand the
goods over themselves.

Pods land **on the console the order was placed at**. Picking any unblocked open tile sounds fairer
and is much worse — "open and unblocked" includes tiles the player has since walled off from
themselves, so deliveries occasionally arrived somewhere they could not reach.

`PLAYER_HOME_SUPPLY_COOLDOWN` in config sets the wait between requests, in seconds (default 300).
The cooldown is spent on *filing*, not on delivery, so the approval queue cannot be spammed any more
than the free tier can.

### Why shipping almost everything freely is safe

**Everything a pod delivers is marked `TRAIT_HOME_FURNISHING`,** including the contents of a
delivered toolbox. Marked things cannot be carried out of a home, so a player can order plasteel
every five minutes forever without a single sheet reaching the round's economy — which is the whole
reason the catalogue needs almost no oversight. `/datum/unit_test/player_home_supply` asserts this for
a real delivery. If you add a delivery path that skips `mark_delivery()`, you have built a free
materials printer that empties into the station.

---

## Throwing things away

A home is sealed, so junk has nowhere to go — leftover sheets, packaging, whatever a guest dropped.
`/obj/structure/closet/crate/bin/home_compactor` is a trash bin that destroys its contents. Put things
in, **alt-click**, and after a short wait they are gone. It is orderable from the console under
Fittings, owner-gated like everything else, and unbolts with a right-click wrench so it can be moved.

**It refuses two things, at any depth:**

- **Anything alive.** Closets accept living mobs, so without this the bin is a murder box.
- **Anything `SShomes.is_round_critical()` returns TRUE for** — the same test `release_home()` uses to
  push gear back out to the terminal on unload. A home is deliberately not allowed to become a black
  hole for the round's objectives, and a bin that deleted the nuke disk would be exactly that with
  extra steps.

"At any depth" is the part worth not breaking. The check runs over `get_all_contents()` of each item
in the bin, so a nuke disk stuffed inside a backpack protects the backpack too — otherwise the bag is
a laundering route straight to the shredder. `/datum/unit_test/player_home_compactor` asserts the
bare case, the nested case, and the mob case.

Note that bins save empty: `SAVE_OBJECT_PROPERTIES` is off, so closet contents do not persist.

---

## Throwing things away

A home is sealed, so junk has nowhere to go — leftover sheets, packaging, whatever a guest dropped.
`/obj/structure/closet/crate/bin/home_compactor` is a trash bin that destroys its contents. Put things
in, **alt-click**, and after a short wait they are gone. It is orderable from the console under
Fittings, owner-gated like everything else, and unbolts with a right-click wrench so it can be moved.

**It refuses two things, at any depth:**

- **Anything alive.** Closets accept living mobs, so without this the bin is a murder box.
- **Anything `SShomes.is_round_critical()` returns TRUE for** — the same test `release_home()` uses to
  push gear back out to the terminal on unload. A home is deliberately not allowed to become a black
  hole for the round's objectives, and a bin that deleted the nuke disk would be exactly that with
  extra steps.

"At any depth" is the part worth not breaking. The check runs over `get_all_contents()` of each item
in the bin, so a nuke disk stuffed inside a backpack protects the backpack too — otherwise the bag is
a laundering route straight to the shredder. `/datum/unit_test/player_home_compactor` asserts the
bare case, the nested case, and the mob case.

Note that bins save empty: `SAVE_OBJECT_PROPERTIES` is off, so closet contents do not persist.

---

## Visiting

Entirely by knocking, and entirely one-time. The terminal lists everyone online who has a home; you
knock, they get a prompt, and if they say yes you are shown straight in. Nothing is remembered —
step back out for any reason and you knock again.

There is deliberately **no guest list and nothing written to disk**. A standing list is a thing
owners have to police, and it lets somebody wander your rooms on the strength of a yes you gave three
rounds ago. A knock costs one click and is always about right now.

An owner who does not want callers can switch **Callers** off under Fittings on their console. That
takes them off the terminal's door list entirely — nobody can knock, and the refusal is indistinguishable
from their being out, so a stale window is not a way to tell "away" from "in, and ignoring you". Guests
already inside are left where they are; this only refuses new callers.

Unlike the lighting and gravity, it is **not** written to the sidecar. It lives on the loaded instance
and lasts only as long as the home is standing — walk out and back in and the door answers again. A
"do not disturb" left set from three rounds ago is a door nobody can knock at for reasons its owner no
longer remembers.

The host has to be **online and in their own home**. You cannot knock at an empty house: admission is
one-time and granted in the moment, so a host answering from the far side of the station would be
letting somebody into rooms they are not in — which is the standing-access model this deliberately
is not. A guest therefore never causes a home to load; they only ever join one already standing.

Two things worth not breaking:

- **Admission is not an action a client can ask for.** `ui_act` exposes `knock` and nothing else;
  `admit_visitor()` is only reachable from `ask_host()`, on the far side of the owner agreeing. If
  you ever wire it to an action, anyone can walk into anyone's house.
- **Hosts are identified to the client by mob ref, never by ckey.** A player should not learn who is
  behind a character from a door list. `host_ckey_from_ref()` resolves it back server-side.

Guests need no special handling once inside — the closed economy already stops them carrying a host's
furnishings out, and `is_owner()` already gates the console, so they cannot save the house, relight
it, unbolt anything, or file requisitions against it.

---

## How the pieces fit

| File | Job |
|---|---|
| `_home_defines.dm` | Defines, config entries, the reservation type, and the starter template list |
| `home_subsystem.dm` | Template registry, loaded homes, the blacklists, the sidecar |
| `home_persistence.dm` | Filing a new home, parse → reserve → load → force area → self-heal → mark contents, and `write_map()` with verify-before-commit and backup rotation |
| `home_instance.dm` | One loaded home: the closed-economy strip, the room settings, and its area |
| `home_door.dm` | The front door, and taking it down to hang it elsewhere |
| `home_terminal.dm` | The cafe pad, and knocking at somebody else's door |
| `home_console.dm` | The console inside: saving, settings, requisitions |
| `home_supply.dm` | Filing a requisition, drop pods, and the admin approval queue |
| `home_supply_catalogue.dm` | What the console will call down: the category parents and every line |
| `home_preview.dm` | Flattens a loaded home into the picture the terminal shows |
| `home_admin.dm` | Inspect, download, restore, wipe, audit |

### The two invariants worth knowing before you change anything

**Everything a save file spawns is marked `TRAIT_HOME_FURNISHING` on load, and the front door takes
back exactly what carries that mark.** This is the entire anti-duplication scheme. An item can only
be duplicated by being saved, and anything saved comes back marked, so a duplicate can never reach
the round. A player's own belongings are unmarked and come and go freely. If you add a way for
things to leave a home, it has to respect that mark.

**`/area/misc/player_home` is deliberately not `UNIQUE_AREA`.** Only unique areas register in
`GLOB.areas_by_type`, and the map loader reuses a registered area instead of making a new one — so
that flag staying `NONE` is what gives every simultaneously-loaded home its own area. Setting it
would silently merge every player's home into one area.

### On-disk layout

```
data/player_saves/[c]/[ckey]/homes/
    home.dmm            current record
    home_backup.dmm     the save before it — restore, and admin recovery
    home.json           landing spot, lighting, gravity, last-saved, object count
    home_preview.png    the picture the terminal shows
```

Settings live in the sidecar rather than the map file on purpose: they describe the residence rather
than anything standing in it, so changing one costs nothing and never risks the record.

### Admin tools

Under **Debug → Player Homes**: inspect, download as `.dmm`, restore a backup, wipe, and an audit
that walks the save tree and reports every stored home with its last save date — disk is the running
cost of this feature and nothing else on the server will tell you what it is being spent on.

`PLAYER_HOMES_ENABLED 0` in config takes the terminal offline without touching anyone's saves.
