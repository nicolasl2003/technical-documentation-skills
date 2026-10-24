---
name: technical-documentation
description: Generates technical documentation (styled READMEs, ADRs, Mermaid architecture diagrams). ALWAYS starts with an interactive menu interview (AskUserQuestion), then shows an editable outline (section titles + summaries) for approval before writing anything. Supports a STRICT mode that follows the user's documents to the letter with zero extra content. User-provided documentation always takes priority over this skill's templates. Use when the user asks to document a project, create or update a README, write an ADR, or produce a diagram.
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
- Do not run scripts, read the codebase or generate files before Batch 1 is answered.
- Do not skip the interview because the request "seems clear". Only skip a
  question if the user already answered it explicitly in their message.

## MENU INTERACTION RULES (critical, prevents dead ends)

A menu choice is NEVER the end of an interaction. Selecting an option only
tells you what the user wants to do. If that action needs details (which
section, what title, what content), you MUST collect them IMMEDIATELY with
another `AskUserQuestion` call, in the same turn.

Hard rules:
- NEVER reply with just "you selected X" or "OK, noted". That is a dead end.
  After a menu choice you either call the next tool or perform the action.
- NEVER say "tell me which section" in plain text and stop. Always open a menu
  instead.
- To collect free text (a new title, new content, a new order), call
  `AskUserQuestion` with 2 to 3 helpful options and tell the user in the question:
  "Choose 'Other' to type your own text". Free text always arrives through
  the automatic "Other" field.
- If the user answers with an empty or unclear value, re-ask with a menu. Do
  not guess, do not continue.
- After EVERY completed action (edit, add, remove, reorder), re-display the
  full updated outline and reopen the Outline menu. Never end silently.
- If a menu choice is "Cancel" or the user dismisses the menu, ask once via a
  menu `Resume` (Resume outline editing / Approve current outline / Cancel
  everything). Never just stop.

## STRICT MODE

Strict mode is chosen in the interview (Batch 2, question `Strictness`). It
applies whenever the user's documents define content or structure.

When strict mode is ON, you operate under the CONTENT CONTRACT:

1. **Allowed content = user documents only.** Every section, sentence, table,
   command and badge in the output must be traceable to (a) a user reference
   document, (b) an explicit interview answer, or (c) a verifiable fact in the
   codebase that fills a field the user document explicitly asks for.
2. **No extras.** Do NOT add sections, badges, emojis, tables, animations,
   "Features" lists, tips, roadmaps, contributing notes, license blurbs or any
   decoration that is not in the user documents. The skill templates
   (README-showcase.md, README-minimal.md) are NOT used in strict mode, except
   for syntax help (valid Markdown / Mermaid).
3. **Same structure.** Reproduce the user document's section order and
   headings exactly, unless the user edited them in the outline.
4. **Same wording where defined.** If the document gives fixed text or a
   template, copy it verbatim and only fill the variable parts.
5. **Missing info = TODO, never invention.** If a required field has no source,
   write `TODO: <what is missing>`. Never fill gaps with plausible content.
6. **Verification pass (mandatory before delivery).** Build a table: for each
   section of the output, name its source. Delete anything with no source.
   Show the user a short summary: "N sections, all traced to sources" and list
   any deletions you made.
7. **Outline in strict mode:** every outline section must carry a
   `[from: <document>]` tag. A section without a tag is not allowed unless the
   user explicitly added it during outline editing (then tag it `[user-added]`).

When strict mode is OFF ("Guided" or "Free"):
- **Guided**: user documents are the base and have priority, the skill may
  complete missing parts using its templates, but must tag such sections
  `[skill-default]` in the outline so the user can remove them.
- **Free**: user documents are inspiration, the skill uses its templates freely.

## SOURCE PRIORITY (absolute rule)

User-provided documentation ALWAYS overrides this skill's templates, defaults
and style suggestions. Order of authority, highest first:

1. **Documents and instructions provided by the user** (docs, specs, style guides,
   templates, existing README, wiki exports, conventions, URLs)
2. **The user's answers during the interview and the approved outline**
3. **The actual codebase** (manifests, config, source)
4. **This skill's templates and defaults** (lowest priority, fallback only, and
   forbidden in strict mode)

Consequences:
- If a user document defines a structure, tone, section order, naming or
  template, FOLLOW IT and ignore the conflicting part of the skill templates.
- If a user document conflicts with the codebase, do not silently choose:
  report the conflict to the user via `AskUserQuestion`.
- Never contradict a user document with your own assumptions.

## SOURCE REGISTRY (persistent memory of reference documents)

During the interview, build a registry of every reference document and URL the
user provided, plus the "rules to follow" extracted from them and the chosen
strictness level. Keep it for the whole session and show it in the recap.

**Re-read rule**: before ANY later action that creates or modifies a document
(outline change, section rewrite, update request, new deliverable, follow-up
request in the same session), you MUST re-read every document in the registry
first, then re-check your planned output against the "rules to follow".

- Never rely on memory of the documents alone: read them again.
- If a registered document changed since the last read, update the rules list
  and tell the user what changed.
- If a registered file or URL is no longer reachable, tell the user via
  `AskUserQuestion` (Provide new path / Continue without / Cancel).
- Persist the registry in `.claude/doc-sources.md` (path, URL, extracted rules,
  strictness level) so it survives across sessions. At the start of a later
  documentation task, if this file exists, load it and ask the user whether it
  is still valid.

