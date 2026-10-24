---
name: technical-documentation
description: Generates technical documentation (styled READMEs, ADRs, Mermaid architecture diagrams). ALWAYS starts by interviewing the user before writing anything. Use when the user asks to document a project, create or update a README, write an ADR, or produce a diagram.
---

# Technical Documentation

## STOP - READ THIS FIRST

You MUST interview the user BEFORE reading the codebase in depth and BEFORE
writing any file. This is not optional.

**Your first reply when this skill is triggered MUST be the questions from
Batch 1 of [interview.md](interview.md), and nothing else.**

- Do not run scripts first.
- Do not generate any file in your first reply.
- Do not skip the interview because the request "seems clear".
- Only skip a question if the user already answered it explicitly in their message.
- After each batch of answers, ask the next batch. Then recap and wait for a "yes".

If you generated a file without interviewing, you made a mistake: stop,
apologize briefly, and start the interview.

## Language rules
- Talk to the user in the language they use (e.g. French).
- ALL generated files (README, ADR, diagrams, comments) are written in English.

## Workflow

1. **Interview** (mandatory, see [interview.md](interview.md)). Batches of max 5 questions.
2. **Recap**: summarize the answers in 3-5 lines and wait for the user to confirm.
3. **Analyze**: run `bash scripts/analyze-project.sh`, read manifests, CI, env files,
   and every source the user mentioned in the interview.
4. **Write**, using the right template:
   - README: copy [README-showcase.md](README-showcase.md) (style Showcase/Modern)
     or [README-minimal.md](README-minimal.md) (style Minimal)
   - ADR: [ADR-template.md](ADR-template.md)
   - Diagrams: [diagrams.md](diagrams.md)
5. **Verify**: commands are real, paths exist, Mermaid is valid, badge URLs use the
   real OWNER/REPO (from `git remote -v`), nothing invented (unknown = `TODO:`).
6. **Report** to the user (in their language): files created, TODOs left, next steps.

## README rules (important)

When the chosen style is Modern or Showcase:
- Do NOT write the README from scratch. Copy `README-showcase.md` and replace
  every `{{PLACEHOLDER}}` with real project values.
- Keep the animated header, typing animation, badges, navigation bar, feature grid,
  collapsible sections and footer. Removing them defeats the purpose of the style.
- Only remove a block if it truly does not apply (e.g. no CLI = no "Usage" CLI block).
- Apply the color palette chosen in the interview to EVERY color placeholder.

## General rules
- Never invent information. Mark unknowns with `TODO:`.
- Never overwrite an existing README without reading it first and proposing a
  backup (`README.old.md`).
- No generic filler content.