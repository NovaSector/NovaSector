https://github.com/NovaSector/NovaSector/pull/<!--PR Number-->

## Hippocrates - Medicine Overhaul

Module ID: MEDICINE_HIPPOCRATES

### Description:

Two linked changes to medicine, both behind a single config flag (`MEDICINE_HIPPOCRATES` in
`config/nova/config_nova.txt`, off by default). With the flag off, every part of this module is inert
and medicine behaves exactly as it does upstream.

#### 1. Liver load

Every medicine can declare a `liver_load` and the `liver_load_flags` (categories) it feeds. Medicines
that treat the same kind of damage pile their load into the same pool, and once a pool goes past
`LIVER_LOAD_FREE_LOAD` every medicine drinking from it heals less:

```
efficiency = 1 / sqrt(combined load)
```

Two full-load brute chems therefore each work at ~71%, so the pair still beats one chem alone but
falls well short of doubling it 1+1 < 2, and 1+1 > 1.

Combat chems, cryo/bed-bound chems (cryoxadone, strange reagent) and pure utility chems are
deliberately left at zero load.

#### 2. Sutures and meshes

Sutures and meshes no longer dump their whole heal into a limb the moment they're applied. They leave
the limb _mending_ instead.

Reapplying refreshes the limb's timer (and upgrades its rate, if the new dressing is better) rather
than stacking a second dose, so you can't burst a fight's worth of damage off in a few clicks. Bleed control and burn wound treatment are untouched, so
they still work as normal for treating wounds.

### TG Proc/File Changes:

- N/A

### Modular Overrides:

The following are overridden from within this module rather than `master_files`, because they only
exist to serve this module and are meaningless without it:

- `/datum/reagent/medicine`: `proc/compute_metabolization`, `proc/metabolize_reagent` — the healing
  hook. `compute_metabolization()` decides both how much reagent burns this tick and the
  `metabolization_ratio` every medicine scales its healing by, so scaling its result is all it takes
  to make a medicine do less per tick; `metabolize_reagent()` then restores the full amount for the
  actual consumption.
- `/obj/item/stack/medical`: `proc/heal_carbon`, `proc/try_heal_checks` — hands healing to the
  mending status effect and stops the repeat loop from emptying a stack into one limb.
- `/obj/item/stack/medical/suture/bloody`, `/obj/item/stack/medical/mesh/bloody`:
  `proc/post_heal_effects` — these live in `modular_nova/modules/food_replicator` and derive their
  oxyloss top-up from how much they just healed, which mending zeroes out, so they read their nominal
  heal value instead.

### Defines:

- `code/__DEFINES/~nova_defines/medicine_hippocrates.dm`: `LIVER_LOAD_BRUTE`, `LIVER_LOAD_BURN`,
  `LIVER_LOAD_TOXIN`, `LIVER_LOAD_OXYGEN`, `LIVER_LOAD_ALL`, `LIVER_LOAD_FREE_LOAD`,
  `LIVER_LOAD_MIN_EFFICIENCY`, `LIVER_LOAD_STRAIN_LOAD`, `LIVER_LOAD_STRAIN_DURATION`,
  `LIVER_LOAD_NO_LIVER_QUALITY`, `LIVER_LOAD_MIN_LIVER_QUALITY`

### Included files that are not contained in this module:

- `config/nova/config_nova.txt`: added the `MEDICINE_HIPPOCRATES` flag entry.

### Balancing notes for future tuning:

Everything worth tuning lives in one of two places. The curve, thresholds and floors are all defines
in `code/__DEFINES/~nova_defines/medicine_hippocrates.dm`; which chems carry how much load, and in which
pool, is a flat list in `code/liver_load_reagents.dm`. Suture and mesh rates are the
`mending_brute_rate` / `mending_burn_rate` / `mending_duration` vars in `code/mending_stacks.dm`.

### Credits:

@Happyowl93
