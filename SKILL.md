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

- Use the `AskUserQuestion` tool for EVERY interview question. It displays an
  interactive selection menu in the terminal.
- NEVER write the questions as plain text in your reply. If you catch yourself
  typing a numbered list of questions, stop and call the tool instead.
- Do not run scripts, read the codebase or generate files before Batch 1 is
  answered.
- Do not skip the interview because the request "seems clear". Only skip a
  question if the user already answered it explicitly in their message or in
  `$ARGUMENTS`.

Language rule: all generated documents are written in **English**, even if the
user speaks another language. Questions and menus may follow the user's
language.

## Workflow

1. **Interview** (see [interview.md](interview.md)): menu-based, always first.
2. **Source Registry**: read and memorize every document the user provided.
3. **Outline**: show every section title with a summary, let the user edit it,
   wait for approval.
4. **Generation**: write the documents, following the approved outline and the
   chosen strictness level.
5. **Traceability check**: verify the content against the sources, remove
   anything unsourced (mandatory in strict mode).
6. **Delivery**: summarize what was created and where.

## Source priority (non-negotiable)

When the user provides documentation (files, folders, URLs, notes), those
documents are the **primary source of truth**. Order of priority:

1. The user's documents (highest priority, always win)
2. Explicit instructions given during the interview
3. Facts found in the codebase (to fill gaps only)
4. This skill's templates and defaults (lowest priority)

If anything in this skill conflicts with a user document, the user document
wins. Never override, reorder or "improve" what a user document prescribes
(structure, section names, tone, formatting rules, naming conventions).

## Source Registry

After Batch 2 of the interview:

1. Read EVERY document the user listed, in full, using `Read`, `Glob`, `Grep`.
2. Build an internal registry: file path, what it prescribes (structure, rules,
   tone, required sections, forbidden content).
3. Save it to `.claude/doc-sources.md` so it survives context resets.
4. **Before every creation or modification** (including each outline edit),
   re-read the documents of the registry. Never rely on memory alone.
5. If a document cannot be read, tell the user and ask via menu how to proceed.

## Strictness levels

The user picks one in the interview.

| Level | Behavior |
|---|---|
| **Strict** | Follow the user's documents to the letter. Content contract below applies. Skill templates and design are disabled. |
| **Guided** | User documents define structure and rules. The skill may add styling (badges, layout) as long as it does not contradict them. |
| **Free** | User documents are inspiration. The skill templates are used as the base. |

### Strict mode: content contract

In strict mode:

- Every section, sentence, table and badge MUST be traceable to a user document
  or to an explicit user instruction from the interview or outline edits.
- Do NOT add sections, badges, emojis, tables of contents, "Contributing",
  "License", "Acknowledgements" or any filler that the documents do not ask for.
- Do NOT use the skill's templates, animations or design.
- Missing information is marked `[TODO: missing info]`. Never invent it.
- Facts from the codebase are allowed ONLY to fill a section that a user
  document explicitly requires.
- Before delivering, run the **Traceability check**: build a table
  `section -> source`. Delete anything without a source.

## Outline (mandatory before writing)

Never write a file before the user approves the outline.

### Step 1 - Build the outline
For each document, list every section with:
- A **number and title**
- A **1-2 sentence summary** of exactly what it will contain (concrete, based on
  the sources and the codebase, not generic)
- A **source tag**: `[from: <doc>]`, `[user-added]` or `[skill-default]`
  (`[skill-default]` is forbidden in strict mode)

### Step 2 - Display it
Print the full outline as text, for example:

```
README.md

1. Project Title
   -> Name "Acme API" and one-line tagline from docs/brief.md.
   [from: docs/brief.md]

2. Installation
   -> Node 20 prerequisite and the npm commands read from package.json.
   [from: docs/style-guide.md]

3. Environment Variables
   -> [TODO: missing info] No .env.example found, table to complete.
   [from: docs/style-guide.md]
```

### Step 3 - The Outline menu (with mandatory follow-ups)
Call `AskUserQuestion`: header `Outline`, "What do you want to do with this outline?"
- Approve: generate the documentation as shown
- Edit a section: change the title or the content of one section
- Add or remove: add a new section or delete existing ones
- Reorder: change the order of the sections

The tool allows 4 options max per question, so "Add or remove" is split in a
second menu (see Follow-up B/C below).

EVERY option except "Approve" MUST be followed immediately by its follow-up
menus below, in the same turn. Never stop after the first choice.

#### Follow-up A: "Edit a section"
1. Call `AskUserQuestion` header `Which`: "Which section do you want to edit?"
   List the section titles as options. The tool allows 4 options, so if there
   are more than 4 sections, use paging: show sections 1-3 plus a `Next page`
   option, then 4-6 plus `Next page` / `Previous page`, and so on. The user can
   also type a section number through "Other".
