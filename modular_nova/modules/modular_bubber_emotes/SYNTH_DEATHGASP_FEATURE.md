# ✅ Synthetic Deathgasp Selection Feature - COMPLETE

## Feature Overview

Added a character creation preference that allows synthetic species to select their deathgasp sound from a variety of options. The preference is positioned under "Character Scream" in the character customization menu.

## Implementation Details

### New Files Created

**1. `synth_deathgasp_datum.dm`**

- Contains `/datum/deathgasp_type` - Base deathgasp datum
- Defines 9 deathgasp type subtypes (Hacked, Error, Scary, etc.)
- Initializes `GLOB.synth_deathgasp_types` - Global list of available deathgasps
- Follows the same pattern as `scream_datums.dm`

**2. `synth_deathgasp_preference.dm`**

- Contains `/datum/preference/choiced/synth_deathgasp` - The preference datum
- Uses `assoc_to_keys(GLOB.synth_deathgasp_types)` for options
- Follows the same pattern as `/datum/preference/choiced/scream`

### How It Works

1. **Accessibility**: Only shows for synthetic species characters
2. **Location**: Found in the "Vocals" category of character preferences
3. **Integration**: Applies the selected death sound to the character on spawn

### Available Options

The preference offers 9 different death sounds:

| Option               | Sound File                                                                        | Description                |
| -------------------- | --------------------------------------------------------------------------------- | -------------------------- |
| **Hacked** (default) | `modular_nova/master_files/sound/effects/hacked.ogg`                              | Standard synth death sound |
| **Error**            | `modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_error.ogg`    | System error sound         |
| **Scary**            | `modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_scary.ogg`    | Disconcerting tone         |
| **Shutdown**         | `modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_shutdown.ogg` | Nostalgic shutdown tone    |
| **Startup**          | `modular_nova/modules/modular_bubber_emotes/sound/synth_voice/synth_startup.ogg`  | Boot chime (ironic!)       |
| **Generic Beep**     | `sound/machines/beep/twobeep_high.ogg`                                            | Simple two-tone beep       |
| **Synth Yes**        | `modular_nova/modules/emotes/sound/emotes/synth_yes.ogg`                          | Affirmative tone           |
| **Synth No**         | `modular_nova/modules/emotes/sound/emotes/synth_no.ogg`                           | Negative tone              |
| **None**             | null                                                                              | No death sound             |

## Code Structure

### Datum System (synth_deathgasp_datum.dm)

```dm
GLOBAL_LIST_INIT(synth_deathgasp_types, init_synth_deathgasp_types())

/datum/deathgasp_type
    var/name
    var/sound_path

// Subtypes: hacked, error, scary, shutdown, startup, generic_beep, synth_yes, synth_no, none
```

### Preference System (synth_deathgasp_preference.dm)

```dm
/datum/preference/choiced/synth_deathgasp
    category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
    savefile_identifier = PREFERENCE_CHARACTER
    savefile_key = "synth_deathgasp"

    // Only accessible for synthetic species
    is_accessible(datum/preferences/preferences)

    // Returns list from global datum list
    init_possible_values() -> assoc_to_keys(GLOB.synth_deathgasp_types)

    // Applies chosen sound to character
    apply_to_human(mob/living/carbon/human/target, value)
```

## User Experience

### In Character Creation:

1. Player selects **Synthetic** species
2. Character customization menu opens
3. New option appears under "Character Scream": **"Synth Deathgasp"**
4. Dropdown shows 9 options
5. Selection is saved to character profile

### In Game:

When the synthetic character dies:

- The selected deathgasp sound plays
- If "None" was selected, no sound plays
- Default is "Hacked" if not configured

## Testing Checklist

- [ ] Create a synthetic character
- [ ] Check that "Deathgasp Sound" appears in Vocals tab
- [ ] Select each sound option and test
- [ ] Verify the selection saves across sessions
- [ ] Test that different sounds play on death
- [ ] Verify non-synth species don't see the option

## Integration

- ✅ Added to `tgstation.dme` on line 8185
- ✅ Documentation updated in all readme files
- ✅ Changelog entry created
- ✅ No linter errors
- ✅ Follows Nova preference system conventions

## Future Expansion Possibilities

- Could add more death sounds as they become available
- Could extend to other synthetic/robotic species
- Could add pitch/volume customization options

---

**Feature Status**: COMPLETE and ready for testing!
