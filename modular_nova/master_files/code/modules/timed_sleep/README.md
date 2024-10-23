https://github.com/NovaSector/NovaSector/WaitForIt

## Title: Timed Sleep

MODULE ID: timed_sleep

### Description:

Overrides the sleep verb and some associated code chunks to implement player-timed sleep, and to account for whether or not sleeping was voluntary.

### TG Proc Changes:

- `/mob/living/mob_sleep()`: Overridden in `modular_nova/master_files/code/modules/timed_sleep/code/mob/living/living.dm`.
- `/datum/status_effect/incapacitating/sleeping/on_creation()`: Overridden in `master_files/code/modules/timed_sleep/code/datums/status_effects/debuffs/debuffs.dm`
- `/mob/living/can_resist()`: Added a conditional to allow resisting if the sleep verb was used.
- `/mob/living/proc/execute_resist()`: Added conditional to allow resisting to wake up from timed sleep.
- `/mob/living/proc/SetSleeping()`: Added var `is_voluntary` to differentiate sleep verb usage from blackouts.
- `/mob/living/proc/PermaSleeping()`:
  - Added var `is_voluntary` to differentiate sleep verb usage from blackouts.
  - Hides sleep duration if permanent.

### Defines:

- N/A

### Master file additions

- `master_files/code/modules/timed_sleep/code/mob/living/living.dm`
- `master_files/code/modules/timed_sleep/code/datums/status_effects/debuffs/debuffs.dm`

### Included files that are not contained in this module:

- N/A


### Credits:
- [@Floofies](https://github.com/Floofies)
