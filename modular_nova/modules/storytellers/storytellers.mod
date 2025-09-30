Storytellers Module: Expression Trees (.json)

Overview
- This module now supports JSON-driven expression trees to decide storyteller events, global and local goals.
- Expressions are evaluated against a context that can include `inputs` (from `datum/storyteller_analyzer`), `owner` (the `datum/storyteller`), and any additional data maps (e.g. `vault`).

Where
- Engine: `modular_nova/modules/storytellers/code/modules/expressions/expr_engine.dm` provides `/datum/story_expr`.
- Usage example: Plan selection can load a JSON and call `E.evaluate(list("inputs" = owner.inputs, "owner" = owner, "vault" = some_list))`.

JSON Node Schema
- Common: each node is an object with a `type` string. Subfields depend on type.

1) Constants
  { "type": "const", "value": any }

2) Variables (dotted path resolution)
  { "type": "var", "name": "inputs.crew_weight" }
  - Looks up by dots across lists and datum vars.

3) Existence check
  { "type": "exists", "name": "vault.some_key" }

4) Unary op
  { "type": "unary", "op": "!", "expr": <node> }
  - ops: !, -, ~

5) Binary op
  { "type": "binary", "op": ">=", "left": <node>, "right": <node> }
  - ops: +, -, *, /, %, ==, !=, <, <=, >, >=, &&, ||

6) Logic helpers
  { "type": "logic", "op": "and", "left": <node>, "right": <node> }
  { "type": "logic", "op": "or",  "left": <node>, "right": <node> }
  { "type": "logic", "op": "not", "expr": <node> }

7) If-then-else
  { "type": "if", "cond": <node>, "then": <node>, "else": <node> }

8) Calls (safe intrinsics only)
  { "type": "call", "name": "clamp", "args": [ <node>, <node>, <node> ] }
  - Available: min(a,b,...), max(a,b,...), clamp(v, lo, hi), ratio(a,b), get(container, key)

Loading and Evaluating
- Build directly from a decoded list: `var/datum/story_expr/E = new(spec)`
- Or load from a JSON file: `E.load_from_json_path("config/storyteller/goal_rules.json")`
- Evaluate: `var/result = E.evaluate(list("inputs" = inputs, "owner" = storyteller, "vault" = rules_cache))`
- Convenience proc: `story_expr_eval_json(path, context)`

Conventions
- Keep expression files in a clear directory (e.g., `config/storyteller/` or `modular_nova/modules/storytellers/config/`).
- Use meaningful variable paths matching `datum/storyteller_inputs` fields: e.g., `inputs.station_value`, `inputs.crew_weight`, `inputs.antag_weight`, `inputs.antag_crew_ratio`, `inputs.player_count`, `inputs.antag_count`, `inputs.station_state`.
- Extend safe intrinsics in `eval_call` as needed; avoid arbitrary proc calls for security and determinism.

Future Integration
- Plug into `datum/storyteller_planner` to select `current_goal` by evaluating a scored set of rules and picking the highest.
- Allow event gating by wrapping triggers as expression files per event.
