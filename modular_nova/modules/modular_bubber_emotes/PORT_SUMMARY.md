# Bubberstation Emotes Port - Summary

## What Was Done

Successfully ported emotes from Bubberstation to NovaSector in a modular fashion.

### Files Created

#### Code Files (`modular_nova/modules/modular_bubber_emotes/code/`)

1. **emotes.dm** - Main emote definitions (18 unique emotes)
2. **hand_items.dm** - Bonking hand item and emote
3. **scream_datums.dm** - Cat and slug scream datums
4. **synth_emotes.dm** - Synthetic species-only emotes (4 emotes)
5. **synth_deathgasp_datum.dm** - Deathgasp datum system (follows scream_datums.dm pattern)
6. **synth_deathgasp_preference.dm** - Character creation preference for synth deathgasp sound selection

#### Documentation

1. **readme.md** - Comprehensive module documentation
2. **PORT_SUMMARY.md** - This file

#### Sound Files (`modular_nova/modules/modular_bubber_emotes/sound/`)

- **voice/** - 20 voice/animal sound files
- **effects/** - 2 files (bonk sound + license)
- **synth_voice/** - 4 synthetic voice files
- **screams/** - 2 scream sound files

### Integration

- Added 6 include lines to `tgstation.dme` (lines 8530-8535)
- Created changelog entry in `html/changelogs/`
- Added character customization preference for synth deathgasp sounds
- Follows the same datum/preference pattern as character scream

## Ported Emotes

### Animal/Creature Sounds (18 emotes)

- `chirp` - Bird chirp
- `fpurr` - Fox purr
- `gecker` - Fox gecker
- `mar` - Shadekin sound
- `meow1` - Alternate meow
- `mrowl` - Cat mrowl
- `tailthump` - Tail thump (requires tail)
- `squeal` - Squeal sound
- `yip` - Single yip (3 variations)
- `yipyip` - Double yip
- `kweh` - Raptor/chocobo sound
- `skweh` - Sad raptor sound
- `xenogrowl` - Xeno growl
- `xenohiss` - Xeno hiss
- `schirp` - Stoat chirp
- `smoo` - Short moo
- `mah` - Deer bleat

### Interactive Emotes (1 emote)

- `bonk` - Ready a hand to bonk someone on the head

### Synthetic Emotes (4 emotes, synth species only)

- `scary` - Disconcerting tone
- `error` - System error
- `startup` - Boot-up chime
- `shutdown` - Shutdown tone

### Scream Types (2 datums)

- Cat scream
- Slug scream

### Character Customization

- **Synth Deathgasp Selection** - Synthetic species can select their preferred death sound in character creation
  - 9 options available (Hacked, Error, Scary, Shutdown, Startup, Generic Beep, Synth Yes, Synth No, None)
  - Positioned under "Character Scream" in character preferences
  - Only accessible when playing as a synthetic species

## Testing Recommendations

1. Test basic emotes in-game with `*chirp`, `*yip`, etc.
2. Test bonk emote - requires targeting head zone
3. Test synth emotes with synthetic species characters
4. Verify tail-dependent emotes (tailthump) work with tailed species
5. Check that sounds play correctly and at appropriate volumes
6. Test synth deathgasp selection in character creation (Vocals tab)
7. Verify different deathgasp sounds play when synth characters die

## Credits

- **Bubberstation Contributors** - Original implementation
- **Vorestation** - Mar sound
- **Splurt** - Slug scream
- **Shiptest** - Tailthump and squeal sounds

## Notes

- All files are modular and self-contained
- No modifications to base game files (except .dme includes)
- Sound files maintain original licensing where applicable
- Follows Nova's existing emote structure and conventions
