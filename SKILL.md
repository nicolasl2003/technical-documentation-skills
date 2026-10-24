---
name: technical-documentation
description: Generates technical documentation for a codebase - README files (including styled, visually rich ones), ADRs (Architecture Decision Records) and architecture diagrams (Mermaid). Starts with a short interview to understand needs and existing sources. Use when the user asks to document a project, create or update a README, write an ADR or record an architecture decision, or produce a diagram.
---

# Automatic Technical Documentation

## Language rules
- Talk to the user in the language they use (e.g. French).
- ALL generated documents (README, ADR, diagrams, comments) are written in English,
  unless the user explicitly asks for another language in the interview.

## Core principle
Never invent information. All documentation must be derived from the actual
codebase or from sources provided by the user. If something cannot be found,
mark it with `TODO:` instead of guessing.

## Workflow

### Phase 1: Interview (mandatory)
Before writing anything, follow [interview.md](interview.md) to ask the user
about their needs, audience, existing documentation and visual preferences.
Skip questions whose answers are already clear from the request or context.
Never ask more than 5 questions at once.

### Phase 2: Analyze
1. Run `bash scripts/analyze-project.sh` for a project summary
2. Read key files: manifests, Dockerfile, CI config, env files
3. Read every source the user pointed to during the interview
   (existing docs, specs, notes, URLs, tickets)
4. Browse entry points and main directories

### Phase 3: Plan and confirm
Summarize in a few lines what you will produce (deliverables, style, language)
and ask for a quick confirmation before generating files.

### Phase 4: Write
Choose the matching template:

| Deliverable | File to consult |
|---|---|
| README | [README-template.md](README-template.md) |
| ADR | [ADR-template.md](ADR-template.md) |
| Diagrams | [diagrams.md](diagrams.md) |

If the request is broad ("document this project"), produce in this order:
README, architecture diagram, then propose ADRs.

### Phase 5: Verify
- [ ] Install and run commands are accurate
- [ ] Cited file paths exist
- [ ] Mermaid diagrams are syntactically valid
- [ ] Badge URLs and image paths are correct
- [ ] No invented information (unknown items marked TODO)

### Phase 6: Report
Tell the user (in their language) which files were created or modified,
which items are marked TODO, and offer next steps.

## Writing rules
- Short sentences, active voice
- Code blocks with the language specified
- No generic filler content
- Never overwrite an existing README without reading it first and
  proposing a merge or backup (`README.old.md`)