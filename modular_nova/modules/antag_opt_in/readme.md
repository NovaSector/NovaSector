https://github.com/NovaSector/NovaSector/pull/121

## \<Title Antagonist Opt In>

Module ID: ANTAG_OPTIN

### Description:

Adds functionality to allow players to 'opt-in' to being an antagonist's mechanical target, with three different levels of involvement - being temporarily inconvenienced, killed, and round removed. Command roles & security are automatically opted-in to at least 'KILL' level. Additionally, contractor & heretic have their objectives adjusted to only have command staff & security as their targets

### TG Proc/File Changes:

- Changes in several antag files (will list later)
- examine_tgui.dm (Adds opt in info to OOC examine info)
- objective.dm (target selection stuff)

### Modular Overrides:

- N/A

### Defines:

- antag_opt_in - code/\_\_DEFINES/~nova_defines/antag_optin_defines.dm
  - `ANTAG_OPT_IN_YES_KILL`, `ANTAG_OPT_IN_YES_PARTIAL`, `ANTAG_OPT_IN_YES_ROUND_REMOVE`, and `OPT_IN_NOT_TARGET` - used for managing antag opt in stuff.

### Included files that are not contained in this module:

- tgui\packages\tgui\interfaces\PreferencesMenu\preferences\features\character_preferences\nova\antag_optin.tsx

### Credits:

- niko - for doing stuff and taking over
- plum - the original author
- moonridden - 2026 policy adjustments and cleanup
