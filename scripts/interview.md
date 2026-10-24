# Interview Guide

This interview is MANDATORY and MUST use the `AskUserQuestion` tool so the user
gets an interactive menu (arrow keys + Enter), not text questions.

## Tool rules
- 1 to 4 questions per `AskUserQuestion` call, each with 2 to 4 options.
- The "Other" free-text option is added automatically by the tool: never add it
  yourself. Free-text answers are how users give paths, URLs and edits.
- Each option has a short `label` and a one-line `description`.
- Use `multiSelect: true` when several answers can apply.
- Use a short `header` (max 12 characters) per question.
- Write labels, descriptions and questions in the user's language.
- One call per batch. Wait for the answers before the next call.
- If the user's message already answers a question, skip it.

## Batch 1 - Goal and audience (FIRST call, alone)

Call `AskUserQuestion` with these 3 questions:

1. header `Deliverable`, multiSelect true: "What do you want to produce?"
   - README: project overview and usage
   - ADR: record of an architecture decision
   - Diagrams: architecture / sequence / data model
   - Everything: README + diagrams + proposed ADRs
2. header `Audience`, multiSelect true: "Who is this documentation for?"
   - End users: people who use the project
   - Contributors: developers working on it
   - Internal team: colleagues, onboarding
   - Public / portfolio: recruiters, open source community
3. header `Mode`: "New document or update?"
   - New: create from scratch
   - Update: improve an existing document (it will be read first)

## Batch 2 - Reference documents (SECOND call, critical)

1. header `Sources`: "Do you have documentation I must base myself on?"
   - Yes, local files: I will give file or folder paths
   - Yes, links: URLs (wiki, Notion, Confluence, specs)
   - Both: files and links
   - No: use the codebase only

If the answer is not "No", ask a follow-up as plain text: "Give me the paths and/or
URLs." Then READ ALL OF THEM before continuing and add them to the Source Registry.
They override the skill defaults.

2. header `Conventions`: "Do your documents define a template or style rules?"
   - Yes, strictly: follow their structure and tone exactly
   - Partially: use them as inspiration, skill fills the gaps
   - No: use the skill defaults

3. header `Exclusions`: "Anything I must NOT include?"
   - Internal URLs: private links and hostnames
   - Client names: customer or partner names
   - Secrets: keys, tokens, credentials
   - Nothing: no restriction

## Batch 3 - Style (README only, skip if a user template is enforced)

1. header `Style`: "Which visual style for the README?"
   - Minimal: plain and classic
   - Modern: badges, emojis, tables, collapsible sections
   - Showcase: animated header, typing text, gradients, centered layout
2. header `Palette`: "Which color palette?"
   - Purple / Blue: modern and tech
   - Green / Cyan: fresh and dev-oriented
   - Orange / Red: energetic and bold
   - Custom: give me your hex color
3. header `Visuals`: "What visuals do you have?"
   - Logo: I have a logo file
   - Screenshots / GIF: I have a demo
   - Nothing yet: leave TODO placeholders

## Batch 4 - Type-specific (only if relevant)
- **ADR**: ask which decision, options considered, constraints, decision date
  (use `AskUserQuestion` for choices, plain text for the decision title).
- **Diagrams**: ask the view (global architecture / sequence / data model /
  deployment) with `AskUserQuestion`, `multiSelect: true`.

## Recap (mandatory)

Summarize in 3 to 5 lines: answers, the Source Registry (documents found) and
the extracted "rules to follow". Then call `AskUserQuestion`:

header `Confirm`: "Ready to build the outline with these settings?"
- Continue to outline: show me the section plan
- Modify: I want to change something
- Cancel: stop here

Proceed to the outline only on "Continue to outline". The interview does NOT
lead directly to writing: the outline approval step comes next.