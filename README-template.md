# README Template

Pick the style chosen during the interview. Remove sections that do not apply.

## Style: Minimal
Title, one-line description, Installation, Usage, License.
No badges, no HTML, plain Markdown.

## Style: Modern
Add: shields.io badges, emojis in headings, a table of contents,
tables for configuration, `<details>` blocks for long sections.

## Style: Showcase
Everything from Modern, plus the visual components below.

---

## Visual components (GitHub-compatible)

GitHub strips `<style>`, `<script>` and most CSS from READMEs.
Only use techniques that work there: HTML alignment, images, GIFs and SVG.

### Animated header (capsule-render)
```markdown
<div align="center">

![Header](https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=220&section=header&text=PROJECT_NAME&fontSize=60&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=One-line%20tagline&descAlignY=58)

</div>
```
Other `type` values: `venom`, `shark`, `cylinder`, `soft`, `rect`.
Add `animation=twinkling|blinking|fadeIn|scaleIn|blink`.

### Typing animation (readme-typing-svg)
```markdown
<div align="center">

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&pause=1000&color=6C63FF&center=true&vCenter=true&width=600&lines=Fast+and+reliable;Easy+to+use;Built+for+developers)](https://git.io/typing-svg)

</div>
```
Replace `color` (hex without #) and the `lines` (separated by `;`, spaces as `+`).

### Badges (shields.io)
```markdown
<div align="center">

![License](https://img.shields.io/badge/license-MIT-6C63FF?style=for-the-badge)
![Version](https://img.shields.io/github/v/release/OWNER/REPO?style=for-the-badge&color=00C896)
![Build](https://img.shields.io/github/actions/workflow/status/OWNER/REPO/ci.yml?style=for-the-badge)
![Stars](https://img.shields.io/github/stars/OWNER/REPO?style=for-the-badge&color=FFB400)

</div>
```
Tech stack badges:
`https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white`
(adapt name, hex color and `logo=` slug from simpleicons.org).

### Navigation bar
```markdown
<div align="center">

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Contributing](#-contributing)

</div>
```

### Divider
```markdown
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%">
```
Or use an SVG divider stored in `docs/assets/divider.svg`.

### Demo GIF or screenshot
```markdown
<div align="center">
  <img src="docs/assets/demo.gif" alt="Demo" width="720">
</div>
```
If no asset exists, add a placeholder comment: `<!-- TODO: add docs/assets/demo.gif -->`

### Callouts (native GitHub alerts)
```markdown
> [!NOTE]
> Useful information.

> [!TIP]
> Helpful advice.

> [!WARNING]
> Critical content.
```

### Collapsible section
```markdown
<details>
<summary><b>Click to expand</b></summary>

Hidden content here.

</details>
```

### Feature grid (HTML table)
```markdown
<table>
  <tr>
    <td align="center" width="33%">⚡<br><b>Fast</b><br>Short description</td>
    <td align="center" width="33%">🔒<br><b>Secure</b><br>Short description</td>
    <td align="center" width="33%">🧩<br><b>Extensible</b><br>Short description</td>
  </tr>
</table>
```

### Footer
```markdown
<div align="center">

![Footer](https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=120&section=footer)

Made with ❤️ by [AUTHOR](https://github.com/AUTHOR)

</div>
```

---

## Showcase layout

1. Animated header (capsule-render)
2. Typing animation (taglines)
3. Badges row (license, version, build, stack)
4. Navigation bar
5. Demo GIF or screenshot
6. Features (grid or list with emojis)
7. Tech stack (badges)
8. Installation and Usage (code blocks)
9. Configuration (table of environment variables)
10. Architecture (Mermaid diagram) in a `<details>` block
11. Roadmap (task list)
12. Contributing and License
13. Footer (capsule-render)

## Design rules
- Choose ONE color palette and reuse it everywhere (header, badges, typing).
  Use the brand color from the interview if given.
- Center hero elements with `<div align="center">`; keep body text left-aligned.
- Use `style=for-the-badge` consistently; do not mix badge styles.
- Maximum ~8 badges. More becomes noise.
- Every image needs an `alt` text.
- Dark mode support for custom images:
  ```markdown
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/logo-dark.svg">
    <img alt="Logo" src="docs/assets/logo-light.svg" width="200">
  </picture>
  ```
- Never reference external assets that were not verified (replace OWNER/REPO
  with the real values from `git remote -v`).
- Tell the user that animated headers rely on third-party services
  (capsule-render, readme-typing-svg) and may fail if these go down;
  mention the self-hosted alternative (SVG stored in the repo).

## Where to find the information
- Description: package.json, pyproject.toml, docstrings, previous README
- Env variables: `.env.example`, code (`process.env`, `os.environ`)
- Commands: manifest scripts, Makefile, CI workflows
- Versions: `.nvmrc`, `.python-version`, `engines` field
- Owner/repo: `git remote -v`