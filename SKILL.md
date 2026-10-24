---
name: technical-documentation
description: Generates technical documentation (styled READMEs, ADRs, Mermaid architecture diagrams). ALWAYS starts with an interactive menu interview (AskUserQuestion), then shows an editable outline (section titles + summaries) for approval before writing anything. User-provided documentation always takes priority over this skill's templates. Use when the user asks to document a project, create or update a README, write an ADR, or produce a diagram.
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

## SOURCE PRIORITY (absolute rule)

User-provided documentation ALWAYS overrides this skill's templates, defaults
and style suggestions. Order of authority, highest first:

1. **Documents and instructions provided by the user** (docs, specs, style guides,
   templates, existing README, wiki exports, conventions, URLs)
2. **The user's answers during the interview and the approved outline**
3. **The actual codebase** (manifests, config, source)
4. **This skill's templates and defaults** (lowest priority, fallback only)

Consequences:
- If a user document defines a structure, tone, section order, naming or
  template, FOLLOW IT and ignore the conflicting part of the skill templates.
- If a user document conflicts with the codebase, do not silently choose:
  report the conflict to the user via `AskUserQuestion`.
- Skill templates are only used for what the user documents do not cover.
- Never contradict a user document with your own assumptions.

## SOURCE REGISTRY (persistent memory of reference documents)

During the interview, build a registry of every reference document and URL the
user provided, plus the "rules to follow" extracted from them. Keep it for the
whole session and show it in the recap.

**Re-read rule**: before ANY later action that creates or modifies a document
(outline change, section rewrite, update request, new deliverable, follow-up
request in the same session), you MUST re-read every document in the registry
first, then re-check your planned output against the "rules to follow".

- Never rely on memory of the documents alone: read them again.
- If a registered document changed since the last read, update the rules list
  and tell the user what changed.
- If a registered file or URL is no longer reachable, tell the user via
  `AskUserQuestion` (Provide new path / Continue without / Cancel).
- Persist the registry in `.claude/doc-sources.md` (path, URL, extracted rules)
  so it survives across sessions. At the start of a later documentation task,
  if this file exists, load it and ask the user whether it is still valid.

## Language rules
- Talk to the user in the language they use (e.g. French), including menu
  labels, outline summaries and descriptions.
- ALL generated files (README, ADR, diagrams, comments) are written in English.
- The outline is shown in the user's language; section titles shown in the
  outline are what the user approves. If the user's language is not English,
  display each title as `Title in user language -> English title used in file`.

## Workflow

1. **Interview** (mandatory): run the batches of [interview.md](interview.md)
   with `AskUserQuestion`. Batch 2 collects the user's reference documents.
2. **Read the user's documents FIRST**: read every document and path listed in
   Batch 2 completely, before any other analysis. Extract their rules
   (structure, tone, templates, constraints). Save the Source Registry.
3. **Recap**: show the answers plus the extracted rules, then confirm with
   `AskUserQuestion` (Continue to outline / Modify / Cancel).
4. **Analyze the codebase**: run `bash scripts/analyze-project.sh`, read
   manifests, CI, env files. Use it to fill facts, never to override user documents.
5. **Outline approval (mandatory, see "Outline" below)**: build and show the
   section plan, let the user edit it, and loop until approved.
6. **Write**: generate the file(s) strictly following the APPROVED outline
   (titles, order, content summaries). Use:
   - the user's template or style guide if one exists,
   - otherwise [README-showcase.md](README-showcase.md) (Modern/Showcase),
     [README-minimal.md](README-minimal.md) (Minimal), [ADR-template.md](ADR-template.md),
     [diagrams.md](diagrams.md).
   Do NOT add, remove or rename a section that was not in the approved outline.
7. **Verify**: commands are real, paths exist, Mermaid is valid, badge URLs use
   the real OWNER/REPO (from `git remote -v`), every user-document rule and every
   approved section is respected.
8. **Report** to the user (in their language): files created, rules applied from
   their documents, TODOs left, any conflicts found.

## Outline (mandatory before writing)

Never write a document before the user has approved its outline.

### Step 1 - Build the outline
Using the interview answers, the Source Registry rules and the codebase analysis,
build the section plan. If a user document defines the structure, the outline
MUST mirror it. Otherwise derive it from the chosen style (Minimal / Modern /
Showcase) and the audience.

### Step 2 - Display the outline
Show it as plain text, in the user's language, in this exact format:

```
OUTLINE: README.md  (Style: Showcase | Audience: Contributors | Sources: 2 docs)

1. <Section title>
   -> <2-3 line summary of exactly what this section will contain,
      including the real facts it will use (e.g. "Lists the 5 npm scripts
      found in package.json: dev, build, test, lint, start").>

2. <Section title>
   -> <summary>
...
```

Rules for summaries:
- Concrete, never generic ("Explains the project" is not acceptable).
- Mention the real data source (file, document, code module) when relevant.
- Mark sections lacking data with `[TODO: missing info]` and say what is missing.
- Mark sections coming from a user document with `[from: <document name>]`.
- Show at most 15 sections. For multi-file deliverables, show one outline per file.

### Step 3 - Let the user edit
Call `AskUserQuestion`: header `Outline`, "What do you want to do with this outline?"
- Approve: generate the documentation as shown
- Edit section: change a title or the content of one section
- Add / Remove: add a new section or delete one
- Reorder: change the order of sections

(The tool adds "Other" automatically for free-text instructions such as
"rename section 3 to ...".)

Then, depending on the choice:
- **Edit section**: ask which one via `AskUserQuestion` (list the section titles
  as options, max 4 per question; if there are more, ask by groups or let the
  user type the number via "Other"). Then ask what to change: Title / Content
  summary / Both. Take the new text from the user (free text), update the outline.
- **Add**: ask for the title and what it should contain, and the position.
- **Remove**: ask which section(s) to delete.
- **Reorder**: ask for the new order (free text, e.g. "move 5 before 2").

After EVERY change, re-display the full updated outline and call the
`Outline` menu again. Loop until the user chooses "Approve".

If the user modification contradicts a rule in a registered user document,
warn them via `AskUserQuestion` (Keep my change / Follow the document) before applying it.

### Step 4 - Lock
Once approved, the outline is the contract. Writing must match it exactly.
If you later discover a needed change (missing data, impossible section), STOP
and propose the outline change to the user instead of deviating silently.

## README rules

When no user template exists and the style is Modern or Showcase:
- Do NOT write the README from scratch. Copy `README-showcase.md` and replace
  every `{{PLACEHOLDER}}`.
- Keep the animated header, typing animation, badges, navigation bar, feature
  grid, collapsible sections and footer, adapted to the approved outline
  (the navigation bar must list exactly the approved sections).
- Apply the chosen color palette to EVERY color placeholder.

## General rules
- Never invent information. Mark unknowns with `TODO:`.
- Never overwrite an existing README without reading it and proposing a backup
  (`README.old.md`).
- No generic filler content.