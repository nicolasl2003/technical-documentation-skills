# ADR Template (Architecture Decision Record)

## Location and naming
- Folder: `docs/adr/`
- File: `NNNN-short-title-in-kebab-case.md` (sequential numbering)
- Check the latest existing number before creating a new ADR

## Format

```markdown
# ADR-NNNN: Title of the decision

- **Status**: Proposed | Accepted | Deprecated | Superseded by ADR-XXXX
- **Date**: YYYY-MM-DD
- **Deciders**: names or teams

## Context
What problem are we facing? What constraints apply (technical, budget, timeline, team)?

## Options considered
### Option 1: Name
- Pros:
- Cons:

### Option 2: Name
- Pros:
- Cons:

## Decision
We choose option X, because...

## Consequences
- Positive:
- Negative / accepted debt:
- Follow-up actions:
```

## Rules
- One ADR = one decision. Do not combine several.
- An accepted ADR is never edited: create a new one that supersedes it.
- If the context or alternatives are unknown, ask the user
  instead of inventing them.