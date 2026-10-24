---
name: technical-documentation
description: Creates and updates technical documentation. Use when the user asks for a README, ADR, architecture diagram, project documentation, "documente", "documentation", "readme", "génère un readme", "écris un ADR", "diagramme d'architecture", or runs /doc. Starts with an interactive menu interview, then an editable outline.
argument-hint: "[readme | adr | diagram | all]"
allowed-tools: AskUserQuestion, Read, Glob, Grep, Write, Edit, Bash
---

# Technical Documentation

## STOP - READ THIS FIRST

You MUST interview the user BEFORE analyzing the codebase and BEFORE writing
any file. This is not optional.

**Your first action when this skill is triggered MUST be a call to the
`AskUserQuestion` tool with Batch 1 of [interview.md](interview.md).**

- Use `AskUserQuestion` for EVERY interview question. It shows an interactive
  selection menu in the terminal.
- NEVER write the questions as plain text in your reply.
- Do NOT read the codebase, do NOT open files, do NOT write anything until the
  interview AND the outline approval are finished.

## Language rules

- Talk to the user in the language they use (French if they write French).
- EVERY generated document (README, ADR, diagrams, comments inside them) is
  written in **English**, always.

## Source priority and strictness

The user's documents ALWAYS take priority over this skill's templates.

**Rule 1 - Structure comes from the user's document.**
If a source document defines the required content or sections of a document,
that list IS the outline. Use those sections, with those exact titles, in
that order when an order is given.

**Rule 2 - Never add a section that is not in the source document.**
Do NOT add a section by habit or by default (for example "Subject", "License",
"Contributing", "Table of contents section", "Roadmap", "FAQ"). If it is not in
the source document, it does not exist. A missing section is never a reason to
add one.

**Rule 3 - Style is separate from structure.**
Visual styling (banner, badges, animations, color palette, emoji markers,
collapsible blocks) applies ON TOP of the required structure. It must never add,
remove or rename a section. It lives in the header area, in formatting, and
inside existing sections only.

**Rule 4 - Mandatory first line.**
If the source document imposes an exact first line, that line is the FIRST line
of the file, with nothing before it (no banner, no badge, no HTML). The visual
header goes immediately after it.

**Rule 5 - Strict mode.**
In strict mode, Rules 1 to 4 apply with no exception and no "helpful
additions". If the document is silent on a topic, stay silent.
In flexible mode, extra sections may be proposed, ONLY as a separate question
in the outline step, never added silently.

**Rule 6 - No placeholders.**
Never write `[TODO: missing info]` or any placeholder in a final document. If
information is missing, ask the user through `AskUserQuestion` before writing,
or omit the detail.

## Workflow

Follow these phases in order. Do not skip any.

### Phase 1 - Interview
Run every batch of [interview.md](interview.md) with `AskUserQuestion`.
Collect: deliverable(s), source documents, strictness, visual style, audience,
and anything else the interview asks.

For source documents, NEVER ask the user to type a path. Run Batch 1b of
`interview.md`: scan the project with `Glob`, then show the candidate files in
a `multiSelect` `AskUserQuestion` menu. Typing is only a fallback through the
built-in "Other" option.

### Phase 2 - Source Registry
Read every selected document, completely (PDFs included, page by page if
needed). Build a Source Registry: for each document, the exact requirements it
imposes (required sections, exact titles, exact sentences, order, constraints).
These requirements override everything in this skill.

If two documents contradict each other, do not choose silently: ask the user
through `AskUserQuestion` which one wins.

### Phase 3 - Codebase analysis
Only now, analyze the code (Glob, Grep, Read) to gather facts. Never invent:
every statement in the documentation must come from the sources or the code.
Verify names, defaults, commands and paths against the real files.

### Phase 4 - Outline approval (MANDATORY, editable, menu-driven)

Never write the document before this phase is approved. Every step below uses
`AskUserQuestion`. Never ask the user to describe a change in the chat.

**Hard rules for this phase:**
- ONE question per `AskUserQuestion` call. Never combine the plan validation
  with any other question (project folder, missing info, etc.).
- NEVER ask the user to "tell me in the chat" which section to change. Open the
  next menu instead.
- NEVER announce that something "will be marked as missing" or left as a
  placeholder. If information is missing, ask for it in a separate, later menu
  (Phase 5) or omit the detail.
- After every change, redisplay the full outline before asking again.

**Step 4.1 - Display the outline.**
Print the outline in the chat, as a numbered list. For each section: the title
in bold, then one line below describing what it will contain.

