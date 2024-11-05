https://github.com/NovaSector/NovaSector/WaitForIt

## Title: Timed Sleep

MODULE ID: timed_sleep

### Description:

Overrides the sleep verb and some associated code chunks to implement player-timed sleep, and to account for whether or not sleeping was voluntary.

### TG Proc Changes:

- `code/datums/status_effects/_status_effect.dm`: Edited `/datum/status_effect/process()` and `/datum/status_effect/proc/remove_duration()` to account for `pause_expiry`.
- `/mob/living/mob_sleep()`: Overridden here in `living.dm`.
- `/datum/status_effect/incapacitating/sleeping/on_creation()`: Overridden here in `debuffs.dm`
- `/mob/living/can_resist()`: Added a conditional to allow resisting if the sleep verb was used.
- `/mob/living/proc/execute_resist()`: Added conditional to allow resisting to wake up from timed sleep.
- `/mob/living/proc/SetSleeping()`: Added argument `is_voluntary`.
- `/mob/living/proc/PermaSleeping()`:
  - Added var `is_voluntary` to differentiate sleep verb usage from blackouts.
  - Hides sleep duration if permanent.

### Defines:

- N/A

### Master file additions

- `master_files/code/modules/timed_sleep/code/mob/living/living.dm`
  - Replacement implementation for `/mob/living/mob_sleep()`.
- `master_files/code/modules/timed_sleep/code/datums/status_effects/_status_effect_.dm`
  - Added variable `pause_expiry` to allow pausing of status effect expiration.
- `master_files/code/modules/timed_sleep/code/datums/status_effects/debuffs/debuffs.dm`
  - Added variable `voluntary` to differentiate between sleep verb usage and blacking out.

### Included files that are not contained in this module:

- N/A


### Credits:
- [@Floofies](https://github.com/Floofies)
