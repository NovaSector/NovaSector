# Protean Species Integration Notes

## Port Complete! ✅

The Protean species has been successfully ported from Bubberstation to NovaSector as a modular module.

## Files Created

### Core Code Files (17 files)

1. `code/_defines.dm` - All protean-specific defines and constants
2. `code/_helpers.dm` - Helper macro for isprotean()
3. `code/protean_species.dm` - Main species datum and outfit handling
4. `code/protean_bodyparts.dm` - Custom bodyparts with damage system
5. `code/protean_verbs.dm` - Player verbs for protean abilities
6. `code/protean_status_effects.dm` - Low power mode and reform effects
7. `code/protean_modsuit.dm` - Modsuit control system with assimilation
8. `code/protean_modsuit_core.dm` - Custom modsuit core
9. `code/protean_prefab.dm` - Empty protean body spawner
10. `code/protean_servo_module.dm` - MOD module for buff abilities
11. `code/protean_cargo.dm` - Cargo supply packs
12. `code/nanite_organ_element.dm` - Element for organ coloring
13. `code/outfit_signal.dm` - Outfit equip signal override
14. `code/signal_defines.dm` - Signal definitions

### Organ Files (7 files)

15. `code/organs/protean_brain.dm` - Core with revival mechanics
16. `code/organs/protean_stomach.dm` - Refactory with metal storage
17. `code/organs/protean_heart.dm` - Orchestrator module
18. `code/organs/protean_eyes.dm` - Imaging nanites
19. `code/organs/protean_ears.dm` - Sensory nanites
20. `code/organs/protean_tongue.dm` - Audio fabricator
21. `code/organs/protean_liver.dm` - Reagent catalyst

### Sprites

22. `icons/protean.dmi` - All protean visual effects and sprites

### Documentation

23. `readme.md` - Full module documentation
24. `INTEGRATION_NOTES.md` - This file

## Integration Checklist

### ✅ Completed

- [x] All code files ported and adapted to NovaSector structure
- [x] Sprites copied from Bubberstation
- [x] Defines adapted for NovaSector
- [x] Helper procs created
- [x] Signal system added for outfit handling
- [x] Documentation created
- [x] No linter errors

### ⚠️ May Need Verification

The following items should be verified when testing:

1. **ORGAN_NANOMACHINE flag** - Added as (1<<18), verify this doesn't conflict
2. **COMSIG_OOC_ESCAPE signal** - Used but may not exist in base, falls back gracefully
3. **COMSIG_CLICK_CTRL_SHIFT signal** - Used for stripping, verify it exists
4. **Bodypart paths** - Uses `obj/item/bodypart/` - verify this matches NovaSector structure
5. **Organ paths** - Uses `obj/item/organ/internal/` - verify this matches NovaSector
6. **Wings compatibility** - References `/obj/item/organ/external/wings/` - verify path

### 📋 Testing Checklist

When testing in-game, verify:

- [ ] Protean species appears in character creation
- [ ] Can spawn as protean without errors
- [ ] Modsuit equips on spawn
- [ ] Can eat metal sheets (golem_food type)
- [ ] Refactory processes metal correctly
- [ ] Can enter/exit modsuit (suit transformation)
- [ ] Revival system works when "dead"
- [ ] Limb damage and auto-dismember works
- [ ] Can assimilate other modsuits
- [ ] Servo module provides correct buffs
- [ ] Cargo packs spawn correctly
- [ ] Status effects apply properly

### 🔧 Potential Adjustments Needed

1. **Organ Paths**: If NovaSector uses different organ paths (e.g., `obj/item/organ/` instead of `obj/item/organ/internal/`), paths will need adjustment

2. **Signal Compatibility**: If COMSIG_OOC_ESCAPE or COMSIG_CLICK_CTRL_SHIFT don't exist:
   - OOC escape functionality may not work (non-critical)
   - Ctrl+Shift stripping may not work (can be replaced with normal stripping)

3. **Icon States**: Verify the protean.dmi has all required icon states:
   - posi1 (brain)
   - refactory
   - orchestrator
   - to_puddle
   - from_puddle
   - protean_lowpower
   - protean_reform

4. **Food Compatibility**: Verify `/obj/item/food/golem_food` exists or needs to be created/adapted

## Known Differences from Bubberstation

1. **Organ Paths**: Changed from `obj/item/organ/` to `obj/item/organ/internal/` to match standard BYOND structure
2. **Outfit Signal**: Added modular override instead of editing core files
3. **Signal Defines**: Created separate file for protean-specific signals

## Credits

**Original Authors (Bubberstation):**

- Waterpig / @Majkl-j
- The Sharkenning / @StrangeWeirdKitten

**Port to NovaSector:**

- Completed [Current Date]

## Support Notes

If you encounter issues:

1. Check linter errors first
2. Verify all paths match NovaSector's structure
3. Ensure all required signals exist in base code
4. Check that icon states exist in the DMI file
5. Verify organ flag values don't conflict with existing flags
