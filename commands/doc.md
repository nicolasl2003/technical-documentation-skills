---
description: Generate or update technical documentation (README, ADR, diagrams) with interactive menus
argument-hint: "[readme | adr | diagram | all | update]"
---

Use the `technical-documentation` skill to handle this request.

Argument received: $ARGUMENTS

1. Check first whether the target document already exists. If it does, run the
   skill's mode detection (Update / Regenerate / Cancel). If the argument is
   `update`, go straight to the Update flow.
2. Otherwise start with the interview using the `AskUserQuestion` tool, exactly
   as described in the skill. If the argument already answers a question (for
   example `readme`), skip that question.
3. For existing documentation to follow, do not ask me to type a file path.
   Scan the project and let me pick the files from a menu.
4. When I modify the outline or an existing section, open the menus described
   in the skill (section picker, change picker, value picker). Do not ask me to
   type my change in the chat, and do not combine questions in one call.
5. In Update mode, change only what I asked for, with `Edit`. Never rewrite
   the whole file.