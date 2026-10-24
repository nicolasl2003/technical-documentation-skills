# README Template

Adapt the sections to the project: remove those that do not apply.

## Recommended structure

1. **Title and description**: one sentence on what the project does and for whom
2. **Badges** (optional): CI, version, license
3. **Features**: 3 to 6 bullet points maximum
4. **Prerequisites**: exact tool versions (Node 20+, Python 3.11...)
5. **Installation**: copy-pasteable commands, in order
6. **Usage**: a minimal working example
7. **Configuration**: table of environment variables

   | Variable | Description | Required | Default |
   |---|---|---|---|

8. **Architecture**: Mermaid diagram + description of main directories
9. **Testing**: how to run the tests
10. **Deployment** (if applicable)
11. **Contributing** and **License**

## Where to find the information
- Description: package.json, pyproject.toml, docstrings, previous README
- Env variables: `.env.example`, code (`process.env`, `os.environ`)
- Commands: manifest scripts, Makefile, CI workflows
- Versions: `.nvmrc`, `.python-version`, `engines` field