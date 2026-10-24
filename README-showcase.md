# Showcase README Model

Copy everything between the `START` and `END` markers into README.md, then
replace every `{{PLACEHOLDER}}`. Color values are hex WITHOUT the `#`.

Palette placeholders:
- `{{COLOR_MAIN}}` main brand color (e.g. 6C63FF)
- `{{COLOR_ACCENT}}` secondary color (e.g. 00C896)
- Header gradient `customColorList`: 0 to 29 preset gradients; use `color=gradient`
  with `customColorList=6,11,20` (purple/blue), `=12,14,26` (green/cyan),
  `=2,5,24` (orange/red), or `color=0:{{COLOR_MAIN}},100:{{COLOR_ACCENT}}`
  for a custom two-color gradient.

<!-- START -->

```markdown
<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:{{COLOR_MAIN}},100:{{COLOR_ACCENT}}&height=240&section=header&text={{PROJECT_NAME}}&fontSize=64&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc={{TAGLINE_URL_ENCODED}}&descSize=20&descAlignY=58" alt="{{PROJECT_NAME}}" width="100%"/>

<a href="https://git.io/typing-svg">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&pause=1200&color={{COLOR_MAIN}}&center=true&vCenter=true&width=700&lines={{TYPING_LINE_1}};{{TYPING_LINE_2}};{{TYPING_LINE_3}}" alt="Typing animation"/>
</a>

<br/>

<img src="https://img.shields.io/badge/license-{{LICENSE}}-{{COLOR_MAIN}}?style=for-the-badge" alt="License"/>
<img src="https://img.shields.io/github/v/release/{{OWNER}}/{{REPO}}?style=for-the-badge&color={{COLOR_ACCENT}}" alt="Release"/>
<img src="https://img.shields.io/github/actions/workflow/status/{{OWNER}}/{{REPO}}/{{CI_FILE}}?style=for-the-badge" alt="Build"/>
<img src="https://img.shields.io/github/stars/{{OWNER}}/{{REPO}}?style=for-the-badge&color=FFB400" alt="Stars"/>

<br/><br/>

**[Features](#-features)** &nbsp;•&nbsp;
**[Quick Start](#-quick-start)** &nbsp;•&nbsp;
**[Usage](#-usage)** &nbsp;•&nbsp;
**[Architecture](#-architecture)** &nbsp;•&nbsp;
**[Contributing](#-contributing)**

</div>

<br/>

<div align="center">
  <img src="docs/assets/demo.gif" alt="{{PROJECT_NAME}} demo" width="780"/>
  <!-- TODO: add docs/assets/demo.gif or remove this block -->
</div>

---

## ✨ Features

<table>
  <tr>
    <td align="center" width="33%">
      <h3>⚡</h3>
      <b>{{FEATURE_1_TITLE}}</b><br/>
      <sub>{{FEATURE_1_DESC}}</sub>
    </td>
    <td align="center" width="33%">
      <h3>🔒</h3>
      <b>{{FEATURE_2_TITLE}}</b><br/>
      <sub>{{FEATURE_2_DESC}}</sub>
    </td>
    <td align="center" width="33%">
      <h3>🧩</h3>
      <b>{{FEATURE_3_TITLE}}</b><br/>
      <sub>{{FEATURE_3_DESC}}</sub>
    </td>
  </tr>
</table>

---

## 🛠 Tech Stack

<div align="center">

<!-- One badge per real technology. Pattern:
<img src="https://img.shields.io/badge/{{TECH}}-{{HEX}}?style=for-the-badge&logo={{SIMPLEICONS_SLUG}}&logoColor=white" alt="{{TECH}}"/>
-->
{{STACK_BADGES}}

</div>

---

## 🚀 Quick Start

> [!NOTE]
> **Prerequisites:** {{PREREQUISITES}}

```bash
{{INSTALL_COMMANDS}}
```

---

## 📖 Usage

```{{LANG}}
{{USAGE_EXAMPLE}}
```

<details>
<summary><b>⚙️ Configuration</b></summary>

<br/>

| Variable | Description | Default | Required |
|---|---|---|---|
| `{{ENV_VAR}}` | {{ENV_DESC}} | `{{ENV_DEFAULT}}` | {{YES_NO}} |

</details>

---

## 🏗 Architecture

{{ARCHITECTURE_SENTENCE}}

<details>
<summary><b>📐 View the architecture diagram</b></summary>

<br/>

```mermaid
{{MERMAID_DIAGRAM}}
```

</details>

<details>
<summary><b>📁 Project structure</b></summary>

<br/>

```
{{TREE}}
```

</details>

---

## 🗺 Roadmap

- [x] {{DONE_ITEM}}
- [ ] {{TODO_ITEM}}

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create your branch: `git checkout -b feat/amazing-feature`
3. Commit your changes: `git commit -m "feat: add amazing feature"`
4. Push and open a Pull Request

> [!TIP]
> Run `{{TEST_COMMAND}}` before opening a PR.

---

## 📄 License

Distributed under the {{LICENSE}} License. See [`LICENSE`](LICENSE) for details.

<br/>

<div align="center">

Made with ❤️ by [{{AUTHOR}}](https://github.com/{{OWNER}})

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:{{COLOR_MAIN}},100:{{COLOR_ACCENT}}&height=120&section=footer" alt="footer" width="100%"/>

</div>
```

<!-- END -->

## Placeholder rules
- `{{TAGLINE_URL_ENCODED}}`: spaces as `%20`.
- `{{TYPING_LINE_n}}`: spaces as `+`, 3 short selling points of the project.
- `{{OWNER}}` / `{{REPO}}`: read them from `git remote -v`. Never guess.
- Remove badges whose data does not exist (no releases = remove the Release badge).
- `{{STACK_BADGES}}`: only technologies actually found in the manifests.
- Keep `<!-- TODO: -->` comments for missing assets, and list them in the final report.