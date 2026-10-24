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

### Phase 2 - Source Registry
Read every document the user listed, completely. Build a Source Registry:
for each document, the exact requirements it imposes (required sections, exact
titles, exact sentences, order, constraints). These requirements override
everything in this skill.

### Phase 3 - Codebase analysis
Only now, analyze the code (Glob, Grep, Read) to gather facts. Never invent:
every statement in the documentation must come from the sources or the code.
Verify names, defaults, commands and paths against the real files.

### Phase 4 - Outline approval (required, editable)
Build the outline from the Source Registry (Rule 1). Present it in the chat as:

```
1. <Section title>
   Summary: <2-3 lines describing exactly what will be written>
2. <Section title>
   Summary: ...
```

Then call `AskUserQuestion` with these options:
- Approve the outline
- Rename or edit a section
- Add a section
- Remove a section
- Reorder sections

**Menu interaction rules (critical):**
- A menu choice alone is NEVER enough. After the user selects "Rename or edit",
  "Add" or "Remove", immediately ask which section, using a new
  `AskUserQuestion` whose options are the numbered section titles, then ask
  what the new title or content should be.
- Because a menu cannot take free text reliably, always include an "Other"
  path: tell the user they can type the section name or the new text directly
  in the chat, and wait for their reply.
- NEVER answer "section selected" without acting on it. Always apply the
  change, redisplay the updated outline, and ask for approval again.
- In strict mode, refuse to add a section that is not in the source document,
  and explain that strict mode forbids it. Offer to switch to flexible mode.
- Loop until the user chooses "Approve the outline".

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