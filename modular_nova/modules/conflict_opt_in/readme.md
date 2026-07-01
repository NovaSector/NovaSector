https://github.com/NovaSector/NovaSector/pull/7439

## \<Title Antagonist Opt In>

Module ID: CONFLICT_OPTIN

### Description:

Adds a new social and policy preference which shows on inspect to indicate the level of violent involvement that someone is willing to get up to or engage with.

### TG Proc/File Changes:

- tgui\packages\tgui\interfaces\ExaminePanel\index.tsx
- tgui\packages\tgui\interfaces\ExaminePanel\data.ts

### Modular Overrides:

- N/A

### Defines:

- conflict_opt_in - code/\_\_DEFINES/~nova_defines/conflict_optin_defines.dm
	- `ANTAG_OPT_IN_YES_KILL`, `ANTAG_OPT_IN_YES_PARTIAL`, `ANTAG_OPT_IN_YES_ROUND_REMOVE`, and `OPT_IN_NOT_TARGET` - used for managing opt in stuff.

### Included files that are not contained in this module:

- modular_nova\master_files\code\modules\mob\living\examine_tgui.dm
- modular_nova\modules\customization\modules\mob\living\silicon\examine.dm

### Credits:

- niko & plumb - for making the original antag-opt module
- moonridden - adapted the module to her own policy purposes in 2026