```
1. **Description**
   Goal of the project and a short overview.
2. **Instructions**
   How to install and run the project.
```

**Step 4.2 - Validation menu.**
Call `AskUserQuestion` with ONE question:
- header `Outline`: "Do you approve this outline?"
  - Approve and write
  - Modify a section
  - Add a section
  - Remove a section

Branch on the answer:
- "Approve and write" goes to Phase 5.
- "Modify a section", "Add a section", "Remove a section" go to Step 4.3.

**Step 4.3 - Section picker (required, never skipped).**

For "Modify a section" or "Remove a section":
Call `AskUserQuestion` with ONE question listing the sections:
- header `Section`: "Which section?"
- Options: the section titles, 4 per page. If there are more than 4 sections,
  add an option "Next sections" and repeat with the following ones. Keep going
  until the user picks one.

For "Add a section":
Call `AskUserQuestion` with ONE question:
- header `New section`: "Where do you want to add it?"
  - At the end
  - After a specific section
  - At the beginning
Then, if "After a specific section", show the section picker above.
Then ask for the new section's title with a menu offering likely titles taken
from the source documents and the codebase; "Other" lets the user type any title.

**Step 4.4 - Change picker (required, never skipped).**

For "Modify a section", call `AskUserQuestion` with ONE question:
- header `Change`: "What do you want to change in '<section title>'?"
  - Rename the title
  - Change the content summary
  - Move it up or down
  - Both title and content

Then for each chosen change, open ONE more menu:

- **Rename the title**: call `AskUserQuestion` with:
  header `New title`: "New title for '<section title>'?"
  Options: 2 or 3 proposals based on the source documents (when they define a
  title, include it as the first option and mark it "(from your document)"),
  and the built-in "Other" for a custom title.

- **Change the content summary**: call `AskUserQuestion` with:
  header `Content`: "What should '<section title>' contain?"
  Options: "Shorter", "More detailed", "Different focus", and the built-in
  "Other" so the user can type the exact content in their own words.
  If the user picked "Shorter", "More detailed" or "Different focus", ask ONE
  follow-up menu with concrete proposals (for example the bullets that could be
  removed, added, or the possible new focus), plus "Other".

- **Move it up or down**: call `AskUserQuestion` with:
  header `Position`: "Where should '<section title>' go?"
  Options: "Move up one", "Move down one", "To the top", "To the bottom".

For "Remove a section": call `AskUserQuestion` with:
- header `Confirm removal`: "Remove '<section title>'?"
  - Yes, remove it
  - No, keep it
In Strict mode, if the section is required by a source document, warn the user
in the question description that the document requires it.

**Step 4.5 - Apply and loop.**
Apply the change to the outline, redisplay the whole outline (Step 4.1), then
return to Step 4.2. Repeat until the user chooses "Approve and write".

Edits to the outline never override a Strict-mode requirement silently. If the
user removes a section the source document requires, apply it, but state it in
one sentence in the chat after the change.

### Phase 5 - Missing information (one menu per question)

Only after the outline is approved. For each piece of information required by a
section but absent from the codebase and the documents (logins, links, how AI
was used, project-management folder...), ask ONE `AskUserQuestion` per item,
never combined with another question.

- If the user answers, use the answer.
- If the user chooses to skip, omit that detail silently. NEVER write
  "[TODO]", "missing", "to be completed" or a similar marker in the document,
  and never warn about it in the document.

Offer an action when relevant (example for a missing project-management
folder): header `Project management`: "How do you want to handle the project
management folder?" with options "I will give the folder name", "Create a
minimal folder for me", "Skip this detail".

### Phase 5 - Writing
Read the needed support files BEFORE writing:
- [readme-showcase.md](readme-showcase.md) for README visual style
- [adr-template.md](adr-template.md) for ADRs
- [diagram-guide.md](diagram-guide.md) for diagrams

Write exactly the approved outline, nothing more. Apply the visual style from
`readme-showcase.md` on top of it (Rules 3 and 4).

### Phase 6 - Verification (required)
Before reporting completion, check and fix:
- [ ] Every approved section exists, with the exact approved title and order
- [ ] No section exists that is not in the approved outline
- [ ] Any mandatory first line from the source document is the first line
- [ ] No `TODO` or placeholder text remains
- [ ] If a visual style was chosen: banner, badges and the chosen animation are
      present, and they sit after the mandatory first line
- [ ] Every command, config key, default value and path matches the real code
- [ ] The document is entirely in English

Report to the user (in their language) what was created and any assumption made.