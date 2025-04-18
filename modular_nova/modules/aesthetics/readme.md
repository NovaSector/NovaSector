https://github.com/Skyrat-SS13/Skyrat-tg/pull/1245

## Title: General aesthetic change.

MODULE ID: AESTHETICS

### Description:

This takes a few sprites from TauCeti station and ports them over to us. With a few sound modifications too.

Otherwise, this is a general module for "TG items that we alter the audio/visuals of".
Try not to put NEW items in this module, only overrides of TG's own aesthetics.

Good examples of what belongs in here (all of which are actually in here):
- Audio and visual changes used to set a different atmosphere (e.g. Lighting or Footsteps)
- Removing visuals that an item's balance doesn't warrant for us (Such as removing the Breathing Implant visual)
- The ported walls/doors, which directly override TG's ancient wall sprites
- Custom floors that override TG's to match the ported walls better
- Sprites we just flat-out prefer to TG's (e.g. Boxes and Tools)


### TG Proc Changes:

- All TG file changes should be tagged with "NOVA EDIT (ADDITION/REMOVAL) - AESTHETICS"

- /obj/machinery/cell_charger/update_overlays()
- /obj/machinery/computer/ui_interact(mob/user, datum/tgui/ui)
- /obj/machinery/door/airlock/try_to_force_door_open(force_type = DEFAULT_DOOR_CHECKS)
- /mob/living/carbon/human/Initialize(mapload)
- /obj/machinery/door/airlock/update_overlays()

### Defines:

- N/A

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:
- TauCeti station
- Gandalf2k15
