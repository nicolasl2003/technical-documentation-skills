<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:4facfe,100:7b2ff7&height=200&section=header&text=Technical%20Documentation%20Skills&fontSize=50&fontColor=ffffff&animation=fadeIn&fontAlignY=38" width="100%"/>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&pause=1000&color=4facfe&center=true&vCenter=true&width=700&lines=Interview+first%2C+write+second;READMEs%2C+ADRs+and+diagrams;Approve+the+outline+before+any+file+is+written" alt="Typing animation"/>

![Markdown](https://img.shields.io/badge/Markdown-7b2ff7?style=for-the-badge&logo=markdown&logoColor=ffffff)
![Mermaid](https://img.shields.io/badge/Mermaid-4facfe?style=for-the-badge&logoColor=ffffff)
![Bash](https://img.shields.io/badge/Bash-7b2ff7?style=for-the-badge&logo=gnubash&logoColor=ffffff)

</div>

## Table of Contents

- [Description](#description)
- [Features](#features)
- [Installation and usage](#installation-and-usage)
- [Workflow](#workflow)
- [Project structure](#project-structure)
- [Customization](#customization)

## Description

A skill for coding agents that generates technical documentation from a real codebase. It runs a guided interview, analyses the project, proposes an editable outline, and only then writes the file. Every command, path and default value in the output is checked against the code.

## Features

- **Deliverables:** README, ADR (Architecture Decision Record), architecture diagram (Mermaid), or all three.
- **Interactive interview:** menu-driven questions for deliverable, source documents, strictness, visual style and audience.
- **Source priority:** user-provided specifications override the templates, and sections are never added silently.
- **Outline approval loop:** approve, modify, add or remove sections before writing.
- **Visual styles:** Showcase (banner, badges, typing animation, colour palette), Clean, or Minimal, without changing the section list.
- **Verification step:** checks section order, placeholders, first line and accuracy of commands before reporting completion.

## Installation and usage

Copy the skill folder into the skills directory of your agent:

```bash
cp -r technical-documentation-skills ~/.config/mammouth/skills/
```

Then trigger it from a project with a request such as:

- `/doc`
- "write a README"
- "écris un ADR"
- "génère un diagramme d'architecture"

The skill starts with the interview. Answer the menus, review the outline, then approve it to generate the file.

## Workflow

1. **Interview:** choose the deliverable, sources, strictness, visual style and audience.
2. **Source registry:** read every selected document completely and collect its requirements.
3. **Codebase analysis:** gather facts with `Glob`, `Grep` and `Read`. Nothing is invented.
4. **Outline approval:** review and edit the section list through menus.
5. **Writing:** produce exactly the approved outline, with the chosen visual style applied on top.
6. **Verification:** confirm sections, order, placeholders, language and command accuracy.

## Project structure

```text
technical-documentation-skills/
├── SKILL.md              # Main workflow and rules
├── interview.md          # Interview batches and menus
├── README-showcase.md    # Showcase style: banner, badges, palettes
├── README-minimal.md     # Minimal README template
├── ADR-template.md       # ADR template
├── diagrams.md           # Mermaid diagram guide
└── scripts/
    └── analyze-project.sh  # Quick project summary (tree, manifests, CI, env files)
```

## Customization

- **Palettes:** add or edit colour pairs in the palette table of `README-showcase.md`.
- **Templates:** adjust the section models in `README-minimal.md` and `ADR-template.md`.
- **Interview:** change the questions and options in `interview.md`.
- **Workflow rules:** edit the phases and strictness rules in `SKILL.md`.
