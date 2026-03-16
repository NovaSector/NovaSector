# Bloodsucker Antagonist

## About

Ported from S.P.L.U.R.T-tg's modular_zubbers implementation. Bloodsuckers are a vampire antagonist type with a clan system, powers, ghouls (vassals), and a day/night Sol cycle mechanic.

## Changes to TG files

- `code/__DEFINES/~nova_defines/traits/declarations.dm` - Added TRAIT_MASQUERADE, TRAIT_COLDBLOODED, TRAIT_TORPOR
- `code/_globalvars/traits/_traits.dm` - Registered new traits for admin tooling

## Modular Overrides

- Integration overrides in `code/bloodsuckers/integration.dm` for blood handling, temperature, trauma masking, etc.

## Defines

- All bloodsucker-specific defines in `code/_defines.dm`

## Credits

- Original implementation by S.P.L.U.R.T-tg contributors (modular_zubbers)
- Ported to NovaSector modular format
