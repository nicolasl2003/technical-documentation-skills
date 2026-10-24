# Interview Guide

Ask these questions in the user's language, in small batches (max 5 at a time).
Skip any question already answered by the request or the codebase.
Offer concrete options so the user can answer quickly.

## Batch 1: Goal and audience
1. What do you want to document? (README / ADR / diagrams / everything)
2. Who is the audience? (end users, contributors, internal team, recruiters,
   open-source community)
3. Is this a new document or an update of an existing one?

## Batch 2: Existing sources
4. Is there existing documentation to build upon? (old README, wiki, Notion,
   specs, API docs, meeting notes, tickets, URLs). Ask for paths or links.
5. Are there conventions to follow? (company template, tone, mandatory sections)
6. Anything that must NOT appear? (internal URLs, secrets, client names)

## Batch 3: Style (mainly for README)
7. Which visual style do you want?
   - **Minimal**: clean and classic
   - **Modern**: badges, emojis, tables, collapsible sections
   - **Showcase**: animated header, gradients, centered layout, social badges
8. Do you have a brand color or logo? (hex code or file path)
   If not, pick a palette that fits the project type.
9. Should the README include screenshots, a demo GIF or a logo?
   (ask for paths, or leave clearly marked placeholders)

## Batch 4: Type-specific
- **ADR**: What decision? What options were considered? What constraints
  (budget, deadline, team skills)? Who decided and when?
- **Diagrams**: Which view? (global architecture, sequence of a flow, data
  model, deployment). Which level of detail?

## After the interview
Recap the answers in 3 to 5 lines and wait for the user's confirmation
before writing (Phase 3 of the workflow).