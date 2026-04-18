## Title: Round Mode Vote

MODULE ID: MODE_VOTE

### Description:

Adds an auto-triggered pregame vote that lets players choose between a normal `Dynamic` round (SSdynamic picks its tier as usual) and a `Greenshift` round (SSdynamic tier is forced to Greenshift, so no dynamic rulesets spawn; only incidental random events from SSevents occur).

The vote auto-starts 60 seconds into pregame when `ALLOW_VOTE_MODE` is set. Admins forcing a tier before the vote fires will cancel the auto-start. The winning mode is posted to every player's status tab as `Round Mode: Dynamic` or `Round Mode: Greenshift`.

### TG Proc Changes:

- N/A

### Defines:

- `MODE_VOTE_DYNAMIC`, `MODE_VOTE_GREENSHIFT`, `MODE_VOTE_AUTO_START_DELAY` (all scoped and `#undef`'d inside `mode_vote.dm`)

### Master file additions

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:

@Happyowl93 - authoring