2. Call `AskUserQuestion` header `What`: "What do you want to change in
   section <N>: <title>?"
   - Title: rename the section
   - Content: change what the section will contain
   - Both: change title and content
   - Delete it: remove this section instead
3. Then collect the new value(s) with `AskUserQuestion` (one question per
   value). Question text: "New title for section <N>? Choose 'Other' to type it."
   with options such as `Keep current title: <current title>` and 1 or 2
   suggested alternatives. Same for content with suggested alternative
   summaries. The user types the exact text in "Other".
4. Apply the change, check it against the Source Registry rules and strict mode
   (if the new content has no source in strict mode, warn: see "Conflict check"),
   re-display the full outline, reopen the Outline menu.

#### Follow-up B/C: "Add or remove"
Call `AskUserQuestion` header `Action`: "Add or remove sections?"
- Add a section: insert a new section
- Remove sections: delete one or more sections
- Back: return to the outline menu

**If "Add a section":**
1. Call `AskUserQuestion` with 3 questions in ONE call:
   - header `Title`: "Title of the new section? Choose 'Other' to type it."
     Options: 2 suggested titles that fit the document (derived from the
     codebase or the user documents) + `I will type my own` (the user then
     uses "Other").
   - header `Content`: "What should this section contain? Choose 'Other' to
     describe it." Options: 2 suggested contents + `I will describe it`.
   - header `Position`: "Where should it go?"
     Options: `At the end`, `At the beginning`, `After a specific section`
     (then follow up with a menu listing sections), `Before the last section`.
2. Insert it, tag it `[user-added]`, re-display the outline, reopen the
   Outline menu.

**If "Remove sections":**
1. Call `AskUserQuestion` header `Remove`, multiSelect true: "Which sections
   do you want to remove?" List the section titles (use paging if more than 4
   sections: `Next page` option). The user can also type numbers or titles
   through "Other".
2. Confirm with `AskUserQuestion` header `Confirm`: "Remove <titles>?"
   - Yes, remove
   - No, keep them
3. Apply, re-display the outline, reopen the Outline menu.

#### Follow-up D: "Reorder"
1. Call `AskUserQuestion` header `Move`: "Which section do you want to move?"
   List the section titles as options (paging with `Next page` / `Previous page`
   if more than 4 sections). The user can also type the section number via "Other".
2. Call `AskUserQuestion` header `Where`: "Where should '<title>' go?"
   - To the top: first position
   - To the bottom: last position
   - Up one: swap with the previous section
   - Down one: swap with the next section
3. If the user needs a precise position (e.g. "after section 5"), they choose
   "Other" and type it. Interpret: "after 5", "position 3", "before <title>".
4. Apply the move, renumber the outline, re-display it in full, then call
   `AskUserQuestion` header `Again`: "Move another section?"
   - Yes: move another one (go back to step 1)
   - No: back to the outline menu
5. If the instruction is unclear, ask again via a menu. Never guess.

### Conflict check
Before applying any outline edit, compare it with the Source Registry.
If the edit contradicts a user document (or, in strict mode, has no source),
call `AskUserQuestion` header `Conflict`:
"This edit contradicts <document> / has no source in your documents. What do
you want to do?"
- Apply anyway: your instruction wins
- Cancel the edit: keep the document's version
- Update the plan to match the document

### Lock
Once approved, the outline is locked. During generation, never add, remove or
rename a section without asking the user first through a menu.

## MENU INTERACTION RULES

1. A menu choice is NEVER the end of an interaction. After any selection, you
   MUST act on it immediately: apply the change or open the follow-up menu.
2. NEVER answer with only "you selected X" or "OK, noted". Always continue
   the flow.
3. The `AskUserQuestion` tool has no free-text field. Free text is entered
   through the automatic "Other" option. Always tell the user: "Choose 'Other'
   to type it", and offer suggested options so the menu is useful.
4. If the user closes a menu or answers nothing, call `AskUserQuestion` again
   with header `Resume`:
   - Resume the previous step
   - Approve the outline as it is
   - Cancel
5. Maximum 4 options per question. Use paging when a list is longer.

## Generation

After the outline is approved:

- Write each document following the approved outline exactly (same order, same
  titles).
- Respect the strictness level (see above).
- In Guided/Free modes, use [readme-showcase.md](readme-showcase.md) for design,
  [adr-template.md](adr-template.md) for ADRs and
  [diagram-guide.md](diagram-guide.md) for Mermaid diagrams, unless a user
  document overrides them.
- All documents in English.

## Traceability check (before delivery)

Build a table `section -> source (document or instruction)`. In strict mode,
delete any section, sentence or element that has no source. In other modes,
flag unsourced additions to the user in the final summary.

## Delivery

Finish with a short summary: files created or updated, sources used, any
`[TODO: missing info]` left, and anything removed by the traceability check.