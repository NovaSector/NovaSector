- https://github.com/NovaSector/NovaSector/pull/4529
- https://github.com/NovaSector/NovaSector/pull/5407
- https://github.com/NovaSector/NovaSector/pull/5428
- https://github.com/NovaSector/NovaSector/pull/6583

## Title: Voice Actor Quirk

MODULE ID: VOICE_ACTOR_QUIRK

### Description:

Adds a quirk and action which allows swapping to a second chat color, TTS voice, and vocal bark / blooper.

### Master File Additions

- Created `modular_nova/master_files/code/modules/client/preferences/middleware/tts.dm`:
  - Overrode `/datum/preference_middleware/tts/New()` .
  - Added `/datum/preference_middleware/tts/proc/play_second_voice()`

### Included files that are not contained in this module:

- `tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/character_preferences/nova/voice_actor.tsx`

### Credits:

- [@Floofies](https://github.com/Floofies)
