---

### Storyteller Global Goals

Global goals for the storyteller are not merely a means to trigger events; they serve as the driving force behind its behavior. These goals act as a catalyst, guiding the narrative in a specific direction. While goals may pose threats on their own, their primary role is to provide a vector for the story's progression.

All global goals must include the `STORY_GOAL_GLOBAL` tag in their category and implement the following methods:

- `/proc/is_available()`: Checks if the goal is valid and can be selected based on the current game state.
- `/proc/get_progress()`: Tracks and reports the progress toward achieving the goal.
- `/proc/complete()`: Signals to the storyteller that the goal has been fully achieved.

These methods encapsulate the essence of the goal. In particular, `/proc/complete()` is critical, as it informs the storyteller that the current objective has been fulfilled, allowing it to move forward with the narrative.

---
