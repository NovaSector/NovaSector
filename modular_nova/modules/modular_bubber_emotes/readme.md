# Bubberstation Emotes Port

## Title: Emotes from Bubberstation

MODULE ID: MODULAR_BUBBER_EMOTES

### Description:

This module ports various emotes from Bubberstation to NovaSector. These emotes add additional expressiveness and variety to player interactions, including species-specific sounds, synthetic emotes, and interactive emotes like bonking.

### Ported Emotes:

#### Animal/Creature Sounds:

- **chirp** - Bird chirp sound
- **fpurr** - Fox purr sound
- **gecker** - Fox gecker sound
- **mar** - Shadekin-style sound (credit to Vorestation)
- **meow1** - Alternate meow sound
- **mrowl** - Cat mrowl
- **tailthump** - Tail thump (requires tail organ)
- **squeal** - Squeal sound
- **yip** - Single yip (random from 3 variations)
- **yipyip** - Double yip
- **kweh** - Raptor/chocobo sound
- **skweh** - Sad raptor sound
- **xenogrowl** - Unnerving xenomorph-style growl
- **xenohiss** - Unnerving xenomorph-style hiss
- **schirp** (stoatchirp) - Stoat chirp sound
- **smoo** (shortmoo) - Quick moo
- **mah** (deermah) - Deer bleat

#### Synthetic Emotes (Synth species only):

- **scary** - Disconcerting tone
- **error** - System error sound
- **startup** - Boot-up chime
- **shutdown** - Shutdown tone

#### Interactive Emotes:

- **bonk** - Ready a hand to bonk someone on the head (requires aiming at head zone)

#### Scream Types:

- Cat scream datum
- Slug scream datum

#### Character Customization:

- **Synthetic Deathgasp Selection** - Synth species can select their death sound in character creation, positioned under "Character Scream"

### Sound Files:

All sound files are located in `modular_nova/modules/modular_bubber_emotes/sound/`:

- `voice/` - Voice and animal sounds
- `synth_voice/` - Synthetic emote sounds
- `effects/` - Effect sounds (bonk)
- `screams/` - Scream sound files

### Deathgasp Sound Options for Synths:

Synthetic species can select from the following deathgasp sounds in character creation (positioned under "Character Scream"):

- **Hacked** (default) - The standard synth death sound
- **Error** - System error sound
- **Scary** - Disconcerting tone
- **Shutdown** - Nostalgic shutdown tone
- **Startup** - Boot chime (ironic death sound)
- **Generic Beep** - Simple two-tone beep
- **Synth Yes** - Affirmative tone
- **Synth No** - Negative tone
- **None** - No death sound

### TG Proc Changes:

None - this is a pure addition module.

### TG File Changes:

None - all changes are modular.

### Defines:

None required.

### Master file additions:

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:

- **Bubberstation Contributors** - Original implementation and sound files
- **Vorestation** - Mar sound file
- **Splurt** - Slug scream sound
- **Shiptest** - Tailthump and squeal sounds
- **YouTube** - Slug scream original source: https://www.youtube.com/watch?v=AdGk4PHQDOE

### Notes:

- The bonk emote creates a hand item that must be used on someone's head (target head zone)
- Synthetic emotes (scary, error, startup, shutdown) are restricted to synthetic species
- Tailthump emote requires the user to have a tail organ
- Some emotes use existing game sounds (raptor sounds, stoat sounds, cow sounds)

### Original Source:

Ported from Bubberstation's modular_zubbers/code/modules/emotes/
Repository: https://github.com/BubberStation/Bubberstation