## Language rules
- Talk to the user in the language they use (e.g. French), including menu
  labels, outline summaries and descriptions.
- ALL generated files (README, ADR, diagrams, comments) are written in English.
- The outline is shown in the user's language. If the user's language is not
  English, display each title as `Title in user language -> English title used in file`.

## Workflow

1. **Interview** (mandatory): run the batches of [interview.md](interview.md)
   with `AskUserQuestion`. Batch 2 collects the user's reference documents and
   the strictness level.
2. **Read the user's documents FIRST**: read every document and path listed in
   Batch 2 completely, before any other analysis. Extract their rules
   (structure, tone, templates, constraints). Save the Source Registry.
3. **Recap**: show the answers plus the extracted rules, then confirm with
   `AskUserQuestion` (Continue to outline / Modify / Cancel).
4. **Analyze the codebase**: run `bash scripts/analyze-project.sh`, read
   manifests, CI, env files. Use it only to fill facts the user documents ask for.
5. **Outline approval (mandatory, see "Outline" below)**.
6. **Write**: generate the file(s) strictly following the APPROVED outline.
   - Strict mode: follow the CONTENT CONTRACT, no skill templates.
   - Guided / Free: use the user's template if one exists, otherwise
     [README-showcase.md](README-showcase.md) (Modern/Showcase),
     [README-minimal.md](README-minimal.md) (Minimal), [ADR-template.md](ADR-template.md),
     [diagrams.md](diagrams.md).
   Do NOT add, remove or rename a section that was not in the approved outline.
7. **Verify**: commands are real, paths exist, Mermaid is valid, badge URLs use
   the real OWNER/REPO (from `git remote -v`), every user-document rule and every
   approved section is respected. In strict mode, run the traceability pass.
8. **Report** to the user (in their language): files created, rules applied from
   their documents, TODOs left, conflicts found, sections removed by the
   strict-mode verification (if any).

## Outline (mandatory before writing)

Never write a document before the user has approved its outline.

### Step 1 - Build the outline
Using the interview answers, the Source Registry rules and the codebase analysis,
build the section plan. If a user document defines the structure, the outline
MUST mirror it exactly. Otherwise derive it from the chosen style and audience.

### Step 2 - Display the outline
Show it as plain text, in the user's language, in this exact format:

```
OUTLINE: README.md  (Mode: Strict | Style: n/a | Sources: 2 docs)

1. <Section title>
   -> <2-3 line summary of exactly what this section will contain,
      including the real facts it will use.>
   [from: <document name>]

2. <Section title>
   -> <summary>
   [from: <document name>]
...
```

Rules for summaries:
- Concrete, never generic ("Explains the project" is not acceptable).
- Mention the real data source (file, document, code module) when relevant.
- Mark sections lacking data with `[TODO: missing info]` and say what is missing.
- Tag the origin of every section: `[from: <doc>]`, `[user-added]`, or
  `[skill-default]` (the last one is forbidden in strict mode).
- Show at most 15 sections. For multi-file deliverables, show one outline per file.

### Step 3 - The Outline menu (with mandatory follow-ups)
Call `AskUserQuestion`: header `Outline`, "What do you want to do with this outline?"
- Approve: generate the documentation as shown
- Edit a section: change the title or the content of one section
- Add a section: insert a new section
- Remove a section: delete one or more sections

(Reorder is handled through the "Other" field, e.g. "move 5 before 2", or
offered as a fifth action in a second menu if the user asks.)

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

#### Follow-up B: "Add a section"
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

#### Follow-up C: "Remove a section"
1. Call `AskUserQuestion` header `Remove`, multiSelect true: "Which sections
   do you want to remove?" List the section titles (use paging if more than 4
   sections: `Next page` option). The user can also type numbers or titles
   through "Other".
2. Confirm with `AskUserQuestion` header `Confirm`: "Remove <titles>?"
   - Yes, remove
   - No, keep them
3. Apply, re-display the outline, reopen the Outline menu.

#### Reordering
If the user types a reorder instruction in "Other" (or selects it), apply it
and re-display the outline. If the instruction is unclear, ask via a menu which
section to move and where.

#### Conflict check (before applying any user edit)
- If the edit contradicts a registered user document, call `AskUserQuestion`
  header `Conflict`: "This change goes against <document>. What do you want to do?"
  - Keep my change
  - Follow the document
  - Cancel the change
- In strict mode, if a new or edited section has no source in the user
  documents, call `AskUserQuestion` header `Strict`: "This section has no
  source in your documents (strict mode is on). What do you want to do?"
  - Add it anyway (tag as user-added)
  - Provide a source document
  - Cancel the change

### Step 4 - Lock
Once approved, the outline is the contract. Writing must match it exactly.
If you later discover a needed change (missing data, impossible section), STOP
and propose the outline change to the user instead of deviating silently.

## README rules

When no user template exists and the mode is Guided or Free, with style Modern
or Showcase:
- Do NOT write the README from scratch. Copy `README-showcase.md` and replace
  every `{{PLACEHOLDER}}`.
- Keep the animated header, typing animation, badges, navigation bar, feature
  grid, collapsible sections and footer, adapted to the approved outline
  (the navigation bar must list exactly the approved sections).
- Apply the chosen color palette to EVERY color placeholder.

In strict mode these decorations are NOT added unless the user document uses them.

## General rules
- Never invent information. Mark unknowns with `TODO:`.
- Never overwrite an existing README without reading it and proposing a backup
  (`README.old.md`).
- No generic filler content.