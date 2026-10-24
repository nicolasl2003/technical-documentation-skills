# README Showcase Style

Read this file BEFORE writing a README when the user chose the Showcase style.
This file controls PRESENTATION only. It never adds, removes or renames a
section. The section list always comes from the user's source document.

## Order of the top of the file

1. If the source document imposes an exact first line, write it FIRST, alone,
   as the very first line (keep its required formatting, for example italics).
2. Then the visual header (banner, badges), centered.
3. Then the table of contents (navigation only, not a section).
4. Then the sections of the approved outline.

Example for the 42 subject:

```markdown
*This project has been created as part of the 42 curriculum by login1, login2.*

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:FFD800,100:FF8C00&height=200&section=header&text=Pac-Man&fontSize=70&fontColor=1a1a1a&animation=fadeIn&fontAlignY=38" width="100%"/>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&pause=1000&color=FFD800&center=true&vCenter=true&width=600&lines=A+Pac-Man+clone+in+Python;Built+with+pygame;Four+ghosts.+One+maze." alt="Typing animation"/>

![Python](https://img.shields.io/badge/Python-3.13-FFD800?style=for-the-badge&logo=python&logoColor=1a1a1a)
![pygame](https://img.shields.io/badge/pygame-2.x-FF8C00?style=for-the-badge)
![License](https://img.shields.io/badge/42-curriculum-1a1a1a?style=for-the-badge)

</div>
```

## Building blocks

### Banner (animated wave)
`https://capsule-render.vercel.app/api?type=waving&color=0:<HEX1>,100:<HEX2>&height=200&section=header&text=<Title>&fontSize=70&animation=fadeIn`
Use `type=waving`, `type=venom` or `type=rect`. Put the same API with
`section=footer` at the very end of the file for a matching footer.

### Typing animation
`https://readme-typing-svg.demolab.com?font=Fira+Code&size=22&pause=1000&color=<HEX>&center=true&vCenter=true&width=600&lines=Line+one;Line+two`
Spaces are written as `+`. Separate lines with `;`.

### Badges (shields.io)
`https://img.shields.io/badge/<Label>-<Value>-<HEX>?style=for-the-badge&logo=<logo>&logoColor=<HEX>`
Only add badges that are true: language and version from the real config,
tools actually used. Never invent a badge (no fake build status or coverage).
A CI badge is allowed only if the workflow file really exists.

### Table of contents
A short linked list of the existing sections, using GitHub anchors. It is
navigation, not a new section: do not give it a heading.

### Collapsible blocks
Use `<details><summary>...</summary> ... </details>` inside an existing section
to hide long content (full config table, long command lists).

### Section markers
A single emoji at the start of a heading is allowed if the user chose
Showcase. Keep the title text identical to the approved title.

## Palettes

| Palette | Color 1 | Color 2 | Text |
|---|---|---|---|
| Yellow / dark | FFD800 | FF8C00 | 1a1a1a |
| Blue / purple | 4facfe | 7b2ff7 | ffffff |
| Green / dark | 00ff9c | 0b3d2e | ffffff |

## Rules

- Style never creates a section. No "Features", "Preview" or "Roadmap" heading
  unless the outline contains it.
- Everything in English.
- Images and badges come from public services; add meaningful `alt` text.
- Keep the file readable as plain text: decoration must not hide information.
- Never leave a placeholder or TODO.