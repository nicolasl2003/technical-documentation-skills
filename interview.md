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
   - Yes, a file in the project (I will give the path)
   - Yes, a URL or text I will paste
   - No, use your best judgment

3. header `Strictness`: "How strictly must I follow those documents?"
   - Strict: follow the document exactly, add nothing extra
   - Flexible: follow the document, I may propose extra sections for approval

4. header `Visual style`: "How should it look? (never changes the sections)"
   - Showcase: banner, badges, animations, colors
   - Clean: simple formatting, no decorations
   - Minimal: plain text, no badges

If the user picks "Yes, a file" or "Yes, a URL or text", ask right after, in
plain chat, for the path or the content, and wait for the answer. Then read it
fully. These documents have priority over this skill.

## Batch 2 - Content (only for what was selected)

For a README:
1. header `Audience`: "Who will read it?"
   - Evaluators / reviewers
   - Developers / contributors
   - End users
   - Recruiters / public portfolio

2. header `Language of examples`: "Anything specific to highlight?"
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

Display a recap in the chat, then call `AskUserQuestion`:

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
- If a source document exists, its requirements are collected in the Source
  Registry and override every default of this skill.