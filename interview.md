# Interview Guide

Use the `AskUserQuestion` tool for every question below. Never print these
questions as plain text. Ask each batch in ONE tool call (up to 4 questions per
call). Questions are shown in the user's language; the documents stay in English.

## Batch 1 - Scope and sources

1. header `Deliverable`: "What do you want to generate?"
   - README
   - ADR (Architecture Decision Record)
   - Architecture diagram
   - Everything (README + ADR + diagram)

2. header `Sources`: "Is there existing documentation I must follow (subject, spec, guidelines)?"
   - Yes, pick files from the project
   - Yes, I will paste a URL or text
   - No, use your best judgment

3. header `Strictness`: "How strictly must I follow those documents?"
   - Strict: follow the document exactly, add nothing extra
   - Flexible: follow the document, I may propose extra sections for approval

4. header `Visual style`: "How should it look? (never changes the sections)"
   - Showcase: banner, badges, animations, colors
   - Clean: simple formatting, no decorations
   - Minimal: plain text, no badges

## Batch 1b - Document picker (only if Sources = "pick files from the project")

Do NOT ask the user to type a path. Instead:

1. Scan the project with `Glob` for documentation candidates. Search these
   patterns from the project root, ignoring `node_modules`, `.git`, `.venv`,
   `venv`, `__pycache__`, `dist`, `build`, `.mypy_cache`:
   - `**/*.pdf`
   - `**/*.md` (exclude the README being generated if it already exists, unless
     the user wants to update it)
   - `**/*.txt`
   - `**/*.rst`
   - `**/docs/**`, `**/doc/**`, `**/subject*`, `**/spec*`, `**/guideline*`
2. Sort candidates by likelihood: files named `subject`, `spec`, `requirements`,
   `guidelines`, `instructions`, `CONTRIBUTING` first, then PDFs, then the rest.
3. Call `AskUserQuestion` with `multiSelect: true`:
   - header `Documents`: "Which documents must I follow?"
   - Options: up to 4 best candidates (path as label, one-line reason as
     description). The built-in "Other" lets the user type any other path.
4. If there are more than 4 candidates, add a first option "Show more files".
   When chosen, ask again with the next 4 candidates, and repeat until the user
   is done. Keep a running list of everything already selected.
5. If `Glob` finds nothing, say so in one sentence and ask via
   `AskUserQuestion`:
   - header `No file found`: "No documentation file detected. What now?"
   - Options: "I will type a path (use Other)", "I will paste text", "Continue without documentation"

After the selection, confirm the final list in the chat (one path per line) and
go on. Then read every selected file COMPLETELY (for PDFs, use the `Read` tool
with pages if the file is long). These documents have priority over this skill
and feed the Source Registry.

If Sources = "I will paste a URL or text": ask, in plain chat, for the content
and wait for it. This is the only case where a plain-text prompt is allowed,
because there is no way to pick pasted text from a menu.

## Batch 2 - Content (only for what was selected)

For a README:
1. header `Audience`: "Who will read it?"
   - Evaluators / reviewers
   - Developers / contributors
   - End users
   - Recruiters / public portfolio

2. header `Highlights`: "Anything specific to highlight?"
   - Installation and usage
   - Technical architecture
   - Features and screenshots
   - Nothing specific

For an ADR:
1. header `Decision`: "Which decision should be recorded?"
   - I will describe it
   - Detect it from the code
2. header `Status`: "What is its status?"
   - Proposed
   - Accepted
   - Deprecated

For a diagram:
1. header `Diagram type`: "Which diagram?"
   - Architecture overview
   - Class diagram
   - Sequence diagram
   - Entity-relationship

2. header `Format`: "Which format?"
   - Mermaid (renders on GitHub)
   - ASCII
   - Both

## Batch 3 - Visual details (only if Visual style = Showcase)

1. header `Palette`: "Which color palette?"
   - Yellow / dark (retro arcade)
   - Blue / purple (modern)
   - Green / dark (terminal)
   - Auto-pick from the project theme

2. header `Animation`: "Which animation?"
   - Typing text animation
   - Animated wave banner
   - Both
   - None

## Batch 4 - Final recap

Display a recap in the chat (deliverable, selected documents, strictness,
style), then call `AskUserQuestion`:

- header `Confirm`: "Is this correct?"
  - Continue to the outline
  - Modify a setting
  - Cancel

On "Modify a setting": ask via a menu which setting to change, then redo ONLY
that question. On "Continue to the outline": go to Phase 4 of SKILL.md. The
interview NEVER leads directly to writing.

## Reminders

- If the user already gave an answer in their message (for example `/doc readme`),
  skip that question.
- Never invent answers. Never assume strictness: always ask.
- Never ask the user to type a file path when files can be listed in a menu.
- Source documents are collected in the Source Registry and override every
  default of this skill.

## Outline editing menus (Phase 4)

The outline is edited ONLY through `AskUserQuestion`, one question per call.
The full sequence is defined in SKILL.md, Phase 4. In short:

1. `Outline` menu: Approve and write / Modify a section / Add a section / Remove a section
2. `Section` menu: pick the section (paged by 4)
3. `Change` menu: Rename the title / Change the content summary / Move / Both
4. A last menu for the actual new value (title proposals, content proposals,
   position), with the built-in "Other" for free text

Never ask the user to type a change in the chat. Never put two of these
questions in the same call. Never mix them with questions about missing
information.