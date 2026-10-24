# Interview

Always run this interview first, using the `AskUserQuestion` tool for every
question (interactive menu). Never write the questions as plain text.

The tool allows up to 4 questions per call and 4 options per question. The user
can always pick "Other" to type a custom answer.

Skip a question only if the user already answered it explicitly in their message
or in `$ARGUMENTS`.

## Batch 1 - Scope (first call, always)

Call `AskUserQuestion` with these questions in ONE call:

1. header `Deliverable`: "What do you want to generate?"
   - README: a project README
   - ADR: an Architecture Decision Record
   - Diagram: Mermaid architecture diagram(s)
   - Everything: README + ADR + diagram

2. header `Strictness`: "How strictly should I follow your documents?"
   - Strict: follow your documents to the letter, nothing added
   - Guided: your documents set the rules, I may add styling
   - Free: your documents are inspiration, I use my templates

3. header `Sources`: "Do you have existing documentation I must base this on?"
   - Yes, local files: I give file or folder paths
   - Yes, URLs: I give links
   - Yes, both: files and links
   - No: use the codebase only

4. header `Audience`: "Who will read this documentation?"
   - Developers: contributors and maintainers
   - Users: people who install and use the project
   - Both: mixed audience
   - Clients: non-technical or business readers

## Batch 2 - Sources and details (second call)

Only if the user answered "Yes" to Sources. Ask the paths or URLs through
`AskUserQuestion` with a question like: "Which documents should I use? Choose
'Other' to type the paths or URLs, separated by commas." with options such as:
- docs/ folder: use the docs directory
- README.md and CONTRIBUTING.md: use the existing root docs
- I will type the paths: use "Other"

Then read every listed document in full (see Source Registry in SKILL.md).

Depending on the Deliverable, add questions (same call, max 4):

**If README or Everything:**
- header `Style`: "Which README style?" (only if Strictness is not Strict)
  - Showcase: badges, colors, animated header
  - Minimal: clean and simple
  - Classic: standard sections
  - Follow my docs: copy the style from my documents
- header `Sections`: "Which sections do you need?" multiSelect true
  - Install and usage
  - Architecture
  - API reference
  - Contributing and license

**If ADR or Everything:**
- header `Decision`: "What decision should the ADR record? Choose 'Other' to type it."
  - Detect it from the codebase
  - I will describe it
- header `ADR status`: "Status of this ADR?"
  - Proposed
  - Accepted
  - Deprecated
  - Superseded

**If Diagram or Everything:**
- header `Diagram type`: "Which diagrams?" multiSelect true
  - System overview
  - Sequence
  - Data model (ER)
  - Deployment

## Batch 3 - Confirmation

Print a short summary of all answers as text, then call `AskUserQuestion`
header `Confirm`: "Ready to build the outline with these settings?"
- Continue to outline: show me the section plan
- Modify: I want to change something
- Cancel: stop here

Proceed to the outline only on "Continue to outline". If "Modify", ask via a
menu which setting to change and redo that question only. The interview does
NOT lead directly to writing: the outline approval step comes next.