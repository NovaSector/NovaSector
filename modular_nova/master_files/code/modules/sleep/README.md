https://github.com/NovaSector/NovaSector/4525

## Title: Enhanced Mob Sleep

MODULE ID: sleep

### Description:

Overrides the sleep verb and some associated code chunks to implement enhancesments to sleeping.

### TG Proc Changes:

- Edited `code/modules/admin/verbs/debug.dm`:
  - Added signal `COMSIG_MOB_GIVE_DIRECT_CONTROL` to `/datum/admin_verb/cmd_give_direct_control()`.
- Edited `code/modules/mob/living\living.dm`:
  - Commented out `/mob/living/proc/mob_sleep()`.
  - Edited `/mob/living/can_resist()`:
    - Added a conditional to allow resisting if the sleep verb was used.
  - Edited `/mob/living/proc/execute_resist()`:
    - Added conditional to allow resisting to wake up from sleep.
- Edited `code/datums/status_effects/_status_effect.dm`:
  - Edited `/datum/status_effect/process()`:
    - Added conditional to allow for handling new variable `pause_expiry` and pausing status effect expiration.
  - Edited `/datum/status_effect/proc/remove_duration()`:
    - Added conditional to allow for handling new variable `pause_expiry` and pausing status effect expiration.
- Edited `code/modules/mob/living/status_procs.dm`:
  - Edited `/mob/living/proc/Sleeping()`:
    - Added argument `is_voluntary` to differentiate voluntary and involuntary sleeping.
- Edited `code/modules/surgery/organs/internal/stomach/_stomach.dm`:
  - Edited `/obj/item/organ/internal/stomach/proc/handle_hunger()`:
    - Added conditional to reduce hunger rate by 50% when lying down or sleeping.

### Defines:

- Edited `code/__DEFINES/~nova_defines/signals.dm`:
  - Added `COMSIG_MOB_GIVE_DIRECT_CONTROL`, emitted by `/datum/admin_verb/cmd_give_direct_control()`.

### Master file additions

- Created `master_files/code/modules/sleep/code/mob/living/living.dm`
  - Added proc `/mob/living/proc/mob_sleep()`, replaces proc definition in `code\modules\mob\living\living.dm`.
- Created `master_files/code/modules/sleep/code/datums/status_effects/_status_effect_.dm`
  - Added variable `pause_expiry` to allow pausing of status effect expiration.
  - Added procs `enable_expiry()` and `disable_expiry()` for signal handlers.
- Created `master_files/code/modules/sleep/code/datums/status_effects/debuffs/debuffs.dm`
  - Added variable `voluntary` to differentiate between voluntary sleep (sleep verb) and involuntary sleep.
  - Added `/atom/movable/screen/alert/status_effect/asleep/proc/Click()` to allow waking up from voluntary sleep.
  - Overrode `/datum/status_effect/incapacitating/sleeping/on_apply()`
    - Registers signals for setting `pause_expiry` upon mob login/logout, being ghostized, and when given control.
  - Overrode `/datum/status_effect/incapacitating/sleeping/on_remove()`
    - Handles unregistering signals for setting `pause_expiry`
  - Overrode `/datum/status_effect/incapacitating/sleeping/proc/on_creation()`:
    - Handles new argument `is_voluntary`.
    - Automatically hides sleep duration in the screen alert if it's infinite.

### Included files that are not contained in this module:

- N/A

### Credits:

- [@Floofies](https://github.com/Floofies)
