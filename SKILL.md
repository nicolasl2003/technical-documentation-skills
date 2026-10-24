---
name: technical-documentation
description: Generates technical documentation for a codebase - README files, ADRs (Architecture Decision Records) and architecture diagrams (Mermaid). Use when the user asks to document a project, create or update a README, write an ADR or record an architecture decision, or produce a diagram (architecture, sequence, data model, state).
---

# Automatic Technical Documentation

## Core principle
Never invent information. All documentation must be derived from the actual
codebase (config files, directory structure, dependencies, scripts).
If a piece of information cannot be found, mark it with `TODO:` instead of guessing.

## Choosing the deliverable

| User request | File to consult |
|---|---|
| README, project overview | [README-template.md](README-template.md) |
| Architecture decision, technical choice | [ADR-template.md](ADR-template.md) |
| Diagram, schema, visual architecture | [diagrams.md](diagrams.md) |

If the request is broad ("document this project"), produce in this order:
README, then an architecture diagram, then propose ADRs.

## Step 1: Analyze the project
1. Run `bash scripts/analyze-project.sh` to get a project summary
2. Read key files: manifests (package.json, pyproject.toml, go.mod,
   pom.xml...), Dockerfile, docker-compose, CI config, environment files
3. Browse entry points and main directories

## Step 2: Write
- Follow the matching template
- Write in the language of the existing documentation (default: English)
- Verify that every command mentioned actually exists (npm scripts, Makefile targets...)

## Step 3: Verify before delivering
- [ ] Install and run commands are accurate
- [ ] Cited file paths exist
- [ ] Mermaid diagrams are syntactically valid
- [ ] No invented information (anything unknown is marked TODO)

## Writing rules
- Short sentences, active voice
- Code blocks with the language specified
- No generic filler content
- Never overwrite an existing README without reading it first and proposing a merge